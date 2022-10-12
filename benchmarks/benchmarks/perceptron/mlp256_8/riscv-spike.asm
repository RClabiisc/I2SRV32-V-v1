
riscv-spike.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <boot>:
   0:	00002fb7          	lui	t6,0x2
   4:	800f8f93          	addi	t6,t6,-2048 # 1800 <__stack_init+0xa38>
   8:	300f9073          	csrw	mstatus,t6
   c:	0340006f          	j	40 <_mstart>
  10:	00000013          	nop
  14:	00000013          	nop
  18:	00000013          	nop
  1c:	00000013          	nop
  20:	00000013          	nop
  24:	00000013          	nop
  28:	00000013          	nop
  2c:	00000013          	nop
  30:	00000013          	nop
  34:	00000013          	nop
  38:	00000013          	nop
  3c:	00000013          	nop

00000040 <_mstart>:
  40:	00000297          	auipc	t0,0x0
  44:	0b428293          	addi	t0,t0,180 # f4 <trap_entry>
  48:	30529073          	csrw	mtvec,t0
  4c:	00000093          	li	ra,0
  50:	00000113          	li	sp,0
  54:	00000193          	li	gp,0
  58:	00000213          	li	tp,0
  5c:	00000293          	li	t0,0
  60:	00000313          	li	t1,0
  64:	00000393          	li	t2,0
  68:	00000413          	li	s0,0
  6c:	00000493          	li	s1,0
  70:	00000513          	li	a0,0
  74:	00000593          	li	a1,0
  78:	00000613          	li	a2,0
  7c:	00000693          	li	a3,0
  80:	00000713          	li	a4,0
  84:	00000793          	li	a5,0
  88:	00000813          	li	a6,0
  8c:	00000893          	li	a7,0
  90:	00000913          	li	s2,0
  94:	00000993          	li	s3,0
  98:	00000a13          	li	s4,0
  9c:	00000a93          	li	s5,0
  a0:	00000b13          	li	s6,0
  a4:	00000b93          	li	s7,0
  a8:	00000c13          	li	s8,0
  ac:	00000c93          	li	s9,0
  b0:	00000d13          	li	s10,0
  b4:	00000d93          	li	s11,0
  b8:	00000e13          	li	t3,0
  bc:	00000e93          	li	t4,0
  c0:	00000f13          	li	t5,0
  c4:	00000f93          	li	t6,0
  c8:	00020197          	auipc	gp,0x20
  cc:	73818193          	addi	gp,gp,1848 # 20800 <__global_pointer$>
  d0:	000ff117          	auipc	sp,0xff
  d4:	f2c10113          	addi	sp,sp,-212 # feffc <__stacktop>
  d8:	00000297          	auipc	t0,0x0
  dc:	01c28293          	addi	t0,t0,28 # f4 <trap_entry>
  e0:	00012503          	lw	a0,0(sp)
  e4:	00000613          	li	a2,0
  e8:	44d000ef          	jal	ra,d34 <main>
  ec:	0000006f          	j	ec <_mstart+0xac>
  f0:	00008067          	ret

000000f4 <trap_entry>:
  f4:	2090006f          	j	afc <ISR5>
  f8:	30200073          	mret
  fc:	2010006f          	j	afc <ISR5>
 100:	30200073          	mret
 104:	1f90006f          	j	afc <ISR5>
 108:	30200073          	mret
 10c:	1f10006f          	j	afc <ISR5>
 110:	30200073          	mret
 114:	1e90006f          	j	afc <ISR5>
 118:	30200073          	mret
 11c:	2fd0006f          	j	c18 <ISR6>
 120:	30200073          	mret
	...

