
riscv-spike.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <boot>:
       0:	00002fb7          	lui	t6,0x2
       4:	800f8f93          	addi	t6,t6,-2048 # 1800 <__stack_init+0x42c>
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
      c8:	00021197          	auipc	gp,0x21
      cc:	07c18193          	addi	gp,gp,124 # 21144 <__global_pointer$>
      d0:	000ff117          	auipc	sp,0xff
      d4:	f2c10113          	addi	sp,sp,-212 # feffc <__stacktop>
      d8:	00000297          	auipc	t0,0x0
      dc:	01c28293          	addi	t0,t0,28 # f4 <trap_entry>
      e0:	00012503          	lw	a0,0(sp)
      e4:	00000613          	li	a2,0
      e8:	054010ef          	jal	ra,113c <main>
      ec:	0000006f          	j	ec <_mstart+0xac>
      f0:	00008067          	ret

000000f4 <trap_entry>:
      f4:	6110006f          	j	f04 <ISR5>
      f8:	30200073          	mret
      fc:	6090006f          	j	f04 <ISR5>
     100:	30200073          	mret
     104:	6010006f          	j	f04 <ISR5>
     108:	30200073          	mret
     10c:	5f90006f          	j	f04 <ISR5>
     110:	30200073          	mret
     114:	5f10006f          	j	f04 <ISR5>
     118:	30200073          	mret
     11c:	7050006f          	j	1020 <ISR6>
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
     150:	60078793          	addi	a5,a5,1536 # 9600 <__stack_init+0x822c>
     154:	00f71a63          	bne	a4,a5,168 <UART_init+0x38>
     158:	fe0407a3          	sb	zero,-17(s0)
     15c:	fa200793          	li	a5,-94
     160:	fef40723          	sb	a5,-18(s0)
     164:	1180006f          	j	27c <UART_init+0x14c>
     168:	fdc42703          	lw	a4,-36(s0)
     16c:	000027b7          	lui	a5,0x2
     170:	58078793          	addi	a5,a5,1408 # 2580 <__stack_init+0x11ac>
     174:	00f71c63          	bne	a4,a5,18c <UART_init+0x5c>
     178:	00200793          	li	a5,2
     17c:	fef407a3          	sb	a5,-17(s0)
     180:	f8b00793          	li	a5,-117
     184:	fef40723          	sb	a5,-18(s0)
     188:	0f40006f          	j	27c <UART_init+0x14c>
     18c:	fdc42703          	lw	a4,-36(s0)
     190:	000057b7          	lui	a5,0x5
     194:	b0078793          	addi	a5,a5,-1280 # 4b00 <__stack_init+0x372c>
     198:	00f71c63          	bne	a4,a5,1b0 <UART_init+0x80>
     19c:	00100793          	li	a5,1
     1a0:	fef407a3          	sb	a5,-17(s0)
     1a4:	04500793          	li	a5,69
     1a8:	fef40723          	sb	a5,-18(s0)
     1ac:	0d00006f          	j	27c <UART_init+0x14c>
     1b0:	fdc42703          	lw	a4,-36(s0)
     1b4:	0000e7b7          	lui	a5,0xe
     1b8:	10078793          	addi	a5,a5,256 # e100 <__stack_init+0xcd2c>
     1bc:	00f71a63          	bne	a4,a5,1d0 <UART_init+0xa0>
     1c0:	fe0407a3          	sb	zero,-17(s0)
     1c4:	03600793          	li	a5,54
     1c8:	fef40723          	sb	a5,-18(s0)
     1cc:	0b00006f          	j	27c <UART_init+0x14c>
     1d0:	fdc42703          	lw	a4,-36(s0)
     1d4:	0001c7b7          	lui	a5,0x1c
     1d8:	20078793          	addi	a5,a5,512 # 1c200 <__stack_init+0x1ae2c>
     1dc:	00f71a63          	bne	a4,a5,1f0 <UART_init+0xc0>
     1e0:	fe0407a3          	sb	zero,-17(s0)
     1e4:	01b00793          	li	a5,27
     1e8:	fef40723          	sb	a5,-18(s0)
     1ec:	0900006f          	j	27c <UART_init+0x14c>
     1f0:	fdc42703          	lw	a4,-36(s0)
     1f4:	000387b7          	lui	a5,0x38
     1f8:	40078793          	addi	a5,a5,1024 # 38400 <__BSS_END__+0x16abc>
     1fc:	00f71a63          	bne	a4,a5,210 <UART_init+0xe0>
     200:	fe0407a3          	sb	zero,-17(s0)
     204:	00e00793          	li	a5,14
     208:	fef40723          	sb	a5,-18(s0)
     20c:	0700006f          	j	27c <UART_init+0x14c>
     210:	fdc42703          	lw	a4,-36(s0)
     214:	000717b7          	lui	a5,0x71
     218:	80078793          	addi	a5,a5,-2048 # 70800 <__BSS_END__+0x4eebc>
     21c:	00f71a63          	bne	a4,a5,230 <UART_init+0x100>
     220:	fe0407a3          	sb	zero,-17(s0)
     224:	00700793          	li	a5,7
     228:	fef40723          	sb	a5,-18(s0)
     22c:	0500006f          	j	27c <UART_init+0x14c>
     230:	fdc42703          	lw	a4,-36(s0)
     234:	0017d7b7          	lui	a5,0x17d
     238:	78478793          	addi	a5,a5,1924 # 17d784 <__VMEM_END+0x6d880>
     23c:	00f71a63          	bne	a4,a5,250 <UART_init+0x120>
     240:	fe0407a3          	sb	zero,-17(s0)
     244:	00400793          	li	a5,4
     248:	fef40723          	sb	a5,-18(s0)
     24c:	0300006f          	j	27c <UART_init+0x14c>
     250:	fdc42703          	lw	a4,-36(s0)
     254:	000bf7b7          	lui	a5,0xbf
     258:	bc278793          	addi	a5,a5,-1086 # bebc2 <__BSS_END__+0x9d27e>
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
     5ac:	3f878793          	addi	a5,a5,1016 # 13f8 <__stack_init+0x24>
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
     724:	3ec78513          	addi	a0,a5,1004 # 13ec <__stack_init+0x18>
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
     8b0:	3d878713          	addi	a4,a5,984 # 13d8 <__stack_init+0x4>
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
     934:	3f078513          	addi	a0,a5,1008 # 13f0 <__stack_init+0x1c>
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

