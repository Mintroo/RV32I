#!/bin/bash
assert() {
  input="$1"
  result="$2"

  ./RVcc "$input" > tmp.asm
  customasm -f hexstr tmp.asm -o test.hex
	./hex2logi test.hex out.hex
  echo "$input => ($result) doudesuka?"
}

assert 5+20-4 21
read var
assert 18-10+4 12
read var
assert 30+12-20 22
read var

echo OK