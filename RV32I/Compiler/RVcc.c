#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  if (argc != 2) {
    fprintf(stderr, "�����̌�������������܂���\n");
    return 1;
  }

  char *p = argv[1];

  printf("#include \"RV32I.asm\"\n");
  printf("globl_main:\n");
  printf(".main:\n");
  printf("  li t0, %ld\n", strtol(p, &p, 10));

  while (*p) {
    if (*p == '+') {
      p++;
      printf("  addi t0, t0, %ld\n", strtol(p, &p, 10));
      continue;
    }

    if (*p == '-') {
      p++;
      printf("  addi t0, t0, -%ld\n", strtol(p, &p, 10));
      continue;
    }

    fprintf(stderr, "�\�����Ȃ������ł�: '%c'\n", *p);
    return 1;
  }
  
  return 0;
}