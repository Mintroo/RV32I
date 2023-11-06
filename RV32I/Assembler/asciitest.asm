#include "RV32I.asm"
#include "GPUplot.asm"

main:
li s2, 0 ; アドレス指定
li32 s1, "lleH"
sw s1, s2, 0
addi s2, s2, 4
li32 s1, "oW o"
sw s1, s2, 0
addi s2, s2, 4
li32 s1, " dlr"
sw s1, s2, 0
addi s2, s2, 4
li32 s1, "\0\0!!"
sw s1, s2, 0
li a4, 0 ; stringptr = 0
li a5, 1 ; stringcolor = 1
li32 a7, 0xA0A0 ; position = (0x30, 0x30)
call setjump(plotString, main2 - 1)
main2: