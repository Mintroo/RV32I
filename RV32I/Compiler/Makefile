.PHONY: tmp
tmp:
	.\RVcc 123 > tmp.asm
	customasm -f hexstr tmp.asm -o test.hex
	.\hex2logi test.hex out.hex

.PHONY: RVcc
RVcc:
	gcc RVcc.c -o RVcc