00000130 <UART_init>:
 130:	fd010113          	addi	sp,sp,-48
 134:	02812623          	sw	s0,44(sp)
 138:	03010413          	addi	s0,sp,48
 13c:	fca42e23          	sw	a0,-36(s0)
 140:	00058793          	mv	a5,a1
 144:	fcf40da3          	sb	a5,-37(s0)
 148:	fdc42703          	lw	a4,-36(s0)
 14c:	000097b7          	lui	a5,0x9
 150:	60078793          	addi	a5,a5,1536 # 9600 <__stack_init+0x8838>
 154:	00f71a63          	bne	a4,a5,168 <UART_init+0x38>
 158:	fe0407a3          	sb	zero,-17(s0)
 15c:	fa200793          	li	a5,-94
 160:	fef40723          	sb	a5,-18(s0)
 164:	1180006f          	j	27c <UART_init+0x14c>
 168:	fdc42703          	lw	a4,-36(s0)
 16c:	000027b7          	lui	a5,0x2
 170:	58078793          	addi	a5,a5,1408 # 2580 <__stack_init+0x17b8>
 174:	00f71c63          	bne	a4,a5,18c <UART_init+0x5c>
 178:	00200793          	li	a5,2
 17c:	fef407a3          	sb	a5,-17(s0)
 180:	f8b00793          	li	a5,-117
 184:	fef40723          	sb	a5,-18(s0)
 188:	0f40006f          	j	27c <UART_init+0x14c>
 18c:	fdc42703          	lw	a4,-36(s0)
 190:	000057b7          	lui	a5,0x5
 194:	b0078793          	addi	a5,a5,-1280 # 4b00 <__stack_init+0x3d38>
 198:	00f71c63          	bne	a4,a5,1b0 <UART_init+0x80>
 19c:	00100793          	li	a5,1
 1a0:	fef407a3          	sb	a5,-17(s0)
 1a4:	04500793          	li	a5,69
 1a8:	fef40723          	sb	a5,-18(s0)
 1ac:	0d00006f          	j	27c <UART_init+0x14c>
 1b0:	fdc42703          	lw	a4,-36(s0)
 1b4:	0000e7b7          	lui	a5,0xe
 1b8:	10078793          	addi	a5,a5,256 # e100 <__stack_init+0xd338>
 1bc:	00f71a63          	bne	a4,a5,1d0 <UART_init+0xa0>
 1c0:	fe0407a3          	sb	zero,-17(s0)
 1c4:	03600793          	li	a5,54
 1c8:	fef40723          	sb	a5,-18(s0)
 1cc:	0b00006f          	j	27c <UART_init+0x14c>
 1d0:	fdc42703          	lw	a4,-36(s0)
 1d4:	0001c7b7          	lui	a5,0x1c
 1d8:	20078793          	addi	a5,a5,512 # 1c200 <__stack_init+0x1b438>
 1dc:	00f71a63          	bne	a4,a5,1f0 <UART_init+0xc0>
 1e0:	fe0407a3          	sb	zero,-17(s0)
 1e4:	01b00793          	li	a5,27
 1e8:	fef40723          	sb	a5,-18(s0)
 1ec:	0900006f          	j	27c <UART_init+0x14c>
 1f0:	fdc42703          	lw	a4,-36(s0)
 1f4:	000387b7          	lui	a5,0x38
 1f8:	40078793          	addi	a5,a5,1024 # 38400 <__global_pointer$+0x17c00>
 1fc:	00f71a63          	bne	a4,a5,210 <UART_init+0xe0>
 200:	fe0407a3          	sb	zero,-17(s0)
 204:	00e00793          	li	a5,14
 208:	fef40723          	sb	a5,-18(s0)
 20c:	0700006f          	j	27c <UART_init+0x14c>
 210:	fdc42703          	lw	a4,-36(s0)
 214:	000717b7          	lui	a5,0x71
 218:	80078793          	addi	a5,a5,-2048 # 70800 <__global_pointer$+0x50000>
 21c:	00f71a63          	bne	a4,a5,230 <UART_init+0x100>
 220:	fe0407a3          	sb	zero,-17(s0)
 224:	00700793          	li	a5,7
 228:	fef40723          	sb	a5,-18(s0)
 22c:	0500006f          	j	27c <UART_init+0x14c>
 230:	fdc42703          	lw	a4,-36(s0)
 234:	0017d7b7          	lui	a5,0x17d
 238:	78478793          	addi	a5,a5,1924 # 17d784 <__VMEM_END+0x792c4>
 23c:	00f71a63          	bne	a4,a5,250 <UART_init+0x120>
 240:	fe0407a3          	sb	zero,-17(s0)
 244:	00400793          	li	a5,4
 248:	fef40723          	sb	a5,-18(s0)
 24c:	0300006f          	j	27c <UART_init+0x14c>
 250:	fdc42703          	lw	a4,-36(s0)
 254:	000bf7b7          	lui	a5,0xbf
 258:	bc278793          	addi	a5,a5,-1086 # bebc2 <__global_pointer$+0x9e3c2>
 25c:	00f71a63          	bne	a4,a5,270 <UART_init+0x140>
 260:	fe0407a3          	sb	zero,-17(s0)
 264:	00800793          	li	a5,8
 268:	fef40723          	sb	a5,-18(s0)
 26c:	0100006f          	j	27c <UART_init+0x14c>
 270:	fe0407a3          	sb	zero,-17(s0)
 274:	00100793          	li	a5,1
 278:	fef40723          	sb	a5,-18(s0)
 27c:	fdb44703          	lbu	a4,-37(s0)
 280:	00100793          	li	a5,1
 284:	00f71663          	bne	a4,a5,290 <UART_init+0x160>
 288:	fe0406a3          	sb	zero,-19(s0)
 28c:	03c0006f          	j	2c8 <UART_init+0x198>
 290:	fdb44703          	lbu	a4,-37(s0)
 294:	00400793          	li	a5,4
 298:	00f71863          	bne	a4,a5,2a8 <UART_init+0x178>
 29c:	04000793          	li	a5,64
 2a0:	fef406a3          	sb	a5,-19(s0)
 2a4:	0240006f          	j	2c8 <UART_init+0x198>
 2a8:	fdb44703          	lbu	a4,-37(s0)
 2ac:	00800793          	li	a5,8
 2b0:	00f71863          	bne	a4,a5,2c0 <UART_init+0x190>
 2b4:	f8000793          	li	a5,-128
 2b8:	fef406a3          	sb	a5,-19(s0)
 2bc:	00c0006f          	j	2c8 <UART_init+0x198>
 2c0:	fc000793          	li	a5,-64
 2c4:	fef406a3          	sb	a5,-19(s0)
 2c8:	5f1007b7          	lui	a5,0x5f100
 2cc:	6f478793          	addi	a5,a5,1780 # 5f1006f4 <__VREG_END+0x5ef806f4>
 2d0:	01300713          	li	a4,19
 2d4:	00e78023          	sb	a4,0(a5)
 2d8:	5f1007b7          	lui	a5,0x5f100
 2dc:	6f378793          	addi	a5,a5,1779 # 5f1006f3 <__VREG_END+0x5ef806f3>
 2e0:	04000713          	li	a4,64
 2e4:	00e78023          	sb	a4,0(a5)
 2e8:	5f1007b7          	lui	a5,0x5f100
 2ec:	6f178793          	addi	a5,a5,1777 # 5f1006f1 <__VREG_END+0x5ef806f1>
 2f0:	00100713          	li	a4,1
 2f4:	00e78023          	sb	a4,0(a5)
 2f8:	5f1007b7          	lui	a5,0x5f100
 2fc:	6f478793          	addi	a5,a5,1780 # 5f1006f4 <__VREG_END+0x5ef806f4>
 300:	f9300713          	li	a4,-109
 304:	00e78023          	sb	a4,0(a5)
 308:	5f1007b7          	lui	a5,0x5f100
 30c:	6f178793          	addi	a5,a5,1777 # 5f1006f1 <__VREG_END+0x5ef806f1>
 310:	fef44703          	lbu	a4,-17(s0)
 314:	00e78023          	sb	a4,0(a5)
 318:	5f1007b7          	lui	a5,0x5f100
 31c:	6f078793          	addi	a5,a5,1776 # 5f1006f0 <__VREG_END+0x5ef806f0>
 320:	fee44703          	lbu	a4,-18(s0)
 324:	00e78023          	sb	a4,0(a5)
 328:	5f1007b7          	lui	a5,0x5f100
 32c:	6f478793          	addi	a5,a5,1780 # 5f1006f4 <__VREG_END+0x5ef806f4>
 330:	01300713          	li	a4,19
 334:	00e78023          	sb	a4,0(a5)
 338:	5f1007b7          	lui	a5,0x5f100
 33c:	6f378793          	addi	a5,a5,1779 # 5f1006f3 <__VREG_END+0x5ef806f3>
 340:	fed44703          	lbu	a4,-19(s0)
 344:	00e78023          	sb	a4,0(a5)
 348:	00000013          	nop
 34c:	02c12403          	lw	s0,44(sp)
 350:	03010113          	addi	sp,sp,48
 354:	00008067          	ret

