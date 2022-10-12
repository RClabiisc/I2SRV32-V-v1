
riscv-spike.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <boot>:
   0:	00002fb7          	lui	t6,0x2
   4:	800f8f93          	addi	t6,t6,-2048 # 1800 <__stack_init+0x121c>
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
  e8:	3b4000ef          	jal	ra,49c <main>
  ec:	0000006f          	j	ec <_mstart+0xac>
  f0:	00008067          	ret

000000f4 <trap_entry>:
  f4:	1700006f          	j	264 <ISR5>
  f8:	30200073          	mret
  fc:	1680006f          	j	264 <ISR5>
 100:	30200073          	mret
 104:	1600006f          	j	264 <ISR5>
 108:	30200073          	mret
 10c:	1580006f          	j	264 <ISR5>
 110:	30200073          	mret
 114:	1500006f          	j	264 <ISR5>
 118:	30200073          	mret
 11c:	2640006f          	j	380 <ISR6>
 120:	30200073          	mret
	...

00000130 <matmul>:
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
 174:	96406257          	vmul.vx	v4,v4,zero
 178:	96806457          	vmul.vx	v8,v8,zero
 17c:	96c06657          	vmul.vx	v12,v12,zero
 180:	97006857          	vmul.vx	v16,v16,zero
 184:	97406a57          	vmul.vx	v20,v20,zero
 188:	97806c57          	vmul.vx	v24,v24,zero
 18c:	97c06e57          	vmul.vx	v28,v28,zero
 190:	00000293          	li	t0,0

00000194 <OUTER_LOOP>:
 194:	00000313          	li	t1,0
 198:	00269e93          	slli	t4,a3,0x2
 19c:	03d28e33          	mul	t3,t0,t4
 1a0:	01c58733          	add	a4,a1,t3
 1a4:	00060793          	mv	a5,a2

000001a8 <INNER_LOOP>:
 1a8:	00269e13          	slli	t3,a3,0x2
 1ac:	01c784b3          	add	s1,a5,t3
 1b0:	01c48933          	add	s2,s1,t3
 1b4:	01c909b3          	add	s3,s2,t3
 1b8:	00072a03          	lw	s4,0(a4)
 1bc:	00472a83          	lw	s5,4(a4)
 1c0:	00872b03          	lw	s6,8(a4)
 1c4:	00c72b83          	lw	s7,12(a4)
 1c8:	0207e207          	vle32.v	v4,(a5)
 1cc:	0204e407          	vle32.v	v8,(s1)
 1d0:	02096607          	vle32.v	v12,(s2)
 1d4:	0209e807          	vle32.v	v16,(s3)
 1d8:	b64a6a57          	vmacc.vx	v20,s4,v4
 1dc:	b68aea57          	vmacc.vx	v20,s5,v8
 1e0:	b6cb6a57          	vmacc.vx	v20,s6,v12
 1e4:	b70bea57          	vmacc.vx	v20,s7,v16
 1e8:	00469e13          	slli	t3,a3,0x4
 1ec:	01c787b3          	add	a5,a5,t3
 1f0:	01000e13          	li	t3,16
 1f4:	01c70733          	add	a4,a4,t3
 1f8:	00130313          	addi	t1,t1,1
 1fc:	fb0316e3          	bne	t1,a6,1a8 <INNER_LOOP>
 200:	02056a27          	vse32.v	v20,(a0)
 204:	96406257          	vmul.vx	v4,v4,zero
 208:	96806457          	vmul.vx	v8,v8,zero
 20c:	96c06657          	vmul.vx	v12,v12,zero
 210:	97006857          	vmul.vx	v16,v16,zero
 214:	97406a57          	vmul.vx	v20,v20,zero
 218:	97806c57          	vmul.vx	v24,v24,zero
 21c:	97c06e57          	vmul.vx	v28,v28,zero
 220:	00269e13          	slli	t3,a3,0x2
 224:	01c50533          	add	a0,a0,t3
 228:	00128293          	addi	t0,t0,1
 22c:	f6d294e3          	bne	t0,a3,194 <OUTER_LOOP>
 230:	00012403          	lw	s0,0(sp)
 234:	00412483          	lw	s1,4(sp)
 238:	00812903          	lw	s2,8(sp)
 23c:	00c12983          	lw	s3,12(sp)
 240:	01012a03          	lw	s4,16(sp)
 244:	01412a83          	lw	s5,20(sp)
 248:	01812b03          	lw	s6,24(sp)
 24c:	01c12b83          	lw	s7,28(sp)
 250:	02012c03          	lw	s8,32(sp)
 254:	02412c83          	lw	s9,36(sp)
 258:	02812d03          	lw	s10,40(sp)
 25c:	02c10113          	addi	sp,sp,44
 260:	00008067          	ret

