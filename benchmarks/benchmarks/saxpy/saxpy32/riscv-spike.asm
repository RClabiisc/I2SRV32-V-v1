
riscv-spike.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <boot>:
   0:	00002fb7          	lui	t6,0x2
   4:	800f8f93          	addi	t6,t6,-2048 # 1800 <__stack_init+0x12ec>
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
  e8:	2e0000ef          	jal	ra,3c8 <main>
  ec:	0000006f          	j	ec <_mstart+0xac>
  f0:	00008067          	ret

000000f4 <trap_entry>:
  f4:	09c0006f          	j	190 <ISR5>
  f8:	30200073          	mret
  fc:	0940006f          	j	190 <ISR5>
 100:	30200073          	mret
 104:	08c0006f          	j	190 <ISR5>
 108:	30200073          	mret
 10c:	0840006f          	j	190 <ISR5>
 110:	30200073          	mret
 114:	07c0006f          	j	190 <ISR5>
 118:	30200073          	mret
 11c:	1900006f          	j	2ac <ISR6>
 120:	30200073          	mret
	...

00000130 <saxpy>:
 130:	00300293          	li	t0,3
 134:	00a2b073          	csrc	vxrm,t0
 138:	0066d713          	srli	a4,a3,0x6
 13c:	00170713          	addi	a4,a4,1
 140:	03f00293          	li	t0,63
 144:	0056f7b3          	and	a5,a3,t0
 148:	00000293          	li	t0,0

0000014c <LOOP>:
 14c:	0127fe57          	vsetvli	t3,a5,e32,m4,tu,mu
 150:	02066407          	vle32.v	v8,(a2)
 154:	02056807          	vle32.v	v16,(a0)
 158:	9685ec57          	vmul.vx	v24,v8,a1
 15c:	03880c57          	vadd.vv	v24,v24,v16
 160:	02056c27          	vse32.v	v24,(a0)
 164:	02804457          	vadd.vx	v8,v8,zero
 168:	03004857          	vadd.vx	v16,v16,zero
 16c:	03804c57          	vadd.vx	v24,v24,zero
 170:	04000793          	li	a5,64
 174:	00128293          	addi	t0,t0,1
 178:	10050513          	addi	a0,a0,256
 17c:	10060613          	addi	a2,a2,256
 180:	fce296e3          	bne	t0,a4,14c <LOOP>
 184:	00000013          	nop
 188:	00000013          	nop
 18c:	00008067          	ret

