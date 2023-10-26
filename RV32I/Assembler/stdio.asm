; a5 = charcolor, a6 = asciiptr, a7 = position
plotChar: ; void plotChar(int a5, int a6, int a7)[t5-6]
li32 t6, GPU_ONECOLOR
sw a5, t6, 0
li32 t6, GPU_POS
sw a7, t6, 0
li32 t6, GPU_ASCIIPTR
sw a6, t6, 0
li32 t6, GPU_EXE
li t5, plotASCII
sw t5, t6, 0
li32 t6, GPU_EN
.plotascii:
lw t5, t6, 0
bnez t5, setjump(plotChar.plotascii, plotChar.plotascii+1)

ret

; a3 = mod4position, a5 = stringcolor, a4 = stringptr, a7 = position
; a0 : when 0 is 画面内で終了
;    : when 1 is 画面外で強制終了
plotString: ; int plotString(int a3, int a5, int a4, int a7)[]
li t6, 0  ; 一時定数をt6で保持
mv t3, a7 ; 初期位置をt3で保持
li32 t6, 0xFF000000 ; マスク用定数
and t3, t3, t6 ; x0をANDでマスク (t3のx0部分を抽出)

.loop:

.case0:
li t6, 0
bne a3, t6, setjump(plotString.case1, plotString.case0 + 1)
lb a6, a4, 3
addi a3, a3, 1
j setjump(plotString.done, plotString.case0 + 4)
.case1:
li t6, 1
bne a3, t6, setjump(plotString.case2, plotString.case1 + 1)
lb a6, a4, 2
addi a3, a3, 1
j setjump(plotString.done, plotString.case1 + 4)
.case2:
li t6, 2
bne a3, t6, setjump(plotString.default, plotString.case2 + 1)
lb a6, a4, 1
addi a3, a3, 1
j setjump(plotString.done, plotString.case2 + 4)
.default:
li t6, 3
bne a3, t6, setjump(plotString.done, plotString.default + 1)
lb a6, a4, 0
li a3, 0
addi a4, a4, 1
.done:

.NUL:
li t6, "\0"
bne a6, t6, setjump(plotString.NF, plotString.NUL + 1)
li a0, 0 ; return 0
ret ; 終端文字なら終了
.NF:
li t6, "\n"
bne a6, t6, setjump(plotString.CR, plotString.NF + 1)
srli t5, a7, 16
li32 t6, 0x000000FF
and t5, t5, t6 ; y0の値をt5に抽出
li t6, 244
ble t5, t6, setjump(plotString.NFclear, plotString.NFclear - 3)
li a0, 1 ; return 1
ret ; 画面外に出たので強制終了
.NFclear:
li32 t6, 0x000d0000
add a7, a7, t6
j setjump(plotString.ASCIIdone, plotString.NF + 5)
.CR:
li t6, "\r"
bne a6, t6, setjump(plotString.defaulto, plotString.CR + 1)
li32 t6, 0x00FFFFFF ; マスク用定数
and a7, a7, t6 ; x0以外をANDマスク
add a7, a7, t3 ; x0部分を初期位置に差し替え
j setjump(plotString.ASCIIdone, plotString.CR + 6)
.defaulto:
addi sp, sp, -1
sw ra, sp, 0 ; plotString関数のraを退避
call setjump(plotChar, plotString.defaulto + 2)
lw ra, sp, 0 ; plotString関数のraを復帰
addi sp, sp, 1 ; spを復帰
srli t5, a7, 24
and t5, t5, t6 ; x0の値をt5に抽出
li t6, 249
ble t5, t6, setjump(plotString.defaultoclear, plotString.defaultoclear - 3)
li a0, 1 ; return 1
ret ; 画面外に出たので強制終了
.defaultoclear:
li32 t6, 0x06000000
add a7, a7, t6
.ASCIIdone:
j setjump(plotString.loop, plotString.ASCIIdone)