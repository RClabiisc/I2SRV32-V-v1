
riscv-spike.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <boot>:
   0:	00002fb7          	lui	t6,0x2
   4:	800f8f93          	addi	t6,t6,-2048 # 1800 <__stack_init+0x12e8>
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
  e8:	2e4000ef          	jal	ra,3cc <main>
  ec:	0000006f          	j	ec <_mstart+0xac>
  f0:	00008067          	ret

000000f4 <trap_entry>:
  f4:	0a00006f          	j	194 <ISR5>
  f8:	30200073          	mret
  fc:	0980006f          	j	194 <ISR5>
 100:	30200073          	mret
 104:	0900006f          	j	194 <ISR5>
 108:	30200073          	mret
 10c:	0880006f          	j	194 <ISR5>
 110:	30200073          	mret
 114:	0800006f          	j	194 <ISR5>
 118:	30200073          	mret
 11c:	1940006f          	j	2b0 <ISR6>
 120:	30200073          	mret
	...

00000130 <saxpy>:
 130:	00300293          	li	t0,3
 134:	00a2b073          	csrc	vxrm,t0
 138:	fff68313          	addi	t1,a3,-1
 13c:	00635713          	srli	a4,t1,0x6
 140:	00170713          	addi	a4,a4,1
 144:	03f00293          	li	t0,63
 148:	0056f7b3          	and	a5,a3,t0
 14c:	00000293          	li	t0,0

00000150 <LOOP>:
 150:	0127fe57          	vsetvli	t3,a5,e32,m4,tu,mu
 154:	02066407          	vle32.v	v8,(a2)
 158:	02056807          	vle32.v	v16,(a0)
 15c:	9685ec57          	vmul.vx	v24,v8,a1
 160:	03880c57          	vadd.vv	v24,v24,v16
 164:	02056c27          	vse32.v	v24,(a0)
 168:	02804457          	vadd.vx	v8,v8,zero
 16c:	03004857          	vadd.vx	v16,v16,zero
 170:	03804c57          	vadd.vx	v24,v24,zero
 174:	04000793          	li	a5,64
 178:	00128293          	addi	t0,t0,1
 17c:	10050513          	addi	a0,a0,256
 180:	10060613          	addi	a2,a2,256
 184:	fce296e3          	bne	t0,a4,150 <LOOP>
 188:	00000013          	nop
 18c:	00000013          	nop
 190:	00008067          	ret

