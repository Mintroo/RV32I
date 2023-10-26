#include "RV32I.asm"

li32 sp, STACKPOINTER

j main-2

#include "stdio.asm"

main:
li s2, 0 ; アドレス指定
li32 s1, "Hell"
sw s1, s2, 0
addi s2, s2, 1
li32 s1, "o Wo"
sw s1, s2, 0
addi s2, s2, 1
li32 s1, "rld "
sw s1, s2, 0
addi s2, s2, 1
li32 s1, "!!\0\0"
sw s1, s2, 0
li a3, 0 ; mod4position = 0
li a4, 0 ; stringptr = 0
li a5, 1 ; stringcolor = 1
li32 a7, 0xC0C00000 ; position = (0x30, 0x30)
call setjump(plotString, main2 - 1)
main2: