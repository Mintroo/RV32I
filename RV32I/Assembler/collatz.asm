#include "RV32I.asm"
#include "GPUplot.asm"

BACKCOLOR = 0 ; white
selectUICOLOR = 1 ; black
confirmUICOLOR = 3 ;
ASCIICOLOR = 1 ; black

selectUI: ; void selectUI(int s1, int a5)
li a6, 2
.minus:
li t6, 0
bne s1, t6, setjump(selectUI.plus, selectUI.minus + 1)
li32 a7, 0x308B3A9A
addi sp, sp, -1
sw ra, sp, 0 ; selectUI関数のraを退避
call setjump(plotSquareFlame, selectUI.plus - 3)
lw ra, sp, 0 ; selectUI関数のraを復帰
addi sp, sp, 1 ; spを復帰
.plus:
li t6, 1
bne s1, t6, setjump(selectUI.start, selectUI.plus + 1)
li32 a7, 0x8A8B949A
addi sp, sp, -1
sw ra, sp, 0 ; selectUI関数のraを退避
call setjump(plotSquareFlame, selectUI.start - 3)
lw ra, sp, 0 ; selectUI関数のraを復帰
addi sp, sp, 1 ; spを復帰
.start:
li t6, 2
bne s1, t6, setjump(selectUI.return, selectUI.start + 1)
li32 a7, 0xA88BCA9A
addi sp, sp, -1
sw ra, sp, 0 ; selectUI関数のraを退避
call setjump(plotSquareFlame, selectUI.return - 3)
lw ra, sp, 0 ; selectUI関数のraを復帰
addi sp, sp, 1 ; spを復帰
.return:
ret

main:
li s0, 0 ; ルートFSM
li s1, 2 ; ボタン選択
li s2, 1 ; シミュレーション数値
li s3, 0 ; ボタン押下記憶 (0 : 押下解除, 1 : 押下中)

li t0, 41 ; 文字列アドレス指定
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
li a5, ASCIICOLOR
li a4, 41
li32 a7, 0x33400000
call setjump(plotString, main.rootloop + 7)
li a5, ASCIICOLOR
mv a4, s2
li32 a7, 0x3F8E0000
call setjump(plotDEC, main.rootloop + 12)
li a5, selectUICOLOR
call setjump(selectUI, main.title - 1)
.title: ; タイトル画面モードのループ処理
li32 t0, GameC_1P ; 1Pコントローラの監視
lw t0, t0, 0 ; 1サイクル内の1Pコントローラの監視
bnez s3, setjump(main.pushcancel, main.movenothing - 1) ; 前回、ボタン押下中の場合はスキップ

.movenothing:
beqz t0, setjump(main.title, main.movenothing)
.moveleft:
li t1, GameC_left
bne t0, t1, setjump(main.moveright, main.moveleft + 1) ; 左矢印押下でない場合はスキップ
li a5, BACKCOLOR
call setjump(selectUI, main.moveleft + 3) ; 前回のボタン選択UIを消去
beqz s1, setjump(main.beforezero, main.moveleft + 4) ; 前回のボタン選択が0の場合はジャンプ
addi s1, s1, -1
j setjump(main.movelefted, main.beforezero - 1)
.beforezero:
li s1, 2 ; 0から2に遷移
.movelefted:
li a5, selectUICOLOR
call setjump(selectUI, main.movelefted + 1) ; 新しく選択したボタンのUIを描画
li s3, 1 ; ボタン押下を記憶
j setjump(main.title, main.moveright - 1)

.moveright:
li t1, GameC_right
bne t0, t1, setjump(main.confirm, main.moveright + 1) ; 右矢印押下でない場合はスキップ
li a5, BACKCOLOR
call setjump(selectUI, main.moveright + 3) ; 前回のボタン選択UIを消去
li t1, 2
beq s1, t1, setjump(main.beforetwo, main.moveright + 5) ; 前回のボタン選択が2の場合はジャンプ
addi s1, s1, 1
j setjump(main.moverighted, main.beforetwo - 1)
.beforetwo:
li s1, 0 ; 2から0に遷移
.moverighted:
li a5, selectUICOLOR
call setjump(selectUI, main.moverighted + 1) ; 新しく選択したボタンのUIを描画
li s3, 1 ; ボタン押下を記憶
j setjump(main.title, main.confirm - 1)

.confirm:
.pushcancel: ; 前回、ボタン押下時に今回ボタン押下を解除した場合はボタン押下を解除する
bnez t0, setjump(main.title, main.pushcancel)
li s3, 0
j setjump(main.title, main.pushcancel + 2)
.simulating: