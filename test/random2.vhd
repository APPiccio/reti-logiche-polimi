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
signal RAM: ram_type := (2 => "00001110", 3 => "01101111", 4 => "11101101",
 5 => "00001011",
 6 => "01100111",
 7 => "01100011",
 8 => "00000101",
 9 => "00100001",
 10 => "10011110",
 11 => "11101011",
 12 => "11101010",
 13 => "11011000",
 14 => "01000100",
 15 => "11010000",
 16 => "11010101",
 17 => "11001011",
 18 => "10100100",
 19 => "00010100",
 20 => "11101001",
 21 => "11100011",
 22 => "01001110",
 23 => "00011100",
 24 => "11011010",
 25 => "00101010",
 26 => "01001110",
 27 => "11000011",
 28 => "01101000",
 29 => "11000110",
 30 => "11110010",
 31 => "11110101",
 32 => "00000010",
 33 => "10000101",
 34 => "11010001",
 35 => "00011111",
 36 => "11100000",
 37 => "01110001",
 38 => "00110100",
 39 => "11100110",
 40 => "11000101",
 41 => "01101010",
 42 => "10011111",
 43 => "10111010",
 44 => "11100011",
 45 => "11111010",
 46 => "00111000",
 47 => "11100000",
 48 => "00101001",
 49 => "10011110",
 50 => "01010110",
 51 => "00010000",
 52 => "11111010",
 53 => "10110011",
 54 => "10111100",
 55 => "10001011",
 56 => "00000011",
 57 => "01000011",
 58 => "11011100",
 59 => "01011001",
 60 => "00001111",
 61 => "11010001",
 62 => "10000011",
 63 => "11010100",
 64 => "10110011",
 65 => "00111001",
 66 => "11110010",
 67 => "00101000",
 68 => "11110111",
 69 => "10010010",
 70 => "01111100",
 71 => "00011101",
 72 => "11100011",
 73 => "10101010",
 74 => "10010010",
 75 => "01001010",
 76 => "01111010",
 77 => "01000011",
 78 => "11000100",
 79 => "00011001",
 80 => "00101000",
 81 => "11010101",
 82 => "01010110",
 83 => "01000101",
 84 => "11011000",
 85 => "10111001",
 86 => "00001001",
 87 => "01100000",
 88 => "01011000",
 89 => "11001110",
 90 => "11111110",
 91 => "00101001",
 92 => "01100100",
 93 => "00110100",
 94 => "01011110",
 95 => "10011011",
 96 => "11110110",
 97 => "10011010",
 98 => "00011111",
 99 => "00001000",
 100 => "00000110",
 101 => "01101001",
 102 => "01101000",
 103 => "00111010",
 104 => "10110110",
 105 => "11010100",
 106 => "01000001",
 107 => "10111101",
 108 => "00110101",
 109 => "11000110",
 110 => "00100111",
 111 => "10011110",
 112 => "11010011",
 113 => "01010001",
 114 => "10110110",
 115 => "11000000",
 116 => "01101000",
 117 => "01110000",
 118 => "11111010",
 119 => "10100111",
 120 => "10101001",
 121 => "01010001",
 122 => "00110101",
 123 => "10111111",
 124 => "10010000",
 125 => "01111100",
 126 => "10111110",
 127 => "00010000",
 128 => "10110100",
 129 => "11001010",
 130 => "10011101",
 131 => "11011110",
 132 => "10001011",
 133 => "10011101",
 134 => "00110011",
 135 => "00100100",
 136 => "01111010",
 137 => "00101011",
 138 => "00001000",
 139 => "01000011",
 140 => "11001011",
 141 => "10000011",
 142 => "00100001",
 143 => "11011101",
 144 => "01110010",
 145 => "00010000",
 146 => "01100001",
 147 => "01011001",
 148 => "10110100",
 149 => "11011010",
 150 => "01111110",
 151 => "01100100",
 152 => "00011011",
 153 => "11111100",
 154 => "11100110",
 155 => "11110001",
 156 => "01001111",
 157 => "00111110",
 158 => "01110011",
 159 => "00100111",
 160 => "00100100",
 161 => "00100010",
 162 => "00011011",
 163 => "01101011",
 164 => "10001010",
 165 => "11101010",
 166 => "11001101",
 167 => "01001110",
 168 => "10100110",
 169 => "11010101",
 170 => "10101001",
 171 => "00110011",
 172 => "00110000",
 173 => "00001011",
 174 => "11010101",
 175 => "01111111",
 176 => "00001111",
 177 => "00110010",
 178 => "01010101",
 179 => "11111110",
 180 => "11111110",
 181 => "00011110",
 182 => "01001100",
 183 => "01000111",
 184 => "00000100",
 185 => "00100111",
 186 => "11110000",
 187 => "01010011",
 188 => "00011111",
 189 => "01010101",
 190 => "01100111",
 191 => "11001001",
 192 => "00110100",
 193 => "01010101",
 194 => "10110110",
 195 => "10011111",
 196 => "11011111",
 197 => "01011110",
 198 => "01000001",
 199 => "00010100",
 200 => "11101000",
 201 => "10110011",
 202 => "10011011",
 203 => "01110100",
 204 => "10000000",
 205 => "11010100",
 206 => "11001101",
 207 => "11000010",
 208 => "11100101",
 209 => "11001010",
 210 => "10001010",
 211 => "11001110",
 212 => "10111001",
 213 => "11101110",
 214 => "10001100",
 215 => "11100111",
 216 => "01000000",
 217 => "10011101",
 218 => "00110000",
 219 => "10111110",
 220 => "10100010",
 221 => "01111001",
 222 => "10100000",
 223 => "01100011",
 224 => "11001011",
 225 => "00100110",
 226 => "10111001",
 227 => "01110000",
 228 => "10110000",
 229 => "11010010",
 230 => "10110001",
 231 => "10000011",
 232 => "00011111",
 233 => "01111111",
 234 => "10001100",
 235 => "10111101",
 236 => "11101001",
 237 => "01010011",
 238 => "00101010",
 239 => "00100101",
 240 => "11100011",
 241 => "01101011",
 242 => "10101000",
 243 => "00000011",
 244 => "01101110",
 245 => "10010100",
 246 => "01100100",
 247 => "00000111",
 248 => "01010011",
 249 => "00000111",
 250 => "10100011",
 251 => "10001011",
 252 => "11101101",
 253 => "11101101",
 254 => "00101010",
 255 => "11000001",
 256 => "00101001",
 257 => "10011111",
 258 => "11010010",
 259 => "00010110",
 260 => "01011000",
 261 => "01001100",
 262 => "11110100",
 263 => "10111010",
 264 => "10111110",
 265 => "10111000",
 266 => "00111000",
 267 => "10110100",
 268 => "11010101",
 269 => "10111110",
 270 => "11010011",
 271 => "10100110",
 272 => "11101110",
 273 => "00001011",
 274 => "11110011",
 275 => "01011010",
 276 => "00011000",
 277 => "00000110",
 278 => "10100111",
 279 => "00110111",
 280 => "10110111",
 281 => "01010001",
 282 => "10001110",
 283 => "11000011",
 284 => "01011111",
 285 => "00001100",
 286 => "00111010",
 287 => "01000100",
 288 => "01011111",
 289 => "11110011",
 290 => "01100010",
 291 => "00001111",
 292 => "10001001",
 293 => "01101001",
 294 => "10011100",
 295 => "10000100",
 296 => "10100001",
 297 => "01100111",
 298 => "11010101",
 299 => "10100001",
 300 => "11001111",
 301 => "10011110",
 302 => "00111011",
 303 => "00010111",
 304 => "10100100",
 305 => "01010011",
 306 => "10001110",
 307 => "11010011",
 308 => "00010101",
 309 => "10101011",
 310 => "11010001",
 311 => "00010011",
 312 => "00101100",
 313 => "01101010",
 314 => "01010000",
 315 => "10001110",
 316 => "00100000",
 317 => "11001001",
 318 => "01000100",
 319 => "11110001",
 320 => "10001110",
 321 => "10000111",
 322 => "00010111",
 323 => "00101100",
 324 => "01001101",
 325 => "10011111",
 326 => "10001100",
 327 => "01001110",
 328 => "11000100",
 329 => "10000101",
 330 => "10110101",
 331 => "00001101",
 332 => "10111001",
 333 => "11100110",
 334 => "00111011",
 335 => "01110011",
 336 => "01011010",
 337 => "00110101",
 338 => "11000100",
 339 => "10001101",
 340 => "01110111",
 341 => "00101011",
 342 => "00101111",
 343 => "00111010",
 344 => "11010110",
 345 => "01001011",
 346 => "00010111",
 347 => "11000110",
 348 => "10111101",
 349 => "01001111",
 350 => "00011000",
 351 => "10111111",
 352 => "01001111",
 353 => "01001110",
 354 => "01011001",
 355 => "10011110",
 356 => "01110001",
 357 => "00111000",
 358 => "11000111",
 359 => "11010101",
 360 => "11000101",
 361 => "11010111",
 362 => "11011000",
 363 => "10111111",
 364 => "11001010",
 365 => "01010110",
 366 => "00100111",
 367 => "10000100",
 368 => "11111110",
 369 => "00011110",
 370 => "10111110",
 371 => "11100101",
 372 => "10110010",
 373 => "11101110",
 374 => "00101000",
 375 => "11110101",
 376 => "00101111",
 377 => "00100000",
 378 => "10010100",
 379 => "11111110",
 380 => "11000100",
 381 => "00010111",
 382 => "00111110",
 383 => "11010101",
 384 => "11101000",
 385 => "10110111",
 386 => "00101001",
 387 => "00100100",
 388 => "00110110",
 389 => "01111111",
 390 => "01010110",
 391 => "00111001",
 392 => "11101111",
 393 => "00101110",
 394 => "00001000",
 395 => "01101100",
 396 => "10101000",
 397 => "11001001",
 398 => "11111110",
 399 => "01011011",
 400 => "10010111",
 401 => "01001111",
 402 => "00100100",
 403 => "10111110",
 404 => "10100010",
 405 => "00010011",
 406 => "01000000",
 407 => "01000101",
 408 => "11110010",
 409 => "00101100",
 410 => "11111010",
 411 => "11100011",
 412 => "00010100",
 413 => "00010010",
 414 => "01010000",
 415 => "10011010",
 416 => "11001100",
 417 => "01111000",
 418 => "01010110",
 419 => "01011111",
 420 => "10001101",
 421 => "11101001",
 422 => "10111100",
 423 => "00111111",
 424 => "10001011",
 425 => "10010001",
 426 => "11011010",
 427 => "10101110",
 428 => "10101010",
 429 => "00001111",
 430 => "00001111",
 431 => "01100110",
 432 => "00111101",
 433 => "00101101",
 434 => "10110011",
 435 => "01001010",
 436 => "00101011",
 437 => "11001110",
 438 => "10101011",
 439 => "01001010",
 440 => "10011001",
 441 => "01101101",
 442 => "11101101",
 443 => "01001110",
 444 => "11101101",
 445 => "10101100",
 446 => "10110111",
 447 => "11100110",
 448 => "01000111",
 449 => "10100011",
 450 => "10110100",
 451 => "00001111",
 452 => "11010001",
 453 => "00111110",
 454 => "10101001",
 455 => "00101101",
 456 => "11111010",
 457 => "00101101",
 458 => "00101110",
 459 => "01101101",
 460 => "01010110",
 461 => "00010000",
 462 => "11110100",
 463 => "10000000",
 464 => "10011010",
 465 => "01101000",
 466 => "10000001",
 467 => "01011110",
 468 => "00011011",
 469 => "11111010",
 470 => "01101101",
 471 => "10110011",
 472 => "11100011",
 473 => "00100000",
 474 => "10101001",
 475 => "00010100",
 476 => "01110010",
 477 => "11100011",
 478 => "10110100",
 479 => "00000101",
 480 => "00100001",
 481 => "10011010",
 482 => "10011111",
 483 => "10110000",
 484 => "10010111",
 485 => "10010011",
 486 => "10101001",
 487 => "10011010",
 488 => "11110011",
 489 => "10111111",
 490 => "00111111",
 491 => "10101110",
 492 => "11110110",
 493 => "11011100",
 494 => "01110001",
 495 => "01001000",
 496 => "10010010",
 497 => "10011011",
 498 => "00010101",
 499 => "00001100",
 500 => "11001000",
 501 => "11111111",
 502 => "01100100",
 503 => "10111101",
 504 => "10011011",
 505 => "00101111",
 506 => "11110000",
 507 => "11110111",
 508 => "10000000",
 509 => "01001001",
 510 => "11001101",
 511 => "01101111",
 512 => "01000010",
 513 => "00011001",
 514 => "01100111",
 515 => "00010010",
 516 => "01110000",
 517 => "01101010",
 518 => "11100011",
 519 => "01100000",
 520 => "11110101",
 521 => "01001111",
 522 => "10100010",
 523 => "01111100",
 524 => "11111010",
 525 => "00100001",
 526 => "01111110",
 527 => "11110110",
 528 => "01011010",
 529 => "01110001",
 530 => "00011010",
 531 => "01111000",
 532 => "11010111",
 533 => "10011011",
 534 => "01101001",
 535 => "10100111",
 536 => "11101101",
 537 => "11011000",
 538 => "10000111",
 539 => "11100101",
 540 => "11011001",
 541 => "00010101",
 542 => "00000000",
 543 => "01110100",
 544 => "11011100",
 545 => "00000110",
 546 => "10101111",
 547 => "10011110",
 548 => "10010101",
 549 => "11001110",
 550 => "10001000",
 551 => "00000101",
 552 => "10001011",
 553 => "01000010",
 554 => "00100100",
 555 => "10000010",
 556 => "01000000",
 557 => "01011010",
 558 => "10011101",
 559 => "10010011",
 560 => "10111001",
 561 => "00110100",
 562 => "11001101",
 563 => "00011100",
 564 => "11110000",
 565 => "01000011",
 566 => "10110011",
 567 => "10100101",
 568 => "11100010",
 569 => "11101001",
 570 => "01100100",
 571 => "01001111",
 572 => "10010111",
 573 => "10001010",
 574 => "01110111",
 575 => "11001100",
 576 => "00001111",
 577 => "00111010",
 578 => "11001001",
 579 => "01000000",
 580 => "01000001",
 581 => "11001100",
 582 => "01001110",
 583 => "00010011",
 584 => "00101000",
 585 => "10101111",
 586 => "01001111",
 587 => "01011101",
 588 => "11100000",
 589 => "01010111",
 590 => "01000100",
 591 => "00000111",
 592 => "11011010",
 593 => "11001011",
 594 => "11000100",
 595 => "00000001",
 596 => "10011010",
 597 => "10001010",
 598 => "11000000",
 599 => "10000011",
 600 => "00010111",
 601 => "00101010",
 602 => "01011000",
 603 => "11111000",
 604 => "11010110",
 605 => "10100000",
 606 => "00001100",
 607 => "01010010",
 608 => "01000100",
 609 => "10101101",
 610 => "01000111",
 611 => "11110001",
 612 => "11001100",
 613 => "01111010",
 614 => "11001011",
 615 => "00011101",
 616 => "01101111",
 617 => "10010100",
 618 => "10000110",
 619 => "01111011",
 620 => "01010011",
 621 => "00011110",
 622 => "11100100",
 623 => "10110000",
 624 => "01000001",
 625 => "00100111",
 626 => "11001010",
 627 => "11101110",
 628 => "01011011",
 629 => "11101111",
 630 => "00000111",
 631 => "00010000",
 632 => "11100100",
 633 => "10010111",
 634 => "11110101",
 635 => "10011110",
 636 => "11000001",
 637 => "11010101",
 638 => "00100000",
 639 => "10001100",
 640 => "00000100",
 641 => "10111000",
 642 => "10100000",
 643 => "00000001",
 644 => "11110110",
 645 => "01100100",
 646 => "11000011",
 647 => "11011000",
 648 => "10110011",
 649 => "01110010",
 650 => "01101111",
 651 => "01111001",
 652 => "10001001",
 653 => "10110111",
 654 => "10111000",
 655 => "00111110",
 656 => "00101001",
 657 => "11011010",
 658 => "01100010",
 659 => "00110111",
 660 => "01111110",
 661 => "11000110",
 662 => "01001110",
 663 => "10001100",
 664 => "00010100",
 665 => "00001111",
 666 => "00100001",
 667 => "10110110",
 668 => "01010000",
 669 => "11000111",
 670 => "11110011",
 671 => "11001000",
 672 => "00111100",
 673 => "10111000",
 674 => "01001110",
 675 => "00110000",
 676 => "11011100",
 677 => "00101100",
 678 => "01101000",
 679 => "01010111",
 680 => "01101001",
 681 => "00001110",
 682 => "01101011",
 683 => "01100011",
 684 => "11111000",
 685 => "01000111",
 686 => "01011000",
 687 => "01000011",
 688 => "11100001",
 689 => "01110001",
 690 => "01100000",
 691 => "00101010",
 692 => "01101010",
 693 => "01100111",
 694 => "00101101",
 695 => "01100110",
 696 => "00101111",
 697 => "11001011",
 698 => "01010101",
 699 => "11110100",
 700 => "11000100",
 701 => "00010011",
 702 => "11011011",
 703 => "10101011",
 704 => "01111110",
 705 => "10101011",
 706 => "10010100",
 707 => "00101111",
 708 => "00001000",
 709 => "01001111",
 710 => "01111111",
 711 => "00001000",
 712 => "01001011",
 713 => "10111011",
 714 => "00010000",
 715 => "00111100",
 716 => "10111111",
 717 => "01110110",
 718 => "11011100",
 719 => "01101001",
 720 => "11000100",
 721 => "01000101",
 722 => "11011110",
 723 => "01110010",
 724 => "10111111",
 725 => "01100100",
 726 => "11111111",
 727 => "10001011",
 728 => "11011101",
 729 => "00000101",
 730 => "00101011",
 731 => "10101001",
 732 => "00010010",
 733 => "10100000",
 734 => "01000110",
 735 => "10010011",
 736 => "10001101",
 737 => "10110011",
 738 => "00110000",
 739 => "11000011",
 740 => "01100001",
 741 => "00111011",
 742 => "11010111",
 743 => "10100011",
 744 => "01010011",
 745 => "10110010",
 746 => "11001001",
 747 => "10010101",
 748 => "11001101",
 749 => "01111111",
 750 => "00001101",
 751 => "00000011",
 752 => "11100111",
 753 => "11101100",
 754 => "01101011",
 755 => "10010010",
 756 => "11000110",
 757 => "00000110",
 758 => "11110111",
 759 => "11000110",
 760 => "01111010",
 761 => "11000001",
 762 => "11101111",
 763 => "01011111",
 764 => "11011001",
 765 => "01011010",
 766 => "00010101",
 767 => "10001101",
 768 => "00000111",
 769 => "11111001",
 770 => "01100000",
 771 => "10101001",
 772 => "11110010",
 773 => "01101110",
 774 => "10010110",
 775 => "10100101",
 776 => "00100001",
 777 => "11001101",
 778 => "11110101",
 779 => "01110000",
 780 => "00011000",
 781 => "00001010",
 782 => "11101000",
 783 => "10000001",
 784 => "00111000",
 785 => "00011110",
 786 => "00010100",
 787 => "10001101",
 788 => "01001100",
 789 => "01111000",
 790 => "01001010",
 791 => "10000011",
 792 => "11001010",
 793 => "10010000",
 794 => "11101010",
 795 => "00101100",
 796 => "10100001",
 797 => "00010100",
 798 => "10100011",
 799 => "11101010",
 800 => "11000011",
 801 => "00010101",
 802 => "10001000",
 803 => "10011100",
 804 => "10000000",
 805 => "11110011",
 806 => "11101100",
 807 => "01111000",
 808 => "11111010",
 809 => "11001110",
 810 => "10000000",
 811 => "10111010",
 812 => "11110110",
 813 => "00010111",
 814 => "00101100",
 815 => "10110010",
 816 => "00110010",
 817 => "00011110",
 818 => "01110100",
 819 => "00010011",
 820 => "00100110",
 821 => "01000010",
 822 => "11000110",
 823 => "01001100",
 824 => "01100110",
 825 => "11101100",
 826 => "01000101",
 827 => "00010111",
 828 => "01011000",
 829 => "11110001",
 830 => "10001000",
 831 => "01101100",
 832 => "01011111",
 833 => "10111001",
 834 => "10011010",
 835 => "01001010",
 836 => "11011111",
 837 => "11110001",
 838 => "11001001",
 839 => "10111010",
 840 => "00111010",
 841 => "11111011",
 842 => "10111100",
 843 => "11111101",
 844 => "01100000",
 845 => "01000100",
 846 => "01101011",
 847 => "11101101",
 848 => "01101110",
 849 => "00111010",
 850 => "01110110",
 851 => "01001001",
 852 => "11011000",
 853 => "00001001",
 854 => "00000101",
 855 => "00110100",
 856 => "00100110",
 857 => "01111010",
 858 => "00010000",
 859 => "00101011",
 860 => "11001101",
 861 => "11111010",
 862 => "00011010",
 863 => "00011101",
 864 => "00000111",
 865 => "00111000",
 866 => "11000011",
 867 => "01001110",
 868 => "01110010",
 869 => "11000001",
 870 => "00011101",
 871 => "00101100",
 872 => "11010111",
 873 => "11101010",
 874 => "00010110",
 875 => "11011011",
 876 => "11011011",
 877 => "11001100",
 878 => "10001111",
 879 => "11010000",
 880 => "10010110",
 881 => "01001001",
 882 => "01001101",
 883 => "10100100",
 884 => "11010110",
 885 => "10111100",
 886 => "11101101",
 887 => "01000110",
 888 => "10011001",
 889 => "11010011",
 890 => "01111000",
 891 => "10100100",
 892 => "11010010",
 893 => "10010011",
 894 => "01001100",
 895 => "01101100",
 896 => "00100001",
 897 => "01011110",
 898 => "01101000",
 899 => "00010101",
 900 => "11000111",
 901 => "10111011",
 902 => "10011011",
 903 => "10010011",
 904 => "00110011",
 905 => "01011110",
 906 => "01000110",
 907 => "00100010",
 908 => "11100010",
 909 => "11000000",
 910 => "10100010",
 911 => "01110111",
 912 => "10000010",
 913 => "11010101",
 914 => "11011000",
 915 => "11110000",
 916 => "00011001",
 917 => "10001111",
 918 => "11110111",
 919 => "10001001",
 920 => "10110100",
 921 => "01101011",
 922 => "11100111",
 923 => "00011101",
 924 => "01011010",
 925 => "00111110",
 926 => "00110111",
 927 => "00111101",
 928 => "01100010",
 929 => "00100001",
 930 => "00110100",
 931 => "10100001",
 932 => "00111100",
 933 => "11101010",
 934 => "10110101",
 935 => "00010000",
 936 => "10100100",
 937 => "10111100",
 938 => "00100101",
 939 => "11110101",
 940 => "00011010",
 941 => "11000000",
 942 => "10111000",
 943 => "10110000",
 944 => "11110101",
 945 => "11110010",
 946 => "11101001",
 947 => "01010010",
 948 => "01100111",
 949 => "10100101",
 950 => "11001100",
 951 => "10010001",
 952 => "01001101",
 953 => "10100100",
 954 => "00100110",
 955 => "01000000",
 956 => "01010101",
 957 => "01101011",
 958 => "00010011",
 959 => "00110111",
 960 => "10111101",
 961 => "01111001",
 962 => "00001111",
 963 => "11001111",
 964 => "00011000",
 965 => "00110110",
 966 => "11011110",
 967 => "01001011",
 968 => "01100011",
 969 => "00101010",
 970 => "01011110",
 971 => "01010111",
 972 => "11000110",
 973 => "01001101",
 974 => "11100000",
 975 => "00100111",
 976 => "11110111",
 977 => "00101011",
 978 => "01100111",
 979 => "10011011",
 980 => "11011010",
 981 => "01000101",
 982 => "01000110",
 983 => "00111111",
 984 => "10010010",
 985 => "01000011",
 986 => "00111110",
 987 => "01101111",
 988 => "00011110",
 989 => "00010011",
 990 => "01111100",
 991 => "00010001",
 992 => "11010010",
 993 => "10111111",
 994 => "10001100",
 995 => "10100010",
 996 => "11010000",
 997 => "10011101",
 998 => "01100100",
 999 => "00101110",
 1000 => "00110101",
 1001 => "01101001",
 1002 => "11101101",
 1003 => "00011111",
 1004 => "11101011",
 1005 => "11111001",
 1006 => "00010110",
 1007 => "10111101",
 1008 => "10101000",
 1009 => "00011000",
 1010 => "01010100",
 1011 => "01011111",
 1012 => "01000000",
 1013 => "00001110",
 1014 => "10011101",
 1015 => "01110010",
 1016 => "10010011",
 1017 => "00100011",
 1018 => "00101111",
 1019 => "01101110",
 1020 => "10010001",
 1021 => "11100011",
 1022 => "11100101",
 1023 => "00011001",
 1024 => "11000001",
 1025 => "01001010",
 1026 => "11100111",
 1027 => "00111011",
 1028 => "00001001",
 1029 => "00101110",
 1030 => "01001001",
 1031 => "10111011",
 1032 => "01100000",
 1033 => "11000101",
 1034 => "10001111",
 1035 => "11110010",
 1036 => "00101101",
 1037 => "11000011",
 1038 => "11001110",
 1039 => "01110001",
 1040 => "00110101",
 1041 => "00001101",
 1042 => "00111101",
 1043 => "10101011",
 1044 => "01001101",
 1045 => "00111010",
 1046 => "11110100",
 1047 => "00100001",
 1048 => "01001001",
 1049 => "11101110",
 1050 => "11010011",
 1051 => "01100001",
 1052 => "01011100",
 1053 => "10101011",
 1054 => "11011101",
 1055 => "11010100",
 1056 => "10000111",
 1057 => "11010000",
 1058 => "01111011",
 1059 => "11101001",
 1060 => "11000000",
 1061 => "00110110",
 1062 => "11000101",
 1063 => "01010100",
 1064 => "10000010",
 1065 => "00101000",
 1066 => "11011100",
 1067 => "11001011",
 1068 => "01110011",
 1069 => "11101111",
 1070 => "00001010",
 1071 => "01001010",
 1072 => "10000111",
 1073 => "10001000",
 1074 => "01010011",
 1075 => "01001011",
 1076 => "11101001",
 1077 => "00001011",
 1078 => "00001101",
 1079 => "11101011",
 1080 => "01110001",
 1081 => "11101110",
 1082 => "00101010",
 1083 => "10100111",
 1084 => "00000001",
 1085 => "10001111",
 1086 => "00001011",
 1087 => "00101110",
 1088 => "10000111",
 1089 => "11110110",
 1090 => "11110000",
 1091 => "11111000",
 1092 => "10111010",
 1093 => "10101101",
 1094 => "01111000",
 1095 => "00010101",
 1096 => "10010001",
 1097 => "10000010",
 1098 => "00110001",
 1099 => "01011011",
 1100 => "00111101",
 1101 => "00011010",
 1102 => "11100010",
 1103 => "01010001",
 1104 => "01011011",
 1105 => "10011101",
 1106 => "00011101",
 1107 => "10000101",
 1108 => "11110110",
 1109 => "01100001",
 1110 => "01010111",
 1111 => "11000011",
 1112 => "00011110",
 1113 => "11110000",
 1114 => "01011100",
 1115 => "11111111",
 1116 => "00110101",
 1117 => "10000011",
 1118 => "00111000",
 1119 => "11100110",
 1120 => "11101010",
 1121 => "00110000",
 1122 => "00111001",
 1123 => "11101011",
 1124 => "10110111",
 1125 => "10010001",
 1126 => "11100010",
 1127 => "01010101",
 1128 => "11101110",
 1129 => "01110101",
 1130 => "01110100",
 1131 => "01101011",
 1132 => "01001001",
 1133 => "10010011",
 1134 => "10001010",
 1135 => "11000100",
 1136 => "00110001",
 1137 => "10001111",
 1138 => "01100111",
 1139 => "11010101",
 1140 => "10011011",
 1141 => "00101001",
 1142 => "11110100",
 1143 => "10000100",
 1144 => "11000101",
 1145 => "01010000",
 1146 => "11111010",
 1147 => "11110111",
 1148 => "00010000",
 1149 => "10111111",
 1150 => "10100011",
 1151 => "01110010",
 1152 => "11011000",
 1153 => "11011100",
 1154 => "00011001",
 1155 => "00010000",
 1156 => "11100111",
 1157 => "01010001",
 1158 => "10010001",
 1159 => "11111010",
 1160 => "01011011",
 1161 => "10001010",
 1162 => "11000101",
 1163 => "11001000",
 1164 => "10000101",
 1165 => "00011000",
 1166 => "00101000",
 1167 => "10010011",
 1168 => "11000100",
 1169 => "10001010",
 1170 => "01101000",
 1171 => "01011110",
 1172 => "11111101",
 1173 => "10010010",
 1174 => "11101011",
 1175 => "00110010",
 1176 => "11011000",
 1177 => "11100110",
 1178 => "01111100",
 1179 => "00001100",
 1180 => "11100000",
 1181 => "01010010",
 1182 => "11101000",
 1183 => "01101111",
 1184 => "10001001",
 1185 => "11101011",
 1186 => "00011010",
 1187 => "10001101",
 1188 => "01111000",
 1189 => "01100110",
 1190 => "00001001",
 1191 => "11100001",
 1192 => "11011110",
 1193 => "11011111",
 1194 => "11110111",
 1195 => "10110100",
 1196 => "01001010",
 1197 => "01010111",
 1198 => "01001100",
 1199 => "11111111",
 1200 => "00100000",
 1201 => "00001101",
 1202 => "00110110",
 1203 => "11001100",
 1204 => "10101011",
 1205 => "01011010",
 1206 => "11011110",
 1207 => "11101110",
 1208 => "10101011",
 1209 => "11101110",
 1210 => "10001000",
 1211 => "11001111",
 1212 => "00110110",
 1213 => "01010111",
 1214 => "00010010",
 1215 => "01000011",
 1216 => "00011011",
 1217 => "00110100",
 1218 => "00111011",
 1219 => "11111101",
 1220 => "00010101",
 1221 => "00101110",
 1222 => "10010011",
 1223 => "11011110",
 1224 => "00110011",
 1225 => "00101001",
 1226 => "00001100",
 1227 => "11000010",
 1228 => "00101110",
 1229 => "01101000",
 1230 => "11111000",
 1231 => "01011100",
 1232 => "10001011",
 1233 => "01110001",
 1234 => "11101010",
 1235 => "11001110",
 1236 => "01111110",
 1237 => "10111111",
 1238 => "00111110",
 1239 => "11100110",
 1240 => "11011010",
 1241 => "10110110",
 1242 => "10101000",
 1243 => "11011001",
 1244 => "01010011",
 1245 => "10000110",
 1246 => "11100101",
 1247 => "00001001",
 1248 => "11101111",
 1249 => "01101100",
 1250 => "00111011",
 1251 => "10100101",
 1252 => "11010111",
 1253 => "00101001",
 1254 => "11100011",
 1255 => "10100110",
 1256 => "10101000",
 1257 => "00000001",
 1258 => "10111110",
 1259 => "10101000",
 1260 => "10010010",
 1261 => "10100001",
 1262 => "10111010",
 1263 => "00011100",
 1264 => "11100011",
 1265 => "00101001",
 1266 => "10000100",
 1267 => "01101100",
 1268 => "10111111",
 1269 => "01000011",
 1270 => "10011111",
 1271 => "11000010",
 1272 => "00001001",
 1273 => "00111011",
 1274 => "01000101",
 1275 => "10101110",
 1276 => "11101110",
 1277 => "01101110",
 1278 => "11000000",
 1279 => "00011010",
 1280 => "10101011",
 1281 => "00001011",
 1282 => "01010100",
 1283 => "00101101",
 1284 => "00101100",
 1285 => "11001001",
 1286 => "10100101",
 1287 => "01100010",
 1288 => "00110101",
 1289 => "01110000",
 1290 => "11001110",
 1291 => "01011101",
 1292 => "01111000",
 1293 => "01001010",
 1294 => "01001011",
 1295 => "01110111",
 1296 => "11010010",
 1297 => "10111000",
 1298 => "10001011",
 1299 => "11100000",
 1300 => "11101110",
 1301 => "01111110",
 1302 => "11111101",
 1303 => "10111110",
 1304 => "01001111",
 1305 => "11010101",
 1306 => "10111100",
 1307 => "10000011",
 1308 => "10000010",
 1309 => "01111110",
 1310 => "00011100",
 1311 => "11000101",
 1312 => "01100111",
 1313 => "10101101",
 1314 => "01000100",
 1315 => "10010010",
 1316 => "00001101",
 1317 => "11011001",
 1318 => "10100000",
 1319 => "10000000",
 1320 => "01111010",
 1321 => "00000000",
 1322 => "01011010",
 1323 => "10100011",
 1324 => "11000011",
 1325 => "01011101",
 1326 => "11000110",
 1327 => "10111001",
 1328 => "00101100",
 1329 => "00100011",
 1330 => "10110001",
 1331 => "00011010",
 1332 => "11110011",
 1333 => "10100000",
 1334 => "10011001",
 1335 => "10000101",
 1336 => "11011011",
 1337 => "01101111",
 1338 => "10110001",
 1339 => "01001110",
 1340 => "01111001",
 1341 => "01011001",
 1342 => "11010000",
 1343 => "10110001",
 1344 => "11000010",
 1345 => "00011100",
 1346 => "01011111",
 1347 => "01101101",
 1348 => "00010011",
 1349 => "11000001",
 1350 => "11001101",
 1351 => "10001101",
 1352 => "00101111",
 1353 => "11110000",
 1354 => "01110000",
 1355 => "01100010",
 1356 => "11010010",
 1357 => "00001110",
 1358 => "11110100",
 1359 => "01000010",
 1360 => "11110101",
 1361 => "10101010",
 1362 => "10110010",
 1363 => "11011111",
 1364 => "10111101",
 1365 => "11101001",
 1366 => "10110000",
 1367 => "00110000",
 1368 => "01110001",
 1369 => "11001111",
 1370 => "11001111",
 1371 => "11110011",
 1372 => "00101000",
 1373 => "01101111",
 1374 => "10010100",
 1375 => "00110001",
 1376 => "11100100",
 1377 => "00011011",
 1378 => "00111001",
 1379 => "00010011",
 1380 => "00010110",
 1381 => "00011001",
 1382 => "11110011",
 1383 => "10101010",
 1384 => "10101011",
 1385 => "11111010",
 1386 => "00111110",
 1387 => "01111010",
 1388 => "01101111",
 1389 => "01111111",
 1390 => "10001001",
 1391 => "01000011",
 1392 => "11101110",
 1393 => "11100100",
 1394 => "11101011",
 1395 => "01101100",
 1396 => "00000000",
 1397 => "11111010",
 1398 => "11101100",
 1399 => "11010011",
 1400 => "11011100",
 1401 => "00000110",
 1402 => "11010010",
 1403 => "00110101",
 1404 => "00111110",
 1405 => "11100000",
 1406 => "11011010",
 1407 => "11011000",
 1408 => "10010011",
 1409 => "11110010",
 1410 => "11101001",
 1411 => "10010110",
 1412 => "11001101",
 1413 => "00011111",
 1414 => "01010000",
 1415 => "10010001",
 1416 => "01010011",
 1417 => "00110010",
 1418 => "10111100",
 1419 => "00010101",
 1420 => "00100010",
 1421 => "11110100",
 1422 => "00101001",
 1423 => "11010110",
 1424 => "01000001",
 1425 => "00110001",
 1426 => "10010111",
 1427 => "01000001",
 1428 => "00100111",
 1429 => "10010001",
 1430 => "10101011",
 1431 => "00011010",
 1432 => "01001011",
 1433 => "00101101",
 1434 => "01101001",
 1435 => "11101011",
 1436 => "00111011",
 1437 => "10110100",
 1438 => "10011100",
 1439 => "01111010",
 1440 => "00100111",
 1441 => "11111000",
 1442 => "00001111",
 1443 => "00111111",
 1444 => "01001011",
 1445 => "01110011",
 1446 => "00110011",
 1447 => "10111110",
 1448 => "01100101",
 1449 => "10100001",
 1450 => "11111010",
 1451 => "01011101",
 1452 => "10100001",
 1453 => "10010111",
 1454 => "10110001",
 1455 => "11110110",
 1456 => "11011100",
 1457 => "00000000",
 1458 => "01111110",
 1459 => "01100000",
 1460 => "11011101",
 1461 => "10010100",
 1462 => "10110011",
 1463 => "10101110",
 1464 => "00001000",
 1465 => "10110010",
 1466 => "00000000",
 1467 => "10001001",
 1468 => "01001101",
 1469 => "00000100",
 1470 => "10101111",
 1471 => "10010010",
 1472 => "01101100",
 1473 => "11011011",
 1474 => "10110110",
 1475 => "01101000",
 1476 => "10101110",
 1477 => "10111000",
 1478 => "11000001",
 1479 => "00011110",
 1480 => "01101010",
 1481 => "11000001",
 1482 => "10011111",
 1483 => "10101010",
 1484 => "10000010",
 1485 => "11001101",
 1486 => "00111111",
 1487 => "11001001",
 1488 => "00110000",
 1489 => "10011001",
 1490 => "10100011",
 1491 => "10100010",
 1492 => "10110111",
 1493 => "00101101",
 1494 => "01110010",
 1495 => "00111111",
 1496 => "00000111",
 1497 => "01001010",
 1498 => "10010110",
 1499 => "01100000",
 1500 => "11101010",
 1501 => "00011100",
 1502 => "11001100",
 1503 => "01000010",
 1504 => "11000000",
 1505 => "00111110",
 1506 => "10100011",
 1507 => "00110001",
 1508 => "10000101",
 1509 => "01101001",
 1510 => "01011011",
 1511 => "01111110",
 1512 => "01101010",
 1513 => "10111100",
 1514 => "10110101",
 1515 => "10101010",
 1516 => "01000100",
 1517 => "10011000",
 1518 => "00101000",
 1519 => "01100011",
 1520 => "01111111",
 1521 => "01111111",
 1522 => "11111111",
 1523 => "00110010",
 1524 => "11100111",
 1525 => "11111000",
 1526 => "01001100",
 1527 => "01100010",
 1528 => "11110111",
 1529 => "11111110",
 1530 => "01110011",
 1531 => "11111100",
 1532 => "11100010",
 1533 => "01110000",
 1534 => "11110001",
 1535 => "11110111",
 1536 => "01111100",
 1537 => "11110010",
 1538 => "11001011",
 1539 => "10000110",
 1540 => "11101010",
 1541 => "11000101",
 1542 => "10011000",
 1543 => "11100111",
 1544 => "01000110",
 1545 => "01110010",
 1546 => "10100001",
 1547 => "00111101",
 1548 => "11101110",
 1549 => "01011001",
 1550 => "01101111",
 1551 => "01110111",
 1552 => "00100111",
 1553 => "01101111",
 1554 => "10010111",
 1555 => "10111100",
 1556 => "01001111",
 1557 => "10110010",
 1558 => "10001111", others => (others =>'0'));
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

 
assert RAM(1) = "00000110" report "FAIL high bits" severity failure;
assert RAM(0) = "00000100" report "FAIL low bits" severity failure;
assert false report "Simulation Ended!, test passed" severity failure;
end process test;
 end projecttb;