#include "RV32I.asm"
#include "GPUplot.asm"

BACKCOLOR = 0 ; white
selectUICOLOR = 1 ; black
confirmUICOLOR = 3 ;
ASCIICOLOR = 1 ; black
WARNINGCOLOR = 7 ;

selectUI: ; void selectUI(int s1, int a5)
li a6, 2
.minus:
li t6, 0
bne s1, t6, setjump(selectUI.plus, selectUI.minus + 1)
li32 a7, 0x9A3A8B30
addi sp, sp, -4
sw ra, sp, 0 ; selectUI関数のraを退避
call setjump(plotSquareFlame, selectUI.plus - 3)
lw ra, sp, 0 ; selectUI関数のraを復帰
addi sp, sp, 4 ; spを復帰
.plus:
li t6, 1
bne s1, t6, setjump(selectUI.start, selectUI.plus + 1)
li32 a7, 0x9A948B8A
addi sp, sp, -4
sw ra, sp, 0 ; selectUI関数のraを退避
call setjump(plotSquareFlame, selectUI.start - 3)
lw ra, sp, 0 ; selectUI関数のraを復帰
addi sp, sp, 4 ; spを復帰
.start:
li t6, 2
bne s1, t6, setjump(selectUI.return, selectUI.start + 1)
li32 a7, 0x9ACA8BA8
addi sp, sp, -4
sw ra, sp, 0 ; selectUI関数のraを退避
call setjump(plotSquareFlame, selectUI.return - 3)
lw ra, sp, 0 ; selectUI関数のraを復帰
addi sp, sp, 4 ; spを復帰
.return:
ret


plotcollatzexecute: ; void plotcollatzexecute(int s2, int a7)
li t6, 0
li t4, 10
mv t5, s2
.DECnumlen:
beqz t5, setjump(plotcollatzexecute.DECnumlened, plotcollatzexecute.DECnumlen)
addi t6, t6, 1
divu t5, t5, t4
j setjump(plotcollatzexecute.DECnumlen, plotcollatzexecute.DECnumlened - 1)
.DECnumlened: ; t6 = numlen
; 238 - 6*numlen < x0 のとき、positionchangeを実行
li t4, 6
mul t4, t4, t6
li t5, 238
sub t5, t5, t4 ; t5 = 238 - 6*numlen
mv t6, a7
li t4, 0xFF
and t6, a7, t4 ; t6 = a7's x0
bge t5, t6, setjump(plotcollatzexecute.plot, plotcollatzexecute.poschange - 1)
.poschange:
; 改行操作
li32 t6, 0x0000FF00 ; マスク用定数
and a7, a7, t6 ; y0のみ継承
liu t6, 0xd01
add a7, a7, t6
.plot:
; execute space描画
li a3, 0
li a5, ASCIICOLOR
li a4, 193
addi sp, sp, -4
sw ra, sp, 0 ; plotcollatzexecute関数のraを退避
call setjump(plotString, plotcollatzexecute.plot + 5)
lw ra, sp, 0 ; plotcollatzexecute関数のraを復帰
addi sp, sp, 4
; s2描画
mv a4, s2
addi sp, sp, -4
sw ra, sp, 0 ; plotcollatzexecute関数のraを退避
call setjump(plotDECu, plotcollatzexecute.plot + 11)
lw ra, sp, 0 ; plotcollatzexecute関数のraを復帰
addi sp, sp, 4

ret


main:
li s0, 0 ; ルートFSM
li s1, 2 ; ボタン選択
li s2, 1 ; シミュレーション数値
li s3, 0 ; ボタン押下記憶 (0 : 押下解除, 1 : 押下中)
li s4, 0 ; エラーメッセージFSM

li t0, 41 ; タイトル画面文字列アドレス指定
li32 t1, "lloC"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, " zta"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "borp"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, " mel"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "umiS"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "otal"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "\n\n\rr"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "\n\n\n\n"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "   -"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "    "
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "    "
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "+   "
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "    "
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "rats"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "\0\0\0t"
sw t1, t0, 0