000009d0 <conv2d>:
     9d0:	fd410113          	addi	sp,sp,-44
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
     a00:	ffe68293          	addi	t0,a3,-2
     a04:	4012d813          	srai	a6,t0,0x1
     a08:	0127fe57          	vsetvli	t3,a5,e32,m4,tu,mu
     a0c:	00279e13          	slli	t3,a5,0x2
     a10:	01c604b3          	add	s1,a2,t3
     a14:	01c48933          	add	s2,s1,t3
     a18:	01c909b3          	add	s3,s2,t3
     a1c:	01c98a33          	add	s4,s3,t3
     a20:	01ca0ab3          	add	s5,s4,t3
     a24:	01ca8b33          	add	s6,s5,t3
     a28:	01cb0bb3          	add	s7,s6,t3
     a2c:	01cb8c33          	add	s8,s7,t3
     a30:	02066107          	vle32.v	v2,(a2)
     a34:	0204e207          	vle32.v	v4,(s1)
     a38:	02096307          	vle32.v	v6,(s2)
     a3c:	0209e407          	vle32.v	v8,(s3)
     a40:	020a6507          	vle32.v	v10,(s4)
     a44:	020ae607          	vle32.v	v12,(s5)
     a48:	020b6707          	vle32.v	v14,(s6)
     a4c:	020be807          	vle32.v	v16,(s7)
     a50:	020c6907          	vle32.v	v18,(s8)
     a54:	02076a07          	vle32.v	v20,(a4)
     a58:	97606b57          	vmul.vx	v22,v22,zero
     a5c:	97806c57          	vmul.vx	v24,v24,zero
     a60:	97a06d57          	vmul.vx	v26,v26,zero
     a64:	97c06e57          	vmul.vx	v28,v28,zero
     a68:	97e06f57          	vmul.vx	v30,v30,zero
     a6c:	03c04e57          	vadd.vx	v28,v28,zero
     a70:	00000293          	li	t0,0

00000a74 <OUTER_LOOP>:
     a74:	00000313          	li	t1,0

00000a78 <INNER_LOOP>:
     a78:	02d283b3          	mul	t2,t0,a3
     a7c:	00730e33          	add	t3,t1,t2
     a80:	003e1e13          	slli	t3,t3,0x3
     a84:	01c58433          	add	s0,a1,t3
     a88:	030283b3          	mul	t2,t0,a6
     a8c:	00730e33          	add	t3,t1,t2
     a90:	002e1e13          	slli	t3,t3,0x2
     a94:	02fe0f33          	mul	t5,t3,a5
     a98:	01e50d33          	add	s10,a0,t5
     a9c:	00042483          	lw	s1,0(s0)
     aa0:	00442903          	lw	s2,4(s0)
     aa4:	00842983          	lw	s3,8(s0)
     aa8:	00c42a03          	lw	s4,12(s0)
     aac:	b624eb57          	vmacc.vx	v22,s1,v2
     ab0:	b6496b57          	vmacc.vx	v22,s2,v4
     ab4:	b669eb57          	vmacc.vx	v22,s3,v6
     ab8:	b6296c57          	vmacc.vx	v24,s2,v2
     abc:	b649ec57          	vmacc.vx	v24,s3,v4
     ac0:	b66a6c57          	vmacc.vx	v24,s4,v6
     ac4:	03c04e57          	vadd.vx	v28,v28,zero
     ac8:	03c04e57          	vadd.vx	v28,v28,zero
     acc:	00269e13          	slli	t3,a3,0x2
     ad0:	01c40433          	add	s0,s0,t3
     ad4:	00042483          	lw	s1,0(s0)
     ad8:	00442903          	lw	s2,4(s0)
     adc:	00842983          	lw	s3,8(s0)
     ae0:	00c42a03          	lw	s4,12(s0)
     ae4:	01c40433          	add	s0,s0,t3
     ae8:	00042a83          	lw	s5,0(s0)
     aec:	00442b03          	lw	s6,4(s0)
     af0:	00842b83          	lw	s7,8(s0)
     af4:	00c42c03          	lw	s8,12(s0)
     af8:	b684eb57          	vmacc.vx	v22,s1,v8
     afc:	b6a96b57          	vmacc.vx	v22,s2,v10
     b00:	b6c9eb57          	vmacc.vx	v22,s3,v12
     b04:	b6896c57          	vmacc.vx	v24,s2,v8
     b08:	b6a9ec57          	vmacc.vx	v24,s3,v10
     b0c:	b6ca6c57          	vmacc.vx	v24,s4,v12
     b10:	b624ed57          	vmacc.vx	v26,s1,v2
     b14:	b6496d57          	vmacc.vx	v26,s2,v4
     b18:	b669ed57          	vmacc.vx	v26,s3,v6
     b1c:	b6296e57          	vmacc.vx	v28,s2,v2
     b20:	b649ee57          	vmacc.vx	v28,s3,v4
     b24:	b66a6e57          	vmacc.vx	v28,s4,v6
     b28:	b6eaeb57          	vmacc.vx	v22,s5,v14
     b2c:	b70b6b57          	vmacc.vx	v22,s6,v16
     b30:	b72beb57          	vmacc.vx	v22,s7,v18
     b34:	b6eb6c57          	vmacc.vx	v24,s6,v14
     b38:	b70bec57          	vmacc.vx	v24,s7,v16
     b3c:	b72c6c57          	vmacc.vx	v24,s8,v18
     b40:	b68aed57          	vmacc.vx	v26,s5,v8
     b44:	b6ab6d57          	vmacc.vx	v26,s6,v10
     b48:	b6cbed57          	vmacc.vx	v26,s7,v12
     b4c:	b68b6e57          	vmacc.vx	v28,s6,v8
     b50:	b6abee57          	vmacc.vx	v28,s7,v10
     b54:	b6cc6e57          	vmacc.vx	v28,s8,v12
     b58:	01c40433          	add	s0,s0,t3
     b5c:	00042483          	lw	s1,0(s0)
     b60:	00442903          	lw	s2,4(s0)
     b64:	00842983          	lw	s3,8(s0)
     b68:	00c42a03          	lw	s4,12(s0)
     b6c:	b6e4ed57          	vmacc.vx	v26,s1,v14
     b70:	b7096d57          	vmacc.vx	v26,s2,v16
     b74:	b729ed57          	vmacc.vx	v26,s3,v18
     b78:	b6e96e57          	vmacc.vx	v28,s2,v14
     b7c:	b709ee57          	vmacc.vx	v28,s3,v16
     b80:	b72a6e57          	vmacc.vx	v28,s4,v18
     b84:	03c04e57          	vadd.vx	v28,v28,zero
     b88:	03c04e57          	vadd.vx	v28,v28,zero
     b8c:	034b0b57          	vadd.vv	v22,v20,v22
     b90:	034c0c57          	vadd.vv	v24,v20,v24
     b94:	034d0d57          	vadd.vv	v26,v20,v26
     b98:	034e0e57          	vadd.vv	v28,v20,v28
     b9c:	27604b57          	vand.vx	v22,v22,zero
     ba0:	27804c57          	vand.vx	v24,v24,zero
     ba4:	27a04d57          	vand.vx	v26,v26,zero
     ba8:	27c04e57          	vand.vx	v28,v28,zero
     bac:	276c0f57          	vand.vv	v30,v22,v24
     bb0:	27ed0f57          	vand.vv	v30,v30,v26
     bb4:	27ee0f57          	vand.vv	v30,v30,v28
     bb8:	020d6f27          	vse32.v	v30,(s10)
     bbc:	97606b57          	vmul.vx	v22,v22,zero
     bc0:	97806c57          	vmul.vx	v24,v24,zero
     bc4:	97a06d57          	vmul.vx	v26,v26,zero
     bc8:	97c06e57          	vmul.vx	v28,v28,zero
     bcc:	00130313          	addi	t1,t1,1
     bd0:	eb0314e3          	bne	t1,a6,a78 <INNER_LOOP>
     bd4:	00128293          	addi	t0,t0,1
     bd8:	e9029ee3          	bne	t0,a6,a74 <OUTER_LOOP>
     bdc:	00012403          	lw	s0,0(sp)
     be0:	00412483          	lw	s1,4(sp)
     be4:	00812903          	lw	s2,8(sp)
     be8:	00c12983          	lw	s3,12(sp)
     bec:	01012a03          	lw	s4,16(sp)
     bf0:	01412a83          	lw	s5,20(sp)
     bf4:	01812b03          	lw	s6,24(sp)
     bf8:	01c12b83          	lw	s7,28(sp)
     bfc:	02012c03          	lw	s8,32(sp)
     c00:	02412c83          	lw	s9,36(sp)
     c04:	02812d03          	lw	s10,40(sp)
     c08:	02c10113          	addi	sp,sp,44
     c0c:	00008067          	ret