00000194 <ISR5>:
 194:	30047073          	csrci	mstatus,8
 198:	e8010113          	addi	sp,sp,-384
 19c:	10112023          	sw	ra,256(sp)
 1a0:	10212223          	sw	sp,260(sp)
 1a4:	10312423          	sw	gp,264(sp)
 1a8:	10412623          	sw	tp,268(sp)
 1ac:	10512823          	sw	t0,272(sp)
 1b0:	10612a23          	sw	t1,276(sp)
 1b4:	10712c23          	sw	t2,280(sp)
 1b8:	10812e23          	sw	s0,284(sp)
 1bc:	12912023          	sw	s1,288(sp)
 1c0:	12a12223          	sw	a0,292(sp)
 1c4:	12b12423          	sw	a1,296(sp)
 1c8:	12c12623          	sw	a2,300(sp)
 1cc:	12d12823          	sw	a3,304(sp)
 1d0:	12e12a23          	sw	a4,308(sp)
 1d4:	12f12c23          	sw	a5,312(sp)
 1d8:	13012e23          	sw	a6,316(sp)
 1dc:	15112023          	sw	a7,320(sp)
 1e0:	15212223          	sw	s2,324(sp)
 1e4:	15312423          	sw	s3,328(sp)
 1e8:	15412623          	sw	s4,332(sp)
 1ec:	15512823          	sw	s5,336(sp)
 1f0:	15612a23          	sw	s6,340(sp)
 1f4:	15712c23          	sw	s7,344(sp)
 1f8:	15812e23          	sw	s8,348(sp)
 1fc:	17912023          	sw	s9,352(sp)
 200:	17a12223          	sw	s10,356(sp)
 204:	17b12423          	sw	s11,360(sp)
 208:	17c12623          	sw	t3,364(sp)
 20c:	17d12823          	sw	t4,368(sp)
 210:	17e12a23          	sw	t5,372(sp)
 214:	17f12c23          	sw	t6,376(sp)
 218:	341022f3          	csrr	t0,mepc
 21c:	16512e23          	sw	t0,380(sp)
 220:	2c0000ef          	jal	ra,4e0 <ISR5_uart>
 224:	30047073          	csrci	mstatus,8
 228:	17c12283          	lw	t0,380(sp)
 22c:	34129073          	csrw	mepc,t0
 230:	10012083          	lw	ra,256(sp)
 234:	10c12203          	lw	tp,268(sp)
 238:	11012283          	lw	t0,272(sp)
 23c:	11412303          	lw	t1,276(sp)
 240:	11812383          	lw	t2,280(sp)
 244:	11c12403          	lw	s0,284(sp)
 248:	12012483          	lw	s1,288(sp)
 24c:	12412503          	lw	a0,292(sp)
 250:	12812583          	lw	a1,296(sp)
 254:	12c12603          	lw	a2,300(sp)
 258:	13012683          	lw	a3,304(sp)
 25c:	13412703          	lw	a4,308(sp)
 260:	13812783          	lw	a5,312(sp)
 264:	13c12803          	lw	a6,316(sp)
 268:	14012883          	lw	a7,320(sp)
 26c:	14412903          	lw	s2,324(sp)
 270:	14812983          	lw	s3,328(sp)
 274:	14c12a03          	lw	s4,332(sp)
 278:	15012a83          	lw	s5,336(sp)
 27c:	15412b03          	lw	s6,340(sp)
 280:	15812b83          	lw	s7,344(sp)
 284:	15c12c03          	lw	s8,348(sp)
 288:	16012c83          	lw	s9,352(sp)
 28c:	16412d03          	lw	s10,356(sp)
 290:	16812d83          	lw	s11,360(sp)
 294:	16c12e03          	lw	t3,364(sp)
 298:	17012e83          	lw	t4,368(sp)
 29c:	17412f03          	lw	t5,372(sp)
 2a0:	17812f83          	lw	t6,376(sp)
 2a4:	18010113          	addi	sp,sp,384
 2a8:	30046073          	csrsi	mstatus,8
 2ac:	30200073          	mret