00000190 <ISR5>:
 190:	30047073          	csrci	mstatus,8
 194:	e8010113          	addi	sp,sp,-384
 198:	10112023          	sw	ra,256(sp)
 19c:	10212223          	sw	sp,260(sp)
 1a0:	10312423          	sw	gp,264(sp)
 1a4:	10412623          	sw	tp,268(sp)
 1a8:	10512823          	sw	t0,272(sp)
 1ac:	10612a23          	sw	t1,276(sp)
 1b0:	10712c23          	sw	t2,280(sp)
 1b4:	10812e23          	sw	s0,284(sp)
 1b8:	12912023          	sw	s1,288(sp)
 1bc:	12a12223          	sw	a0,292(sp)
 1c0:	12b12423          	sw	a1,296(sp)
 1c4:	12c12623          	sw	a2,300(sp)
 1c8:	12d12823          	sw	a3,304(sp)
 1cc:	12e12a23          	sw	a4,308(sp)
 1d0:	12f12c23          	sw	a5,312(sp)
 1d4:	13012e23          	sw	a6,316(sp)
 1d8:	15112023          	sw	a7,320(sp)
 1dc:	15212223          	sw	s2,324(sp)
 1e0:	15312423          	sw	s3,328(sp)
 1e4:	15412623          	sw	s4,332(sp)
 1e8:	15512823          	sw	s5,336(sp)
 1ec:	15612a23          	sw	s6,340(sp)
 1f0:	15712c23          	sw	s7,344(sp)
 1f4:	15812e23          	sw	s8,348(sp)
 1f8:	17912023          	sw	s9,352(sp)
 1fc:	17a12223          	sw	s10,356(sp)
 200:	17b12423          	sw	s11,360(sp)
 204:	17c12623          	sw	t3,364(sp)
 208:	17d12823          	sw	t4,368(sp)
 20c:	17e12a23          	sw	t5,372(sp)
 210:	17f12c23          	sw	t6,376(sp)
 214:	341022f3          	csrr	t0,mepc
 218:	16512e23          	sw	t0,380(sp)
 21c:	2c0000ef          	jal	ra,4dc <ISR5_uart>
 220:	30047073          	csrci	mstatus,8
 224:	17c12283          	lw	t0,380(sp)
 228:	34129073          	csrw	mepc,t0
 22c:	10012083          	lw	ra,256(sp)
 230:	10c12203          	lw	tp,268(sp)
 234:	11012283          	lw	t0,272(sp)
 238:	11412303          	lw	t1,276(sp)
 23c:	11812383          	lw	t2,280(sp)
 240:	11c12403          	lw	s0,284(sp)
 244:	12012483          	lw	s1,288(sp)
 248:	12412503          	lw	a0,292(sp)
 24c:	12812583          	lw	a1,296(sp)
 250:	12c12603          	lw	a2,300(sp)
 254:	13012683          	lw	a3,304(sp)
 258:	13412703          	lw	a4,308(sp)
 25c:	13812783          	lw	a5,312(sp)
 260:	13c12803          	lw	a6,316(sp)
 264:	14012883          	lw	a7,320(sp)
 268:	14412903          	lw	s2,324(sp)
 26c:	14812983          	lw	s3,328(sp)
 270:	14c12a03          	lw	s4,332(sp)
 274:	15012a83          	lw	s5,336(sp)
 278:	15412b03          	lw	s6,340(sp)
 27c:	15812b83          	lw	s7,344(sp)
 280:	15c12c03          	lw	s8,348(sp)
 284:	16012c83          	lw	s9,352(sp)
 288:	16412d03          	lw	s10,356(sp)
 28c:	16812d83          	lw	s11,360(sp)
 290:	16c12e03          	lw	t3,364(sp)
 294:	17012e83          	lw	t4,368(sp)
 298:	17412f03          	lw	t5,372(sp)
 29c:	17812f83          	lw	t6,376(sp)
 2a0:	18010113          	addi	sp,sp,384
 2a4:	30046073          	csrsi	mstatus,8
 2a8:	30200073          	mret