00000c10 <layer2>:
     c10:	fd010113          	addi	sp,sp,-48
     c14:	00812023          	sw	s0,0(sp)
     c18:	00912223          	sw	s1,4(sp)
     c1c:	01212423          	sw	s2,8(sp)
     c20:	01312623          	sw	s3,12(sp)
     c24:	01412823          	sw	s4,16(sp)
     c28:	01512a23          	sw	s5,20(sp)
     c2c:	01612c23          	sw	s6,24(sp)
     c30:	01712e23          	sw	s7,28(sp)
     c34:	03812023          	sw	s8,32(sp)
     c38:	03912223          	sw	s9,36(sp)
     c3c:	03a12423          	sw	s10,40(sp)
     c40:	03b12623          	sw	s11,44(sp)
     c44:	030782b3          	mul	t0,a5,a6
     c48:	00229313          	slli	t1,t0,0x2
     c4c:	fe612e23          	sw	t1,-4(sp)
     c50:	ffe68293          	addi	t0,a3,-2
     c54:	4012d893          	srai	a7,t0,0x1
     c58:	0127fe57          	vsetvli	t3,a5,e32,m4,tu,mu
     c5c:	00000293          	li	t0,0

00000c60 <OUTER_LOOP>:
     c60:	00000313          	li	t1,0

00000c64 <INNER_LOOP>:
     c64:	031283b3          	mul	t2,t0,a7
     c68:	00730e33          	add	t3,t1,t2
     c6c:	002e1e13          	slli	t3,t3,0x2
     c70:	02fe0f33          	mul	t5,t3,a5
     c74:	01e50d33          	add	s10,a0,t5
     c78:	96406257          	vmul.vx	v4,v4,zero
     c7c:	96806457          	vmul.vx	v8,v8,zero
     c80:	96c06657          	vmul.vx	v12,v12,zero
     c84:	97006857          	vmul.vx	v16,v16,zero
     c88:	97406a57          	vmul.vx	v20,v20,zero
     c8c:	97806c57          	vmul.vx	v24,v24,zero
     c90:	97c06e57          	vmul.vx	v28,v28,zero
     c94:	97c06e57          	vmul.vx	v28,v28,zero
     c98:	00000e93          	li	t4,0

00000c9c <IMG_DIM_LOOP>:
     c9c:	02d283b3          	mul	t2,t0,a3
     ca0:	00730e33          	add	t3,t1,t2
     ca4:	003e1e13          	slli	t3,t3,0x3
     ca8:	030e0e33          	mul	t3,t3,a6
     cac:	01c58433          	add	s0,a1,t3
     cb0:	002e9f13          	slli	t5,t4,0x2
     cb4:	01e40433          	add	s0,s0,t5
     cb8:	02fe8e33          	mul	t3,t4,a5
     cbc:	002e1f13          	slli	t5,t3,0x2
     cc0:	01e60cb3          	add	s9,a2,t5
     cc4:	00000d93          	li	s11,0

