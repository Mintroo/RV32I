#include "RV32I.asm"

li32 t0, 0b10000000000000000000000000000001
li t1, 0

sh t0, t1, 0
sh t0, t1, 1

lw t2, t1, 0