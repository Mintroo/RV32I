#include "RV32I.asm"
#include "GPUplot.asm"

main:
li s0, 0 ; ワード内の位置のmod4
li s1, " " ; asciiコードの中身
li s2, 0 ; mod4の一時定数
li s3, 0 ; ramのワード単位のポインタ
.case0:
li s2, 0
bne s0, s2, setjump(main.case1, main.case0 + 1)
sb s1, s3, 3
addi s0, s0, 1
j setjump(main.done, main.case1 - 1)
.case1:
li s2, 1
bne s0, s2, setjump(main.case2, main.case1 + 1)
sb s1, s3, 2
addi s0, s0, 1
j setjump(main.done, main.case2 - 1)
.case2:
li s2, 2
bne s0, s2, setjump(main.default, main.case2 + 1)
sb s1, s3, 1
addi s0, s0, 1
j setjump(main.done, main.default - 1)
.default:
sb s1, s3, 0
li s0, 0
addi s3, s3, 1
.done:
addi s1, s1, 1
li s2, 127
beq s1, s2, setjump(main.plot, main.done + 2)
j setjump(main.case0, main.plot - 1)
.plot:
li a5, 1
li a3, 0
li a4, 0
li32 a7, 0x00000000
.plotloop:
call setjump(plotString, main.plotloop)
li s0, 0
beq a0, s0, setjump(main.plotted, main.plotloop + 2)
li32 s0, 0x00FFFFFF
and a7, a7, s0
li32 s0, 0x000d0000
add a7, a7, s0
j setjump(main.plotloop, main.plotted - 1)
.plotted:
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
li32 s1, "!!\r\n"
sw s1, s2, 0
addi s2, s2, 1
li32 s1, "eah\0"
sw s1, s2, 0
li a3, 0 ; mod4position = 0
li a4, 0 ; stringptr = 0
li a5, 1 ; stringcolor = 1
li32 a7, 0x5A7F0000 ; position = (0x5A, 0x7F)
.plotted2:
call setjump(plotString, main.plotted2)