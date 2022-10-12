
riscv-spike.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <boot>:
   0:	00002fb7          	lui	t6,0x2
   4:	800f8f93          	addi	t6,t6,-2048 # 1800 <__stack_init+0x1224>
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
  e8:	3ac000ef          	jal	ra,494 <main>
  ec:	0000006f          	j	ec <_mstart+0xac>
  f0:	00008067          	ret

000000f4 <trap_entry>:
  f4:	1680006f          	j	25c <ISR5>
  f8:	30200073          	mret
  fc:	1600006f          	j	25c <ISR5>
 100:	30200073          	mret
 104:	1580006f          	j	25c <ISR5>
 108:	30200073          	mret
 10c:	1500006f          	j	25c <ISR5>
 110:	30200073          	mret
 114:	1480006f          	j	25c <ISR5>
 118:	30200073          	mret
 11c:	25c0006f          	j	378 <ISR6>
 120:	30200073          	mret
	...

00000130 <matmul64>:
 130:	fd410113          	addi	sp,sp,-44
 134:	00812023          	sw	s0,0(sp)
 138:	00912223          	sw	s1,4(sp)
 13c:	01212423          	sw	s2,8(sp)
 140:	01312623          	sw	s3,12(sp)
 144:	01412823          	sw	s4,16(sp)
 148:	01512a23          	sw	s5,20(sp)
 14c:	01612c23          	sw	s6,24(sp)
 150:	01712e23          	sw	s7,28(sp)
 154:	03812023          	sw	s8,32(sp)
 158:	03912223          	sw	s9,36(sp)
 15c:	03a12423          	sw	s10,40(sp)
 160:	00300293          	li	t0,3
 164:	00a2b073          	csrc	vxrm,t0
 168:	0126fe57          	vsetvli	t3,a3,e32,m4,tu,mu
 16c:	0026d813          	srli	a6,a3,0x2
 170:	96006057          	vmul.vx	v0,v0,zero
 174:	96806457          	vmul.vx	v8,v8,zero
 178:	96806857          	vmul.vx	v16,v8,zero
 17c:	96c06c57          	vmul.vx	v24,v12,zero
 180:	96006057          	vmul.vx	v0,v0,zero
 184:	96806457          	vmul.vx	v8,v8,zero
 188:	97006857          	vmul.vx	v16,v16,zero
 18c:	97806c57          	vmul.vx	v24,v24,zero
 190:	00000293          	li	t0,0

00000194 <OUTER_LOOP>:
 194:	00000313          	li	t1,0
 198:	00829e13          	slli	t3,t0,0x8
 19c:	01c58733          	add	a4,a1,t3
 1a0:	00060793          	mv	a5,a2

000001a4 <INNER_LOOP>:
 1a4:	10000e13          	li	t3,256
 1a8:	01c784b3          	add	s1,a5,t3
 1ac:	01c48933          	add	s2,s1,t3
 1b0:	01c909b3          	add	s3,s2,t3
 1b4:	00072a03          	lw	s4,0(a4)
 1b8:	00472a83          	lw	s5,4(a4)
 1bc:	00872b03          	lw	s6,8(a4)
 1c0:	00c72b83          	lw	s7,12(a4)
 1c4:	0207e407          	vle32.v	v8,(a5)
 1c8:	0204e807          	vle32.v	v16,(s1)
 1cc:	b68a6c57          	vmacc.vx	v24,s4,v8
 1d0:	b70aec57          	vmacc.vx	v24,s5,v16
 1d4:	02096407          	vle32.v	v8,(s2)
 1d8:	0209e807          	vle32.v	v16,(s3)
 1dc:	b68b6c57          	vmacc.vx	v24,s6,v8
 1e0:	b70bec57          	vmacc.vx	v24,s7,v16
 1e4:	40000e13          	li	t3,1024
 1e8:	01c787b3          	add	a5,a5,t3
 1ec:	01000e13          	li	t3,16
 1f0:	01c70733          	add	a4,a4,t3
 1f4:	00130313          	addi	t1,t1,1
 1f8:	fb0316e3          	bne	t1,a6,1a4 <INNER_LOOP>
 1fc:	02056c27          	vse32.v	v24,(a0)
 200:	96806457          	vmul.vx	v8,v8,zero
 204:	97006857          	vmul.vx	v16,v16,zero
 208:	97806c57          	vmul.vx	v24,v24,zero
 20c:	97006857          	vmul.vx	v16,v16,zero
 210:	97806c57          	vmul.vx	v24,v24,zero
 214:	97006857          	vmul.vx	v16,v16,zero
 218:	97806c57          	vmul.vx	v24,v24,zero
 21c:	10050513          	addi	a0,a0,256
 220:	00128293          	addi	t0,t0,1
 224:	f6d298e3          	bne	t0,a3,194 <OUTER_LOOP>
 228:	00012403          	lw	s0,0(sp)
 22c:	00412483          	lw	s1,4(sp)
 230:	00812903          	lw	s2,8(sp)
 234:	00c12983          	lw	s3,12(sp)
 238:	01012a03          	lw	s4,16(sp)
 23c:	01412a83          	lw	s5,20(sp)
 240:	01812b03          	lw	s6,24(sp)
 244:	01c12b83          	lw	s7,28(sp)
 248:	02012c03          	lw	s8,32(sp)
 24c:	02412c83          	lw	s9,36(sp)
 250:	02812d03          	lw	s10,40(sp)
 254:	02c10113          	addi	sp,sp,44
 258:	00008067          	ret