00000264 <ISR5>:
 264:	30047073          	csrci	mstatus,8
 268:	e8010113          	addi	sp,sp,-384
 26c:	10112023          	sw	ra,256(sp)
 270:	10212223          	sw	sp,260(sp)
 274:	10312423          	sw	gp,264(sp)
 278:	10412623          	sw	tp,268(sp)
 27c:	10512823          	sw	t0,272(sp)
 280:	10612a23          	sw	t1,276(sp)
 284:	10712c23          	sw	t2,280(sp)
 288:	10812e23          	sw	s0,284(sp)
 28c:	12912023          	sw	s1,288(sp)
 290:	12a12223          	sw	a0,292(sp)
 294:	12b12423          	sw	a1,296(sp)
 298:	12c12623          	sw	a2,300(sp)
 29c:	12d12823          	sw	a3,304(sp)
 2a0:	12e12a23          	sw	a4,308(sp)
 2a4:	12f12c23          	sw	a5,312(sp)
 2a8:	13012e23          	sw	a6,316(sp)
 2ac:	15112023          	sw	a7,320(sp)
 2b0:	15212223          	sw	s2,324(sp)
 2b4:	15312423          	sw	s3,328(sp)
 2b8:	15412623          	sw	s4,332(sp)
 2bc:	15512823          	sw	s5,336(sp)
 2c0:	15612a23          	sw	s6,340(sp)
 2c4:	15712c23          	sw	s7,344(sp)
 2c8:	15812e23          	sw	s8,348(sp)
 2cc:	17912023          	sw	s9,352(sp)
 2d0:	17a12223          	sw	s10,356(sp)
 2d4:	17b12423          	sw	s11,360(sp)
 2d8:	17c12623          	sw	t3,364(sp)
 2dc:	17d12823          	sw	t4,368(sp)
 2e0:	17e12a23          	sw	t5,372(sp)
 2e4:	17f12c23          	sw	t6,376(sp)
 2e8:	341022f3          	csrr	t0,mepc
 2ec:	16512e23          	sw	t0,380(sp)
 2f0:	2bc000ef          	jal	ra,5ac <ISR5_uart>
 2f4:	30047073          	csrci	mstatus,8
 2f8:	17c12283          	lw	t0,380(sp)
 2fc:	34129073          	csrw	mepc,t0
 300:	10012083          	lw	ra,256(sp)
 304:	10c12203          	lw	tp,268(sp)
 308:	11012283          	lw	t0,272(sp)
 30c:	11412303          	lw	t1,276(sp)
 310:	11812383          	lw	t2,280(sp)
 314:	11c12403          	lw	s0,284(sp)
 318:	12012483          	lw	s1,288(sp)
 31c:	12412503          	lw	a0,292(sp)
 320:	12812583          	lw	a1,296(sp)
 324:	12c12603          	lw	a2,300(sp)
 328:	13012683          	lw	a3,304(sp)
 32c:	13412703          	lw	a4,308(sp)
 330:	13812783          	lw	a5,312(sp)
 334:	13c12803          	lw	a6,316(sp)
 338:	14012883          	lw	a7,320(sp)
 33c:	14412903          	lw	s2,324(sp)
 340:	14812983          	lw	s3,328(sp)
 344:	14c12a03          	lw	s4,332(sp)
 348:	15012a83          	lw	s5,336(sp)
 34c:	15412b03          	lw	s6,340(sp)
 350:	15812b83          	lw	s7,344(sp)
 354:	15c12c03          	lw	s8,348(sp)
 358:	16012c83          	lw	s9,352(sp)
 35c:	16412d03          	lw	s10,356(sp)
 360:	16812d83          	lw	s11,360(sp)
 364:	16c12e03          	lw	t3,364(sp)
 368:	17012e83          	lw	t4,368(sp)
 36c:	17412f03          	lw	t5,372(sp)
 370:	17812f83          	lw	t6,376(sp)
 374:	18010113          	addi	sp,sp,384
 378:	30046073          	csrsi	mstatus,8
 37c:	30200073          	mret