li t0, 105 ; エラーメッセージ文字列アドレス指定
li32 t1, "ilaV"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "ar d"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, " egn"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "v fo"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "eula"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "si s"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "eb\n\r"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "eewt"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, " 1 n"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, " dna"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "4924"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "2769"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "\0\059"
sw t1, t0, 0

li t0, 157 ; Odd operation文字列アドレス指定
li32 t1, " ddO"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, " :  "
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "\0\0\0\0"
sw t1, t0, 0

li t0, 169 ; Even operation文字列アドレス指定
li32 t1, "nevE"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, " :  "
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "\0\0\0\0"
sw t1, t0, 0

li t0, 181 ; Total operation文字列アドレス指定
li32 t1, "atoT"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, " : l"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "\0\0\0\0"
sw t1, t0, 0

li t0, 193 ; execute space文字列アドレス指定
li32 t1, "\0 - "
sw t1, t0, 0

li t0, 197 ; シミュレーション完了文字列アドレス指定
li32 t1, "pmoC"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "etel"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "!! d"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "rP\n\r"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, " sse"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "ot B"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, " og "
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "kcab"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "\0\0\0."
sw t1, t0, 0

li t0, 233 ; オーバーフローエラー文字列アドレス指定
li32 t1, "revO"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "wolf"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "! de"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "P\n\r!"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "sser"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "t B "
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "og o"
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "cab "
sw t1, t0, 0
addi t0, t0, 4
li32 t1, "\0\0.k"
sw t1, t0, 0

.rootloop:
li t0, 0
bne s0, t0, setjump(main.simulating, main.rootloop + 1)
; タイトル画面モードの処理
; タイトル描画
li a3, 0
li a5, ASCIICOLOR
li a4, 41
li32 a7, 0x4033
call setjump(plotString, main.rootloop + 7)
li a5, ASCIICOLOR
mv a4, s2
li32 a7, 0x8E3F
call setjump(plotDECu, main.rootloop + 12)
li a5, selectUICOLOR
call setjump(selectUI, main.title - 1)
.title: ; タイトル画面モードのループ処理
li32 t0, GameC_1P ; 1Pコントローラの監視
lw t0, t0, 0 ; 1サイクル内の1Pコントローラの監視
bnez s3, setjump(main.pushcancel, main.movenothing - 1) ; 前回、ボタン押下中の場合はスキップ

