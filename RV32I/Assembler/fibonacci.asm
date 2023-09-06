#include "RV32I.asm"

li t0, 0
li t1, 1
loop:
add t2, t0, t1
mv t0, t1
mv t1, t2
jal:
jal zero, setjump(jal, loop)