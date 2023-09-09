#!/bin/bash
assert() {
  input="$1"
  result="$2"

  ./RVcc "$input" > tmp.asm
  customasm -f hexstr tmp.asm -o test.hex
	./hex2logi test.hex out.hex
  echo "$input => ($result) doudesuka?"
}

assert " -+21-21+23-- " ?
read var
assert " 23 - 10 + 2-1" 14
read var
assert " 12 + 1-12+2 " 3

echo OK