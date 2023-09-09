#include "RV32I.asm"

j main

random64: ; 64個のランダムな値をメモリに代入する関数 引数なし
li t1, 0
li t0, 19
sw t0, t1, 0
li t0, 54
sw t0, t1, 1
li t0, 56
sw t0, t1, 2
li t0, 20
sw t0, t1, 3
li t0, 53
sw t0, t1, 4
li t0, 24
sw t0, t1, 5
li t0, 0
sw t0, t1, 6
li t0, 13
sw t0, t1, 7
li t0, 48
sw t0, t1, 8
li t0, 43
sw t0, t1, 9
li t0, 8
sw t0, t1, 10
li t0, 7
sw t0, t1, 11
li t0, 30
sw t0, t1, 12
li t0, 44
sw t0, t1, 13
li t0, 12
sw t0, t1, 14
li t0, 58
sw t0, t1, 15
li t0, 16
sw t0, t1, 16
li t0, 33
sw t0, t1, 17
li t0, 3
sw t0, t1, 18
li t0, 45
sw t0, t1, 19
li t0, 37
sw t0, t1, 20
li t0, 5
sw t0, t1, 21
li t0, 6
sw t0, t1, 22
li t0, 29
sw t0, t1, 23
li t0, 52
sw t0, t1, 24
li t0, 61
sw t0, t1, 25
li t0, 42
sw t0, t1, 26
li t0, 15
sw t0, t1, 27
li t0, 35
sw t0, t1, 28
li t0, 11
sw t0, t1, 29
li t0, 49
sw t0, t1, 30
li t0, 51
sw t0, t1, 31
li t0, 57
sw t0, t1, 32
li t0, 18
sw t0, t1, 33
li t0, 10
sw t0, t1, 34
li t0, 62
sw t0, t1, 35
li t0, 39
sw t0, t1, 36
li t0, 34
sw t0, t1, 37
li t0, 40
sw t0, t1, 38
li t0, 4
sw t0, t1, 39
li t0, 9
sw t0, t1, 40
li t0, 41
sw t0, t1, 41
li t0, 59
sw t0, t1, 42
li t0, 28
sw t0, t1, 43
li t0, 25
sw t0, t1, 44
li t0, 1
sw t0, t1, 45
li t0, 31
sw t0, t1, 46
li t0, 17
sw t0, t1, 47
li t0, 60
sw t0, t1, 48
li t0, 47
sw t0, t1, 49
li t0, 46
sw t0, t1, 50
li t0, 26
sw t0, t1, 51
li t0, 27
sw t0, t1, 52
li t0, 63
sw t0, t1, 53
li t0, 38
sw t0, t1, 54
li t0, 36
sw t0, t1, 55
li t0, 14
sw t0, t1, 56
li t0, 2
sw t0, t1, 57
li t0, 23
sw t0, t1, 58
li t0, 55
sw t0, t1, 59
li t0, 21
sw t0, t1, 60
li t0, 32
sw t0, t1, 61
li t0, 22
sw t0, t1, 62
li t0, 50
sw t0, t1, 63
ret

bubble_sort: ; 配列をバブルソートする関数 引数: a1:要素数

li t1, 0 ; t1 <= int i, i = 0
addi a1, a1, -1 ; n = n - 1
bubble_sort_for_i:
bge t1, a1, setjump(bubble_sort_for_i_end, bubble_sort_for_i) ; while(i < n-1)

mv t2, a1 ; t2 <= int j, j = n - 1
addi t1, t1, 1 ; i = i + 1
bubble_sort_for_j:
blt t2, t1, setjump(bubble_sort_for_j_end, bubble_sort_for_j)
addi t2, t2, -1 ; j = j - 1
lw t3, t2, 0 ; t3 <= data[j-1]
addi t2, t2, 1  ; j = j + 1 (元に戻す)
lw t4, t2, 0 ; t4 <= data[j]
ble t3, t4, setjump(bubble_sort_swaped, bubble_sort_for_j + 5)
addi t2, t2, -1 ; j = j - 1
sw t4, t2, 0 ; data[j-1] <= data[j]
addi t2, t2, 1  ; j = j + 1 (元に戻す)
sw t3, t2, 0 ; data[j] <= data[j-1]
bubble_sort_swaped:
addi t2, t2, -1 ; j--
j setjump(bubble_sort_for_j, bubble_sort_swaped + 1)
bubble_sort_for_j_end:

j setjump(bubble_sort_for_i, bubble_sort_for_j_end)
bubble_sort_for_i_end:

ret

main:
call setjump(random64, main)
li a1, 64
call setjump(bubble_sort, main+2)
li a1, 0
j setjump(main, main+4)