000002ac <ISR6>:
 2ac:	30047073          	csrci	mstatus,8
 2b0:	e8010113          	addi	sp,sp,-384
 2b4:	10112023          	sw	ra,256(sp)
 2b8:	10212223          	sw	sp,260(sp)
 2bc:	10312423          	sw	gp,264(sp)
 2c0:	10412623          	sw	tp,268(sp)
 2c4:	10512823          	sw	t0,272(sp)
 2c8:	10612a23          	sw	t1,276(sp)
 2cc:	10712c23          	sw	t2,280(sp)
 2d0:	10812e23          	sw	s0,284(sp)
 2d4:	12912023          	sw	s1,288(sp)
 2d8:	12a12223          	sw	a0,292(sp)
 2dc:	12b12423          	sw	a1,296(sp)
 2e0:	12c12623          	sw	a2,300(sp)
 2e4:	12d12823          	sw	a3,304(sp)
 2e8:	12e12a23          	sw	a4,308(sp)
 2ec:	12f12c23          	sw	a5,312(sp)
 2f0:	13012e23          	sw	a6,316(sp)
 2f4:	15112023          	sw	a7,320(sp)
 2f8:	15212223          	sw	s2,324(sp)
 2fc:	15312423          	sw	s3,328(sp)
 300:	15412623          	sw	s4,332(sp)
 304:	15512823          	sw	s5,336(sp)
 308:	15612a23          	sw	s6,340(sp)
 30c:	15712c23          	sw	s7,344(sp)
 310:	15812e23          	sw	s8,348(sp)
 314:	17912023          	sw	s9,352(sp)
 318:	17a12223          	sw	s10,356(sp)
 31c:	17b12423          	sw	s11,360(sp)
 320:	17c12623          	sw	t3,364(sp)
 324:	17d12823          	sw	t4,368(sp)
 328:	17e12a23          	sw	t5,372(sp)
 32c:	17f12c23          	sw	t6,376(sp)
 330:	341022f3          	csrr	t0,mepc
 334:	16512e23          	sw	t0,380(sp)
 338:	1c0000ef          	jal	ra,4f8 <ISR6_addr_exception>
 33c:	30047073          	csrci	mstatus,8
 340:	17c12283          	lw	t0,380(sp)
 344:	34129073          	csrw	mepc,t0
 348:	10012083          	lw	ra,256(sp)
 34c:	10c12203          	lw	tp,268(sp)
 350:	11012283          	lw	t0,272(sp)
 354:	11412303          	lw	t1,276(sp)
 358:	11812383          	lw	t2,280(sp)
 35c:	11c12403          	lw	s0,284(sp)
 360:	12012483          	lw	s1,288(sp)
 364:	12412503          	lw	a0,292(sp)
 368:	12812583          	lw	a1,296(sp)
 36c:	12c12603          	lw	a2,300(sp)
 370:	13012683          	lw	a3,304(sp)
 374:	13412703          	lw	a4,308(sp)
 378:	13812783          	lw	a5,312(sp)
 37c:	13c12803          	lw	a6,316(sp)
 380:	14012883          	lw	a7,320(sp)
 384:	14412903          	lw	s2,324(sp)
 388:	14812983          	lw	s3,328(sp)
 38c:	14c12a03          	lw	s4,332(sp)
 390:	15012a83          	lw	s5,336(sp)
 394:	15412b03          	lw	s6,340(sp)
 398:	15812b83          	lw	s7,344(sp)
 39c:	15c12c03          	lw	s8,348(sp)
 3a0:	16012c83          	lw	s9,352(sp)
 3a4:	16412d03          	lw	s10,356(sp)
 3a8:	16812d83          	lw	s11,360(sp)
 3ac:	16c12e03          	lw	t3,364(sp)
 3b0:	17012e83          	lw	t4,368(sp)
 3b4:	17412f03          	lw	t5,372(sp)
 3b8:	17812f83          	lw	t6,376(sp)
 3bc:	18010113          	addi	sp,sp,384
 3c0:	30046073          	csrsi	mstatus,8
 3c4:	30200073          	mret

