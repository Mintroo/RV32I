#include "RV32I.asm"

li32 t0, GPU_ONECOLOR
li t3, WHITE
sw t3, t0, 0

loop:
li32 t0, GPU_POS
li t1, 0x0000FFFF
sw t1, t0, 0

li32 t0, GPU_EXE
li t1, plotRect
sw t1, t0, 0

li32 t0, GPU_EN
gGPU0:
lw t2, t0, 0
bnez t2, setjump(gGPU0, gGPU0 + 1)

addi t3, t3, 1
li32 t0, GPU_ONECOLOR
sw t3, t0, 0

li32 t0, GPU_POS
li32 t1, 0x46787417
sw t1, t0, 0

li32 t0, GPU_EXE
li t1, plotLine
sw t1, t0, 0

li32 t0, GPU_EN
GPU0:
lw t2, t0, 0
bnez t2, setjump(GPU0, GPU0 + 1)

li32 t0, GPU_POS
li32 t1, 0x7417A078
sw t1, t0, 0

li32 t0, GPU_EXE
li t1, plotLine
sw t1, t0, 0

li32 t0, GPU_EN
GPU1:
lw t2, t0, 0
bnez t2, setjump(GPU1, GPU1 + 1)

li32 t0, GPU_POS
li32 t1, 0xA0783046
sw t1, t0, 0

li32 t0, GPU_EXE
li t1, plotLine
sw t1, t0, 0

li32 t0, GPU_EN
GPU2:
lw t2, t0, 0
bnez t2, setjump(GPU2, GPU2 + 1)

li32 t0, GPU_POS
li32 t1, 0x3046A846
sw t1, t0, 0

li32 t0, GPU_EXE
li t1, plotLine
sw t1, t0, 0

li32 t0, GPU_EN
GPU3:
lw t2, t0, 0
bnez t2, setjump(GPU3, GPU3 + 1)

li32 t0, GPU_POS
li32 t1, 0xA8464678
sw t1, t0, 0

li32 t0, GPU_EXE
li t1, plotLine
sw t1, t0, 0

li32 t0, GPU_EN
GPU4:
lw t2, t0, 0
bnez t2, setjump(GPU4, GPU4 + 1)

li32 t0, GPU_POS
li32 t1, 0x10101010
sw t1, t0, 0

li32 t0, GPU_EXE
li t1, plotLine
sw t1, t0, 0

li32 t0, GPU_EN
GPU5:
lw t2, t0, 0
bnez t2, setjump(GPU5, GPU5 + 1)

li32 t0, GPU_POS
li32 t1, 0x11111111
sw t1, t0, 0

li32 t0, GPU_EXE
li t1, plotLine
sw t1, t0, 0
loopend:
j setjump(loop, loopend)



