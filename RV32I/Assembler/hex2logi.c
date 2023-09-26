#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define HALFBYTE 8 // 24bit長の場合は、24÷4=6
#define MAX_LEN 100000

int main(int argc, char* argv[]) {
    if (argc != 3) {
        printf(".\\hex2logi <変換するファイル> <変換後のファイル>\nの形式で入力してね。\n");
        return 1;
    }

    char line[MAX_LEN];
    FILE* fp;

    if (fopen_s(&fp, argv[1], "r")) {
        printf("ファイル開けんかった\n");
        return 1;
    }
    fgets(line, sizeof(line), fp);

    int len = strlen(line) / HALFBYTE;
    printf("%d\n", len);
    char** all = malloc(sizeof(char*) * len);
    for (int i = 0; i < len; i++) {
        *(all + i) = malloc(sizeof(char) * (HALFBYTE + 1));
        all[i][HALFBYTE] = '\0';
    }
    int k = 0;
    for (int i = 0; i < len; i++) {
        for (int j = 0; j < HALFBYTE; j++) {
            all[i][j] = line[k];
            k++;
        }
    }
    fclose(fp);

    if (fopen_s(&fp, argv[2], "w")) {
        printf("ファイル開けんかった\n");
        return 1;
    }
    fprintf(fp, "v2.0 raw\n");
    for (int i = 0; i < len; i++) {
        fprintf(fp, "%s\n", *(all + i));
    }
    fclose(fp);
    free(all);

    printf("hex2logi conversion succeeded.\n");

    return 0;
}