00000cc8 <KER_ROW_LOOP>:
     cc8:	ffc12383          	lw	t2,-4(sp)
     ccc:	007c8f33          	add	t5,s9,t2
     cd0:	007f0fb3          	add	t6,t5,t2
     cd4:	00042483          	lw	s1,0(s0)
     cd8:	04042903          	lw	s2,64(s0)
     cdc:	08042983          	lw	s3,128(s0)
     ce0:	0c042a03          	lw	s4,192(s0)
     ce4:	030683b3          	mul	t2,a3,a6
     ce8:	00239393          	slli	t2,t2,0x2
     cec:	00740433          	add	s0,s0,t2
     cf0:	00042a83          	lw	s5,0(s0)
     cf4:	04042b03          	lw	s6,64(s0)
     cf8:	08042b83          	lw	s7,128(s0)
     cfc:	0c042c03          	lw	s8,192(s0)
     d00:	020ce207          	vle32.v	v4,(s9)
     d04:	020f6407          	vle32.v	v8,(t5)
     d08:	020fe607          	vle32.v	v12,(t6)
     d0c:	b644e857          	vmacc.vx	v16,s1,v4
     d10:	b6896857          	vmacc.vx	v16,s2,v8
     d14:	b6c9e857          	vmacc.vx	v16,s3,v12
     d18:	b6496a57          	vmacc.vx	v20,s2,v4
     d1c:	b689ea57          	vmacc.vx	v20,s3,v8
     d20:	b6ca6a57          	vmacc.vx	v20,s4,v12
     d24:	b64aec57          	vmacc.vx	v24,s5,v4
     d28:	b68b6c57          	vmacc.vx	v24,s6,v8
     d2c:	b6cbec57          	vmacc.vx	v24,s7,v12
     d30:	b64b6e57          	vmacc.vx	v28,s6,v4
     d34:	b68bee57          	vmacc.vx	v28,s7,v8
     d38:	b6cc6e57          	vmacc.vx	v28,s8,v12
     d3c:	03c04e57          	vadd.vx	v28,v28,zero
     d40:	001d8d93          	addi	s11,s11,1
     d44:	ffc12383          	lw	t2,-4(sp)
     d48:	007f8cb3          	add	s9,t6,t2
     d4c:	00300393          	li	t2,3
     d50:	f67d9ce3          	bne	s11,t2,cc8 <KER_ROW_LOOP>
     d54:	001e8e93          	addi	t4,t4,1
     d58:	f50e92e3          	bne	t4,a6,c9c <IMG_DIM_LOOP>
     d5c:	00000013          	nop
     d60:	00000013          	nop
     d64:	02076207          	vle32.v	v4,(a4)
     d68:	03c04e57          	vadd.vx	v28,v28,zero
     d6c:	02480857          	vadd.vv	v16,v4,v16
     d70:	024a0a57          	vadd.vv	v20,v4,v20
     d74:	024c0c57          	vadd.vv	v24,v4,v24
     d78:	024e0e57          	vadd.vv	v28,v4,v28
     d7c:	27004857          	vand.vx	v16,v16,zero
     d80:	27404a57          	vand.vx	v20,v20,zero
     d84:	27804c57          	vand.vx	v24,v24,zero
     d88:	27c04e57          	vand.vx	v28,v28,zero
     d8c:	270a0457          	vand.vv	v8,v16,v20
     d90:	268c0457          	vand.vv	v8,v8,v24
     d94:	268e0457          	vand.vv	v8,v8,v28
     d98:	020d6427          	vse32.v	v8,(s10)
     d9c:	26840457          	vand.vv	v8,v8,v8
     da0:	26840457          	vand.vv	v8,v8,v8
     da4:	00130313          	addi	t1,t1,1
     da8:	eb131ee3          	bne	t1,a7,c64 <INNER_LOOP>
     dac:	00128293          	addi	t0,t0,1
     db0:	eb1298e3          	bne	t0,a7,c60 <OUTER_LOOP>
     db4:	00012403          	lw	s0,0(sp)
     db8:	00412483          	lw	s1,4(sp)
     dbc:	00812903          	lw	s2,8(sp)
     dc0:	00c12983          	lw	s3,12(sp)
     dc4:	01012a03          	lw	s4,16(sp)
     dc8:	01412a83          	lw	s5,20(sp)
     dcc:	01812b03          	lw	s6,24(sp)
     dd0:	01c12b83          	lw	s7,28(sp)
     dd4:	02012c03          	lw	s8,32(sp)
     dd8:	02412c83          	lw	s9,36(sp)
     ddc:	02812d03          	lw	s10,40(sp)
     de0:	02c12d83          	lw	s11,44(sp)
     de4:	03010113          	addi	sp,sp,48
     de8:	00008067          	ret

00000dec <layer3>:
     dec:	fd010113          	addi	sp,sp,-48
     df0:	00812023          	sw	s0,0(sp)
     df4:	00912223          	sw	s1,4(sp)
     df8:	01212423          	sw	s2,8(sp)
     dfc:	01312623          	sw	s3,12(sp)
     e00:	01412823          	sw	s4,16(sp)
     e04:	01512a23          	sw	s5,20(sp)
     e08:	01612c23          	sw	s6,24(sp)
     e0c:	01712e23          	sw	s7,28(sp)
     e10:	03812023          	sw	s8,32(sp)
     e14:	03912223          	sw	s9,36(sp)
     e18:	03a12423          	sw	s10,40(sp)
     e1c:	03b12623          	sw	s11,44(sp)
     e20:	02000313          	li	t1,32
     e24:	01237e57          	vsetvli	t3,t1,e32,m4,tu,mu
     e28:	00400313          	li	t1,4
     e2c:	0026d813          	srli	a6,a3,0x2
     e30:	96006057          	vmul.vx	v0,v0,zero
     e34:	96406257          	vmul.vx	v4,v4,zero
     e38:	96806457          	vmul.vx	v8,v8,zero
     e3c:	96c06657          	vmul.vx	v12,v12,zero
     e40:	97006857          	vmul.vx	v16,v16,zero
     e44:	97406a57          	vmul.vx	v20,v20,zero
     e48:	97806c57          	vmul.vx	v24,v24,zero
     e4c:	97c06e57          	vmul.vx	v28,v28,zero
     e50:	0127fe57          	vsetvli	t3,a5,e32,m4,tu,mu
     e54:	00000293          	li	t0,0
     e58:	02f303b3          	mul	t2,t1,a5
     e5c:	02630e33          	mul	t3,t1,t1

