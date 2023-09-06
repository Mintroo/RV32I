#bankdef mybank {
  #bits 32
  #outp 0
}

#subruledef reg {
  zero => 0
  ra => 1
  sp => 2
  gp => 3
  tp => 4
  t0 => 5
  t1 => 6
  t2 => 7
  s0 => 8
  fp => 8
  s1 => 9
  a0 => 10
  a1 => 11
  a2 => 12
  a3 => 13
  a4 => 14
  a5 => 15
  a6 => 16
  a7 => 17
  s2 => 18
  s3 => 19
  s4 => 20
  s5 => 21
  s6 => 22
  s7 => 23
  s8 => 24
  s9 => 25
  s10 => 26
  s11 => 27
  t3 => 28
  t4 => 29
  t5 => 30
  t6 => 31
}

#subruledef freg {
  fr0 => 0
  fr1 => 1
  fr2 => 2
  fr3 => 3
  fr4 => 4
  fr5 => 5
  fr6 => 6
  fr7 => 7
  fr8 => 8
  fr9 => 9
  fr10 => 10
  fr11 => 11
  fr12 => 12
  fr13 => 13
  fr14 => 14
  fr15 => 15
  fr16 => 16
  fr17 => 17
  fr18 => 18
  fr19 => 19
  fr20 => 20
  fr21 => 21
  fr22 => 22
  fr23 => 23
  fr24 => 24
  fr25 => 25
  fr26 => 26
  fr27 => 27
  fr28 => 28
  fr29 => 29
  fr30 => 30
  fr31 => 31
}