000003c8 <main>:
 3c8:	fd010113          	addi	sp,sp,-48
 3cc:	02112623          	sw	ra,44(sp)
 3d0:	02812423          	sw	s0,40(sp)
 3d4:	03010413          	addi	s0,sp,48
 3d8:	fca42e23          	sw	a0,-36(s0)
 3dc:	fcb42c23          	sw	a1,-40(s0)
 3e0:	04000793          	li	a5,64
 3e4:	fef42423          	sw	a5,-24(s0)
 3e8:	02000693          	li	a3,32
 3ec:	001007b7          	lui	a5,0x100
 3f0:	00078613          	mv	a2,a5
 3f4:	fe842583          	lw	a1,-24(s0)
 3f8:	001007b7          	lui	a5,0x100
 3fc:	08078513          	addi	a0,a5,128 # 100080 <y_vec>
 400:	d31ff0ef          	jal	ra,130 <saxpy>
 404:	00a00793          	li	a5,10
 408:	fef42223          	sw	a5,-28(s0)
 40c:	001007b7          	lui	a5,0x100
 410:	1807a023          	sw	zero,384(a5) # 100180 <err_count>
 414:	fe042623          	sw	zero,-20(s0)
 418:	0a00006f          	j	4b8 <main+0xf0>
 41c:	001007b7          	lui	a5,0x100
 420:	08078713          	addi	a4,a5,128 # 100080 <y_vec>
 424:	fec42783          	lw	a5,-20(s0)
 428:	00279793          	slli	a5,a5,0x2
 42c:	00f707b3          	add	a5,a4,a5
 430:	0007a703          	lw	a4,0(a5)
 434:	001007b7          	lui	a5,0x100
 438:	10078693          	addi	a3,a5,256 # 100100 <expected_output>
 43c:	fec42783          	lw	a5,-20(s0)
 440:	00279793          	slli	a5,a5,0x2
 444:	00f687b3          	add	a5,a3,a5
 448:	0007a783          	lw	a5,0(a5)
 44c:	40f707b3          	sub	a5,a4,a5
 450:	fe442703          	lw	a4,-28(s0)
 454:	04f74263          	blt	a4,a5,498 <main+0xd0>
 458:	001007b7          	lui	a5,0x100
 45c:	08078713          	addi	a4,a5,128 # 100080 <y_vec>
 460:	fec42783          	lw	a5,-20(s0)
 464:	00279793          	slli	a5,a5,0x2
 468:	00f707b3          	add	a5,a4,a5
 46c:	0007a703          	lw	a4,0(a5)
 470:	001007b7          	lui	a5,0x100
 474:	10078693          	addi	a3,a5,256 # 100100 <expected_output>
 478:	fec42783          	lw	a5,-20(s0)
 47c:	00279793          	slli	a5,a5,0x2
 480:	00f687b3          	add	a5,a3,a5
 484:	0007a783          	lw	a5,0(a5)
 488:	40f70733          	sub	a4,a4,a5
 48c:	fe442783          	lw	a5,-28(s0)
 490:	40f007b3          	neg	a5,a5
 494:	00f75c63          	bge	a4,a5,4ac <main+0xe4>
 498:	001007b7          	lui	a5,0x100
 49c:	1807a783          	lw	a5,384(a5) # 100180 <err_count>
 4a0:	00178713          	addi	a4,a5,1
 4a4:	001007b7          	lui	a5,0x100
 4a8:	18e7a023          	sw	a4,384(a5) # 100180 <err_count>
 4ac:	fec42783          	lw	a5,-20(s0)
 4b0:	00178793          	addi	a5,a5,1
 4b4:	fef42623          	sw	a5,-20(s0)
 4b8:	fec42703          	lw	a4,-20(s0)
 4bc:	01f00793          	li	a5,31
 4c0:	f4e7dee3          	bge	a5,a4,41c <main+0x54>
 4c4:	00000793          	li	a5,0
 4c8:	00078513          	mv	a0,a5
 4cc:	02c12083          	lw	ra,44(sp)
 4d0:	02812403          	lw	s0,40(sp)
 4d4:	03010113          	addi	sp,sp,48
 4d8:	00008067          	ret

000004dc <ISR5_uart>:
 4dc:	ff010113          	addi	sp,sp,-16
 4e0:	00812623          	sw	s0,12(sp)
 4e4:	01010413          	addi	s0,sp,16
 4e8:	00000013          	nop
 4ec:	00c12403          	lw	s0,12(sp)
 4f0:	01010113          	addi	sp,sp,16
 4f4:	00008067          	ret

000004f8 <ISR6_addr_exception>:
 4f8:	ff010113          	addi	sp,sp,-16
 4fc:	00812623          	sw	s0,12(sp)
 500:	01010413          	addi	s0,sp,16
 504:	00000013          	nop
 508:	00c12403          	lw	s0,12(sp)
 50c:	01010113          	addi	sp,sp,16
 510:	00008067          	ret

00000514 <__stack_init>:
 514:	000feffc                                ....