00000358 <UARTCharPut>:
 358:	fe010113          	addi	sp,sp,-32
 35c:	00812e23          	sw	s0,28(sp)
 360:	02010413          	addi	s0,sp,32
 364:	00050793          	mv	a5,a0
 368:	fef407a3          	sb	a5,-17(s0)
 36c:	00000013          	nop
 370:	5f1007b7          	lui	a5,0x5f100
 374:	6f678793          	addi	a5,a5,1782 # 5f1006f6 <__VREG_END+0x5ef806f6>
 378:	0007c783          	lbu	a5,0(a5)
 37c:	0ff7f793          	andi	a5,a5,255
 380:	0207f793          	andi	a5,a5,32
 384:	0ff7f793          	andi	a5,a5,255
 388:	fe0784e3          	beqz	a5,370 <UARTCharPut+0x18>
 38c:	5f1007b7          	lui	a5,0x5f100
 390:	6f078793          	addi	a5,a5,1776 # 5f1006f0 <__VREG_END+0x5ef806f0>
 394:	fef44703          	lbu	a4,-17(s0)
 398:	00e78023          	sb	a4,0(a5)
 39c:	00000013          	nop
 3a0:	01c12403          	lw	s0,28(sp)
 3a4:	02010113          	addi	sp,sp,32
 3a8:	00008067          	ret

000003ac <UART_string>:
 3ac:	fe010113          	addi	sp,sp,-32
 3b0:	00112e23          	sw	ra,28(sp)
 3b4:	00812c23          	sw	s0,24(sp)
 3b8:	02010413          	addi	s0,sp,32
 3bc:	fea42623          	sw	a0,-20(s0)
 3c0:	01c0006f          	j	3dc <UART_string+0x30>
 3c4:	fec42783          	lw	a5,-20(s0)
 3c8:	00178713          	addi	a4,a5,1
 3cc:	fee42623          	sw	a4,-20(s0)
 3d0:	0007c783          	lbu	a5,0(a5)
 3d4:	00078513          	mv	a0,a5
 3d8:	f81ff0ef          	jal	ra,358 <UARTCharPut>
 3dc:	fec42783          	lw	a5,-20(s0)
 3e0:	0007c783          	lbu	a5,0(a5)
 3e4:	fe0790e3          	bnez	a5,3c4 <UART_string+0x18>
 3e8:	00000013          	nop
 3ec:	00000013          	nop
 3f0:	01c12083          	lw	ra,28(sp)
 3f4:	01812403          	lw	s0,24(sp)
 3f8:	02010113          	addi	sp,sp,32
 3fc:	00008067          	ret

00000400 <UART_newline>:
 400:	ff010113          	addi	sp,sp,-16
 404:	00112623          	sw	ra,12(sp)
 408:	00812423          	sw	s0,8(sp)
 40c:	01010413          	addi	s0,sp,16
 410:	00a00513          	li	a0,10
 414:	f45ff0ef          	jal	ra,358 <UARTCharPut>
 418:	00d00513          	li	a0,13
 41c:	f3dff0ef          	jal	ra,358 <UARTCharPut>
 420:	00000013          	nop
 424:	00c12083          	lw	ra,12(sp)
 428:	00812403          	lw	s0,8(sp)
 42c:	01010113          	addi	sp,sp,16
 430:	00008067          	ret

00000434 <UART_Htab>:
 434:	ff010113          	addi	sp,sp,-16
 438:	00112623          	sw	ra,12(sp)
 43c:	00812423          	sw	s0,8(sp)
 440:	01010413          	addi	s0,sp,16
 444:	00900513          	li	a0,9
 448:	f11ff0ef          	jal	ra,358 <UARTCharPut>
 44c:	00000013          	nop
 450:	00c12083          	lw	ra,12(sp)
 454:	00812403          	lw	s0,8(sp)
 458:	01010113          	addi	sp,sp,16
 45c:	00008067          	ret

00000460 <UARTwrite>:
 460:	fd010113          	addi	sp,sp,-48
 464:	02112623          	sw	ra,44(sp)
 468:	02812423          	sw	s0,40(sp)
 46c:	03010413          	addi	s0,sp,48
 470:	fca42e23          	sw	a0,-36(s0)
 474:	fcb42c23          	sw	a1,-40(s0)
 478:	fe042623          	sw	zero,-20(s0)
 47c:	0480006f          	j	4c4 <UARTwrite+0x64>
 480:	fdc42703          	lw	a4,-36(s0)
 484:	fec42783          	lw	a5,-20(s0)
 488:	00f707b3          	add	a5,a4,a5
 48c:	0007c703          	lbu	a4,0(a5)
 490:	00a00793          	li	a5,10
 494:	00f71663          	bne	a4,a5,4a0 <UARTwrite+0x40>
 498:	00d00513          	li	a0,13
 49c:	ebdff0ef          	jal	ra,358 <UARTCharPut>
 4a0:	fdc42703          	lw	a4,-36(s0)
 4a4:	fec42783          	lw	a5,-20(s0)
 4a8:	00f707b3          	add	a5,a4,a5
 4ac:	0007c783          	lbu	a5,0(a5)
 4b0:	00078513          	mv	a0,a5
 4b4:	ea5ff0ef          	jal	ra,358 <UARTCharPut>
 4b8:	fec42783          	lw	a5,-20(s0)
 4bc:	00178793          	addi	a5,a5,1
 4c0:	fef42623          	sw	a5,-20(s0)
 4c4:	fec42703          	lw	a4,-20(s0)
 4c8:	fd842783          	lw	a5,-40(s0)
 4cc:	faf76ae3          	bltu	a4,a5,480 <UARTwrite+0x20>
 4d0:	fec42783          	lw	a5,-20(s0)
 4d4:	00078513          	mv	a0,a5
 4d8:	02c12083          	lw	ra,44(sp)
 4dc:	02812403          	lw	s0,40(sp)
 4e0:	03010113          	addi	sp,sp,48
 4e4:	00008067          	ret