0000025c <ISR5>:
 25c:	30047073          	csrci	mstatus,8
 260:	e8010113          	addi	sp,sp,-384
 264:	10112023          	sw	ra,256(sp)
 268:	10212223          	sw	sp,260(sp)
 26c:	10312423          	sw	gp,264(sp)
 270:	10412623          	sw	tp,268(sp)
 274:	10512823          	sw	t0,272(sp)
 278:	10612a23          	sw	t1,276(sp)
 27c:	10712c23          	sw	t2,280(sp)
 280:	10812e23          	sw	s0,284(sp)
 284:	12912023          	sw	s1,288(sp)
 288:	12a12223          	sw	a0,292(sp)
 28c:	12b12423          	sw	a1,296(sp)
 290:	12c12623          	sw	a2,300(sp)
 294:	12d12823          	sw	a3,304(sp)
 298:	12e12a23          	sw	a4,308(sp)
 29c:	12f12c23          	sw	a5,312(sp)
 2a0:	13012e23          	sw	a6,316(sp)
 2a4:	15112023          	sw	a7,320(sp)
 2a8:	15212223          	sw	s2,324(sp)
 2ac:	15312423          	sw	s3,328(sp)
 2b0:	15412623          	sw	s4,332(sp)
 2b4:	15512823          	sw	s5,336(sp)
 2b8:	15612a23          	sw	s6,340(sp)
 2bc:	15712c23          	sw	s7,344(sp)
 2c0:	15812e23          	sw	s8,348(sp)
 2c4:	17912023          	sw	s9,352(sp)
 2c8:	17a12223          	sw	s10,356(sp)
 2cc:	17b12423          	sw	s11,360(sp)
 2d0:	17c12623          	sw	t3,364(sp)
 2d4:	17d12823          	sw	t4,368(sp)
 2d8:	17e12a23          	sw	t5,372(sp)
 2dc:	17f12c23          	sw	t6,376(sp)
 2e0:	341022f3          	csrr	t0,mepc
 2e4:	16512e23          	sw	t0,380(sp)
 2e8:	2bc000ef          	jal	ra,5a4 <ISR5_uart>
 2ec:	30047073          	csrci	mstatus,8
 2f0:	17c12283          	lw	t0,380(sp)
 2f4:	34129073          	csrw	mepc,t0
 2f8:	10012083          	lw	ra,256(sp)
 2fc:	10c12203          	lw	tp,268(sp)
 300:	11012283          	lw	t0,272(sp)
 304:	11412303          	lw	t1,276(sp)
 308:	11812383          	lw	t2,280(sp)
 30c:	11c12403          	lw	s0,284(sp)
 310:	12012483          	lw	s1,288(sp)
 314:	12412503          	lw	a0,292(sp)
 318:	12812583          	lw	a1,296(sp)
 31c:	12c12603          	lw	a2,300(sp)
 320:	13012683          	lw	a3,304(sp)
 324:	13412703          	lw	a4,308(sp)
 328:	13812783          	lw	a5,312(sp)
 32c:	13c12803          	lw	a6,316(sp)
 330:	14012883          	lw	a7,320(sp)
 334:	14412903          	lw	s2,324(sp)
 338:	14812983          	lw	s3,328(sp)
 33c:	14c12a03          	lw	s4,332(sp)
 340:	15012a83          	lw	s5,336(sp)
 344:	15412b03          	lw	s6,340(sp)
 348:	15812b83          	lw	s7,344(sp)
 34c:	15c12c03          	lw	s8,348(sp)
 350:	16012c83          	lw	s9,352(sp)
 354:	16412d03          	lw	s10,356(sp)
 358:	16812d83          	lw	s11,360(sp)
 35c:	16c12e03          	lw	t3,364(sp)
 360:	17012e83          	lw	t4,368(sp)
 364:	17412f03          	lw	t5,372(sp)
 368:	17812f83          	lw	t6,376(sp)
 36c:	18010113          	addi	sp,sp,384
 370:	30046073          	csrsi	mstatus,8
 374:	30200073          	mret