00000e60 <OUTER_LOOP>:
     e60:	0005a483          	lw	s1,0(a1)
     e64:	0045a903          	lw	s2,4(a1)
     e68:	0085a983          	lw	s3,8(a1)
     e6c:	00c5aa03          	lw	s4,12(a1)
     e70:	00760ab3          	add	s5,a2,t2
     e74:	007a8b33          	add	s6,s5,t2
     e78:	007b0bb3          	add	s7,s6,t2
     e7c:	02066107          	vle32.v	v2,(a2)
     e80:	020ae207          	vle32.v	v4,(s5)
     e84:	020b6307          	vle32.v	v6,(s6)
     e88:	020be407          	vle32.v	v8,(s7)
     e8c:	b624ea57          	vmacc.vx	v20,s1,v2
     e90:	b6496a57          	vmacc.vx	v20,s2,v4
     e94:	b669ea57          	vmacc.vx	v20,s3,v6
     e98:	b68a6a57          	vmacc.vx	v20,s4,v8
     e9c:	00128293          	addi	t0,t0,1
     ea0:	01c585b3          	add	a1,a1,t3
     ea4:	007b8633          	add	a2,s7,t2
     ea8:	fb029ce3          	bne	t0,a6,e60 <OUTER_LOOP>
     eac:	02076207          	vle32.v	v4,(a4)
     eb0:	03c04e57          	vadd.vx	v28,v28,zero
     eb4:	024a0a57          	vadd.vv	v20,v4,v20
     eb8:	27404a57          	vand.vx	v20,v20,zero
     ebc:	1f4a0557          	vmax.vv	v10,v20,v20
     ec0:	96006257          	vmul.vx	v4,v0,zero
     ec4:	96006457          	vmul.vx	v8,v0,zero
     ec8:	96006657          	vmul.vx	v12,v0,zero
     ecc:	00012403          	lw	s0,0(sp)
     ed0:	00412483          	lw	s1,4(sp)
     ed4:	00812903          	lw	s2,8(sp)
     ed8:	00c12983          	lw	s3,12(sp)
     edc:	01012a03          	lw	s4,16(sp)
     ee0:	01412a83          	lw	s5,20(sp)
     ee4:	01812b03          	lw	s6,24(sp)
     ee8:	01c12b83          	lw	s7,28(sp)
     eec:	02012c03          	lw	s8,32(sp)
     ef0:	02412c83          	lw	s9,36(sp)
     ef4:	02812d03          	lw	s10,40(sp)
     ef8:	02c12d83          	lw	s11,44(sp)
     efc:	03010113          	addi	sp,sp,48
     f00:	00008067          	ret

00000f04 <ISR5>:
     f04:	30047073          	csrci	mstatus,8
     f08:	e8010113          	addi	sp,sp,-384
     f0c:	10112023          	sw	ra,256(sp)
     f10:	10212223          	sw	sp,260(sp)
     f14:	10312423          	sw	gp,264(sp)
     f18:	10412623          	sw	tp,268(sp)
     f1c:	10512823          	sw	t0,272(sp)
     f20:	10612a23          	sw	t1,276(sp)
     f24:	10712c23          	sw	t2,280(sp)
     f28:	10812e23          	sw	s0,284(sp)
     f2c:	12912023          	sw	s1,288(sp)
     f30:	12a12223          	sw	a0,292(sp)
     f34:	12b12423          	sw	a1,296(sp)
     f38:	12c12623          	sw	a2,300(sp)
     f3c:	12d12823          	sw	a3,304(sp)
     f40:	12e12a23          	sw	a4,308(sp)
     f44:	12f12c23          	sw	a5,312(sp)
     f48:	13012e23          	sw	a6,316(sp)
     f4c:	15112023          	sw	a7,320(sp)
     f50:	15212223          	sw	s2,324(sp)
     f54:	15312423          	sw	s3,328(sp)
     f58:	15412623          	sw	s4,332(sp)
     f5c:	15512823          	sw	s5,336(sp)
     f60:	15612a23          	sw	s6,340(sp)
     f64:	15712c23          	sw	s7,344(sp)
     f68:	15812e23          	sw	s8,348(sp)
     f6c:	17912023          	sw	s9,352(sp)
     f70:	17a12223          	sw	s10,356(sp)
     f74:	17b12423          	sw	s11,360(sp)
     f78:	17c12623          	sw	t3,364(sp)
     f7c:	17d12823          	sw	t4,368(sp)
     f80:	17e12a23          	sw	t5,372(sp)
     f84:	17f12c23          	sw	t6,376(sp)
     f88:	341022f3          	csrr	t0,mepc
     f8c:	16512e23          	sw	t0,380(sp)
     f90:	2a4000ef          	jal	ra,1234 <ISR5_uart>
     f94:	30047073          	csrci	mstatus,8
     f98:	17c12283          	lw	t0,380(sp)
     f9c:	34129073          	csrw	mepc,t0
     fa0:	10012083          	lw	ra,256(sp)
     fa4:	10c12203          	lw	tp,268(sp)
     fa8:	11012283          	lw	t0,272(sp)
     fac:	11412303          	lw	t1,276(sp)
     fb0:	11812383          	lw	t2,280(sp)
     fb4:	11c12403          	lw	s0,284(sp)
     fb8:	12012483          	lw	s1,288(sp)
     fbc:	12412503          	lw	a0,292(sp)
     fc0:	12812583          	lw	a1,296(sp)
     fc4:	12c12603          	lw	a2,300(sp)
     fc8:	13012683          	lw	a3,304(sp)
     fcc:	13412703          	lw	a4,308(sp)
     fd0:	13812783          	lw	a5,312(sp)
     fd4:	13c12803          	lw	a6,316(sp)
     fd8:	14012883          	lw	a7,320(sp)
     fdc:	14412903          	lw	s2,324(sp)
     fe0:	14812983          	lw	s3,328(sp)
     fe4:	14c12a03          	lw	s4,332(sp)
     fe8:	15012a83          	lw	s5,336(sp)
     fec:	15412b03          	lw	s6,340(sp)
     ff0:	15812b83          	lw	s7,344(sp)
     ff4:	15c12c03          	lw	s8,348(sp)
     ff8:	16012c83          	lw	s9,352(sp)
     ffc:	16412d03          	lw	s10,356(sp)
    1000:	16812d83          	lw	s11,360(sp)
    1004:	16c12e03          	lw	t3,364(sp)
    1008:	17012e83          	lw	t4,368(sp)
    100c:	17412f03          	lw	t5,372(sp)
    1010:	17812f83          	lw	t6,376(sp)
    1014:	18010113          	addi	sp,sp,384
    1018:	30046073          	csrsi	mstatus,8
    101c:	30200073          	mret

00001020 <ISR6>:
    1020:	30047073          	csrci	mstatus,8
    1024:	e8010113          	addi	sp,sp,-384
    1028:	10112023          	sw	ra,256(sp)
    102c:	10212223          	sw	sp,260(sp)
    1030:	10312423          	sw	gp,264(sp)
    1034:	10412623          	sw	tp,268(sp)
    1038:	10512823          	sw	t0,272(sp)
    103c:	10612a23          	sw	t1,276(sp)
    1040:	10712c23          	sw	t2,280(sp)
    1044:	10812e23          	sw	s0,284(sp)
    1048:	12912023          	sw	s1,288(sp)
    104c:	12a12223          	sw	a0,292(sp)
    1050:	12b12423          	sw	a1,296(sp)
    1054:	12c12623          	sw	a2,300(sp)
    1058:	12d12823          	sw	a3,304(sp)
    105c:	12e12a23          	sw	a4,308(sp)
    1060:	12f12c23          	sw	a5,312(sp)
    1064:	13012e23          	sw	a6,316(sp)
    1068:	15112023          	sw	a7,320(sp)
    106c:	15212223          	sw	s2,324(sp)
    1070:	15312423          	sw	s3,328(sp)
    1074:	15412623          	sw	s4,332(sp)
    1078:	15512823          	sw	s5,336(sp)
    107c:	15612a23          	sw	s6,340(sp)
    1080:	15712c23          	sw	s7,344(sp)
    1084:	15812e23          	sw	s8,348(sp)
    1088:	17912023          	sw	s9,352(sp)
    108c:	17a12223          	sw	s10,356(sp)
    1090:	17b12423          	sw	s11,360(sp)
    1094:	17c12623          	sw	t3,364(sp)
    1098:	17d12823          	sw	t4,368(sp)
    109c:	17e12a23          	sw	t5,372(sp)
    10a0:	17f12c23          	sw	t6,376(sp)
    10a4:	341022f3          	csrr	t0,mepc
    10a8:	16512e23          	sw	t0,380(sp)
    10ac:	30c000ef          	jal	ra,13b8 <ISR6_addr_exception>
    10b0:	30047073          	csrci	mstatus,8
    10b4:	17c12283          	lw	t0,380(sp)
    10b8:	34129073          	csrw	mepc,t0
    10bc:	10012083          	lw	ra,256(sp)
    10c0:	10c12203          	lw	tp,268(sp)
    10c4:	11012283          	lw	t0,272(sp)
    10c8:	11412303          	lw	t1,276(sp)
    10cc:	11812383          	lw	t2,280(sp)
    10d0:	11c12403          	lw	s0,284(sp)
    10d4:	12012483          	lw	s1,288(sp)
    10d8:	12412503          	lw	a0,292(sp)
    10dc:	12812583          	lw	a1,296(sp)
    10e0:	12c12603          	lw	a2,300(sp)
    10e4:	13012683          	lw	a3,304(sp)
    10e8:	13412703          	lw	a4,308(sp)
    10ec:	13812783          	lw	a5,312(sp)
    10f0:	13c12803          	lw	a6,316(sp)
    10f4:	14012883          	lw	a7,320(sp)
    10f8:	14412903          	lw	s2,324(sp)
    10fc:	14812983          	lw	s3,328(sp)
    1100:	14c12a03          	lw	s4,332(sp)
    1104:	15012a83          	lw	s5,336(sp)
    1108:	15412b03          	lw	s6,340(sp)
    110c:	15812b83          	lw	s7,344(sp)
    1110:	15c12c03          	lw	s8,348(sp)
    1114:	16012c83          	lw	s9,352(sp)
    1118:	16412d03          	lw	s10,356(sp)
    111c:	16812d83          	lw	s11,360(sp)
    1120:	16c12e03          	lw	t3,364(sp)
    1124:	17012e83          	lw	t4,368(sp)
    1128:	17412f03          	lw	t5,372(sp)
    112c:	17812f83          	lw	t6,376(sp)
    1130:	18010113          	addi	sp,sp,384
    1134:	30046073          	csrsi	mstatus,8
    1138:	30200073          	mret

