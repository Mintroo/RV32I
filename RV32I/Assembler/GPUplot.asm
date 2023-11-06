; a5 = charcolor, a6 = asciiptr, a7 = position
plotChar: ; void plotChar(int a5, int a6, int a7)[t5-6]
li32 t6, GPU_ONECOLOR
sb a5, t6, 0
li32 t6, GPU_APOS
sh a7, t6, 0
li32 t6, GPU_ASCIIPTR
sb a6, t6, 0
li32 t6, GPU_EXE
li t5, plotASCII
sb t5, t6, 0
li32 t6, GPU_EN
.plotascii:
lb t5, t6, 0
bnez t5, setjump(plotChar.plotascii, plotChar.plotascii+1)

ret

; a5 = stringcolor, a4 = stringptr, a7 = position
; a0 : when 0 is 画面内で終了
;    : when 1 is 画面外で強制終了
plotString: ; int plotString(int a3, int a5, int a4, int a7)[]
li t6, 0  ; 一時定数をt6で保持
mv t3, a7 ; 初期位置をt3で保持
li t6, 0xFF ; マスク用定数
and t3, t3, t6 ; x0をANDでマスク (t3のx0部分を抽出)

.loop:

; 1文字取得
lb a6, a4, 0
addi a4, a4, 1

.NUL:
li t6, "\0"
bne a6, t6, setjump(plotString.NF, plotString.NUL + 1)
li a0, 0 ; return 0
ret ; 終端文字なら終了
.NF:
li t6, "\n"
bne a6, t6, setjump(plotString.CR, plotString.NF + 1)
srli t5, a7, 8
li t6, 0xFF
and t5, t5, t6 ; y0の値をt5に抽出
li t6, 244
ble t5, t6, setjump(plotString.NFclear, plotString.NFclear - 3)
li a0, 1 ; return 1
ret ; 画面外に出たので強制終了
.NFclear:
liu t6, 0xd00
add a7, a7, t6
j setjump(plotString.ASCIIdone, plotString.CR - 1)
.CR:
li t6, "\r"
bne a6, t6, setjump(plotString.defaulto, plotString.CR + 1)
li32 t6, 0xFFFFFF00 ; マスク用定数
and a7, a7, t6 ; x0以外をANDマスク
add a7, a7, t3 ; x0部分を初期位置に差し替え
j setjump(plotString.ASCIIdone, plotString.CR + 6)
.defaulto:
li t6, " "
beq a6, t6, setjump(plotString.plotted, plotString.defaulto + 1)
addi sp, sp, -4
sw ra, sp, 0 ; plotString関数のraを退避
call setjump(plotChar, plotString.defaulto + 4)
lw ra, sp, 0 ; plotString関数のraを復帰
addi sp, sp, 4 ; spを復帰
.plotted:
li t5, 0xFF ; マスク用定数
and t5, a7, t5 ; t5にa7のx0を抽出
li t6, 249
ble t5, t6, setjump(plotString.defaultoclear, plotString.defaultoclear - 3)
li a0, 1 ; return 1
ret ; 画面外に出たので強制終了
.defaultoclear:
li t6, 6
add a7, a7, t6
.ASCIIdone:
j setjump(plotString.loop, plotString.ASCIIdone)

ret

; a5 = stringcolor, a4 = number, a7 = position
; a0 : when 0 is 画面内で終了
;    : when 1 is 画面外で強制終了
plotDEC: ; int plotDEC(int a5, int a4, int a7)[]
li t6, 0  ; t6 : カウントアップ変数
li t5, 0  ; t5 : あまり、ASCIIコード格納変数
li t4, 10 ; t4 : 一時定数、文字列ポインタ
li t3, 0  ; t3 : mod4変数
li t2, 0  ; t2 : 一時定数
.sign:
bgez a4, setjump(plotDEC.strnumloop, plotDEC.sign)
neg a4, a4
li t3, 1
.strnumloop:
beqz a4, setjump(plotDEC.strnumed, plotDEC.strnumloop)
rem t5, a4, t4
addi t5, t5, 48
sw t5, t6, 0
div a4, a4, t4
addi t6, t6, 1
j setjump(plotDEC.strnumloop, plotDEC.strnumed - 1)
.strnumed:
beqz t3, setjump(plotDEC.strASCII, plotDEC.strnumed)
li t5, "-"
sw t5, t6, 0
addi t6, t6, 1
li t3, 0
.strASCII:
li t4, 32 ; 数値のASCII文字列の先頭のポインタ
bnez t6, setjump(plotDEC.strASCIIloop, plotDEC.strASCII + 1)
li32 t5, "0\0\0\0" ; numberが0の場合は、"0"を代入してstrASCIIは終了
sw t5, t4, 0
j setjump(plotDEC.plot, plotDEC.strASCIIloop - 1)