00000378 <ISR6>:
 378:	30047073          	csrci	mstatus,8
 37c:	e8010113          	addi	sp,sp,-384
 380:	10112023          	sw	ra,256(sp)
 384:	10212223          	sw	sp,260(sp)
 388:	10312423          	sw	gp,264(sp)
 38c:	10412623          	sw	tp,268(sp)
 390:	10512823          	sw	t0,272(sp)
 394:	10612a23          	sw	t1,276(sp)
 398:	10712c23          	sw	t2,280(sp)
 39c:	10812e23          	sw	s0,284(sp)
 3a0:	12912023          	sw	s1,288(sp)
 3a4:	12a12223          	sw	a0,292(sp)
 3a8:	12b12423          	sw	a1,296(sp)
 3ac:	12c12623          	sw	a2,300(sp)
 3b0:	12d12823          	sw	a3,304(sp)
 3b4:	12e12a23          	sw	a4,308(sp)
 3b8:	12f12c23          	sw	a5,312(sp)
 3bc:	13012e23          	sw	a6,316(sp)
 3c0:	15112023          	sw	a7,320(sp)
 3c4:	15212223          	sw	s2,324(sp)
 3c8:	15312423          	sw	s3,328(sp)
 3cc:	15412623          	sw	s4,332(sp)
 3d0:	15512823          	sw	s5,336(sp)
 3d4:	15612a23          	sw	s6,340(sp)
 3d8:	15712c23          	sw	s7,344(sp)
 3dc:	15812e23          	sw	s8,348(sp)
 3e0:	17912023          	sw	s9,352(sp)
 3e4:	17a12223          	sw	s10,356(sp)
 3e8:	17b12423          	sw	s11,360(sp)
 3ec:	17c12623          	sw	t3,364(sp)
 3f0:	17d12823          	sw	t4,368(sp)
 3f4:	17e12a23          	sw	t5,372(sp)
 3f8:	17f12c23          	sw	t6,376(sp)
 3fc:	341022f3          	csrr	t0,mepc
 400:	16512e23          	sw	t0,380(sp)
 404:	1bc000ef          	jal	ra,5c0 <ISR6_addr_exception>
 408:	30047073          	csrci	mstatus,8
 40c:	17c12283          	lw	t0,380(sp)
 410:	34129073          	csrw	mepc,t0
 414:	10012083          	lw	ra,256(sp)
 418:	10c12203          	lw	tp,268(sp)
 41c:	11012283          	lw	t0,272(sp)
 420:	11412303          	lw	t1,276(sp)
 424:	11812383          	lw	t2,280(sp)
 428:	11c12403          	lw	s0,284(sp)
 42c:	12012483          	lw	s1,288(sp)
 430:	12412503          	lw	a0,292(sp)
 434:	12812583          	lw	a1,296(sp)
 438:	12c12603          	lw	a2,300(sp)
 43c:	13012683          	lw	a3,304(sp)
 440:	13412703          	lw	a4,308(sp)
 444:	13812783          	lw	a5,312(sp)
 448:	13c12803          	lw	a6,316(sp)
 44c:	14012883          	lw	a7,320(sp)
 450:	14412903          	lw	s2,324(sp)
 454:	14812983          	lw	s3,328(sp)
 458:	14c12a03          	lw	s4,332(sp)
 45c:	15012a83          	lw	s5,336(sp)
 460:	15412b03          	lw	s6,340(sp)
 464:	15812b83          	lw	s7,344(sp)
 468:	15c12c03          	lw	s8,348(sp)
 46c:	16012c83          	lw	s9,352(sp)
 470:	16412d03          	lw	s10,356(sp)
 474:	16812d83          	lw	s11,360(sp)
 478:	16c12e03          	lw	t3,364(sp)
 47c:	17012e83          	lw	t4,368(sp)
 480:	17412f03          	lw	t5,372(sp)
 484:	17812f83          	lw	t6,376(sp)
 488:	18010113          	addi	sp,sp,384
 48c:	30046073          	csrsi	mstatus,8
 490:	30200073          	mret

