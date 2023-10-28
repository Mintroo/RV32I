#include "RV32I.asm"
#include "GPUplot.asm"

selectUI: ; void selectUI(int s1, int a5)
li a6, 6
.minus:
li t6, 0
bne s1, t6, setjump(selectUI.plus, selectUI.minus + 1)
li32 a7, 0x318C399B
call setjump(plotSquareFlame, selectUI.plus - 1)
.plus:
li t6, 1
bne s1, t6, setjump(selectUI.start, selectUI.plus + 1)
li32 a7, 0x8B8C939B
call setjump(plotSquareFlame, selectUI.start - 1)
.start:
li t6, 2
bne s1, t6, setjump(selectUI.return, selectUI.start + 1)
li32 a7, 0xE58CED9B
call setjump(plotSquareFlame, selectUI.return - 1)
.return:
ret

main:
li s0, 0 ; ルートFSM
li s1, 1 ; ボタン選択
li s2, 1 ; シミュレーション数値

li t0, 45 ; 文字列アドレス指定
li32 t1, "Coll"
sw t1, t0, 0
addi t0, t0, 1
li32 t1, "atz "
sw t1, t0, 0
addi t0, t0, 1
li32 t1, "prob"
sw t1, t0, 0
addi t0, t0, 1
li32 t1, "lem "
sw t1, t0, 0
addi t0, t0, 1
li32 t1, "Simu"
sw t1, t0, 0
addi t0, t0, 1
li32 t1, "lato"
sw t1, t0, 0
addi t0, t0, 1
li32 t1, "r\r\n\n"
sw t1, t0, 0
addi t0, t0, 1
li32 t1, "\n\n\n\n"
sw t1, t0, 0
addi t0, t0, 1
li32 t1, "-   "
sw t1, t0, 0
addi t0, t0, 1
li32 t1, "    "
sw t1, t0, 0
addi t0, t0, 1
li32 t1, "    "
sw t1, t0, 0
addi t0, t0, 1
li32 t1, "   +"
sw t1, t0, 0
addi t0, t0, 1
li32 t1, "    "
sw t1, t0, 0
addi t0, t0, 1
li32 t1, "star"
sw t1, t0, 0
addi t0, t0, 1
li32 t1, "t\0\0\0"
sw t1, t0, 0
.rootloop:
li t0, 0
bne s0, t0, setjump(main.simulating, main.rootloop + 1)
; タイトル画面モードの処理
; タイトル描画
li a3, 0
li a5, 1
li a4, 45
li32 a7, 0x33400000
call setjump(plotString, main.rootloop + 7)
li a5, 1
mv a4, s2
li32 a7, 0x3F8E0000
call setjump(plotDEC, main.rootloop + 12)
li a5, 3
call setjump(selectUI, main.title - 1)
.title: ; タイトル画面モードのループ

.simulating: