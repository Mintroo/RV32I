#include "RV32I.asm"

backcolor = BLACK
stickcolor = 5

li a5, 0
li a6, 50
li a7, stickcolor
; a5 = memoryaddress, a6 = value, a7 = color
plotStick: ; void plotStick(int a5, int a6, int a7)[]
li32 t6, GPU_ONECOLOR
li t5, backcolor
sw t5, t6, 0
li32 t6, GPU_POS
sb a5, t6, 1
sb a5, t6, 3
li t5, 255
sb t5, t6, 2
sb zero, t6, 0
li32 t6, GPU_EXE
li t5, plotRect
sw t5, t6, 0
li32 t6, GPU_EN
plotStick1:
lw t5, t6, 0
bnez t5, setjump(plotStick1, plotStick1+1)

li32 t6, GPU_POS
li t5, 255
sub t5, t5, a6
sb t5, t6, 0
li32 t6, GPU_ONECOLOR
mv t5, a7
sw t5, t6, 0
li32 t6, GPU_EXE
li t5, plotRect
sw t5, t6, 0
li32 t6, GPU_EN
plotStick2:
lw t5, t6, 0
bnez t5, setjump(plotStick2, plotStick2+1)