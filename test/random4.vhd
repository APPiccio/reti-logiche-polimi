library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb is
end project_tb;
architecture projecttb of project_tb is
constant c_CLOCK_PERIOD		: time := 15 ns;
signal   tb_done		: std_logic;
signal   mem_address		: std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst		    : std_logic := '0';
signal   tb_start		: std_logic := '0';
signal   tb_clk		    : std_logic := '0';
signal   mem_o_data,mem_i_data		: std_logic_vector (7 downto 0);
signal   enable_wire  		: std_logic;
signal   mem_we		: std_logic;
type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);
signal RAM: ram_type := (2 => "00010001", 3 => "01010010", 4 => "01000011",
 5 => "11010010",
 6 => "10001010",
 7 => "11000111",
 8 => "10110111",
 9 => "01000110",
 10 => "01110011",
 11 => "10111000",
 12 => "00111101",
 13 => "10011101",
 14 => "11010101",
 15 => "00110010",
 16 => "01010101",
 17 => "10011011",
 18 => "01000000",
 19 => "01100110",
 20 => "01101000",
 21 => "01101110",
 22 => "01010011",
 23 => "01001001",
 24 => "01010100",
 25 => "00010101",
 26 => "01100010",
 27 => "11110111",
 28 => "01101000",
 29 => "01100010",
 30 => "00010100",
 31 => "00110110",
 32 => "10000111",
 33 => "00111111",
 34 => "11001100",
 35 => "00110010",
 36 => "00000001",
 37 => "11010011",
 38 => "10010111",
 39 => "01111110",
 40 => "10101101",
 41 => "01110010",
 42 => "01110010",
 43 => "00011000",
 44 => "11010000",
 45 => "11000001",
 46 => "10100111",
 47 => "10101111",
 48 => "11101110",
 49 => "10010101",
 50 => "10101110",
 51 => "01000101",
 52 => "01001110",
 53 => "01101101",
 54 => "00000111",
 55 => "11011111",
 56 => "01011001",
 57 => "01011100",
 58 => "00101010",
 59 => "10110100",
 60 => "00011010",
 61 => "01110110",
 62 => "11001010",
 63 => "00111010",
 64 => "01101011",
 65 => "01001010",
 66 => "11010010",
 67 => "01101110",
 68 => "10001000",
 69 => "10000001",
 70 => "11000010",
 71 => "10101011",
 72 => "00101100",
 73 => "11110100",
 74 => "00000110",
 75 => "01001110",
 76 => "00100111",
 77 => "11000010",
 78 => "01001010",
 79 => "01000111",
 80 => "11000110",
 81 => "00011111",
 82 => "01001110",
 83 => "01100101",
 84 => "00011010",
 85 => "00111110",
 86 => "10010000",
 87 => "11010100",
 88 => "11110100",
 89 => "11010110",
 90 => "01000111",
 91 => "00000111",
 92 => "01110110",
 93 => "11010111",
 94 => "01010101",
 95 => "00101111",
 96 => "10110001",
 97 => "01100001",
 98 => "10111110",
 99 => "10101001",
 100 => "10000100",
 101 => "10011100",
 102 => "10001000",
 103 => "00111110",
 104 => "10100110",
 105 => "11000111",
 106 => "00000101",
 107 => "01111010",
 108 => "00010000",
 109 => "11101001",
 110 => "11000111",
 111 => "00101100",
 112 => "00101111",
 113 => "11000011",
 114 => "00010110",
 115 => "00000011",
 116 => "01100100",
 117 => "00010001",
 118 => "01011010",
 119 => "10110101",
 120 => "11111011",
 121 => "00111010",
 122 => "10001111",
 123 => "01100110",
 124 => "01100001",
 125 => "11011000",
 126 => "00000100",
 127 => "00101110",
 128 => "01010111",
 129 => "11101111",
 130 => "10110010",
 131 => "10010101",
 132 => "10010000",
 133 => "00001100",
 134 => "01010000",
 135 => "11101011",
 136 => "01011101",
 137 => "00010000",
 138 => "10001010",
 139 => "00110001",
 140 => "00111010",
 141 => "00110111",
 142 => "10000001",
 143 => "01111100",
 144 => "01000011",
 145 => "10111110",
 146 => "01100101",
 147 => "00010010",
 148 => "11111001",
 149 => "10010000",
 150 => "00110010",
 151 => "10101100",
 152 => "00001011",
 153 => "01110010",
 154 => "01101101",
 155 => "01100111",
 156 => "01011000",
 157 => "10001100",
 158 => "10001110",
 159 => "11100010",
 160 => "10101111",
 161 => "00001110",
 162 => "01011011",
 163 => "11101011",
 164 => "10100101",
 165 => "00010010",
 166 => "01000100",
 167 => "11010100",
 168 => "11101110",
 169 => "00010011",
 170 => "01111000",
 171 => "01011001",
 172 => "00011110",
 173 => "11010010",
 174 => "10010010",
 175 => "00010000",
 176 => "01000000",
 177 => "11000001",
 178 => "00011101",
 179 => "10111011",
 180 => "00010000",
 181 => "11110011",
 182 => "10011001",
 183 => "11101010",
 184 => "01101000",
 185 => "11110111",
 186 => "01110011",
 187 => "10001011",
 188 => "01111100",
 189 => "00111110",
 190 => "00010101",
 191 => "00011001",
 192 => "10101111",
 193 => "01110111",
 194 => "01011011",
 195 => "01100101",
 196 => "11101111",
 197 => "10111100",
 198 => "10001010",
 199 => "11001111",
 200 => "11111001",
 201 => "11010110",
 202 => "11101100",
 203 => "11100101",
 204 => "11010101",
 205 => "10000101",
 206 => "10110100",
 207 => "11000000",
 208 => "01011001",
 209 => "10010000",
 210 => "11110001",
 211 => "00000011",
 212 => "00110110",
 213 => "00111110",
 214 => "00010001",
 215 => "10011101",
 216 => "11001010",
 217 => "10010001",
 218 => "01110101",
 219 => "01000111",
 220 => "11001001",
 221 => "01110100",
 222 => "01010000",
 223 => "00000100",
 224 => "00010100",
 225 => "00110000",
 226 => "00001110",
 227 => "11110010",
 228 => "10001100",
 229 => "01110010",
 230 => "11000011",
 231 => "00100111",
 232 => "00111100",
 233 => "11111001",
 234 => "10101011",
 235 => "01110010",
 236 => "00001010",
 237 => "10100111",
 238 => "01110111",
 239 => "01010111",
 240 => "01100000",
 241 => "01001011",
 242 => "01100100",
 243 => "01011111",
 244 => "00100101",
 245 => "10011000",
 246 => "01001000",
 247 => "00101110",
 248 => "10100011",
 249 => "00001000",
 250 => "11100111",
 251 => "10101011",
 252 => "00110100",
 253 => "11101000",
 254 => "00010010",
 255 => "01110001",
 256 => "01111001",
 257 => "01100000",
 258 => "10101000",
 259 => "00011101",
 260 => "00010111",
 261 => "10100110",
 262 => "00111111",
 263 => "01110110",
 264 => "00000100",
 265 => "10111000",
 266 => "01100001",
 267 => "01000100",
 268 => "10011110",
 269 => "01111011",
 270 => "11011001",
 271 => "01111101",
 272 => "10110101",
 273 => "01000110",
 274 => "01010001",
 275 => "11110101",
 276 => "01011101",
 277 => "10011001",
 278 => "11100111",
 279 => "10001010",
 280 => "01101000",
 281 => "01010010",
 282 => "00100000",
 283 => "00011010",
 284 => "11011001",
 285 => "01011010",
 286 => "11101111",
 287 => "00111010",
 288 => "01001100",
 289 => "11101011",
 290 => "00001100",
 291 => "00101011",
 292 => "10011000",
 293 => "11000011",
 294 => "01011011",
 295 => "11111110",
 296 => "01111110",
 297 => "11100100",
 298 => "01101010",
 299 => "01001001",
 300 => "01010110",
 301 => "00011001",
 302 => "01111100",
 303 => "01111001",
 304 => "01011100",
 305 => "11010000",
 306 => "00001000",
 307 => "00111000",
 308 => "00100011",
 309 => "11111011",
 310 => "11011110",
 311 => "10111001",
 312 => "01110111",
 313 => "10101001",
 314 => "10000100",
 315 => "00110100",
 316 => "01100010",
 317 => "00110011",
 318 => "10010100",
 319 => "00000100",
 320 => "01101010",
 321 => "11000001",
 322 => "10100011",
 323 => "11010101",
 324 => "10100001",
 325 => "00100010",
 326 => "01010111",
 327 => "01010010",
 328 => "10000100",
 329 => "01000101",
 330 => "00001001",
 331 => "10000101",
 332 => "10111010",
 333 => "11100011",
 334 => "10011001",
 335 => "01101000",
 336 => "10101010",
 337 => "10000100",
 338 => "01101001",
 339 => "01001110",
 340 => "11010101",
 341 => "01110010",
 342 => "01000010",
 343 => "11001101",
 344 => "11000011",
 345 => "01111001",
 346 => "01011110",
 347 => "00101110",
 348 => "01101000",
 349 => "01010011",
 350 => "10011101",
 351 => "11101101",
 352 => "11001010",
 353 => "01111001",
 354 => "11100111",
 355 => "01000000",
 356 => "11111101",
 357 => "11000000",
 358 => "01000110",
 359 => "11101110",
 360 => "00000110",
 361 => "10110001",
 362 => "01010111",
 363 => "01000010",
 364 => "11101110",
 365 => "00011101",
 366 => "11101111",
 367 => "00001001",
 368 => "01010100",
 369 => "10000011",
 370 => "01111110",
 371 => "10011000",
 372 => "11101111",
 373 => "10110101",
 374 => "10011000",
 375 => "11010100",
 376 => "00011111",
 377 => "01010101",
 378 => "00100000",
 379 => "11000111",
 380 => "00001011",
 381 => "00100000",
 382 => "11111011",
 383 => "11001100",
 384 => "00110101",
 385 => "01001010",
 386 => "11011110",
 387 => "10001111",
 388 => "10100010",
 389 => "10000011",
 390 => "00110010",
 391 => "01101011",
 392 => "10011010",
 393 => "10010000",
 394 => "10001000",
 395 => "01001110",
 396 => "10011111",
 397 => "01011000",
 398 => "10010111",
 399 => "10000101",
 400 => "11111100",
 401 => "00011110",
 402 => "10100101",
 403 => "00110101",
 404 => "11011011",
 405 => "10110101",
 406 => "00011001",
 407 => "00101110",
 408 => "01101001",
 409 => "11100100",
 410 => "11001011",
 411 => "01111101",
 412 => "11000001",
 413 => "00000011",
 414 => "10101100",
 415 => "11010110",
 416 => "01111110",
 417 => "01111010",
 418 => "00010001",
 419 => "11010000",
 420 => "10000010",
 421 => "11000011",
 422 => "11010100",
 423 => "11100111",
 424 => "10010010",
 425 => "11001111",
 426 => "10111101",
 427 => "01101000",
 428 => "01101011",
 429 => "01000011",
 430 => "11011011",
 431 => "00000010",
 432 => "11111101",
 433 => "11101011",
 434 => "11111101",
 435 => "11101100",
 436 => "01000001",
 437 => "10000110",
 438 => "01010011",
 439 => "01010101",
 440 => "01100000",
 441 => "11101010",
 442 => "01100001",
 443 => "10100110",
 444 => "11000110",
 445 => "00011011",
 446 => "00111110",
 447 => "10110100",
 448 => "00100000",
 449 => "10010001",
 450 => "11011101",
 451 => "10111010",
 452 => "11111101",
 453 => "00111101",
 454 => "10011000",
 455 => "01011101",
 456 => "00000010",
 457 => "00100001",
 458 => "11101011",
 459 => "01111011",
 460 => "11100001",
 461 => "11000010",
 462 => "00101011",
 463 => "10110110",
 464 => "00011000",
 465 => "10100110",
 466 => "10101011",
 467 => "00001110",
 468 => "11010100",
 469 => "01100101",
 470 => "11110101",
 471 => "00110101",
 472 => "10010101",
 473 => "11010101",
 474 => "01110111",
 475 => "01100001",
 476 => "11110011",
 477 => "01010001",
 478 => "00101001",
 479 => "10101011",
 480 => "11100011",
 481 => "01101000",
 482 => "00011000",
 483 => "00110011",
 484 => "01110100",
 485 => "11010011",
 486 => "01000110",
 487 => "00110110",
 488 => "01011101",
 489 => "10111000",
 490 => "11010010",
 491 => "00100100",
 492 => "11000001",
 493 => "00110100",
 494 => "11010100",
 495 => "10111110",
 496 => "00110010",
 497 => "00111111",
 498 => "11010110",
 499 => "00001000",
 500 => "11110100",
 501 => "11010110",
 502 => "01010111",
 503 => "00000011",
 504 => "00010101",
 505 => "11000010",
 506 => "10011011",
 507 => "10101100",
 508 => "00000000",
 509 => "01011011",
 510 => "11000000",
 511 => "01110100",
 512 => "11101100",
 513 => "11011010",
 514 => "11110110",
 515 => "11001010",
 516 => "00000001",
 517 => "11111110",
 518 => "01010000",
 519 => "01010011",
 520 => "00011010",
 521 => "00111101",
 522 => "11000000",
 523 => "00010111",
 524 => "01001100",
 525 => "01100010",
 526 => "00100011",
 527 => "01110000",
 528 => "01110011",
 529 => "01000111",
 530 => "00110001",
 531 => "10000100",
 532 => "01001101",
 533 => "00001110",
 534 => "01011101",
 535 => "00110011",
 536 => "00001000",
 537 => "01000100",
 538 => "00111111",
 539 => "00010111",
 540 => "10000000",
 541 => "01100111",
 542 => "00001110",
 543 => "10001010",
 544 => "11111010",
 545 => "00001000",
 546 => "00001101",
 547 => "10110110",
 548 => "10101000",
 549 => "11010000",
 550 => "10011101",
 551 => "10101011",
 552 => "10000101",
 553 => "10111101",
 554 => "00010000",
 555 => "01011110",
 556 => "10100110",
 557 => "10101100",
 558 => "01100000",
 559 => "01001111",
 560 => "10000011",
 561 => "01001000",
 562 => "11010000",
 563 => "01010011",
 564 => "10100000",
 565 => "11101111",
 566 => "11110111",
 567 => "11011010",
 568 => "11001010",
 569 => "00101010",
 570 => "11010100",
 571 => "11110101",
 572 => "11110001",
 573 => "11111100",
 574 => "01000010",
 575 => "11000001",
 576 => "10001010",
 577 => "01001111",
 578 => "00010000",
 579 => "10001101",
 580 => "01000010",
 581 => "01101111",
 582 => "11001111",
 583 => "10101111",
 584 => "00110100",
 585 => "11010000",
 586 => "11111000",
 587 => "01001101",
 588 => "00110011",
 589 => "11111010",
 590 => "10010000",
 591 => "01001000",
 592 => "00100111",
 593 => "00100100",
 594 => "00001100",
 595 => "11001111",
 596 => "10101100",
 597 => "01001100",
 598 => "00110111",
 599 => "00110100",
 600 => "11110010",
 601 => "11000100",
 602 => "00000000",
 603 => "10001110",
 604 => "11010011",
 605 => "00100010",
 606 => "00101110",
 607 => "00110000",
 608 => "00100010",
 609 => "11100110",
 610 => "00000001",
 611 => "01001101",
 612 => "01010101",
 613 => "01100011",
 614 => "11110001",
 615 => "01110110",
 616 => "00000001",
 617 => "00001111",
 618 => "01010100",
 619 => "11001010",
 620 => "11111011",
 621 => "00110111",
 622 => "00000111",
 623 => "10001000",
 624 => "11011111",
 625 => "00001100",
 626 => "10010011",
 627 => "10101111",
 628 => "10110001",
 629 => "00110010",
 630 => "01101001",
 631 => "00111001",
 632 => "11111110",
 633 => "11100010",
 634 => "01111011",
 635 => "01110101",
 636 => "01011110",
 637 => "10100011",
 638 => "01110111",
 639 => "11110000",
 640 => "00011111",
 641 => "00111101",
 642 => "00010101",
 643 => "00101100",
 644 => "01110101",
 645 => "11011000",
 646 => "01111011",
 647 => "00101011",
 648 => "10111100",
 649 => "00111101",
 650 => "11110110",
 651 => "11000110",
 652 => "10000001",
 653 => "10011110",
 654 => "11110000",
 655 => "11010000",
 656 => "10000000",
 657 => "01001010",
 658 => "11110000",
 659 => "10001000",
 660 => "00100001",
 661 => "00001111",
 662 => "10100010",
 663 => "10010110",
 664 => "01010000",
 665 => "01110000",
 666 => "10110110",
 667 => "10001101",
 668 => "00000010",
 669 => "00110001",
 670 => "11100111",
 671 => "01101001",
 672 => "00110000",
 673 => "10100011",
 674 => "00111001",
 675 => "01001111",
 676 => "10011010",
 677 => "00000110",
 678 => "00001110",
 679 => "00010000",
 680 => "01000000",
 681 => "01111101",
 682 => "11001101",
 683 => "10010000",
 684 => "01010101",
 685 => "01110111",
 686 => "10010001",
 687 => "01000111",
 688 => "10011010",
 689 => "11111001",
 690 => "01010001",
 691 => "11000101",
 692 => "10010111",
 693 => "11101110",
 694 => "10111000",
 695 => "10111000",
 696 => "00110101",
 697 => "11011111",
 698 => "11010010",
 699 => "11001000",
 700 => "10001011",
 701 => "11111101",
 702 => "01101101",
 703 => "01010010",
 704 => "01101001",
 705 => "10101100",
 706 => "11001010",
 707 => "11100110",
 708 => "01100010",
 709 => "10111100",
 710 => "10000111",
 711 => "11010011",
 712 => "10100100",
 713 => "00010100",
 714 => "11011010",
 715 => "01111111",
 716 => "10011110",
 717 => "11101001",
 718 => "11011110",
 719 => "00000000",
 720 => "01100100",
 721 => "00001001",
 722 => "01001001",
 723 => "01101001",
 724 => "10000000",
 725 => "11001100",
 726 => "00101001",
 727 => "00001100",
 728 => "01011011",
 729 => "11100101",
 730 => "01001010",
 731 => "01011110",
 732 => "11000100",
 733 => "10111001",
 734 => "00011001",
 735 => "01110100",
 736 => "01000000",
 737 => "00011111",
 738 => "11011011",
 739 => "11011111",
 740 => "10010101",
 741 => "10100100",
 742 => "01100000",
 743 => "11111000",
 744 => "11100010",
 745 => "11000001",
 746 => "01110110",
 747 => "10111011",
 748 => "00011010",
 749 => "01111101",
 750 => "00101000",
 751 => "01001010",
 752 => "00000111",
 753 => "01111011",
 754 => "10111111",
 755 => "00001100",
 756 => "01011111",
 757 => "10111110",
 758 => "00011110",
 759 => "10011101",
 760 => "01111010",
 761 => "11101111",
 762 => "01011110",
 763 => "10010000",
 764 => "00101011",
 765 => "01100000",
 766 => "10101111",
 767 => "11110101",
 768 => "01000010",
 769 => "01011001",
 770 => "10101001",
 771 => "11010100",
 772 => "11011101",
 773 => "01110001",
 774 => "00111011",
 775 => "10010000",
 776 => "01110011",
 777 => "11001000",
 778 => "10011101",
 779 => "00000010",
 780 => "01010111",
 781 => "10111100",
 782 => "01111000",
 783 => "10001001",
 784 => "00101010",
 785 => "01001100",
 786 => "00101010",
 787 => "01110000",
 788 => "11010101",
 789 => "11100100",
 790 => "00010111",
 791 => "10001110",
 792 => "10111110",
 793 => "01000010",
 794 => "10001010",
 795 => "10110110",
 796 => "00000111",
 797 => "10000100",
 798 => "00011110",
 799 => "00011000",
 800 => "01000000",
 801 => "11001001",
 802 => "11010000",
 803 => "00101010",
 804 => "01000111",
 805 => "10110001",
 806 => "00011100",
 807 => "11010001",
 808 => "11011101",
 809 => "10001011",
 810 => "01011100",
 811 => "11001010",
 812 => "10001000",
 813 => "10101001",
 814 => "00101111",
 815 => "01110100",
 816 => "11011001",
 817 => "10000111",
 818 => "01001111",
 819 => "00100110",
 820 => "00110001",
 821 => "00110110",
 822 => "11110110",
 823 => "11010010",
 824 => "01001001",
 825 => "01000101",
 826 => "01100111",
 827 => "01001011",
 828 => "11001011",
 829 => "01110011",
 830 => "01111001",
 831 => "11111101",
 832 => "10011110",
 833 => "11110001",
 834 => "10100000",
 835 => "10011010",
 836 => "11111110",
 837 => "00010011",
 838 => "11011111",
 839 => "11110010",
 840 => "01111101",
 841 => "01011101",
 842 => "01101101",
 843 => "00010010",
 844 => "01100001",
 845 => "00100010",
 846 => "10101110",
 847 => "10001000",
 848 => "10100010",
 849 => "11111101",
 850 => "10001010",
 851 => "10010101",
 852 => "01001111",
 853 => "10011011",
 854 => "01010001",
 855 => "10111010",
 856 => "00010100",
 857 => "10110001",
 858 => "01110011",
 859 => "10101111",
 860 => "00000000",
 861 => "11010010",
 862 => "10011101",
 863 => "10011000",
 864 => "00101001",
 865 => "01011010",
 866 => "01101111",
 867 => "00101011",
 868 => "00100001",
 869 => "00010100",
 870 => "01111110",
 871 => "00100000",
 872 => "11101001",
 873 => "01000111",
 874 => "11110110",
 875 => "11001101",
 876 => "01000011",
 877 => "00110110",
 878 => "01011010",
 879 => "10100010",
 880 => "11000010",
 881 => "11111001",
 882 => "01010111",
 883 => "10011000",
 884 => "01011100",
 885 => "11000011",
 886 => "00110101",
 887 => "10010010",
 888 => "10111001",
 889 => "00001101",
 890 => "01101100",
 891 => "11100011",
 892 => "01100111",
 893 => "10101101",
 894 => "00010100",
 895 => "00110001",
 896 => "10101110",
 897 => "10100100",
 898 => "01100001",
 899 => "01010110",
 900 => "00010100",
 901 => "00000100",
 902 => "11100111",
 903 => "01110001",
 904 => "11000000",
 905 => "01111111",
 906 => "01101010",
 907 => "11010010",
 908 => "11110010",
 909 => "11011011",
 910 => "01111101",
 911 => "01010100",
 912 => "00110110",
 913 => "01100001",
 914 => "11010010",
 915 => "01000011",
 916 => "01000001",
 917 => "10010010",
 918 => "01010001",
 919 => "00101110",
 920 => "01001110",
 921 => "10011100",
 922 => "00010111",
 923 => "11101100",
 924 => "11111010",
 925 => "11101100",
 926 => "10011100",
 927 => "01001010",
 928 => "10111010",
 929 => "11110111",
 930 => "11101101",
 931 => "11010101",
 932 => "01111001",
 933 => "11100011",
 934 => "00001000",
 935 => "10101101",
 936 => "01110000",
 937 => "01101110",
 938 => "11011001",
 939 => "00000011",
 940 => "01101111",
 941 => "01110001",
 942 => "10101111",
 943 => "10010001",
 944 => "01011111",
 945 => "11101110",
 946 => "11011111",
 947 => "01110101",
 948 => "00110111",
 949 => "10110011",
 950 => "10011101",
 951 => "00010000",
 952 => "10011001",
 953 => "01101100",
 954 => "00101101",
 955 => "00001101",
 956 => "01111100",
 957 => "11001110",
 958 => "11011111",
 959 => "01000101",
 960 => "01100001",
 961 => "00010010",
 962 => "01010101",
 963 => "10000011",
 964 => "00010111",
 965 => "01011011",
 966 => "11011010",
 967 => "10000000",
 968 => "11111010",
 969 => "00101110",
 970 => "11010010",
 971 => "10001110",
 972 => "01111001",
 973 => "00010110",
 974 => "01110111",
 975 => "10001100",
 976 => "10110111",
 977 => "11001111",
 978 => "00011111",
 979 => "01100111",
 980 => "01001100",
 981 => "10001111",
 982 => "10101100",
 983 => "00000101",
 984 => "11010101",
 985 => "11001011",
 986 => "01110011",
 987 => "11000110",
 988 => "10100010",
 989 => "11110111",
 990 => "01001001",
 991 => "00001011",
 992 => "00111100",
 993 => "00111111",
 994 => "00011101",
 995 => "11010001",
 996 => "10010111",
 997 => "10101101",
 998 => "00111001",
 999 => "10111110",
 1000 => "00100100",
 1001 => "11101110",
 1002 => "11001100",
 1003 => "01111111",
 1004 => "01001010",
 1005 => "00011010",
 1006 => "00010100",
 1007 => "00100111",
 1008 => "11110000",
 1009 => "10011110",
 1010 => "11100001",
 1011 => "10111110",
 1012 => "01100101",
 1013 => "01110101",
 1014 => "11100110",
 1015 => "11000111",
 1016 => "11110101",
 1017 => "00001001",
 1018 => "00000101",
 1019 => "11010000",
 1020 => "10110110",
 1021 => "01110010",
 1022 => "00000100",
 1023 => "01100010",
 1024 => "01111001",
 1025 => "01100001",
 1026 => "11111001",
 1027 => "00010011",
 1028 => "11100101",
 1029 => "10000000",
 1030 => "11111001",
 1031 => "00110101",
 1032 => "00110100",
 1033 => "11001100",
 1034 => "00100111",
 1035 => "00111011",
 1036 => "00110101",
 1037 => "11100010",
 1038 => "01111000",
 1039 => "01011010",
 1040 => "01011001",
 1041 => "10101010",
 1042 => "10000001",
 1043 => "11101101",
 1044 => "00011111",
 1045 => "00001011",
 1046 => "00010110",
 1047 => "10000010",
 1048 => "10010000",
 1049 => "11000101",
 1050 => "01111100",
 1051 => "00011100",
 1052 => "11001010",
 1053 => "11101101",
 1054 => "11110111",
 1055 => "10011000",
 1056 => "10010010",
 1057 => "01001101",
 1058 => "00110001",
 1059 => "11001010",
 1060 => "00111111",
 1061 => "11100010",
 1062 => "01110111",
 1063 => "00110110",
 1064 => "11011111",
 1065 => "01100010",
 1066 => "00011000",
 1067 => "10100011",
 1068 => "01000100",
 1069 => "00110000",
 1070 => "00010000",
 1071 => "11100111",
 1072 => "00100101",
 1073 => "01000111",
 1074 => "00111110",
 1075 => "10001110",
 1076 => "01110011",
 1077 => "01010011",
 1078 => "01001100",
 1079 => "00011101",
 1080 => "01000111",
 1081 => "11000000",
 1082 => "00110110",
 1083 => "10101100",
 1084 => "11101000",
 1085 => "11100111",
 1086 => "00000110",
 1087 => "11010000",
 1088 => "00011000",
 1089 => "00101001",
 1090 => "11000000",
 1091 => "10101001",
 1092 => "10101011",
 1093 => "00101111",
 1094 => "10010100",
 1095 => "01011010",
 1096 => "10001110",
 1097 => "10001000",
 1098 => "10011000",
 1099 => "01110010",
 1100 => "10111100",
 1101 => "10001100",
 1102 => "01100001",
 1103 => "01110010",
 1104 => "00101101",
 1105 => "01100010",
 1106 => "11010101",
 1107 => "01010111",
 1108 => "00010000",
 1109 => "11111101",
 1110 => "10001100",
 1111 => "10001110",
 1112 => "10101001",
 1113 => "01010001",
 1114 => "00100010",
 1115 => "00100011",
 1116 => "11101110",
 1117 => "01111110",
 1118 => "11011101",
 1119 => "10100100",
 1120 => "01110111",
 1121 => "11000010",
 1122 => "01000000",
 1123 => "01111101",
 1124 => "10110110",
 1125 => "10100100",
 1126 => "00100010",
 1127 => "01011101",
 1128 => "11101001",
 1129 => "11011111",
 1130 => "11110110",
 1131 => "01111101",
 1132 => "11000010",
 1133 => "11101111",
 1134 => "10010110",
 1135 => "10111000",
 1136 => "10011111",
 1137 => "11001110",
 1138 => "01101111",
 1139 => "00000110",
 1140 => "00100111",
 1141 => "00110001",
 1142 => "10001101",
 1143 => "10110001",
 1144 => "01100110",
 1145 => "00111001",
 1146 => "00101100",
 1147 => "10000000",
 1148 => "00011010",
 1149 => "11101101",
 1150 => "01010101",
 1151 => "11000100",
 1152 => "10001110",
 1153 => "00001011",
 1154 => "11010001",
 1155 => "10010000",
 1156 => "01111011",
 1157 => "00110100",
 1158 => "01001000",
 1159 => "00000001",
 1160 => "01110110",
 1161 => "10010010",
 1162 => "00010000",
 1163 => "00010000",
 1164 => "00100101",
 1165 => "01011010",
 1166 => "00010111",
 1167 => "00001010",
 1168 => "00000110",
 1169 => "10001100",
 1170 => "10011111",
 1171 => "01111100",
 1172 => "00011101",
 1173 => "00001101",
 1174 => "00100001",
 1175 => "11101000",
 1176 => "00011000",
 1177 => "10010110",
 1178 => "00000101",
 1179 => "10000101",
 1180 => "00010000",
 1181 => "01111110",
 1182 => "00001110",
 1183 => "11111000",
 1184 => "01111011",
 1185 => "01011011",
 1186 => "00110100",
 1187 => "01111010",
 1188 => "10100110",
 1189 => "00001000",
 1190 => "01000110",
 1191 => "00000010",
 1192 => "00001000",
 1193 => "11110010",
 1194 => "00111000",
 1195 => "10000110",
 1196 => "00110110",
 1197 => "10101101",
 1198 => "00011111",
 1199 => "00100001",
 1200 => "01110101",
 1201 => "11010111",
 1202 => "01000100",
 1203 => "01110010",
 1204 => "00100101",
 1205 => "01110111",
 1206 => "01100001",
 1207 => "11010111",
 1208 => "00111101",
 1209 => "10010010",
 1210 => "11111100",
 1211 => "10011101",
 1212 => "00101010",
 1213 => "10011010",
 1214 => "00110100",
 1215 => "11101001",
 1216 => "01011000",
 1217 => "10001101",
 1218 => "11100000",
 1219 => "01000111",
 1220 => "11011110",
 1221 => "00110010",
 1222 => "01110010",
 1223 => "00100101",
 1224 => "00000100",
 1225 => "01011110",
 1226 => "01000011",
 1227 => "01100010",
 1228 => "00110001",
 1229 => "01001111",
 1230 => "10001101",
 1231 => "10111000",
 1232 => "11100011",
 1233 => "10101001",
 1234 => "11001100",
 1235 => "01110010",
 1236 => "10011110",
 1237 => "00001011",
 1238 => "00100000",
 1239 => "10110111",
 1240 => "00111111",
 1241 => "10101000",
 1242 => "11011110",
 1243 => "01011111",
 1244 => "10000100",
 1245 => "11000101",
 1246 => "10101101",
 1247 => "10100100",
 1248 => "10110010",
 1249 => "10100010",
 1250 => "00110000",
 1251 => "01001111",
 1252 => "10000100",
 1253 => "01111011",
 1254 => "01011110",
 1255 => "11101100",
 1256 => "10101011",
 1257 => "10001101",
 1258 => "01010011",
 1259 => "01001111",
 1260 => "10011000",
 1261 => "10111001",
 1262 => "01000100",
 1263 => "01010110",
 1264 => "00001010",
 1265 => "00000001",
 1266 => "11101011",
 1267 => "10100110",
 1268 => "00010111",
 1269 => "10001100",
 1270 => "10010000",
 1271 => "01000101",
 1272 => "01101111",
 1273 => "11101101",
 1274 => "00001100",
 1275 => "00110001",
 1276 => "00110100",
 1277 => "01000100",
 1278 => "11100010",
 1279 => "11010011",
 1280 => "00001101",
 1281 => "00111100",
 1282 => "10101111",
 1283 => "11110110",
 1284 => "01011110",
 1285 => "11101010",
 1286 => "01001111",
 1287 => "00000011",
 1288 => "10111110",
 1289 => "01011100",
 1290 => "11011111",
 1291 => "01001110",
 1292 => "00011010",
 1293 => "01000100",
 1294 => "00011111",
 1295 => "01100111",
 1296 => "11001001",
 1297 => "11100101",
 1298 => "01110010",
 1299 => "00100000",
 1300 => "10000101",
 1301 => "11001010",
 1302 => "00000010",
 1303 => "10100101",
 1304 => "00000010",
 1305 => "11100100",
 1306 => "10010100",
 1307 => "00111110",
 1308 => "01111001",
 1309 => "01100010",
 1310 => "11110000",
 1311 => "11110011",
 1312 => "10001110",
 1313 => "00101100",
 1314 => "01100110",
 1315 => "11111001",
 1316 => "10101110",
 1317 => "11101110",
 1318 => "11110100",
 1319 => "01110101",
 1320 => "01101000",
 1321 => "11010001",
 1322 => "00010010",
 1323 => "01010101",
 1324 => "11110011",
 1325 => "01000100",
 1326 => "10101000",
 1327 => "10011111",
 1328 => "00110111",
 1329 => "01100110",
 1330 => "11110101",
 1331 => "11100011",
 1332 => "10001010",
 1333 => "01101000",
 1334 => "11001000",
 1335 => "01111101",
 1336 => "00010101",
 1337 => "01111001",
 1338 => "10111101",
 1339 => "01100000",
 1340 => "00000011",
 1341 => "01000010",
 1342 => "11111010",
 1343 => "01000111",
 1344 => "01100110",
 1345 => "10001101",
 1346 => "01110111",
 1347 => "11110101",
 1348 => "01010011",
 1349 => "11000111",
 1350 => "01000011",
 1351 => "11100110",
 1352 => "10110010",
 1353 => "11110110",
 1354 => "01001011",
 1355 => "10000001",
 1356 => "00001101",
 1357 => "10100001",
 1358 => "00010001",
 1359 => "01100111",
 1360 => "11000010",
 1361 => "00101000",
 1362 => "10110010",
 1363 => "01101011",
 1364 => "11110001",
 1365 => "01110011",
 1366 => "00101101",
 1367 => "10101101",
 1368 => "10100000",
 1369 => "01011000",
 1370 => "00101010",
 1371 => "11000010",
 1372 => "01100111",
 1373 => "10000100",
 1374 => "00000011",
 1375 => "11001001",
 1376 => "10101110",
 1377 => "00111111",
 1378 => "11100000",
 1379 => "00001001",
 1380 => "00010010",
 1381 => "00001001",
 1382 => "10011110",
 1383 => "10100111",
 1384 => "00100101",
 1385 => "00101111",
 1386 => "00101010",
 1387 => "00010000",
 1388 => "01010000",
 1389 => "01011111",
 1390 => "11111101",
 1391 => "10101001",
 1392 => "00011101",
 1393 => "01111000",
 1394 => "11011010",
 1395 => "10010101",
 1396 => "01111011",
 1397 => "00001011",
 1398 => "00111111", others => (others =>'0'));