000004e8 <UARTvprintf>:
 4e8:	fa010113          	addi	sp,sp,-96
 4ec:	04112e23          	sw	ra,92(sp)
 4f0:	04812c23          	sw	s0,88(sp)
 4f4:	06010413          	addi	s0,sp,96
 4f8:	faa42623          	sw	a0,-84(s0)
 4fc:	fab42423          	sw	a1,-88(s0)
 500:	4440006f          	j	944 <UARTvprintf+0x45c>
 504:	fe042623          	sw	zero,-20(s0)
 508:	0100006f          	j	518 <UARTvprintf+0x30>
 50c:	fec42783          	lw	a5,-20(s0)
 510:	00178793          	addi	a5,a5,1
 514:	fef42623          	sw	a5,-20(s0)
 518:	fac42703          	lw	a4,-84(s0)
 51c:	fec42783          	lw	a5,-20(s0)
 520:	00f707b3          	add	a5,a4,a5
 524:	0007c703          	lbu	a4,0(a5)
 528:	02500793          	li	a5,37
 52c:	00f70c63          	beq	a4,a5,544 <UARTvprintf+0x5c>
 530:	fac42703          	lw	a4,-84(s0)
 534:	fec42783          	lw	a5,-20(s0)
 538:	00f707b3          	add	a5,a4,a5
 53c:	0007c783          	lbu	a5,0(a5)
 540:	fc0796e3          	bnez	a5,50c <UARTvprintf+0x24>
 544:	fec42583          	lw	a1,-20(s0)
 548:	fac42503          	lw	a0,-84(s0)
 54c:	f15ff0ef          	jal	ra,460 <UARTwrite>
 550:	fac42703          	lw	a4,-84(s0)
 554:	fec42783          	lw	a5,-20(s0)
 558:	00f707b3          	add	a5,a4,a5
 55c:	faf42623          	sw	a5,-84(s0)
 560:	fac42783          	lw	a5,-84(s0)
 564:	0007c703          	lbu	a4,0(a5)
 568:	02500793          	li	a5,37
 56c:	3cf71a63          	bne	a4,a5,940 <UARTvprintf+0x458>
 570:	fac42783          	lw	a5,-84(s0)
 574:	00178793          	addi	a5,a5,1
 578:	faf42623          	sw	a5,-84(s0)
 57c:	fe042223          	sw	zero,-28(s0)
 580:	02000793          	li	a5,32
 584:	fcf40da3          	sb	a5,-37(s0)
 588:	fac42783          	lw	a5,-84(s0)
 58c:	00178713          	addi	a4,a5,1
 590:	fae42623          	sw	a4,-84(s0)
 594:	0007c783          	lbu	a5,0(a5)
 598:	fdb78793          	addi	a5,a5,-37
 59c:	05300713          	li	a4,83
 5a0:	38f76663          	bltu	a4,a5,92c <UARTvprintf+0x444>
 5a4:	00279713          	slli	a4,a5,0x2
 5a8:	000017b7          	lui	a5,0x1
 5ac:	dec78793          	addi	a5,a5,-532 # dec <__stack_init+0x24>
 5b0:	00f707b3          	add	a5,a4,a5
 5b4:	0007a783          	lw	a5,0(a5)
 5b8:	00078067          	jr	a5
 5bc:	fac42783          	lw	a5,-84(s0)
 5c0:	fff78793          	addi	a5,a5,-1
 5c4:	0007c703          	lbu	a4,0(a5)
 5c8:	03000793          	li	a5,48
 5cc:	00f71a63          	bne	a4,a5,5e0 <UARTvprintf+0xf8>
 5d0:	fe442783          	lw	a5,-28(s0)
 5d4:	00079663          	bnez	a5,5e0 <UARTvprintf+0xf8>
 5d8:	03000793          	li	a5,48
 5dc:	fcf40da3          	sb	a5,-37(s0)
 5e0:	fe442703          	lw	a4,-28(s0)
 5e4:	00070793          	mv	a5,a4
 5e8:	00279793          	slli	a5,a5,0x2
 5ec:	00e787b3          	add	a5,a5,a4
 5f0:	00179793          	slli	a5,a5,0x1
 5f4:	fef42223          	sw	a5,-28(s0)
 5f8:	fac42783          	lw	a5,-84(s0)
 5fc:	fff78793          	addi	a5,a5,-1
 600:	0007c783          	lbu	a5,0(a5)
 604:	00078713          	mv	a4,a5
 608:	fe442783          	lw	a5,-28(s0)
 60c:	00f707b3          	add	a5,a4,a5
 610:	fd078793          	addi	a5,a5,-48
 614:	fef42223          	sw	a5,-28(s0)
 618:	f71ff06f          	j	588 <UARTvprintf+0xa0>
 61c:	fa842783          	lw	a5,-88(s0)
 620:	00478713          	addi	a4,a5,4
 624:	fae42423          	sw	a4,-88(s0)
 628:	0007a783          	lw	a5,0(a5)
 62c:	fcf42223          	sw	a5,-60(s0)
 630:	fc440793          	addi	a5,s0,-60
 634:	00100593          	li	a1,1
 638:	00078513          	mv	a0,a5
 63c:	e25ff0ef          	jal	ra,460 <UARTwrite>
 640:	3040006f          	j	944 <UARTvprintf+0x45c>
 644:	fa842783          	lw	a5,-88(s0)
 648:	00478713          	addi	a4,a5,4
 64c:	fae42423          	sw	a4,-88(s0)
 650:	0007a783          	lw	a5,0(a5)
 654:	fcf42223          	sw	a5,-60(s0)
 658:	fe042423          	sw	zero,-24(s0)
 65c:	fc442783          	lw	a5,-60(s0)
 660:	0007de63          	bgez	a5,67c <UARTvprintf+0x194>
 664:	fc442783          	lw	a5,-60(s0)
 668:	40f007b3          	neg	a5,a5
 66c:	fcf42223          	sw	a5,-60(s0)
 670:	00100793          	li	a5,1
 674:	fcf42e23          	sw	a5,-36(s0)
 678:	0080006f          	j	680 <UARTvprintf+0x198>
 67c:	fc042e23          	sw	zero,-36(s0)
 680:	00a00793          	li	a5,10
 684:	fef42023          	sw	a5,-32(s0)
 688:	1040006f          	j	78c <UARTvprintf+0x2a4>
 68c:	fa842783          	lw	a5,-88(s0)
 690:	00778793          	addi	a5,a5,7
 694:	ff87f793          	andi	a5,a5,-8
 698:	00878713          	addi	a4,a5,8
 69c:	fae42423          	sw	a4,-88(s0)
 6a0:	0007a703          	lw	a4,0(a5)
 6a4:	0047a783          	lw	a5,4(a5)
 6a8:	fce42423          	sw	a4,-56(s0)
 6ac:	fcf42623          	sw	a5,-52(s0)
 6b0:	2940006f          	j	944 <UARTvprintf+0x45c>
 6b4:	fa842783          	lw	a5,-88(s0)
 6b8:	00478713          	addi	a4,a5,4
 6bc:	fae42423          	sw	a4,-88(s0)
 6c0:	0007a783          	lw	a5,0(a5)
 6c4:	fcf42a23          	sw	a5,-44(s0)
 6c8:	fe042623          	sw	zero,-20(s0)
 6cc:	0100006f          	j	6dc <UARTvprintf+0x1f4>
 6d0:	fec42783          	lw	a5,-20(s0)
 6d4:	00178793          	addi	a5,a5,1
 6d8:	fef42623          	sw	a5,-20(s0)
 6dc:	fd442703          	lw	a4,-44(s0)
 6e0:	fec42783          	lw	a5,-20(s0)
 6e4:	00f707b3          	add	a5,a4,a5
 6e8:	0007c783          	lbu	a5,0(a5)
 6ec:	fe0792e3          	bnez	a5,6d0 <UARTvprintf+0x1e8>
 6f0:	fec42583          	lw	a1,-20(s0)
 6f4:	fd442503          	lw	a0,-44(s0)
 6f8:	d69ff0ef          	jal	ra,460 <UARTwrite>
 6fc:	fe442703          	lw	a4,-28(s0)
 700:	fec42783          	lw	a5,-20(s0)
 704:	24e7f063          	bgeu	a5,a4,944 <UARTvprintf+0x45c>
 708:	fe442703          	lw	a4,-28(s0)
 70c:	fec42783          	lw	a5,-20(s0)
 710:	40f707b3          	sub	a5,a4,a5
 714:	fef42223          	sw	a5,-28(s0)
 718:	0140006f          	j	72c <UARTvprintf+0x244>
 71c:	00100593          	li	a1,1
 720:	000017b7          	lui	a5,0x1
 724:	de078513          	addi	a0,a5,-544 # de0 <__stack_init+0x18>
 728:	d39ff0ef          	jal	ra,460 <UARTwrite>
 72c:	fe442783          	lw	a5,-28(s0)
 730:	fff78713          	addi	a4,a5,-1
 734:	fee42223          	sw	a4,-28(s0)
 738:	fe0792e3          	bnez	a5,71c <UARTvprintf+0x234>
 73c:	2080006f          	j	944 <UARTvprintf+0x45c>
 740:	fa842783          	lw	a5,-88(s0)
 744:	00478713          	addi	a4,a5,4
 748:	fae42423          	sw	a4,-88(s0)
 74c:	0007a783          	lw	a5,0(a5)
 750:	fcf42223          	sw	a5,-60(s0)
 754:	fe042423          	sw	zero,-24(s0)
 758:	00a00793          	li	a5,10
 75c:	fef42023          	sw	a5,-32(s0)
 760:	fc042e23          	sw	zero,-36(s0)
 764:	0280006f          	j	78c <UARTvprintf+0x2a4>
 768:	fa842783          	lw	a5,-88(s0)
 76c:	00478713          	addi	a4,a5,4
 770:	fae42423          	sw	a4,-88(s0)
 774:	0007a783          	lw	a5,0(a5)
 778:	fcf42223          	sw	a5,-60(s0)
 77c:	fe042423          	sw	zero,-24(s0)
 780:	01000793          	li	a5,16
 784:	fef42023          	sw	a5,-32(s0)
 788:	fc042e23          	sw	zero,-36(s0)
 78c:	00100793          	li	a5,1
 790:	fef42623          	sw	a5,-20(s0)
 794:	0200006f          	j	7b4 <UARTvprintf+0x2cc>
 798:	fec42703          	lw	a4,-20(s0)
 79c:	fe042783          	lw	a5,-32(s0)
 7a0:	02f707b3          	mul	a5,a4,a5
 7a4:	fef42623          	sw	a5,-20(s0)
 7a8:	fe442783          	lw	a5,-28(s0)
 7ac:	fff78793          	addi	a5,a5,-1
 7b0:	fef42223          	sw	a5,-28(s0)
 7b4:	fec42703          	lw	a4,-20(s0)
 7b8:	fe042783          	lw	a5,-32(s0)
 7bc:	02f70733          	mul	a4,a4,a5
 7c0:	fc442783          	lw	a5,-60(s0)
 7c4:	02e7e063          	bltu	a5,a4,7e4 <UARTvprintf+0x2fc>
 7c8:	fec42703          	lw	a4,-20(s0)
 7cc:	fe042783          	lw	a5,-32(s0)
 7d0:	02f70733          	mul	a4,a4,a5
 7d4:	fe042783          	lw	a5,-32(s0)
 7d8:	02f757b3          	divu	a5,a4,a5
 7dc:	fec42703          	lw	a4,-20(s0)
 7e0:	faf70ce3          	beq	a4,a5,798 <UARTvprintf+0x2b0>
 7e4:	fdc42783          	lw	a5,-36(s0)
 7e8:	00078863          	beqz	a5,7f8 <UARTvprintf+0x310>
 7ec:	fe442783          	lw	a5,-28(s0)
 7f0:	fff78793          	addi	a5,a5,-1
 7f4:	fef42223          	sw	a5,-28(s0)
 7f8:	fdc42783          	lw	a5,-36(s0)
 7fc:	02078863          	beqz	a5,82c <UARTvprintf+0x344>
 800:	fdb44703          	lbu	a4,-37(s0)
 804:	03000793          	li	a5,48
 808:	02f71263          	bne	a4,a5,82c <UARTvprintf+0x344>
 80c:	fe842783          	lw	a5,-24(s0)
 810:	00178713          	addi	a4,a5,1
 814:	fee42423          	sw	a4,-24(s0)
 818:	ff040713          	addi	a4,s0,-16
 81c:	00f707b3          	add	a5,a4,a5
 820:	02d00713          	li	a4,45
 824:	fce78223          	sb	a4,-60(a5)
 828:	fc042e23          	sw	zero,-36(s0)
 82c:	fe442703          	lw	a4,-28(s0)
 830:	00100793          	li	a5,1
 834:	04e7f863          	bgeu	a5,a4,884 <UARTvprintf+0x39c>
 838:	fe442703          	lw	a4,-28(s0)
 83c:	00f00793          	li	a5,15
 840:	04e7e263          	bltu	a5,a4,884 <UARTvprintf+0x39c>
 844:	fe442783          	lw	a5,-28(s0)
 848:	fff78793          	addi	a5,a5,-1
 84c:	fef42223          	sw	a5,-28(s0)
 850:	02c0006f          	j	87c <UARTvprintf+0x394>
 854:	fe842783          	lw	a5,-24(s0)
 858:	00178713          	addi	a4,a5,1
 85c:	fee42423          	sw	a4,-24(s0)
 860:	ff040713          	addi	a4,s0,-16
 864:	00f707b3          	add	a5,a4,a5
 868:	fdb44703          	lbu	a4,-37(s0)
 86c:	fce78223          	sb	a4,-60(a5)
 870:	fe442783          	lw	a5,-28(s0)
 874:	fff78793          	addi	a5,a5,-1
 878:	fef42223          	sw	a5,-28(s0)
 87c:	fe442783          	lw	a5,-28(s0)
 880:	fc079ae3          	bnez	a5,854 <UARTvprintf+0x36c>
 884:	fdc42783          	lw	a5,-36(s0)
 888:	06078863          	beqz	a5,8f8 <UARTvprintf+0x410>
 88c:	fe842783          	lw	a5,-24(s0)
 890:	00178713          	addi	a4,a5,1
 894:	fee42423          	sw	a4,-24(s0)
 898:	ff040713          	addi	a4,s0,-16
 89c:	00f707b3          	add	a5,a4,a5
 8a0:	02d00713          	li	a4,45
 8a4:	fce78223          	sb	a4,-60(a5)
 8a8:	0500006f          	j	8f8 <UARTvprintf+0x410>
 8ac:	000017b7          	lui	a5,0x1
 8b0:	dcc78713          	addi	a4,a5,-564 # dcc <__stack_init+0x4>
 8b4:	fc442683          	lw	a3,-60(s0)
 8b8:	fec42783          	lw	a5,-20(s0)
 8bc:	02f6d6b3          	divu	a3,a3,a5
 8c0:	fe042783          	lw	a5,-32(s0)
 8c4:	02f6f7b3          	remu	a5,a3,a5
 8c8:	00f70733          	add	a4,a4,a5
 8cc:	fe842783          	lw	a5,-24(s0)
 8d0:	00178693          	addi	a3,a5,1
 8d4:	fed42423          	sw	a3,-24(s0)
 8d8:	00074703          	lbu	a4,0(a4)
 8dc:	ff040693          	addi	a3,s0,-16
 8e0:	00f687b3          	add	a5,a3,a5
 8e4:	fce78223          	sb	a4,-60(a5)
 8e8:	fec42703          	lw	a4,-20(s0)
 8ec:	fe042783          	lw	a5,-32(s0)
 8f0:	02f757b3          	divu	a5,a4,a5
 8f4:	fef42623          	sw	a5,-20(s0)
 8f8:	fec42783          	lw	a5,-20(s0)
 8fc:	fa0798e3          	bnez	a5,8ac <UARTvprintf+0x3c4>
 900:	fb440793          	addi	a5,s0,-76
 904:	fe842583          	lw	a1,-24(s0)
 908:	00078513          	mv	a0,a5
 90c:	b55ff0ef          	jal	ra,460 <UARTwrite>
 910:	0340006f          	j	944 <UARTvprintf+0x45c>
 914:	fac42783          	lw	a5,-84(s0)
 918:	fff78793          	addi	a5,a5,-1
 91c:	00100593          	li	a1,1
 920:	00078513          	mv	a0,a5
 924:	b3dff0ef          	jal	ra,460 <UARTwrite>
 928:	01c0006f          	j	944 <UARTvprintf+0x45c>
 92c:	00500593          	li	a1,5
 930:	000017b7          	lui	a5,0x1
 934:	de478513          	addi	a0,a5,-540 # de4 <__stack_init+0x1c>
 938:	b29ff0ef          	jal	ra,460 <UARTwrite>
 93c:	0080006f          	j	944 <UARTvprintf+0x45c>
 940:	00000013          	nop
 944:	fac42783          	lw	a5,-84(s0)
 948:	0007c783          	lbu	a5,0(a5)
 94c:	ba079ce3          	bnez	a5,504 <UARTvprintf+0x1c>
 950:	00000013          	nop
 954:	00000013          	nop
 958:	05c12083          	lw	ra,92(sp)
 95c:	05812403          	lw	s0,88(sp)
 960:	06010113          	addi	sp,sp,96
 964:	00008067          	ret

