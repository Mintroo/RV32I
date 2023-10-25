#include "RV32I.asm"

backcolor = BLACK
stickcolor = WHITE

li32 sp, STACKPOINTER

j main-2

#include "random256.asm"

; a5 = memoryaddress, a6 = value, a7 = color
plotStick: ; void plotStick(int a5, int a6, int a7)[t5-6]
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

ret

bubblesort: ; void bubblesort()[]
li t0, 0 ; t0 <= int i
.for_i: ; while(i < 255)
li t1, 255
bge t0, t1, setjump(bubblesort.for_i_end, bubblesort.for_i + 1)

li t2, 255 ; t2 <= int j = n - 1
addi t0, t0, 1 ; i++
.for_j: ; while(j >= i + 1)
blt t2, t0, setjump(bubblesort.for_j_end, bubblesort.for_j)
lw t1, t2, -1 ; t1 <= data[j-1]
lw t3, t2, 0  ; t3 <= data[j]
.if:
ble t1, t3, setjump(bubblesort.swaped, bubblesort.if)
sw t3, t2, -1 ; data[j-1] <= data[j]
sw t1, t2, 0  ; data[j] <= data[j-1]
mv a5, t2
mv a6, t1
li a7, stickcolor
addi sp, sp, -1 ; bubblesort関数のraを退避
sw ra, sp, 0
call setjump(plotStick, bubblesort.if + 8)
addi t2, t2, -1 ; j--
mv a5, t2
mv a6, t3
li a7, stickcolor
call setjump(plotStick, bubblesort.if + 13)
lw ra, sp, 0 ; bubblesort関数のraを復帰
addi sp, sp, 1 ; spを復帰
addi t2, t2, 1 ; j++ (jをもとに戻す)
.swaped:
addi t2, t2, -1 ; j--
j setjump(bubblesort.for_j, bubblesort.swaped + 1)
.for_j_end:
j setjump(bubblesort.for_i, bubblesort.for_j_end)
.for_i_end:

ret

main:
call setjump(random256, main)
li t0, 0 ; t0 <= int i = 0
li t1, 256
for_i: ; while(i < 256)
bge t0, t1, setjump(for_i_end, for_i)
lw t2, t0, 0
mv a5, t0
mv a6, t2
li a7, stickcolor
call setjump(plotStick, for_i+5)
addi t0, t0, 1
j setjump(for_i, for_i+7)
for_i_end:
call setjump(bubblesort, for_i_end)

li t2, "\r"