000002b0 <ISR6>:
 2b0:	30047073          	csrci	mstatus,8
 2b4:	e8010113          	addi	sp,sp,-384
 2b8:	10112023          	sw	ra,256(sp)
 2bc:	10212223          	sw	sp,260(sp)
 2c0:	10312423          	sw	gp,264(sp)
 2c4:	10412623          	sw	tp,268(sp)
 2c8:	10512823          	sw	t0,272(sp)
 2cc:	10612a23          	sw	t1,276(sp)
 2d0:	10712c23          	sw	t2,280(sp)
 2d4:	10812e23          	sw	s0,284(sp)
 2d8:	12912023          	sw	s1,288(sp)
 2dc:	12a12223          	sw	a0,292(sp)
 2e0:	12b12423          	sw	a1,296(sp)
 2e4:	12c12623          	sw	a2,300(sp)
 2e8:	12d12823          	sw	a3,304(sp)
 2ec:	12e12a23          	sw	a4,308(sp)
 2f0:	12f12c23          	sw	a5,312(sp)
 2f4:	13012e23          	sw	a6,316(sp)
 2f8:	15112023          	sw	a7,320(sp)
 2fc:	15212223          	sw	s2,324(sp)
 300:	15312423          	sw	s3,328(sp)
 304:	15412623          	sw	s4,332(sp)
 308:	15512823          	sw	s5,336(sp)
 30c:	15612a23          	sw	s6,340(sp)
 310:	15712c23          	sw	s7,344(sp)
 314:	15812e23          	sw	s8,348(sp)
 318:	17912023          	sw	s9,352(sp)
 31c:	17a12223          	sw	s10,356(sp)
 320:	17b12423          	sw	s11,360(sp)
 324:	17c12623          	sw	t3,364(sp)
 328:	17d12823          	sw	t4,368(sp)
 32c:	17e12a23          	sw	t5,372(sp)
 330:	17f12c23          	sw	t6,376(sp)
 334:	341022f3          	csrr	t0,mepc
 338:	16512e23          	sw	t0,380(sp)
 33c:	1c0000ef          	jal	ra,4fc <ISR6_addr_exception>
 340:	30047073          	csrci	mstatus,8
 344:	17c12283          	lw	t0,380(sp)
 348:	34129073          	csrw	mepc,t0
 34c:	10012083          	lw	ra,256(sp)
 350:	10c12203          	lw	tp,268(sp)
 354:	11012283          	lw	t0,272(sp)
 358:	11412303          	lw	t1,276(sp)
 35c:	11812383          	lw	t2,280(sp)
 360:	11c12403          	lw	s0,284(sp)
 364:	12012483          	lw	s1,288(sp)
 368:	12412503          	lw	a0,292(sp)
 36c:	12812583          	lw	a1,296(sp)
 370:	12c12603          	lw	a2,300(sp)
 374:	13012683          	lw	a3,304(sp)
 378:	13412703          	lw	a4,308(sp)
 37c:	13812783          	lw	a5,312(sp)
 380:	13c12803          	lw	a6,316(sp)
 384:	14012883          	lw	a7,320(sp)
 388:	14412903          	lw	s2,324(sp)
 38c:	14812983          	lw	s3,328(sp)
 390:	14c12a03          	lw	s4,332(sp)
 394:	15012a83          	lw	s5,336(sp)
 398:	15412b03          	lw	s6,340(sp)
 39c:	15812b83          	lw	s7,344(sp)
 3a0:	15c12c03          	lw	s8,348(sp)
 3a4:	16012c83          	lw	s9,352(sp)
 3a8:	16412d03          	lw	s10,356(sp)
 3ac:	16812d83          	lw	s11,360(sp)
 3b0:	16c12e03          	lw	t3,364(sp)
 3b4:	17012e83          	lw	t4,368(sp)
 3b8:	17412f03          	lw	t5,372(sp)
 3bc:	17812f83          	lw	t6,376(sp)
 3c0:	18010113          	addi	sp,sp,384
 3c4:	30046073          	csrsi	mstatus,8
 3c8:	30200073          	mret