0000113c <main>:
    113c:	fd010113          	addi	sp,sp,-48
    1140:	02112623          	sw	ra,44(sp)
    1144:	02812423          	sw	s0,40(sp)
    1148:	03010413          	addi	s0,sp,48
    114c:	fca42e23          	sw	a0,-36(s0)
    1150:	fcb42c23          	sw	a1,-40(s0)
    1154:	00100593          	li	a1,1
    1158:	0000e7b7          	lui	a5,0xe
    115c:	10078513          	addi	a0,a5,256 # e100 <__stack_init+0xcd2c>
    1160:	fd1fe0ef          	jal	ra,130 <UART_init>
    1164:	04300513          	li	a0,67
    1168:	9f0ff0ef          	jal	ra,358 <UARTCharPut>
    116c:	04e00513          	li	a0,78
    1170:	9e8ff0ef          	jal	ra,358 <UARTCharPut>
    1174:	04e00513          	li	a0,78
    1178:	9e0ff0ef          	jal	ra,358 <UARTCharPut>
    117c:	bb41a783          	lw	a5,-1100(gp) # 20cf8 <pflag>
    1180:	fe078ee3          	beqz	a5,117c <main+0x40>
    1184:	01000793          	li	a5,16
    1188:	00100737          	lui	a4,0x100
    118c:	24070713          	addi	a4,a4,576 # 100240 <bias>
    1190:	01c00693          	li	a3,28
    1194:	00100637          	lui	a2,0x100
    1198:	00060613          	mv	a2,a2
    119c:	000215b7          	lui	a1,0x21
    11a0:	d0458593          	addi	a1,a1,-764 # 20d04 <img_buf>
    11a4:	0010d537          	lui	a0,0x10d
    11a8:	84050513          	addi	a0,a0,-1984 # 10c840 <Y>
    11ac:	825ff0ef          	jal	ra,9d0 <conv2d>
    11b0:	01000813          	li	a6,16
    11b4:	02000793          	li	a5,32
    11b8:	00105737          	lui	a4,0x105
    11bc:	a8070713          	addi	a4,a4,-1408 # 104a80 <bias2>
    11c0:	00d00693          	li	a3,13
    11c4:	00100637          	lui	a2,0x100
    11c8:	28060613          	addi	a2,a2,640 # 100280 <ker2>
    11cc:	0010d5b7          	lui	a1,0x10d
    11d0:	84058593          	addi	a1,a1,-1984 # 10c840 <Y>
    11d4:	0010f537          	lui	a0,0x10f
    11d8:	28050513          	addi	a0,a0,640 # 10f280 <Y2>
    11dc:	a35ff0ef          	jal	ra,c10 <layer2>
    11e0:	fe042623          	sw	zero,-20(s0)
    11e4:	00a00793          	li	a5,10
    11e8:	0010d737          	lui	a4,0x10d
    11ec:	80070713          	addi	a4,a4,-2048 # 10c800 <bias3>
    11f0:	32000693          	li	a3,800
    11f4:	00105637          	lui	a2,0x105
    11f8:	b0060613          	addi	a2,a2,-1280 # 104b00 <w3>
    11fc:	0010f5b7          	lui	a1,0x10f
    1200:	28058593          	addi	a1,a1,640 # 10f280 <Y2>
    1204:	fec42503          	lw	a0,-20(s0)
    1208:	be5ff0ef          	jal	ra,dec <layer3>
    120c:	00050713          	mv	a4,a0
    1210:	bae1ae23          	sw	a4,-1092(gp) # 20d00 <digit_classified>
    1214:	bbc1a783          	lw	a5,-1092(gp) # 20d00 <digit_classified>
    1218:	0ff7f793          	andi	a5,a5,255
    121c:	03078793          	addi	a5,a5,48
    1220:	0ff7f793          	andi	a5,a5,255
    1224:	00078513          	mv	a0,a5
    1228:	930ff0ef          	jal	ra,358 <UARTCharPut>
    122c:	ba01aa23          	sw	zero,-1100(gp) # 20cf8 <pflag>
    1230:	f4dff06f          	j	117c <main+0x40>

