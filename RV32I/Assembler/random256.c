#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define numSelections 256

int main() {
    int selections[numSelections];
    int pool[256]; // プールとして利用する0から255までの数字

    // プールの初期化
    for (int i = 0; i < 256; i++) {
        pool[i] = i;
    }

    // 乱数の初期化
    srand((unsigned int)time(NULL) + (unsigned int)clock());

    // 数字の選択
    for (int i = 0; i < numSelections; i++) {
        int randomIndex = rand() % (256 - i); // 残りの数字の中からランダムに選ぶ
        selections[i] = pool[randomIndex];
        pool[randomIndex] = pool[256 - i - 1]; // 選ばれた数字をプールから削除
    }

    // 選ばれた数字の表示
    FILE* fp;
    if (fopen_s(&fp, "random256.asm", "w")) {
        printf("failed to open file.");
        return 1;
    }
    fprintf(fp, "random256: ; void random256()[t5-6]\n");
    fprintf(fp, "li t6, 0\n");
    for (int i = 0; i < numSelections; i++) {
        fprintf(fp, "li t5, %d\n", selections[i]);
        fprintf(fp, "sw t5, t6, %d\n", i);
    }
    fprintf(fp, "\nret\n");

    fclose(fp);

    return 0;
}