.strASCIIloop:
beqz t6, setjump(plotDEC.NUL, plotDEC.strASCIIloop)
addi t6, t6, -1
lw t5, t6, 0
.case0:
li t2, 0
bne t3, t2, setjump(plotDEC.case1, plotDEC.case0 + 1)
sb t5, t4, 3
addi t3, t3, 1
j setjump(plotDEC.strASCIIloop, plotDEC.case1 - 1)
.case1:
li t2, 1
bne t3, t2, setjump(plotDEC.case2, plotDEC.case1 + 1)
sb t5, t4, 2
addi t3, t3, 1
j setjump(plotDEC.strASCIIloop, plotDEC.case2 - 1)
.case2:
li t2, 2
bne t3, t2, setjump(plotDEC.default, plotDEC.case2 + 1)
sb t5, t4, 1
addi t3, t3, 1
j setjump(plotDEC.strASCIIloop, plotDEC.default - 1)
.default:
sb t5, t4, 0
li t3, 0
addi t4, t4, 1
j setjump(plotDEC.strASCIIloop, plotDEC.NUL - 1)

.NUL:
li t5, "\0"
.ccase0:
li t2, 0
bne t3, t2, setjump(plotDEC.ccase1, plotDEC.ccase0 + 1)
sb t5, t4, 3
j setjump(plotDEC.plot, plotDEC.ccase1 - 1)
.ccase1:
li t2, 1
bne t3, t2, setjump(plotDEC.ccase2, plotDEC.ccase1 + 1)
sb t5, t4, 2
j setjump(plotDEC.plot, plotDEC.ccase2 - 1)
.ccase2:
li t2, 2
bne t3, t2, setjump(plotDEC.ddefault, plotDEC.ccase2 + 1)
sb t5, t4, 1
j setjump(plotDEC.plot, plotDEC.ddefault - 1)
.ddefault:
sb t5, t4, 0
.plot:
li a3, 0
li a4, 32
addi sp, sp, -1
sw ra, sp, 0 ; plotDEC関数のraを退避
call setjump(plotString, plotDEC.plot + 4)
lw ra, sp, 0 ; plotDEC関数のraを復帰
addi sp, sp, 1 ; spを復帰

ret

; a5 = stringcolor, a4 = number, a7 = position
; a0 : when 0 is 画面内で終了
;    : when 1 is 画面外で強制終了
plotDECu: ; int plotDECu(int a5, unsigned int a4, int a7)[]
li t6, 0  ; t6 : カウントアップ変数
li t5, 0  ; t5 : あまり、ASCIIコード格納変数
li t4, 10 ; t4 : 一時定数、文字列ポインタ
li t3, 0  ; t3 : mod4変数
li t2, 0  ; t2 : 一時定数

.strnumloop:
beqz a4, setjump(plotDECu.strASCII, plotDECu.strnumloop)
remu t5, a4, t4
addi t5, t5, 48
sw t5, t6, 0
divu a4, a4, t4
addi t6, t6, 1
j setjump(plotDECu.strnumloop, plotDECu.strASCII - 1)
.strASCII:
li t4, 32 ; 数値のASCII文字列の先頭のポインタ
bnez t6, setjump(plotDECu.strASCIIloop, plotDECu.strASCII + 1)
li32 t5, "0\0\0\0" ; numberが0の場合は、"0"を代入してstrASCIIは終了
sw t5, t4, 0
j setjump(plotDECu.plot, plotDECu.strASCIIloop - 1)

.strASCIIloop:
beqz t6, setjump(plotDECu.NUL, plotDECu.strASCIIloop)
addi t6, t6, -1
lw t5, t6, 0
.case0:
li t2, 0
bne t3, t2, setjump(plotDECu.case1, plotDECu.case0 + 1)
sb t5, t4, 3
addi t3, t3, 1
j setjump(plotDECu.strASCIIloop, plotDECu.case1 - 1)
.case1:
li t2, 1
bne t3, t2, setjump(plotDECu.case2, plotDECu.case1 + 1)
sb t5, t4, 2
addi t3, t3, 1
j setjump(plotDECu.strASCIIloop, plotDECu.case2 - 1)
.case2:
li t2, 2
bne t3, t2, setjump(plotDECu.default, plotDECu.case2 + 1)
sb t5, t4, 1
addi t3, t3, 1
j setjump(plotDECu.strASCIIloop, plotDECu.default - 1)
.default:
sb t5, t4, 0
li t3, 0
addi t4, t4, 1
j setjump(plotDECu.strASCIIloop, plotDECu.NUL - 1)