00000968 <UARTprintf>:
 968:	fb010113          	addi	sp,sp,-80
 96c:	02112623          	sw	ra,44(sp)
 970:	02812423          	sw	s0,40(sp)
 974:	03010413          	addi	s0,sp,48
 978:	fca42e23          	sw	a0,-36(s0)
 97c:	00b42223          	sw	a1,4(s0)
 980:	00c42423          	sw	a2,8(s0)
 984:	00d42623          	sw	a3,12(s0)
 988:	00e42823          	sw	a4,16(s0)
 98c:	00f42a23          	sw	a5,20(s0)
 990:	01042c23          	sw	a6,24(s0)
 994:	01142e23          	sw	a7,28(s0)
 998:	02040793          	addi	a5,s0,32
 99c:	fcf42c23          	sw	a5,-40(s0)
 9a0:	fd842783          	lw	a5,-40(s0)
 9a4:	fe478793          	addi	a5,a5,-28
 9a8:	fef42623          	sw	a5,-20(s0)
 9ac:	fec42783          	lw	a5,-20(s0)
 9b0:	00078593          	mv	a1,a5
 9b4:	fdc42503          	lw	a0,-36(s0)
 9b8:	b31ff0ef          	jal	ra,4e8 <UARTvprintf>
 9bc:	00000013          	nop
 9c0:	02c12083          	lw	ra,44(sp)
 9c4:	02812403          	lw	s0,40(sp)
 9c8:	05010113          	addi	sp,sp,80
 9cc:	00008067          	ret

