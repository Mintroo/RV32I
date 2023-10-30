#include "RV32I.asm"
#include "GPUplot.asm"

main:
li32 s1, -498275
li32 s2, -35325523
li32 s3, -1
li a5, 1
mv a4, s3
li32 a7, 0xA0A00000
call setjump(plotDECu, main.HALT - 1)
.HALT:
neg s3, s3
mv a4, s3
li32 a7, 0xA0AD0000
call setjump(plotDECu, main.HALT2 - 1)
.HALT2: