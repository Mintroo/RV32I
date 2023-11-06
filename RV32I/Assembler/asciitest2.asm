#include "RV32I.asm"
#include "GPUplot.asm"

main:
li s0, 0 ; ワード内の位置のmod4
li s1, " " ; asciiコードの中身
li s2, 0 ; mod4の一時定数
li s3, 0 ; ramのワード単位のポインタ
.default:
sb s1, s3, 0
addi s3, s3, 1
addi s1, s1, 1
li s2, 127
beq s1, s2, setjump(main.plot, main.plot - 2)
j setjump(main.default, main.plot - 1)
.plot:
li a5, 1
li a4, 0
li32 a7, 0x00000000
.plotloop:
call setjump(plotString, main.plotloop)
li s0, 0
beq a0, s0, setjump(main.plotted, main.plotloop + 2)
li32 s0, 0xFFFFFF00
and a7, a7, s0
li32 s0, 0x00000d00
add a7, a7, s0
j setjump(main.plotloop, main.plotted - 1)
.plotted:
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
li32 s1, "\n\r!!"
sw s1, s2, 0
addi s2, s2, 4
li32 s1, "haey"
sw s1, s2, 0
addi s2, s2, 4
li32 s1, "\0!! "
sw s1, s2, 0
li a4, 0 ; stringptr = 0
li a5, 1 ; stringcolor = 1
li32 a7, 0x7F5A ; position = (0x5A, 0x7F)
.plotted2:
call setjump(plotString, main.plotted2)