000009d0 <perceptron>:
 9d0:	fd010113          	addi	sp,sp,-48
 9d4:	00812023          	sw	s0,0(sp)
 9d8:	00912223          	sw	s1,4(sp)
 9dc:	01212423          	sw	s2,8(sp)
 9e0:	01312623          	sw	s3,12(sp)
 9e4:	01412823          	sw	s4,16(sp)
 9e8:	01512a23          	sw	s5,20(sp)
 9ec:	01612c23          	sw	s6,24(sp)
 9f0:	01712e23          	sw	s7,28(sp)
 9f4:	03812023          	sw	s8,32(sp)
 9f8:	03912223          	sw	s9,36(sp)
 9fc:	03a12423          	sw	s10,40(sp)
 a00:	03b12623          	sw	s11,44(sp)
 a04:	02000313          	li	t1,32
 a08:	01237e57          	vsetvli	t3,t1,e32,m4,tu,mu
 a0c:	00400313          	li	t1,4
 a10:	0026d813          	srli	a6,a3,0x2
 a14:	00300293          	li	t0,3
 a18:	00a2b073          	csrc	vxrm,t0
 a1c:	96006057          	vmul.vx	v0,v0,zero
 a20:	96406257          	vmul.vx	v4,v4,zero
 a24:	96806457          	vmul.vx	v8,v8,zero
 a28:	96c06657          	vmul.vx	v12,v12,zero
 a2c:	97006857          	vmul.vx	v16,v16,zero
 a30:	97406a57          	vmul.vx	v20,v20,zero
 a34:	97806c57          	vmul.vx	v24,v24,zero
 a38:	97c06e57          	vmul.vx	v28,v28,zero
 a3c:	01277e57          	vsetvli	t3,a4,e32,m4,tu,mu
 a40:	00000293          	li	t0,0
 a44:	02e303b3          	mul	t2,t1,a4
 a48:	02630e33          	mul	t3,t1,t1