#ruledef {
  lb {rd:reg}, {addr:reg}, {offset}  => offset`12 @ addr`5 @ 0`3 @ rd`5 @ 3`7
  lh {rd:reg}, {addr:reg}, {offset}  => offset`12 @ addr`5 @ 1`3 @ rd`5 @ 3`7
  lw {rd:reg}, {addr:reg}, {offset}  => offset`12 @ addr`5 @ 2`3 @ rd`5 @ 3`7
  lbu {rd:reg}, {addr:reg}, {offset} => offset`12 @ addr`5 @ 4`3 @ rd`5 @ 3`7
  lhu {rd:reg}, {addr:reg}, {offset} => offset`12 @ addr`5 @ 5`3 @ rd`5 @ 3`7

  addi {rd:reg}, {rs1:reg}, {imm}  => imm`12        @ rs1`5 @ 0`3 @ rd`5 @ 19`7
  slli {rd:reg}, {rs1:reg}, {uimm} => 0`7 @ uimm`5  @ rs1`5 @ 1`3 @ rd`5 @ 19`7
  slti {rd:reg}, {rs1:reg}, {imm}  => imm`12        @ rs1`5 @ 2`3 @ rd`5 @ 19`7
  sltiu {rd:reg}, {rs1:reg}, {imm} => imm`12        @ rs1`5 @ 3`3 @ rd`5 @ 19`7
  xori {rd:reg}, {rs1:reg}, {imm}  => imm`12        @ rs1`5 @ 4`3 @ rd`5 @ 19`7
  srli {rd:reg}, {rs1:reg}, {uimm} => 0`7  @ uimm`5 @ rs1`5 @ 5`3 @ rd`5 @ 19`7
  srai {rd:reg}, {rs1:reg}, {uimm} => 64`7 @ uimm`5 @ rs1`5 @ 5`3 @ rd`5 @ 19`7
  ori {rd:reg}, {rs1:reg}, {imm}   => imm`12        @ rs1`5 @ 6`3 @ rd`5 @ 19`7
  andi {rd:reg}, {rs1:reg}, {imm}  => imm`12        @ rs1`5 @ 7`3 @ rd`5 @ 19`7

  addui {rd:reg}, {rs1:reg}, {imm}  => imm`12       @ rs1`5 @ 0`3 @ rd`5 @ 20`7

  sb {rs2:reg}, {addr:reg}, {offset} => 0`7 @ rs2`5 @ addr`5 @ 0`3 @ offset`5 @ 35`7
  sh {rs2:reg}, {addr:reg}, {offset} => 0`7 @ rs2`5 @ addr`5 @ 1`3 @ offset`5 @ 35`7
  sw {rs2:reg}, {addr:reg}, {offset} => 0`7 @ rs2`5 @ addr`5 @ 2`3 @ offset`5 @ 35`7

  add {rd:reg}, {rs1:reg}, {rs2:reg}  => 0`7  @ rs2`5 @ rs1`5 @ 0`3 @ rd`5 @ 51`7
  sub {rd:reg}, {rs1:reg}, {rs2:reg}  => 64`7 @ rs2`5 @ rs1`5 @ 0`3 @ rd`5 @ 51`7
  sll {rd:reg}, {rs1:reg}, {rs2:reg}  => 0`7  @ rs2`5 @ rs1`5 @ 1`3 @ rd`5 @ 51`7
  slt {rd:reg}, {rs1:reg}, {rs2:reg}  => 0`7  @ rs2`5 @ rs1`5 @ 2`3 @ rd`5 @ 51`7
  sltu {rd:reg}, {rs1:reg}, {rs2:reg} => 0`7  @ rs2`5 @ rs1`5 @ 3`3 @ rd`5 @ 51`7
  xor {rd:reg}, {rs1:reg}, {rs2:reg}  => 0`7  @ rs2`5 @ rs1`5 @ 4`3 @ rd`5 @ 51`7
  srl {rd:reg}, {rs1:reg}, {rs2:reg}  => 0`7  @ rs2`5 @ rs1`5 @ 5`3 @ rd`5 @ 51`7
  sra {rd:reg}, {rs1:reg}, {rs2:reg}  => 64`7 @ rs2`5 @ rs1`5 @ 5`3 @ rd`5 @ 51`7
  or {rd:reg}, {rs1:reg}, {rs2:reg}   => 0`7  @ rs2`5 @ rs1`5 @ 6`3 @ rd`5 @ 51`7
  and {rd:reg}, {rs1:reg}, {rs2:reg}  => 0`7  @ rs2`5 @ rs1`5 @ 7`3 @ rd`5 @ 51`7

  mul {rd:reg}, {rs1:reg}, {rs2:reg}     => 1`7 @ rs2`5 @ rs1`5 @ 0`3 @ rd`5 @ 51`7
  mulh {rd:reg}, {rs1:reg}, {rs2:reg}    => 1`7 @ rs2`5 @ rs1`5 @ 1`3 @ rd`5 @ 51`7
  mulhsu {rd:reg}, {rs1:reg}, {rs2:reg}  => 1`7 @ rs2`5 @ rs1`5 @ 2`3 @ rd`5 @ 51`7
  mulhu {rd:reg}, {rs1:reg}, {rs2:reg}   => 1`7 @ rs2`5 @ rs1`5 @ 3`3 @ rd`5 @ 51`7
  div {rd:reg}, {rs1:reg}, {rs2:reg}     => 1`7 @ rs2`5 @ rs1`5 @ 4`3 @ rd`5 @ 51`7
  divu {rd:reg}, {rs1:reg}, {rs2:reg}    => 1`7 @ rs2`5 @ rs1`5 @ 5`3 @ rd`5 @ 51`7
  rem {rd:reg}, {rs1:reg}, {rs2:reg}     => 1`7 @ rs2`5 @ rs1`5 @ 6`3 @ rd`5 @ 51`7
  remu {rd:reg}, {rs1:reg}, {rs2:reg}    => 1`7 @ rs2`5 @ rs1`5 @ 7`3 @ rd`5 @ 51`7

  beq {rs1:reg}, {rs2:reg}, {label}  => label[11:5] @ rs2`5 @ rs1`5 @ 0`3 @ label[4:0] @ 99`7
  bne {rs1:reg}, {rs2:reg}, {label}  => label[11:5] @ rs2`5 @ rs1`5 @ 1`3 @ label[4:0] @ 99`7
  blt {rs1:reg}, {rs2:reg}, {label}  => label[11:5] @ rs2`5 @ rs1`5 @ 4`3 @ label[4:0] @ 99`7
  bge {rs1:reg}, {rs2:reg}, {label}  => label[11:5] @ rs2`5 @ rs1`5 @ 5`3 @ label[4:0] @ 99`7
  bltu {rs1:reg}, {rs2:reg}, {label} => label[11:5] @ rs2`5 @ rs1`5 @ 6`3 @ label[4:0] @ 99`7
  bgeu {rs1:reg}, {rs2:reg}, {label} => label[11:5] @ rs2`5 @ rs1`5 @ 7`3 @ label[4:0] @ 99`7

  jalr {rd:reg}, {rs1:reg}, {offset} => offset`12 @ rs1`5 @ 0`3 @ rd`5 @ 103`7

  jal {rd:reg}, {label} => label`20 @ rd`5 @ 111`7

  lui {rd:reg}, {upimm} => upimm`20 @ rd`5 @ 55`7

  auipc {rd:reg}, {upimm} => upimm`20 @ rd`5 @ 23`7

  ; 単精度浮動小数命令
  fadd {fd:freg}, {fs1:freg}, {fs2:freg} => 0`7 @ fs2`5 @ fs1`5 @ 0`3 @ fd`5 @ 83`7
  fsub {fd:freg}, {fs1:freg}, {fs2:freg} => 0`7 @ fs2`5 @ fs1`5 @ 1`3 @ fd`5 @ 83`7
  fmul {fd:freg}, {fs1:freg}, {fs2:freg} => 0`7 @ fs2`5 @ fs1`5 @ 2`3 @ fd`5 @ 83`7
  fdiv {fd:freg}, {fs1:freg}, {fs2:freg} => 0`7 @ fs2`5 @ fs1`5 @ 3`3 @ fd`5 @ 83`7
  fmin {fd:freg}, {fs1:freg}, {fs2:freg} => 0`7 @ fs2`5 @ fs1`5 @ 4`3 @ fd`5 @ 83`7
  fmax {fd:freg}, {fs1:freg}, {fs2:freg} => 0`7 @ fs2`5 @ fs1`5 @ 5`3 @ fd`5 @ 83`7

  feq {rd:reg}, {fs1:freg}, {fs2:freg} => 0`7 @ fs2`5 @ fs1`5 @ 0`3 @ rd`5 @ 84`7
  flt {rd:reg}, {fs1:freg}, {fs2:freg} => 0`7 @ fs2`5 @ fs1`5 @ 1`3 @ rd`5 @ 84`7
  fle {rd:reg}, {fs1:freg}, {fs2:freg} => 0`7 @ fs2`5 @ fs1`5 @ 2`3 @ rd`5 @ 84`7

  flw {fd:freg}, {addr:reg}, {offset}  => offset`12 @ addr`5 @ 2`3    @ fd`5 @ 7`7
  fsw {fs2:freg}, {addr:reg}, {offset} => 0`7       @ fs2`5  @ addr`5 @ 2`3  @ offset`5 @ 39`7

  fcvt.w.s  {rd:reg}, {fs1:freg} => 0`7 @ 0`5 @ fs1`5 @ 0`3 @ rd`5 @ 85`7
  fcvt.wu.s {rd:reg}, {fs1:freg} => 0`7 @ 0`5 @ fs1`5 @ 1`3 @ rd`5 @ 85`7
  fmv.x.w   {rd:reg}, {fs1:freg} => 0`7 @ 0`5 @ fs1`5 @ 2`3 @ rd`5 @ 85`7

  fcvt.s.w  {fd:freg}, {rs1:reg} => 0`7 @ 0`5 @ rs1`5 @ 0`3 @ fd`5 @ 86`7
  fcvt.s.wu {fd:freg}, {rs1:reg} => 0`7 @ 0`5 @ rs1`5 @ 1`3 @ fd`5 @ 86`7
  fmv.w.x   {fd:freg}, {rs1:reg} => 0`7 @ 0`5 @ rs1`5 @ 2`3 @ fd`5 @ 86`7


  ; 疑似命令
  nop => asm { addi 0, 0, 0 }

  li {rd:reg}, {imm} => asm { addi {rd}, zero, {imm} }
  li32 {rd:reg}, {imm} => asm {
                              lui {rd}, {imm}[31:12]
                              addui {rd}, {rd}, {imm}[11:0]
                              }

  mv {rd:reg}, {rs1:reg}   => asm { addi {rd}, {rs1}, 0 }
  not {rd:reg}, {rs1:reg}  => asm { xori {rd}, {rs1}, -1 }
  neg {rd:reg}, {rs1:reg}  => asm { sub {rd}, 0, {rs1} }
  seqz {rd:reg}, {rs1:reg} => asm { sltiu {rd}, {rs1}, 1 }
  snez {rd:reg}, {rs1:reg} => asm { sltu {rd}, zero, {rs1} }
  sltz {rd:reg}, {rs1:reg} => asm { slt {rd}, {rs1}, zero }
  sgtz {rd:reg}, {rs1:reg} => asm { slt {rd}, zero, {rs1} }

  beqz {rs1:reg}, {label} => asm { beq {rs1}, zero, {label} }
  bnez {rs1:reg}, {label} => asm { bne {rs1}, zero, {label} }
  blez {rs1:reg}, {label} => asm { bge zero, {rs1}, {label} }
  bgez {rs1:reg}, {label} => asm { bge {rs1}, zero, {label} }
  bltz {rs1:reg}, {label} => asm { blt {rs1}, zero, {label} }
  bgtz {rs1:reg}, {label} => asm { blt zero, {rs1}, {label} }

  ble {rs1:reg}, {rs2:reg}, {label}  => asm { bge {rs2}, {rs1}, {label} }
  bgt {rs1:reg}, {rs2:reg}, {label}  => asm { blt {rs2}, {rs1}, {label} }
  bleu {rs1:reg}, {rs2:reg}, {label} => asm { bgeu {rs2}, {rs1}, {label} }
  bgtu {rs1:reg}, {rs2:reg}, {label} => asm { bltu {rs2}, {rs1}, {label} }

  j {label}      => asm { jal zero, {label} }
  jal {label}    => asm { jal ra, {label} }
  jr {rs1:reg}   => asm { jalr zero, {rs1}, 0 }
  jalr {rs1:reg} => asm { jalr ra, {rs1}, 0 }
  ret            => asm { jalr zero, ra, 0 }
  call {label}   => asm { jal ra, {label} }
  call32 {label} => asm {
                          auipc ra, {label}[31:12]
                          jalr ra, ra, label[11:0]
  }
  ; 浮動小数点命令
  fgt {rd:reg}, {fs1:freg}, {fs2:freg} => asm { flt {rd}, {fs2}, {fs1} }
  fge {rd:reg}, {fs1:freg}, {fs2:freg} => asm { fle {rd}, {fs2}, {fs1} }
}

#fn setjump(jumpdestination, current) => jumpdestination - current