.movenothing:
beqz t0, setjump(main.title, main.movenothing)
.dlterror:
beqz s4, setjump(main.moveleft, main.dlterror) ; エラーメッセージを消去
li a5, BACKCOLOR
li32 a7, 0xE6BED010
call setjump(plotRectangle, main.moveleft - 2)
li s4, 0 ; エラーメッセージ消去判定
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
li t1, GameC_B
bne t0, t1, setjump(main.title, main.confirm + 1) ; 決定押下でない場合はスキップ
li a5, confirmUICOLOR
call setjump(selectUI, main.confirm + 3) ; 確定UIに差し替え
; 現在選択しているボタンに応じて、そのボタンの処理を実行
.confirm_minus:
li t1, 0 ; マイナスボタンの処理
bne s1, t1, setjump(main.confirm_plus, main.confirm_minus + 1)
li t1, 1 ; シミュレーション数値が1の場合はエラーメッセージを表示
bne s2, t1, setjump(main.confirm_minus_clear, main.confirm_minus + 3)
li a3, 0
li a5, WARNINGCOLOR
li a4, 105
li32 a7, 0xD010
call setjump(plotString, main.confirm_minus + 9)
li s4, 1 ; エラーメッセージ生成判定
j setjump(main.confirmed, main.confirm_minus_clear - 1)
.confirm_minus_clear:
li a5, BACKCOLOR ; 前回のシミュレーション数値フィールドを削除
li32 a7, 0x997A8E3F
call setjump(plotRectangle, main.confirm_minus_clear + 3)
addi s2, s2, -1
li a5, ASCIICOLOR ; シミュレーション数値フィールドを更新
mv a4, s2
li32 a7, 0x8E3F
call setjump(plotDECu, main.confirm_minus_clear + 9)
j setjump(main.confirmed, main.confirm_minus_clear + 10)
.confirm_plus:
li t1, 1 ; プラスボタンの処理
bne s1, t1, setjump(main.confirm_start, main.confirm_plus + 1)
li32 t1, 0xFFFFFFFF ; シミュレーション数値が2^32 - 1の場合はエラーメッセージを表示
bne s2, t1, setjump(main.confirm_plus_clear, main.confirm_plus + 4)
li a3, 0
li a5, WARNINGCOLOR
li a4, 105
li32 a7, 0xD010
call setjump(plotString, main.confirm_plus + 10)
li s4, 1 ; エラーメッセージ生成判定
j setjump(main.confirmed, main.confirm_plus_clear - 1)
.confirm_plus_clear:
li a5, BACKCOLOR ; 前回のシミュレーション数値フィールドを削除
li32 a7, 0x997A8E3F
call setjump(plotRectangle, main.confirm_plus_clear + 3)
addi s2, s2, 1
li a5, ASCIICOLOR ; シミュレーション数値フィールドを更新
mv a4, s2
li32 a7, 0x8E3F
call setjump(plotDECu, main.confirm_plus_clear + 9)
j setjump(main.confirmed, main.confirm_plus_clear + 10)
.confirmed:
li s3, 1 ; ボタン押下を記憶
j setjump(main.title, main.confirmed + 1)
.confirm_start:
li s0, 1 ; シミュレーションモードに移行
j setjump(main.rootloop, main.confirm_start + 1)

.pushcancel: ; 前回、ボタン押下時に今回ボタン押下を解除した場合はボタン押下を解除する
bnez t0, setjump(main.title, main.pushcancel)
li s3, 0
li a5, ASCIICOLOR
call setjump(selectUI, main.pushcancel + 3)
j setjump(main.title, main.pushcancel + 4)


