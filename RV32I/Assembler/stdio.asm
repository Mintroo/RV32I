#include "RV32I.asm"

; a5 = charcolor, a6 = asciiptr, a7 = position
plotChar: ; void plotChar(int a5, int a6, int a7)[t5-6]
li32 t6, GPU_ONECOLOR
sw a5, t6, 0
li32 t6, GPU_POS
sw a7, t6, 0
li32 t6, GPU_ASCIIPTR
sw a6, t6, 0
li32 t6, GPU_EXE
li t5, plotASCII
sw t5, t6, 0
li32 t6, GPU_EN
.plotascii:
lw t5, t6, 0
bnez t5, setjump(plotChar.plotascii, plotChar.plotascii+1)

ret

; a5 = stringcolor, a4 = stringptr, a3 = position
plotString: ; void plotString(int a5, int a4, int a3)[]
li t4, 0
li t6, 0

.loop:

.case0:
li t6, 0
bne t4, t6, setjump(plotString.case1, plotString.case0 + 1)
lb a6, a4, 3
addi t4, t4, 1
j setjump(plotString.done, plotString.case0 + 4)
.case1:
li t6, 1
bne t4, t6, setjump(plotString.case2, plotString.case1 + 1)
lb a6, a4, 2
addi t4, t4, 1
j setjump(plotString.done, plotString.case1 + 4)
.case2:
li t6, 2
bne t4, t6, setjump(plotString.default, plotString.case2 + 1)
lb a6, a4, 1
addi t4, t4, 1
j setjump(plotString.done, plotString.case2 + 4)
.default:
li t6, 3
bne t4, t6, setjump(plotString.done, plotString.default + 1)
lb a6, a4, 0
li t4, 0
addi a4, a4, 1
.done:

.NUL:
li t6, "\0"
bne a6, t6, setjump(plotString.NF, plotString.NUL + 1)
ret ; 終端文字なら終了
.NF:
li t6, "\n"
bne a6, t6, setjump(plotString.CR, plotString.NF + 1)
li32 t6, 0x000d0000
add a3, a3, t6
j setjump(plotString.ASCIIdone, plotString.NF + 5)
.CR:
li t6, "\r"
bne a6, t6, setjump(plotString.ASCIIdone, plotString.CR + 1)
li32 t6, 0x


mv a7, a3
addi sp, sp, -1
sw ra, sp, 0
call setjump(plotChar, plotString + 4)