000003cc <main>:
 3cc:	fd010113          	addi	sp,sp,-48
 3d0:	02112623          	sw	ra,44(sp)
 3d4:	02812423          	sw	s0,40(sp)
 3d8:	03010413          	addi	s0,sp,48
 3dc:	fca42e23          	sw	a0,-36(s0)
 3e0:	fcb42c23          	sw	a1,-40(s0)
 3e4:	04000793          	li	a5,64
 3e8:	fef42423          	sw	a5,-24(s0)
 3ec:	04000693          	li	a3,64
 3f0:	001007b7          	lui	a5,0x100
 3f4:	00078613          	mv	a2,a5
 3f8:	fe842583          	lw	a1,-24(s0)
 3fc:	001007b7          	lui	a5,0x100
 400:	10078513          	addi	a0,a5,256 # 100100 <y_vec>
 404:	d2dff0ef          	jal	ra,130 <saxpy>
 408:	00a00793          	li	a5,10
 40c:	fef42223          	sw	a5,-28(s0)
 410:	001007b7          	lui	a5,0x100
 414:	3007a023          	sw	zero,768(a5) # 100300 <err_count>
 418:	fe042623          	sw	zero,-20(s0)
 41c:	0a00006f          	j	4bc <main+0xf0>
 420:	001007b7          	lui	a5,0x100
 424:	10078713          	addi	a4,a5,256 # 100100 <y_vec>
 428:	fec42783          	lw	a5,-20(s0)
 42c:	00279793          	slli	a5,a5,0x2
 430:	00f707b3          	add	a5,a4,a5
 434:	0007a703          	lw	a4,0(a5)
 438:	001007b7          	lui	a5,0x100
 43c:	20078693          	addi	a3,a5,512 # 100200 <expected_output>
 440:	fec42783          	lw	a5,-20(s0)
 444:	00279793          	slli	a5,a5,0x2
 448:	00f687b3          	add	a5,a3,a5
 44c:	0007a783          	lw	a5,0(a5)
 450:	40f707b3          	sub	a5,a4,a5
 454:	fe442703          	lw	a4,-28(s0)
 458:	04f74263          	blt	a4,a5,49c <main+0xd0>
 45c:	001007b7          	lui	a5,0x100
 460:	10078713          	addi	a4,a5,256 # 100100 <y_vec>
 464:	fec42783          	lw	a5,-20(s0)
 468:	00279793          	slli	a5,a5,0x2
 46c:	00f707b3          	add	a5,a4,a5
 470:	0007a703          	lw	a4,0(a5)
 474:	001007b7          	lui	a5,0x100
 478:	20078693          	addi	a3,a5,512 # 100200 <expected_output>
 47c:	fec42783          	lw	a5,-20(s0)
 480:	00279793          	slli	a5,a5,0x2
 484:	00f687b3          	add	a5,a3,a5
 488:	0007a783          	lw	a5,0(a5)
 48c:	40f70733          	sub	a4,a4,a5
 490:	fe442783          	lw	a5,-28(s0)
 494:	40f007b3          	neg	a5,a5
 498:	00f75c63          	bge	a4,a5,4b0 <main+0xe4>
 49c:	001007b7          	lui	a5,0x100
 4a0:	3007a783          	lw	a5,768(a5) # 100300 <err_count>
 4a4:	00178713          	addi	a4,a5,1
 4a8:	001007b7          	lui	a5,0x100
 4ac:	30e7a023          	sw	a4,768(a5) # 100300 <err_count>
 4b0:	fec42783          	lw	a5,-20(s0)
 4b4:	00178793          	addi	a5,a5,1
 4b8:	fef42623          	sw	a5,-20(s0)
 4bc:	fec42703          	lw	a4,-20(s0)
 4c0:	03f00793          	li	a5,63
 4c4:	f4e7dee3          	bge	a5,a4,420 <main+0x54>
 4c8:	00000793          	li	a5,0
 4cc:	00078513          	mv	a0,a5
 4d0:	02c12083          	lw	ra,44(sp)
 4d4:	02812403          	lw	s0,40(sp)
 4d8:	03010113          	addi	sp,sp,48
 4dc:	00008067          	ret

000004e0 <ISR5_uart>:
 4e0:	ff010113          	addi	sp,sp,-16
 4e4:	00812623          	sw	s0,12(sp)
 4e8:	01010413          	addi	s0,sp,16
 4ec:	00000013          	nop
 4f0:	00c12403          	lw	s0,12(sp)
 4f4:	01010113          	addi	sp,sp,16
 4f8:	00008067          	ret

000004fc <ISR6_addr_exception>:
 4fc:	ff010113          	addi	sp,sp,-16
 500:	00812623          	sw	s0,12(sp)
 504:	01010413          	addi	s0,sp,16
 508:	00000013          	nop
 50c:	00c12403          	lw	s0,12(sp)
 510:	01010113          	addi	sp,sp,16
 514:	00008067          	ret

00000518 <__stack_init>:
 518:	000feffc                                ....