00000380 <ISR6>:
 380:	30047073          	csrci	mstatus,8
 384:	e8010113          	addi	sp,sp,-384
 388:	10112023          	sw	ra,256(sp)
 38c:	10212223          	sw	sp,260(sp)
 390:	10312423          	sw	gp,264(sp)
 394:	10412623          	sw	tp,268(sp)
 398:	10512823          	sw	t0,272(sp)
 39c:	10612a23          	sw	t1,276(sp)
 3a0:	10712c23          	sw	t2,280(sp)
 3a4:	10812e23          	sw	s0,284(sp)
 3a8:	12912023          	sw	s1,288(sp)
 3ac:	12a12223          	sw	a0,292(sp)
 3b0:	12b12423          	sw	a1,296(sp)
 3b4:	12c12623          	sw	a2,300(sp)
 3b8:	12d12823          	sw	a3,304(sp)
 3bc:	12e12a23          	sw	a4,308(sp)
 3c0:	12f12c23          	sw	a5,312(sp)
 3c4:	13012e23          	sw	a6,316(sp)
 3c8:	15112023          	sw	a7,320(sp)
 3cc:	15212223          	sw	s2,324(sp)
 3d0:	15312423          	sw	s3,328(sp)
 3d4:	15412623          	sw	s4,332(sp)
 3d8:	15512823          	sw	s5,336(sp)
 3dc:	15612a23          	sw	s6,340(sp)
 3e0:	15712c23          	sw	s7,344(sp)
 3e4:	15812e23          	sw	s8,348(sp)
 3e8:	17912023          	sw	s9,352(sp)
 3ec:	17a12223          	sw	s10,356(sp)
 3f0:	17b12423          	sw	s11,360(sp)
 3f4:	17c12623          	sw	t3,364(sp)
 3f8:	17d12823          	sw	t4,368(sp)
 3fc:	17e12a23          	sw	t5,372(sp)
 400:	17f12c23          	sw	t6,376(sp)
 404:	341022f3          	csrr	t0,mepc
 408:	16512e23          	sw	t0,380(sp)
 40c:	1bc000ef          	jal	ra,5c8 <ISR6_addr_exception>
 410:	30047073          	csrci	mstatus,8
 414:	17c12283          	lw	t0,380(sp)
 418:	34129073          	csrw	mepc,t0
 41c:	10012083          	lw	ra,256(sp)
 420:	10c12203          	lw	tp,268(sp)
 424:	11012283          	lw	t0,272(sp)
 428:	11412303          	lw	t1,276(sp)
 42c:	11812383          	lw	t2,280(sp)
 430:	11c12403          	lw	s0,284(sp)
 434:	12012483          	lw	s1,288(sp)
 438:	12412503          	lw	a0,292(sp)
 43c:	12812583          	lw	a1,296(sp)
 440:	12c12603          	lw	a2,300(sp)
 444:	13012683          	lw	a3,304(sp)
 448:	13412703          	lw	a4,308(sp)
 44c:	13812783          	lw	a5,312(sp)
 450:	13c12803          	lw	a6,316(sp)
 454:	14012883          	lw	a7,320(sp)
 458:	14412903          	lw	s2,324(sp)
 45c:	14812983          	lw	s3,328(sp)
 460:	14c12a03          	lw	s4,332(sp)
 464:	15012a83          	lw	s5,336(sp)
 468:	15412b03          	lw	s6,340(sp)
 46c:	15812b83          	lw	s7,344(sp)
 470:	15c12c03          	lw	s8,348(sp)
 474:	16012c83          	lw	s9,352(sp)
 478:	16412d03          	lw	s10,356(sp)
 47c:	16812d83          	lw	s11,360(sp)
 480:	16c12e03          	lw	t3,364(sp)
 484:	17012e83          	lw	t4,368(sp)
 488:	17412f03          	lw	t5,372(sp)
 48c:	17812f83          	lw	t6,376(sp)
 490:	18010113          	addi	sp,sp,384
 494:	30046073          	csrsi	mstatus,8
 498:	30200073          	mret