00000494 <main>:
 494:	fd010113          	addi	sp,sp,-48
 498:	02112623          	sw	ra,44(sp)
 49c:	02812423          	sw	s0,40(sp)
 4a0:	03010413          	addi	s0,sp,48
 4a4:	fca42e23          	sw	a0,-36(s0)
 4a8:	fcb42c23          	sw	a1,-40(s0)
 4ac:	04000693          	li	a3,64
 4b0:	001047b7          	lui	a5,0x104
 4b4:	00078613          	mv	a2,a5
 4b8:	001007b7          	lui	a5,0x100
 4bc:	00078593          	mv	a1,a5
 4c0:	0010c7b7          	lui	a5,0x10c
 4c4:	00078513          	mv	a0,a5
 4c8:	c69ff0ef          	jal	ra,130 <matmul64>
 4cc:	00a00793          	li	a5,10
 4d0:	fef42423          	sw	a5,-24(s0)
 4d4:	001107b7          	lui	a5,0x110
 4d8:	0007a023          	sw	zero,0(a5) # 110000 <err_count>
 4dc:	fe042623          	sw	zero,-20(s0)
 4e0:	0a00006f          	j	580 <main+0xec>
 4e4:	0010c7b7          	lui	a5,0x10c
 4e8:	00078713          	mv	a4,a5
 4ec:	fec42783          	lw	a5,-20(s0)
 4f0:	00279793          	slli	a5,a5,0x2
 4f4:	00f707b3          	add	a5,a4,a5
 4f8:	0007a703          	lw	a4,0(a5) # 10c000 <y_mat>
 4fc:	001087b7          	lui	a5,0x108
 500:	00078693          	mv	a3,a5
 504:	fec42783          	lw	a5,-20(s0)
 508:	00279793          	slli	a5,a5,0x2
 50c:	00f687b3          	add	a5,a3,a5
 510:	0007a783          	lw	a5,0(a5) # 108000 <expected_output>
 514:	40f707b3          	sub	a5,a4,a5
 518:	fe842703          	lw	a4,-24(s0)
 51c:	04f74263          	blt	a4,a5,560 <main+0xcc>
 520:	0010c7b7          	lui	a5,0x10c
 524:	00078713          	mv	a4,a5
 528:	fec42783          	lw	a5,-20(s0)
 52c:	00279793          	slli	a5,a5,0x2
 530:	00f707b3          	add	a5,a4,a5
 534:	0007a703          	lw	a4,0(a5) # 10c000 <y_mat>
 538:	001087b7          	lui	a5,0x108
 53c:	00078693          	mv	a3,a5
 540:	fec42783          	lw	a5,-20(s0)
 544:	00279793          	slli	a5,a5,0x2
 548:	00f687b3          	add	a5,a3,a5
 54c:	0007a783          	lw	a5,0(a5) # 108000 <expected_output>
 550:	40f70733          	sub	a4,a4,a5
 554:	fe842783          	lw	a5,-24(s0)
 558:	40f007b3          	neg	a5,a5
 55c:	00f75c63          	bge	a4,a5,574 <main+0xe0>
 560:	001107b7          	lui	a5,0x110
 564:	0007a783          	lw	a5,0(a5) # 110000 <err_count>
 568:	00178713          	addi	a4,a5,1
 56c:	001107b7          	lui	a5,0x110
 570:	00e7a023          	sw	a4,0(a5) # 110000 <err_count>
 574:	fec42783          	lw	a5,-20(s0)
 578:	00178793          	addi	a5,a5,1
 57c:	fef42623          	sw	a5,-20(s0)
 580:	fec42703          	lw	a4,-20(s0)
 584:	000017b7          	lui	a5,0x1
 588:	f4f74ee3          	blt	a4,a5,4e4 <main+0x50>
 58c:	00000793          	li	a5,0
 590:	00078513          	mv	a0,a5
 594:	02c12083          	lw	ra,44(sp)
 598:	02812403          	lw	s0,40(sp)
 59c:	03010113          	addi	sp,sp,48
 5a0:	00008067          	ret

000005a4 <ISR5_uart>:
 5a4:	ff010113          	addi	sp,sp,-16
 5a8:	00812623          	sw	s0,12(sp)
 5ac:	01010413          	addi	s0,sp,16
 5b0:	00000013          	nop
 5b4:	00c12403          	lw	s0,12(sp)
 5b8:	01010113          	addi	sp,sp,16
 5bc:	00008067          	ret

000005c0 <ISR6_addr_exception>:
 5c0:	ff010113          	addi	sp,sp,-16
 5c4:	00812623          	sw	s0,12(sp)
 5c8:	01010413          	addi	s0,sp,16
 5cc:	00000013          	nop
 5d0:	00c12403          	lw	s0,12(sp)
 5d4:	01010113          	addi	sp,sp,16
 5d8:	00008067          	ret

000005dc <__stack_init>:
 5dc:	000feffc                                ....