00000a4c <OUTER_LOOP>:
 a4c:	0005a483          	lw	s1,0(a1)
 a50:	0045a903          	lw	s2,4(a1)
 a54:	0085a983          	lw	s3,8(a1)
 a58:	00c5aa03          	lw	s4,12(a1)
 a5c:	00760ab3          	add	s5,a2,t2
 a60:	007a8b33          	add	s6,s5,t2
 a64:	007b0bb3          	add	s7,s6,t2
 a68:	02066207          	vle32.v	v4,(a2)
 a6c:	020ae407          	vle32.v	v8,(s5)
 a70:	020b6607          	vle32.v	v12,(s6)
 a74:	020be807          	vle32.v	v16,(s7)
 a78:	b644ea57          	vmacc.vx	v20,s1,v4
 a7c:	b6896a57          	vmacc.vx	v20,s2,v8
 a80:	b6c9ea57          	vmacc.vx	v20,s3,v12
 a84:	b70a6a57          	vmacc.vx	v20,s4,v16
 a88:	00128293          	addi	t0,t0,1
 a8c:	01c585b3          	add	a1,a1,t3
 a90:	007b8633          	add	a2,s7,t2
 a94:	fb029ce3          	bne	t0,a6,a4c <OUTER_LOOP>
 a98:	00000013          	nop
 a9c:	00000013          	nop
 aa0:	00000013          	nop
 aa4:	0207e207          	vle32.v	v4,(a5)
 aa8:	03c04e57          	vadd.vx	v28,v28,zero
 aac:	024a0a57          	vadd.vv	v20,v4,v20
 ab0:	27404a57          	vand.vx	v20,v20,zero
 ab4:	96006257          	vmul.vx	v4,v0,zero
 ab8:	02056a27          	vse32.v	v20,(a0)
 abc:	96006257          	vmul.vx	v4,v0,zero
 ac0:	96006457          	vmul.vx	v8,v0,zero
 ac4:	00012403          	lw	s0,0(sp)
 ac8:	00412483          	lw	s1,4(sp)
 acc:	00812903          	lw	s2,8(sp)
 ad0:	00c12983          	lw	s3,12(sp)
 ad4:	01012a03          	lw	s4,16(sp)
 ad8:	01412a83          	lw	s5,20(sp)
 adc:	01812b03          	lw	s6,24(sp)
 ae0:	01c12b83          	lw	s7,28(sp)
 ae4:	02012c03          	lw	s8,32(sp)
 ae8:	02412c83          	lw	s9,36(sp)
 aec:	02812d03          	lw	s10,40(sp)
 af0:	02c12d83          	lw	s11,44(sp)
 af4:	03010113          	addi	sp,sp,48
 af8:	00008067          	ret

00000afc <ISR5>:
 afc:	30047073          	csrci	mstatus,8
 b00:	e8010113          	addi	sp,sp,-384
 b04:	10112023          	sw	ra,256(sp)
 b08:	10212223          	sw	sp,260(sp)
 b0c:	10312423          	sw	gp,264(sp)
 b10:	10412623          	sw	tp,268(sp)
 b14:	10512823          	sw	t0,272(sp)
 b18:	10612a23          	sw	t1,276(sp)
 b1c:	10712c23          	sw	t2,280(sp)
 b20:	10812e23          	sw	s0,284(sp)
 b24:	12912023          	sw	s1,288(sp)
 b28:	12a12223          	sw	a0,292(sp)
 b2c:	12b12423          	sw	a1,296(sp)
 b30:	12c12623          	sw	a2,300(sp)
 b34:	12d12823          	sw	a3,304(sp)
 b38:	12e12a23          	sw	a4,308(sp)
 b3c:	12f12c23          	sw	a5,312(sp)
 b40:	13012e23          	sw	a6,316(sp)
 b44:	15112023          	sw	a7,320(sp)
 b48:	15212223          	sw	s2,324(sp)
 b4c:	15312423          	sw	s3,328(sp)
 b50:	15412623          	sw	s4,332(sp)
 b54:	15512823          	sw	s5,336(sp)
 b58:	15612a23          	sw	s6,340(sp)
 b5c:	15712c23          	sw	s7,344(sp)
 b60:	15812e23          	sw	s8,348(sp)
 b64:	17912023          	sw	s9,352(sp)
 b68:	17a12223          	sw	s10,356(sp)
 b6c:	17b12423          	sw	s11,360(sp)
 b70:	17c12623          	sw	t3,364(sp)
 b74:	17d12823          	sw	t4,368(sp)
 b78:	17e12a23          	sw	t5,372(sp)
 b7c:	17f12c23          	sw	t6,376(sp)
 b80:	341022f3          	csrr	t0,mepc
 b84:	16512e23          	sw	t0,380(sp)
 b88:	208000ef          	jal	ra,d90 <ISR5_uart>
 b8c:	30047073          	csrci	mstatus,8
 b90:	17c12283          	lw	t0,380(sp)
 b94:	34129073          	csrw	mepc,t0
 b98:	10012083          	lw	ra,256(sp)
 b9c:	10c12203          	lw	tp,268(sp)
 ba0:	11012283          	lw	t0,272(sp)
 ba4:	11412303          	lw	t1,276(sp)
 ba8:	11812383          	lw	t2,280(sp)
 bac:	11c12403          	lw	s0,284(sp)
 bb0:	12012483          	lw	s1,288(sp)
 bb4:	12412503          	lw	a0,292(sp)
 bb8:	12812583          	lw	a1,296(sp)
 bbc:	12c12603          	lw	a2,300(sp)
 bc0:	13012683          	lw	a3,304(sp)
 bc4:	13412703          	lw	a4,308(sp)
 bc8:	13812783          	lw	a5,312(sp)
 bcc:	13c12803          	lw	a6,316(sp)
 bd0:	14012883          	lw	a7,320(sp)
 bd4:	14412903          	lw	s2,324(sp)
 bd8:	14812983          	lw	s3,328(sp)
 bdc:	14c12a03          	lw	s4,332(sp)
 be0:	15012a83          	lw	s5,336(sp)
 be4:	15412b03          	lw	s6,340(sp)
 be8:	15812b83          	lw	s7,344(sp)
 bec:	15c12c03          	lw	s8,348(sp)
 bf0:	16012c83          	lw	s9,352(sp)
 bf4:	16412d03          	lw	s10,356(sp)
 bf8:	16812d83          	lw	s11,360(sp)
 bfc:	16c12e03          	lw	t3,364(sp)
 c00:	17012e83          	lw	t4,368(sp)
 c04:	17412f03          	lw	t5,372(sp)
 c08:	17812f83          	lw	t6,376(sp)
 c0c:	18010113          	addi	sp,sp,384
 c10:	30046073          	csrsi	mstatus,8
 c14:	30200073          	mret

