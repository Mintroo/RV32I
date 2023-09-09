#include "RV32I.asm"

j main

sqrt: ; float fr11(float fr11)
li32 a1, 0b00111111000000000000000000000000 ; a1 <= 0.5f
fmv.w.x fr12, a1  ; fr12 <= a1 (0.5f)
fmul fr13, fr11, fr12 ; fr13 <= xHalf
li32 a2, 0x5f3759df ; a2 <= 謎の数字
fmv.x.w a3, fr11 ; a3 <= fr11
srli a3, a3, 1 ; a3 >> 1
sub a2, a2, a3  ; tmp <= a2 = 謎の数字 - (x >> 1)
fmv.w.x fr14, a2 ; fr14 <= xRes = *(float*)tmp

li32 a1, 0b00111111110000000000000000000000 ; a1 <= 1.5f
fmv.w.x fr12, a1 ; fr12 <= a1 (1.5f)
fmul fr15, fr13, fr14 ; fr15 <= xHalf * xRes
fmul fr15, fr15, fr14 ; fr15 <= xHalf * xRes * xRes
fsub fr15, fr12, fr15 ; fr15 <= 1.5f - (xHalf * xRes * xRes)
fmul fr14, fr14, fr15 ; xRes *= fr15
fmul fr15, fr13, fr14 ; fr15 <= xHalf * xRes
fmul fr15, fr15, fr14 ; fr15 <= xHalf * xRes * xRes
fsub fr15, fr12, fr15 ; fr15 <= 1.5f - (xHalf * xRes * xRes)
fmul fr14, fr14, fr15 ; xRes *= fr15
fmul fr10, fr14, fr11 ; return = xRes * x

ret


main:
li32 t0, 0b01000001000100000000000000000000 ; t0 <= 9.0f
fmv.w.x fr11, t0 ; fr11 <= t0 (9.0f)
call setjump(sqrt, main + 3)