0000049c <main>:
 49c:	fd010113          	addi	sp,sp,-48
 4a0:	02112623          	sw	ra,44(sp)
 4a4:	02812423          	sw	s0,40(sp)
 4a8:	03010413          	addi	s0,sp,48
 4ac:	fca42e23          	sw	a0,-36(s0)
 4b0:	fcb42c23          	sw	a1,-40(s0)
 4b4:	00800693          	li	a3,8
 4b8:	001007b7          	lui	a5,0x100
 4bc:	10078613          	addi	a2,a5,256 # 100100 <b_mat>
 4c0:	001007b7          	lui	a5,0x100
 4c4:	00078593          	mv	a1,a5
 4c8:	001007b7          	lui	a5,0x100
 4cc:	30078513          	addi	a0,a5,768 # 100300 <y_mat>
 4d0:	c61ff0ef          	jal	ra,130 <matmul>
 4d4:	00a00793          	li	a5,10
 4d8:	fef42423          	sw	a5,-24(s0)
 4dc:	001007b7          	lui	a5,0x100
 4e0:	4007a023          	sw	zero,1024(a5) # 100400 <err_count>
 4e4:	fe042623          	sw	zero,-20(s0)
 4e8:	0a00006f          	j	588 <main+0xec>
 4ec:	001007b7          	lui	a5,0x100
 4f0:	30078713          	addi	a4,a5,768 # 100300 <y_mat>
 4f4:	fec42783          	lw	a5,-20(s0)
 4f8:	00279793          	slli	a5,a5,0x2
 4fc:	00f707b3          	add	a5,a4,a5
 500:	0007a703          	lw	a4,0(a5)
 504:	001007b7          	lui	a5,0x100
 508:	20078693          	addi	a3,a5,512 # 100200 <expected_output>
 50c:	fec42783          	lw	a5,-20(s0)
 510:	00279793          	slli	a5,a5,0x2
 514:	00f687b3          	add	a5,a3,a5
 518:	0007a783          	lw	a5,0(a5)
 51c:	40f707b3          	sub	a5,a4,a5
 520:	fe842703          	lw	a4,-24(s0)
 524:	04f74263          	blt	a4,a5,568 <main+0xcc>
 528:	001007b7          	lui	a5,0x100
 52c:	30078713          	addi	a4,a5,768 # 100300 <y_mat>
 530:	fec42783          	lw	a5,-20(s0)
 534:	00279793          	slli	a5,a5,0x2
 538:	00f707b3          	add	a5,a4,a5
 53c:	0007a703          	lw	a4,0(a5)
 540:	001007b7          	lui	a5,0x100
 544:	20078693          	addi	a3,a5,512 # 100200 <expected_output>
 548:	fec42783          	lw	a5,-20(s0)
 54c:	00279793          	slli	a5,a5,0x2
 550:	00f687b3          	add	a5,a3,a5
 554:	0007a783          	lw	a5,0(a5)
 558:	40f70733          	sub	a4,a4,a5
 55c:	fe842783          	lw	a5,-24(s0)
 560:	40f007b3          	neg	a5,a5
 564:	00f75c63          	bge	a4,a5,57c <main+0xe0>
 568:	001007b7          	lui	a5,0x100
 56c:	4007a783          	lw	a5,1024(a5) # 100400 <err_count>
 570:	00178713          	addi	a4,a5,1
 574:	001007b7          	lui	a5,0x100
 578:	40e7a023          	sw	a4,1024(a5) # 100400 <err_count>
 57c:	fec42783          	lw	a5,-20(s0)
 580:	00178793          	addi	a5,a5,1
 584:	fef42623          	sw	a5,-20(s0)
 588:	fec42703          	lw	a4,-20(s0)
 58c:	03f00793          	li	a5,63
 590:	f4e7dee3          	bge	a5,a4,4ec <main+0x50>
 594:	00000793          	li	a5,0
 598:	00078513          	mv	a0,a5
 59c:	02c12083          	lw	ra,44(sp)
 5a0:	02812403          	lw	s0,40(sp)
 5a4:	03010113          	addi	sp,sp,48
 5a8:	00008067          	ret

000005ac <ISR5_uart>:
 5ac:	ff010113          	addi	sp,sp,-16
 5b0:	00812623          	sw	s0,12(sp)
 5b4:	01010413          	addi	s0,sp,16
 5b8:	00000013          	nop
 5bc:	00c12403          	lw	s0,12(sp)
 5c0:	01010113          	addi	sp,sp,16
 5c4:	00008067          	ret

000005c8 <ISR6_addr_exception>:
 5c8:	ff010113          	addi	sp,sp,-16
 5cc:	00812623          	sw	s0,12(sp)
 5d0:	01010413          	addi	s0,sp,16
 5d4:	00000013          	nop
 5d8:	00c12403          	lw	s0,12(sp)
 5dc:	01010113          	addi	sp,sp,16
 5e0:	00008067          	ret

000005e4 <__stack_init>:
 5e4:	000feffc                                ....