.simulating:
li s5, 0 ; 奇数操作の回数
li s6, 0 ; 偶数操作の回数
li s7, 0 ; 操作の総数
; タイトル画面の消去
li a5, BACKCOLOR
li32 a7, 0x4BC94033
call setjump(plotRectangle, main.simulating + 6)
li32 a7, 0x9BCB8A30
call setjump(plotRectangle, main.simulating + 9)
; odd operationフィールドの描画
li a3, 0
li a5, ASCIICOLOR
li a4, 157
li32 a7, 0x0101
call setjump(plotString, main.simulating + 15)
mv a4, s5
call setjump(plotDECu, main.simulating + 17)
; even operationフィールドの描画
li a3, 0
li a4, 169
li32 a7, 0x0E01
call setjump(plotString, main.simulating + 22)
mv a4, s6
call setjump(plotDECu, main.simulating + 24)
; total operationフィールドの描画
li a3, 0
li a4, 181
li32 a7, 0x1B01
call setjump(plotString, main.simulating + 29)
mv a4, s7
call setjump(plotDECu, main.simulating + 31)
; 横線の描画
li32 a7, 0x28FF2800
call setjump(plotRectangle, main.simulating + 34)
; シミュレーション数値の描画
mv a4, s2
li32 a7, 0x2A01
call setjump(plotDECu, main.simulating + 38)
; シミュレーション数値の退避
li t0, 300
sw s2, t0, 0
; executeposの退避
li t0, 304
sw a7, t0, 0
.collatzloop:
li t0, 1
bne s2, t0, setjump(main.collatzoperation, main.collatzloop + 1)
; 1になった時の処理
; completeの描画
li a3, 0
li a4, 197
li32 a7, 0x0E81
call setjump(plotString, main.collatzloop + 6)
j setjump(main.collatzfinish, main.collatzloop + 7)
.collatzoperation:
andi t0, s2, 1 ; 1桁目をマスク
beqz t0, setjump(main.collatz_even, main.collatzoperation + 1)
; 奇数時の操作(3倍して1を足す)
;           =>(2倍+1倍+1)
mv t1, s2 ; オーバーフロー検出用に退避
slli t0, s2, 1 ; t0 = s2 * 2
add s2, s2, t0 ; s2 = s2 + t0
addi s2, s2, 1 ; s2 = s2 + 1
bgtu s2, t1, setjump(main.collatz_odd_clear, main.collatzoperation + 6)
; オーバーフローエラーの描画
li a3, 0
li a4, 233
li32 a7, 0x0E81
call setjump(plotString, main.collatzoperation + 11)
j setjump(main.collatzfinish, main.collatzoperation + 12)
.collatz_odd_clear:
; executeposの復帰
li t0, 304
lw a7, t0, 0
; コラッツ操作の描画
call setjump(plotcollatzexecute, main.collatz_odd_clear + 2)
; executeposの退避
li t0, 304
sw a7, t0, 0
addi s5, s5, 1 ; 奇数操作回数をカウント
; oddフィールドの消去
li a5, BACKCOLOR
li32 a7, 0x0C6D0131
call setjump(plotRectangle, main.collatz_odd_clear + 9)
; oddフィールドの更新
li a5, ASCIICOLOR
mv a4, s5
li32 a7, 0x0131
call setjump(plotDECu, main.collatz_odd_clear + 14)
addi s7, s7, 1 ; 操作の総数をカウント
; totalフィールドの消去
li a5, BACKCOLOR
li32 a7, 0x266D1B31
call setjump(plotRectangle, main.collatz_odd_clear + 19)
; totalフィールドの更新
li a5, ASCIICOLOR
mv a4, s7
li32 a7, 0x1B31
call setjump(plotDECu, main.collatz_odd_clear + 24)

.collatz_even:
; 偶数時の操作(2でわる)
;           =>(右に1ビットシフトする)
srli s2, s2, 1 ; s2 = s2 / 2
; executeposの復帰
li t0, 304
lw a7, t0, 0
; コラッツ操作の描画
call setjump(plotcollatzexecute, main.collatz_even + 3)
; executeposの退避
li t0, 304
sw a7, t0, 0
addi s6, s6, 1 ; 偶数操作回数をカウント
; evenフィールドの消去
li a5, BACKCOLOR
li32 a7, 0x196D0E31
call setjump(plotRectangle, main.collatz_even + 10)
; evenフィールドの更新
li a5, ASCIICOLOR
mv a4, s6
li32 a7, 0x0E31
call setjump(plotDECu, main.collatz_even + 15)
addi s7, s7, 1 ; 操作の総数をカウント
; totalフィールドの消去
li a5, BACKCOLOR
li32 a7, 0x266D1B31
call setjump(plotRectangle, main.collatz_even + 20)
; totalフィールドの更新
li a5, ASCIICOLOR
mv a4, s7
li32 a7, 0x1B31
call setjump(plotDECu, main.collatz_even + 25)
j setjump(main.collatzloop, main.collatz_even + 26)

.collatzfinish:
li32 t0, GameC_1P ; 1Pコントローラの監視
lw t0, t0, 0 ; 1サイクル内の1Pコントローラの監視
li t1, GameC_B
bne t0, t1, setjump(main.collatzfinish, main.collatzfinish + 4)
; 画面リセット
li a5, BACKCOLOR
li32 a7, 0xFFFF0000
call setjump(plotRectangle, main.collatzfinish + 8)
; シミュレーション数値の復帰
li t0, 300
lw s2, t0, 0
li s0, 0 ; タイトル画面モードに遷移
j setjump(main.rootloop, main.collatzfinish + 12)