00001234 <ISR5_uart>:
    1234:	ff010113          	addi	sp,sp,-16
    1238:	00112623          	sw	ra,12(sp)
    123c:	00812423          	sw	s0,8(sp)
    1240:	01010413          	addi	s0,sp,16
    1244:	5f1007b7          	lui	a5,0x5f100
    1248:	6f078793          	addi	a5,a5,1776 # 5f1006f0 <__VREG_END+0x5ef806f0>
    124c:	0007c783          	lbu	a5,0(a5)
    1250:	0ff7f713          	andi	a4,a5,255
    1254:	bae18823          	sb	a4,-1104(gp) # 20cf4 <read_val>
    1258:	bb01c783          	lbu	a5,-1104(gp) # 20cf4 <read_val>
    125c:	00078513          	mv	a0,a5
    1260:	8f8ff0ef          	jal	ra,358 <UARTCharPut>
    1264:	ba81a783          	lw	a5,-1112(gp) # 20cec <recv_counter>
    1268:	00178713          	addi	a4,a5,1
    126c:	bae1a423          	sw	a4,-1112(gp) # 20cec <recv_counter>
    1270:	bb91c783          	lbu	a5,-1095(gp) # 20cfd <start_read>
    1274:	0c079a63          	bnez	a5,1348 <ISR5_uart+0x114>
    1278:	bb81c783          	lbu	a5,-1096(gp) # 20cfc <header_count>
    127c:	02079663          	bnez	a5,12a8 <ISR5_uart+0x74>
    1280:	bb01c703          	lbu	a4,-1104(gp) # 20cf4 <read_val>
    1284:	0aa00793          	li	a5,170
    1288:	00f71a63          	bne	a4,a5,129c <ISR5_uart+0x68>
    128c:	00100713          	li	a4,1
    1290:	bae18c23          	sb	a4,-1096(gp) # 20cfc <header_count>
    1294:	ba018ca3          	sb	zero,-1095(gp) # 20cfd <start_read>
    1298:	0e00006f          	j	1378 <ISR5_uart+0x144>
    129c:	ba018c23          	sb	zero,-1096(gp) # 20cfc <header_count>
    12a0:	ba018ca3          	sb	zero,-1095(gp) # 20cfd <start_read>
    12a4:	0d40006f          	j	1378 <ISR5_uart+0x144>
    12a8:	bb81c703          	lbu	a4,-1096(gp) # 20cfc <header_count>
    12ac:	00100793          	li	a5,1
    12b0:	02f71663          	bne	a4,a5,12dc <ISR5_uart+0xa8>
    12b4:	bb01c703          	lbu	a4,-1104(gp) # 20cf4 <read_val>
    12b8:	05500793          	li	a5,85
    12bc:	00f71a63          	bne	a4,a5,12d0 <ISR5_uart+0x9c>
    12c0:	00200713          	li	a4,2
    12c4:	bae18c23          	sb	a4,-1096(gp) # 20cfc <header_count>
    12c8:	ba018ca3          	sb	zero,-1095(gp) # 20cfd <start_read>
    12cc:	0ac0006f          	j	1378 <ISR5_uart+0x144>
    12d0:	ba018c23          	sb	zero,-1096(gp) # 20cfc <header_count>
    12d4:	ba018ca3          	sb	zero,-1095(gp) # 20cfd <start_read>
    12d8:	0a00006f          	j	1378 <ISR5_uart+0x144>
    12dc:	bb81c703          	lbu	a4,-1096(gp) # 20cfc <header_count>
    12e0:	00200793          	li	a5,2
    12e4:	02f71663          	bne	a4,a5,1310 <ISR5_uart+0xdc>
    12e8:	bb01c703          	lbu	a4,-1104(gp) # 20cf4 <read_val>
    12ec:	0bb00793          	li	a5,187
    12f0:	00f71a63          	bne	a4,a5,1304 <ISR5_uart+0xd0>
    12f4:	00300713          	li	a4,3
    12f8:	bae18c23          	sb	a4,-1096(gp) # 20cfc <header_count>
    12fc:	ba018ca3          	sb	zero,-1095(gp) # 20cfd <start_read>
    1300:	0780006f          	j	1378 <ISR5_uart+0x144>
    1304:	ba018c23          	sb	zero,-1096(gp) # 20cfc <header_count>
    1308:	ba018ca3          	sb	zero,-1095(gp) # 20cfd <start_read>
    130c:	06c0006f          	j	1378 <ISR5_uart+0x144>
    1310:	bb81c703          	lbu	a4,-1096(gp) # 20cfc <header_count>
    1314:	00300793          	li	a5,3
    1318:	06f71063          	bne	a4,a5,1378 <ISR5_uart+0x144>
    131c:	bb01c703          	lbu	a4,-1104(gp) # 20cf4 <read_val>
    1320:	06600793          	li	a5,102
    1324:	00f71c63          	bne	a4,a5,133c <ISR5_uart+0x108>
    1328:	00400713          	li	a4,4
    132c:	bae18c23          	sb	a4,-1096(gp) # 20cfc <header_count>
    1330:	00100713          	li	a4,1
    1334:	bae18ca3          	sb	a4,-1095(gp) # 20cfd <start_read>
    1338:	0400006f          	j	1378 <ISR5_uart+0x144>
    133c:	ba018c23          	sb	zero,-1096(gp) # 20cfc <header_count>
    1340:	ba018ca3          	sb	zero,-1095(gp) # 20cfd <start_read>
    1344:	0340006f          	j	1378 <ISR5_uart+0x144>
    1348:	bb01c783          	lbu	a5,-1104(gp) # 20cf4 <read_val>
    134c:	00078713          	mv	a4,a5
    1350:	bac1a783          	lw	a5,-1108(gp) # 20cf0 <recv_num_counter>
    1354:	01071713          	slli	a4,a4,0x10
    1358:	000216b7          	lui	a3,0x21
    135c:	d0468693          	addi	a3,a3,-764 # 20d04 <img_buf>
    1360:	00279793          	slli	a5,a5,0x2
    1364:	00f687b3          	add	a5,a3,a5
    1368:	00e7a023          	sw	a4,0(a5)
    136c:	bac1a783          	lw	a5,-1108(gp) # 20cf0 <recv_num_counter>
    1370:	00178713          	addi	a4,a5,1
    1374:	bae1a623          	sw	a4,-1108(gp) # 20cf0 <recv_num_counter>
    1378:	bac1a703          	lw	a4,-1108(gp) # 20cf0 <recv_num_counter>
    137c:	31000793          	li	a5,784
    1380:	02f71063          	bne	a4,a5,13a0 <ISR5_uart+0x16c>
    1384:	00100713          	li	a4,1
    1388:	bae1aa23          	sw	a4,-1100(gp) # 20cf8 <pflag>
    138c:	ba01a623          	sw	zero,-1108(gp) # 20cf0 <recv_num_counter>
    1390:	ba01a423          	sw	zero,-1112(gp) # 20cec <recv_counter>
    1394:	ba018ca3          	sb	zero,-1095(gp) # 20cfd <start_read>
    1398:	ba018c23          	sb	zero,-1096(gp) # 20cfc <header_count>
    139c:	0080006f          	j	13a4 <ISR5_uart+0x170>
    13a0:	ba01aa23          	sw	zero,-1100(gp) # 20cf8 <pflag>
    13a4:	00000013          	nop
    13a8:	00c12083          	lw	ra,12(sp)
    13ac:	00812403          	lw	s0,8(sp)
    13b0:	01010113          	addi	sp,sp,16
    13b4:	00008067          	ret

000013b8 <ISR6_addr_exception>:
    13b8:	ff010113          	addi	sp,sp,-16
    13bc:	00812623          	sw	s0,12(sp)
    13c0:	01010413          	addi	s0,sp,16
    13c4:	00000013          	nop
    13c8:	00c12403          	lw	s0,12(sp)
    13cc:	01010113          	addi	sp,sp,16
    13d0:	00008067          	ret

000013d4 <__stack_init>:
    13d4:	000feffc                                ....