.NUL:
li t5, "\0"
.ccase0:
li t2, 0
bne t3, t2, setjump(plotDECu.ccase1, plotDECu.ccase0 + 1)
sb t5, t4, 3
j setjump(plotDECu.plot, plotDECu.ccase1 - 1)
.ccase1:
li t2, 1
bne t3, t2, setjump(plotDECu.ccase2, plotDECu.ccase1 + 1)
sb t5, t4, 2
j setjump(plotDECu.plot, plotDECu.ccase2 - 1)
.ccase2:
li t2, 2
bne t3, t2, setjump(plotDECu.ddefault, plotDECu.ccase2 + 1)
sb t5, t4, 1
j setjump(plotDECu.plot, plotDECu.ddefault - 1)
.ddefault:
sb t5, t4, 0
.plot:
li a3, 0
li a4, 32
addi sp, sp, -1
sw ra, sp, 0 ; plotDEC関数のraを退避
call setjump(plotString, plotDECu.plot + 4)
lw ra, sp, 0 ; plotDEC関数のraを復帰
addi sp, sp, 1 ; spを復帰

ret

; a5 = stringcolor, a7 = position
plotRectangle:
li32 t6, GPU_ONECOLOR
sw a5, t6, 0
li32 t6, GPU_POS
sw a7, t6, 0
li32 t6, GPU_EXE
li t5, plotRect
sw t5, t6, 0
li32 t6, GPU_EN
.rect:
lw t5, t6, 0
bnez t5, setjump(plotRectangle.rect, plotRectangle.rect + 1)

ret

; a5 = stringcolor, a6 = thickness, a7 = position
plotSquareFlame:
bgtz a6, setjump(plotSquareFlame.plot, plotSquareFlame)
ret
.plot:
sw a7, zero, 0 ; edit_position
sw a7, zero, 1 ; protect_position

lb t6, zero, 2
sb t6, zero, 0
lw a7, zero, 0
addi sp, sp, -1
sw ra, sp, 0 ; plotSquareFlame関数のraを退避
call setjump(plotRectangle, plotSquareFlame.plot + 7)
lw ra, sp, 0 ; plotSquareFlame関数のraを復帰
addi sp, sp, 1 ; spを復帰
lw t6, zero, 1
sw t6, zero, 0

lb t6, zero, 3
sb t6, zero, 1
lw a7, zero, 0
addi sp, sp, -1
sw ra, sp, 0 ; plotSquareFlame関数のraを退避
call setjump(plotRectangle, plotSquareFlame.plot + 17)
lw ra, sp, 0 ; plotSquareFlame関数のraを復帰
addi sp, sp, 1 ; spを復帰
lw t6, zero, 1
sw t6, zero, 0

lb t6, zero, 0
sb t6, zero, 2
lw a7, zero, 0
addi sp, sp, -1
sw ra, sp, 0 ; plotSquareFlame関数のraを退避
call setjump(plotRectangle, plotSquareFlame.plot + 27)
lw ra, sp, 0 ; plotSquareFlame関数のraを復帰
addi sp, sp, 1 ; spを復帰
lw t6, zero, 1
sw t6, zero, 0

lb t6, zero, 1
sb t6, zero, 3
lw a7, zero, 0
addi sp, sp, -1
sw ra, sp, 0 ; plotSquareFlame関数のraを退避
call setjump(plotRectangle, plotSquareFlame.plot + 37)
lw ra, sp, 0 ; plotSquareFlame関数のraを復帰
addi sp, sp, 1 ; spを復帰

addi a6, a6, -1
beqz a6, setjump(plotSquareFlame.return, plotSquareFlame.plot + 41)
lw a7, zero, 1
li32 t6, 0x00000101
add a7, a7, t6
li32 t6, 0x01010000
sub a7, a7, t6
addi sp, sp, -1
sw ra, sp, 0 ; 再帰呼び出し前のplotSquareFlame関数のraを退避
call setjump(plotSquareFlame, plotSquareFlame + 51)
lw ra, sp, 0 ; 再帰呼び出し前のplotSquareFlame関数のraを復帰
addi sp, sp, 1 ; spを復帰
.return:
ret