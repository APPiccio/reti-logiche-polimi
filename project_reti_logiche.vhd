library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity project_reti_logiche is
    port (
        i_clk         : in  std_logic;
        i_start       : in  std_logic;
        i_rst         : in  std_logic;
        i_data       : in  std_logic_vector(7 downto 0); --1 byte
        o_address     : out std_logic_vector(15 downto 0); --16 bit addr: max size is 255*255 + 3 more for max x and y and thresh.
        o_done            : out std_logic;
        o_en         : out std_logic;
        o_we       : out std_logic;
        o_data            : out std_logic_vector (7 downto 0)
      );
end project_reti_logiche;
            -- Index = x*col + y + 5 
architecture Behavioral of project_reti_logiche is
signal scol, srow, ssoglia : std_logic_vector(7 downto 0);
signal sh,sarea : std_logic_vector(15 downto 0) := "0000000000000000";
signal swidth, sheight: std_logic_vector(7 downto 0) := "11111111";
signal sa0,sa1 : std_logic_vector(7 downto 0) := "11111111";
begin
    process(i_clk,i_start,i_rst)
    variable adr : std_logic_vector(15 downto 0) := "0000000000000010";
    variable col, row, soglia: std_logic_vector(7 downto 0) := "00000000";
    variable top, bottom, left, right: std_logic_vector(7 downto 0) := "00000000";
    variable found, sostegno : std_logic := '0'; -- sostegno ? una variabile che serve solamente al sistema per un controllo per capire se siamo gi? entrati in fase di lavoro o se stiamo ancora inizializzando.
    variable x,y,h : std_logic_vector(7 downto 0) := "00000000";
    variable area : std_logic_vector(15 downto 0) := "0000000000000000";
    variable a0, a1 : std_logic_vector(7 downto 0) := "00000000";
    --flag is used to identify clock writing clock period, so the code will write in RAM(flag)
    -- 00 --> write in RAM(0)
    -- 01 --> write in RAM(1)
    -- 11 --> finish
    variable height, width : std_logic_vector(7 downto 0) := "00000000";
    variable flag: std_logic_vector(1 downto 0) := "00";
    variable compute : std_logic := '0';
    variable can_start : std_logic := '0';
    begin  
        if (i_rst = '1') then      --reinizializzazione di tutte le variabile ai loro valori predefiniti
            adr := "0000000000000010";
            
            col := "00000000";
            row := "00000000";
            soglia := "00000000";
            
            top := "00000000"; 
            bottom := "00000000"; 
            left := "00000000"; 
            right:= "00000000";
            
            found := '0';
            sostegno := '0';
            
            x := "00000000";
            y := "00000000";
            h:= "00000000";
            
            area := "0000000000000000";
            
            a0 := "00000000"; 
            a1 := "00000000";
            --flag is used to identify clock writing clock period, so the code will write in RAM(flag)
            -- 00 --> write in RAM(0)
            -- 01 --> write in RAM(1)
            -- 11 --> finish
            
            height := "00000000";
            width := "00000000";
            
            flag:= "00";
            
            compute := '0';
            
            can_start := '0';
        
        elsif i_start = '1' then
            can_start := '1';
        elsif can_start = '1' then
            
            if rising_edge(i_clk) then
                o_address <= adr; 
                --o_data <= x;
       
                o_en <= '1';
                if adr = "0000000000000100" then
                    col := i_data;
                elsif adr = "0000000000000101" then
                    row := i_data;
                elsif adr = "0000000000000110" then
                    soglia := i_data;
                    top := row;
                    left := col;
                    sh <= std_logic_vector((UNSIGNED(row)*UNSIGNED(col)) +4);
                else
                                             
                    if (i_data >= soglia) then
                        found := '1';
                        --x := std_logic_vector((UNSIGNED(adr) - 6) / UNSIGNED(col));
                        --y := std_logic_vector((UNSIGNED(adr) - 6) mod UNSIGNED(col));
                        if x < top then
                            top := x;
                        end if;
                        if x > bottom then
                            bottom := x;
                        end if;
                        if y < left then
                            left := y;
                        end if;
                        if y > right then
                            right := y;
                        end if;     
                    end if;
                end if;
            
                --scol <= col;
                --srow <= row;
                --ssoglia <= soglia;
            
                --if here, i red all the data
                if(adr = std_logic_vector(UNSIGNED(sh) +2) and sostegno = '1') then
                    sarea <= area;
                    --adr := std_logic_vector(UNSIGNED(adr) - 1);
                    if (found = '1') then 
                        height := std_logic_vector(UNSIGNED(bottom) - UNSIGNED(top) + 1);
                        width := std_logic_vector(UNSIGNED(right) - UNSIGNED(left) + 1);
                        --area := std_logic_vector(UNSIGNED(swidth)*UNSIGNED(sheight));
                    else
                        height := "00000000";
                        width := "00000000";         
                        --area := "0000000000000000";      
                    end if;
                
                    sheight <= height;
                    swidth <= width;
                
                    if compute = '0' then
                        compute := '1';
                        area := std_logic_vector(UNSIGNED(height)*UNSIGNED(width));
                    end if;
                
                    --calcolo area 
               
                    if flag = "00" then
                        --area := std_logic_vector(UNSIGNED(sheight)*UNSIGNED(swidth));
                    
                        a1 := area(15 downto 8);
                        a0 := area(7 downto 0);
                        o_data <= a0;
                        --o_data <= "00000000";
                        o_address <= "0000000000000000";
                        o_we <= '1';
                        flag := "01";
                        sa0 <= a0;
                        sa1 <= a1;
                    else
                        if flag = "01" then
                            o_data <= a1;
                            --o_data <= "00000000";
                            o_address <= "0000000000000001";
                            o_we <= '1';
                            flag := "10";
                        else
                            if flag = "10" then
                                flag := "11";
                                o_done <= '1';
                                o_we <= '0';
                            else 
                                o_done <= '0';
                            end if; 
                        end if;
                    end if; 
                else     
                    --sub process that counts x and y to know what cell i'm reading      
                    if (adr > "0000000000000110") then
                        sostegno := '1';
                        if (y = std_logic_vector(UNSIGNED(col) - 1)) then
                            y := "00000000";
                            x := std_logic_vector(UNSIGNED(x) + 1);
                        else
                            y := std_logic_vector(UNSIGNED(y) + 1);
                        end if;
                    end if;
                    adr := std_logic_vector(UNSIGNED(adr) + 1);
                end if;
            end if;  
        end if;
    end process;
end Behavioral;