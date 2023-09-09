#include "RV32I.asm"

li s0, 1
li s1, -1
li s2, 0
li s3, 4
li s4, 2
fcvt.s.w fr0, s0 ; fr0 <= a
fcvt.s.w fr1, s1 ; fr1 <= b
fcvt.s.w fr2, s2 ; fr2 <= current
fcvt.s.w fr3, s3 ; fr3 <= finish

fcvt.s.w fr4, s0 ; fr4 <= c
fcvt.s.w fr5, s4 ; fr5 <= 2.0f

li t0, 0 ; t0 <= int i = 0
li32 t1, 1000000
for_i:
bge t0, t1, setjump(for_i_end, for_i)

rem t2, t0, s4
bne t2, s2, setjump(a_ed, for_i + 2)
fdiv fr6, fr0, fr4
fadd fr2, fr2, fr6
j setjump(b_ed, a_ed - 1)
a_ed:
fdiv fr6, fr1, fr4
fadd fr2, fr2, fr6
b_ed:
fadd fr4, fr4, fr5
addi t0, t0, 1
j setjump(for_i, b_ed + 2)
for_i_end:

fmul fr2, fr2, fr3
