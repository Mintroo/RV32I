#include "RV32I.asm"

j main

math:
.sqrt: ; float(fa0) sqrt(float fa7)[ft8-11, t4-6]
li32 t6, 0b00111111000000000000000000000000 ; t6 <= 0.5f
fmv.w.x ft11, t6     ; ft11 <= t6 (0.5f)
fmul ft10, fa7, ft11 ; xHalf(ft10)
li32 t5, 0x5f3759df  ; t5 <= magic number
fmv.x.w t4, fa7      ; t4 <= fa7
srli t4, t4, 1       ; t4 >> 1
sub t5, t5, t4       ; tmp(t5) = magicnumber - (x >> 1)
fmv.w.x ft9, t5      ; xRes(ft9) = *(float*)tmp(t5)

li32 t6, 0b00111111110000000000000000000000 ; t6 <= 1.5f
fmv.w.x ft11, t6     ; ft11 <= t6 (1.5f)
fmul ft8, ft10, ft9  ; ft8 <= xHalf * xRes
fmul ft8, ft8, ft9   ; ft8 <= xHalf * xRes * xRes
fsub ft8, ft11, ft8  ; ft8 <= 1.5f - (xHalf * xRes * xRes)
fmul ft9, ft9, ft8   ; xRes = xRes * ft8
fmul ft8, ft10, ft9  ; ft8 <= xHalf * xRes
fmul ft8, ft8, ft9   ; ft8 <= xHalf * xRes * xRes
fsub ft8, ft11, ft8  ; ft8 <= 1.5f - (xHalf * xRes * xRes)
fmul ft9, ft9, ft8   ; xRes = xRes * ft8
fmul fa0, ft9, fa7   ; return = xRes * x

ret

.rsqrt: ; float(fa0) rsqrt(float fa7)[ft8-11, t4-6]
li32 t6, 0b00111111000000000000000000000000 ; t6 <= 0.5f
fmv.w.x ft11, t6     ; ft11 <= t6 (0.5f)
fmul ft10, fa7, ft11 ; xHalf(ft10)
li32 t5, 0x5f3759df  ; t5 <= magic number
fmv.x.w t4, fa7      ; t4 <= fa7
srli t4, t4, 1       ; t4 >> 1
sub t5, t5, t4       ; tmp(t5) = magicnumber - (x >> 1)
fmv.w.x ft9, t5      ; xRes(ft9) = *(float*)tmp(t5)

li32 t6, 0b00111111110000000000000000000000 ; t6 <= 1.5f
fmv.w.x ft11, t6     ; ft11 <= t6 (1.5f)
fmul ft8, ft10, ft9  ; ft8 <= xHalf * xRes
fmul ft8, ft8, ft9   ; ft8 <= xHalf * xRes * xRes
fsub ft8, ft11, ft8  ; ft8 <= 1.5f - (xHalf * xRes * xRes)
fmul ft9, ft9, ft8   ; xRes = xRes * ft8
fmul ft8, ft10, ft9  ; ft8 <= xHalf * xRes
fmul ft8, ft8, ft9   ; ft8 <= xHalf * xRes * xRes
fsub ft8, ft11, ft8  ; ft8 <= 1.5f - (xHalf * xRes * xRes)
fmul fa0, ft9, ft8   ; return = xRes * ft8

ret

main:
li32 t0, 0b01000001000100000000000000000000 ; t0 <= 9.0f
fmv.w.x fa7, t0 ; fa7 <= t0 (9.0f)
call setjump(math.sqrt, main + 3)
li32 t0, 0b01000000100000000000000000000000 ; t0 <= 4.0f
fmv.w.x fa7, t0 ; fa7 <= t0 (4.0f)
call setjump(math.rsqrt, main + 7)