00000c18 <ISR6>:
 c18:	30047073          	csrci	mstatus,8
 c1c:	e8010113          	addi	sp,sp,-384
 c20:	10112023          	sw	ra,256(sp)
 c24:	10212223          	sw	sp,260(sp)
 c28:	10312423          	sw	gp,264(sp)
 c2c:	10412623          	sw	tp,268(sp)
 c30:	10512823          	sw	t0,272(sp)
 c34:	10612a23          	sw	t1,276(sp)
 c38:	10712c23          	sw	t2,280(sp)
 c3c:	10812e23          	sw	s0,284(sp)
 c40:	12912023          	sw	s1,288(sp)
 c44:	12a12223          	sw	a0,292(sp)
 c48:	12b12423          	sw	a1,296(sp)
 c4c:	12c12623          	sw	a2,300(sp)
 c50:	12d12823          	sw	a3,304(sp)
 c54:	12e12a23          	sw	a4,308(sp)
 c58:	12f12c23          	sw	a5,312(sp)
 c5c:	13012e23          	sw	a6,316(sp)
 c60:	15112023          	sw	a7,320(sp)
 c64:	15212223          	sw	s2,324(sp)
 c68:	15312423          	sw	s3,328(sp)
 c6c:	15412623          	sw	s4,332(sp)
 c70:	15512823          	sw	s5,336(sp)
 c74:	15612a23          	sw	s6,340(sp)
 c78:	15712c23          	sw	s7,344(sp)
 c7c:	15812e23          	sw	s8,348(sp)
 c80:	17912023          	sw	s9,352(sp)
 c84:	17a12223          	sw	s10,356(sp)
 c88:	17b12423          	sw	s11,360(sp)
 c8c:	17c12623          	sw	t3,364(sp)
 c90:	17d12823          	sw	t4,368(sp)
 c94:	17e12a23          	sw	t5,372(sp)
 c98:	17f12c23          	sw	t6,376(sp)
 c9c:	341022f3          	csrr	t0,mepc
 ca0:	16512e23          	sw	t0,380(sp)
 ca4:	108000ef          	jal	ra,dac <ISR6_addr_exception>
 ca8:	30047073          	csrci	mstatus,8
 cac:	17c12283          	lw	t0,380(sp)
 cb0:	34129073          	csrw	mepc,t0
 cb4:	10012083          	lw	ra,256(sp)
 cb8:	10c12203          	lw	tp,268(sp)
 cbc:	11012283          	lw	t0,272(sp)
 cc0:	11412303          	lw	t1,276(sp)
 cc4:	11812383          	lw	t2,280(sp)
 cc8:	11c12403          	lw	s0,284(sp)
 ccc:	12012483          	lw	s1,288(sp)
 cd0:	12412503          	lw	a0,292(sp)
 cd4:	12812583          	lw	a1,296(sp)
 cd8:	12c12603          	lw	a2,300(sp)
 cdc:	13012683          	lw	a3,304(sp)
 ce0:	13412703          	lw	a4,308(sp)
 ce4:	13812783          	lw	a5,312(sp)
 ce8:	13c12803          	lw	a6,316(sp)
 cec:	14012883          	lw	a7,320(sp)
 cf0:	14412903          	lw	s2,324(sp)
 cf4:	14812983          	lw	s3,328(sp)
 cf8:	14c12a03          	lw	s4,332(sp)
 cfc:	15012a83          	lw	s5,336(sp)
 d00:	15412b03          	lw	s6,340(sp)
 d04:	15812b83          	lw	s7,344(sp)
 d08:	15c12c03          	lw	s8,348(sp)
 d0c:	16012c83          	lw	s9,352(sp)
 d10:	16412d03          	lw	s10,356(sp)
 d14:	16812d83          	lw	s11,360(sp)
 d18:	16c12e03          	lw	t3,364(sp)
 d1c:	17012e83          	lw	t4,368(sp)
 d20:	17412f03          	lw	t5,372(sp)
 d24:	17812f83          	lw	t6,376(sp)
 d28:	18010113          	addi	sp,sp,384
 d2c:	30046073          	csrsi	mstatus,8
 d30:	30200073          	mret

00000d34 <main>:
 d34:	fe010113          	addi	sp,sp,-32
 d38:	00112e23          	sw	ra,28(sp)
 d3c:	00812c23          	sw	s0,24(sp)
 d40:	02010413          	addi	s0,sp,32
 d44:	fea42623          	sw	a0,-20(s0)
 d48:	feb42423          	sw	a1,-24(s0)
 d4c:	001047b7          	lui	a5,0x104
 d50:	40078793          	addi	a5,a5,1024 # 104400 <bias>
 d54:	01000713          	li	a4,16
 d58:	10000693          	li	a3,256
 d5c:	00100637          	lui	a2,0x100
 d60:	40060613          	addi	a2,a2,1024 # 100400 <weights>
 d64:	001005b7          	lui	a1,0x100
 d68:	00058593          	mv	a1,a1
 d6c:	00104537          	lui	a0,0x104
 d70:	48050513          	addi	a0,a0,1152 # 104480 <Y>
 d74:	c5dff0ef          	jal	ra,9d0 <perceptron>
 d78:	00000793          	li	a5,0
 d7c:	00078513          	mv	a0,a5
 d80:	01c12083          	lw	ra,28(sp)
 d84:	01812403          	lw	s0,24(sp)
 d88:	02010113          	addi	sp,sp,32
 d8c:	00008067          	ret

00000d90 <ISR5_uart>:
 d90:	ff010113          	addi	sp,sp,-16
 d94:	00812623          	sw	s0,12(sp)
 d98:	01010413          	addi	s0,sp,16
 d9c:	00000013          	nop
 da0:	00c12403          	lw	s0,12(sp)
 da4:	01010113          	addi	sp,sp,16
 da8:	00008067          	ret

00000dac <ISR6_addr_exception>:
 dac:	ff010113          	addi	sp,sp,-16
 db0:	00812623          	sw	s0,12(sp)
 db4:	01010413          	addi	s0,sp,16
 db8:	00000013          	nop
 dbc:	00c12403          	lw	s0,12(sp)
 dc0:	01010113          	addi	sp,sp,16
 dc4:	00008067          	ret

00000dc8 <__stack_init>:
 dc8:	000feffc                                ....