component project_reti_logiche is 
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
end component project_reti_logiche;
begin 
	UUT: project_reti_logiche
	port map (
		  i_clk      	=> tb_clk,	
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address, 
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
		  o_we 	=> mem_we,
          o_data    => mem_i_data
);p_CLK_GEN : process is
  begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
  end process p_CLK_GEN; 
 MEM : process(tb_clk)
   begin
    if tb_clk'event and tb_clk = '1' then
     if enable_wire = '1' then
      if mem_we = '1' then
       RAM(conv_integer(mem_address))              <= mem_i_data;
       mem_o_data                      <= mem_i_data;
      else
       mem_o_data <= RAM(conv_integer(mem_address));
      end if;
     end if;
    end if;
   end process;
test : process is
begin 
wait for 100 ns;
wait for c_CLOCK_PERIOD;
tb_rst <= '1';
wait for c_CLOCK_PERIOD;
tb_rst <= '0';
wait for c_CLOCK_PERIOD;
tb_start <= '1';
wait for c_CLOCK_PERIOD; 
tb_start <= '0';
wait until tb_done = '1';
wait until tb_done = '0';
wait until rising_edge(tb_clk);

 
assert RAM(1) = "00000101" report "FAIL high bits" severity failure;
assert RAM(0) = "01110010" report "FAIL low bits" severity failure;
assert false report "Simulation Ended!, test passed" severity failure;
end process test;
 end projecttb;