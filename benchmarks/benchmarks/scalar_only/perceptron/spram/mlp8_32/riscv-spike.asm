
riscv-spike.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <main>:
   0:	001007b7          	lui	a5,0x100
   4:	40078793          	addi	a5,a5,1024 # 100400 <inp>
   8:	fe010113          	addi	sp,sp,-32
   c:	00c7a383          	lw	t2,12(a5)
  10:	0107a283          	lw	t0,16(a5)
  14:	0147af83          	lw	t6,20(a5)
  18:	0187af03          	lw	t5,24(a5)
  1c:	01c7ae83          	lw	t4,28(a5)
  20:	00812e23          	sw	s0,28(sp)
  24:	00912c23          	sw	s1,24(sp)
  28:	0087a403          	lw	s0,8(a5)
  2c:	0047a483          	lw	s1,4(a5)
  30:	01212a23          	sw	s2,20(sp)
  34:	0007a903          	lw	s2,0(a5)
  38:	001007b7          	lui	a5,0x100
  3c:	000208b7          	lui	a7,0x20
  40:	00078793          	mv	a5,a5
  44:	00100337          	lui	t1,0x100
  48:	00488813          	addi	a6,a7,4 # 20004 <Y>
  4c:	01312823          	sw	s3,16(sp)
  50:	01412623          	sw	s4,12(sp)
  54:	01512423          	sw	s5,8(sp)
  58:	42030313          	addi	t1,t1,1056 # 100420 <bias>
  5c:	08078e13          	addi	t3,a5,128 # 100080 <weights+0x80>
  60:	00488893          	addi	a7,a7,4
  64:	0200006f          	j	84 <main+0x84>
  68:	00032683          	lw	a3,0(t1)
  6c:	00478793          	addi	a5,a5,4
  70:	00430313          	addi	t1,t1,4
  74:	00e68733          	add	a4,a3,a4
  78:	00e8a023          	sw	a4,0(a7)
  7c:	00488893          	addi	a7,a7,4
  80:	07c78c63          	beq	a5,t3,f8 <main+0xf8>
  84:	0807aa03          	lw	s4,128(a5)
  88:	0007aa83          	lw	s5,0(a5)
  8c:	1007a983          	lw	s3,256(a5)
  90:	1807a503          	lw	a0,384(a5)
  94:	03448a33          	mul	s4,s1,s4
  98:	2007a583          	lw	a1,512(a5)
  9c:	2807a603          	lw	a2,640(a5)
  a0:	3007a683          	lw	a3,768(a5)
  a4:	3807a703          	lw	a4,896(a5)
  a8:	03590ab3          	mul	s5,s2,s5
  ac:	033409b3          	mul	s3,s0,s3
  b0:	015a0a33          	add	s4,s4,s5
  b4:	02a38533          	mul	a0,t2,a0
  b8:	014989b3          	add	s3,s3,s4
  bc:	02b285b3          	mul	a1,t0,a1
  c0:	01350533          	add	a0,a0,s3
  c4:	02cf8633          	mul	a2,t6,a2
  c8:	00a585b3          	add	a1,a1,a0
  cc:	02df06b3          	mul	a3,t5,a3
  d0:	00b60633          	add	a2,a2,a1
  d4:	02ee8733          	mul	a4,t4,a4
  d8:	00c686b3          	add	a3,a3,a2
  dc:	00d70733          	add	a4,a4,a3
  e0:	f8e044e3          	bgtz	a4,68 <main+0x68>
  e4:	0008a023          	sw	zero,0(a7)
  e8:	00478793          	addi	a5,a5,4
  ec:	00430313          	addi	t1,t1,4
  f0:	00488893          	addi	a7,a7,4
  f4:	f9c798e3          	bne	a5,t3,84 <main+0x84>
  f8:	000207b7          	lui	a5,0x20
  fc:	0007a583          	lw	a1,0(a5) # 20000 <err_limit>
 100:	00100e37          	lui	t3,0x100
 104:	520e0e13          	addi	t3,t3,1312 # 100520 <err_count>
 108:	00100737          	lui	a4,0x100
 10c:	000e2023          	sw	zero,0(t3)
 110:	40b00333          	neg	t1,a1
 114:	4a070713          	addi	a4,a4,1184 # 1004a0 <expected_output>
 118:	08080513          	addi	a0,a6,128
 11c:	00000893          	li	a7,0
 120:	00000613          	li	a2,0
 124:	00082783          	lw	a5,0(a6)
 128:	00072683          	lw	a3,0(a4)
 12c:	00480813          	addi	a6,a6,4
 130:	00470713          	addi	a4,a4,4
 134:	40d787b3          	sub	a5,a5,a3
 138:	00f5c463          	blt	a1,a5,140 <main+0x140>
 13c:	0067d663          	bge	a5,t1,148 <main+0x148>
 140:	00160613          	addi	a2,a2,1
 144:	00100893          	li	a7,1
 148:	fd051ee3          	bne	a0,a6,124 <main+0x124>
 14c:	00088463          	beqz	a7,154 <main+0x154>
 150:	00ce2023          	sw	a2,0(t3)
 154:	01c12403          	lw	s0,28(sp)
 158:	01812483          	lw	s1,24(sp)
 15c:	01412903          	lw	s2,20(sp)
 160:	01012983          	lw	s3,16(sp)
 164:	00c12a03          	lw	s4,12(sp)
 168:	00812a83          	lw	s5,8(sp)
 16c:	00000513          	li	a0,0
 170:	02010113          	addi	sp,sp,32
 174:	00008067          	ret
	...

00000180 <boot>:
 180:	00002fb7          	lui	t6,0x2
 184:	800f8f93          	addi	t6,t6,-2048 # 1800 <__stack_init+0x1310>
 188:	300f9073          	csrw	mstatus,t6
 18c:	0340006f          	j	1c0 <_mstart>
 190:	00000013          	nop
 194:	00000013          	nop
 198:	00000013          	nop
 19c:	00000013          	nop
 1a0:	00000013          	nop
 1a4:	00000013          	nop
 1a8:	00000013          	nop
 1ac:	00000013          	nop
 1b0:	00000013          	nop
 1b4:	00000013          	nop
 1b8:	00000013          	nop
 1bc:	00000013          	nop

000001c0 <_mstart>:
 1c0:	00000297          	auipc	t0,0x0
 1c4:	0b428293          	addi	t0,t0,180 # 274 <trap_entry>
 1c8:	30529073          	csrw	mtvec,t0
 1cc:	00000093          	li	ra,0
 1d0:	00000113          	li	sp,0
 1d4:	00000193          	li	gp,0
 1d8:	00000213          	li	tp,0
 1dc:	00000293          	li	t0,0
 1e0:	00000313          	li	t1,0
 1e4:	00000393          	li	t2,0
 1e8:	00000413          	li	s0,0
 1ec:	00000493          	li	s1,0
 1f0:	00000513          	li	a0,0
 1f4:	00000593          	li	a1,0
 1f8:	00000613          	li	a2,0
 1fc:	00000693          	li	a3,0
 200:	00000713          	li	a4,0
 204:	00000793          	li	a5,0
 208:	00000813          	li	a6,0
 20c:	00000893          	li	a7,0
 210:	00000913          	li	s2,0
 214:	00000993          	li	s3,0
 218:	00000a13          	li	s4,0
 21c:	00000a93          	li	s5,0
 220:	00000b13          	li	s6,0
 224:	00000b93          	li	s7,0
 228:	00000c13          	li	s8,0
 22c:	00000c93          	li	s9,0
 230:	00000d13          	li	s10,0
 234:	00000d93          	li	s11,0
 238:	00000e13          	li	t3,0
 23c:	00000e93          	li	t4,0
 240:	00000f13          	li	t5,0
 244:	00000f93          	li	t6,0
 248:	00020197          	auipc	gp,0x20
 24c:	5b818193          	addi	gp,gp,1464 # 20800 <__global_pointer$>
 250:	000ff117          	auipc	sp,0xff
 254:	dac10113          	addi	sp,sp,-596 # feffc <__stacktop>
 258:	00000297          	auipc	t0,0x0
 25c:	01c28293          	addi	t0,t0,28 # 274 <trap_entry>
 260:	00012503          	lw	a0,0(sp)
 264:	00000613          	li	a2,0
 268:	d99ff0ef          	jal	ra,0 <main>
 26c:	0000006f          	j	26c <_mstart+0xac>
 270:	00008067          	ret

00000274 <trap_entry>:
 274:	03c0006f          	j	2b0 <ISR5>
 278:	30200073          	mret
 27c:	0340006f          	j	2b0 <ISR5>
 280:	30200073          	mret
 284:	02c0006f          	j	2b0 <ISR5>
 288:	30200073          	mret
 28c:	0240006f          	j	2b0 <ISR5>
 290:	30200073          	mret
 294:	01c0006f          	j	2b0 <ISR5>
 298:	30200073          	mret
 29c:	1300006f          	j	3cc <ISR6>
 2a0:	30200073          	mret
	...

000002b0 <ISR5>:
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
 33c:	1ac000ef          	jal	ra,4e8 <ISR5_uart>
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

000003cc <ISR6>:
 3cc:	30047073          	csrci	mstatus,8
 3d0:	e8010113          	addi	sp,sp,-384
 3d4:	10112023          	sw	ra,256(sp)
 3d8:	10212223          	sw	sp,260(sp)
 3dc:	10312423          	sw	gp,264(sp)
 3e0:	10412623          	sw	tp,268(sp)
 3e4:	10512823          	sw	t0,272(sp)
 3e8:	10612a23          	sw	t1,276(sp)
 3ec:	10712c23          	sw	t2,280(sp)
 3f0:	10812e23          	sw	s0,284(sp)
 3f4:	12912023          	sw	s1,288(sp)
 3f8:	12a12223          	sw	a0,292(sp)
 3fc:	12b12423          	sw	a1,296(sp)
 400:	12c12623          	sw	a2,300(sp)
 404:	12d12823          	sw	a3,304(sp)
 408:	12e12a23          	sw	a4,308(sp)
 40c:	12f12c23          	sw	a5,312(sp)
 410:	13012e23          	sw	a6,316(sp)
 414:	15112023          	sw	a7,320(sp)
 418:	15212223          	sw	s2,324(sp)
 41c:	15312423          	sw	s3,328(sp)
 420:	15412623          	sw	s4,332(sp)
 424:	15512823          	sw	s5,336(sp)
 428:	15612a23          	sw	s6,340(sp)
 42c:	15712c23          	sw	s7,344(sp)
 430:	15812e23          	sw	s8,348(sp)
 434:	17912023          	sw	s9,352(sp)
 438:	17a12223          	sw	s10,356(sp)
 43c:	17b12423          	sw	s11,360(sp)
 440:	17c12623          	sw	t3,364(sp)
 444:	17d12823          	sw	t4,368(sp)
 448:	17e12a23          	sw	t5,372(sp)
 44c:	17f12c23          	sw	t6,376(sp)
 450:	341022f3          	csrr	t0,mepc
 454:	16512e23          	sw	t0,380(sp)
 458:	094000ef          	jal	ra,4ec <ISR6_addr_exception>
 45c:	30047073          	csrci	mstatus,8
 460:	17c12283          	lw	t0,380(sp)
 464:	34129073          	csrw	mepc,t0
 468:	10012083          	lw	ra,256(sp)
 46c:	10c12203          	lw	tp,268(sp)
 470:	11012283          	lw	t0,272(sp)
 474:	11412303          	lw	t1,276(sp)
 478:	11812383          	lw	t2,280(sp)
 47c:	11c12403          	lw	s0,284(sp)
 480:	12012483          	lw	s1,288(sp)
 484:	12412503          	lw	a0,292(sp)
 488:	12812583          	lw	a1,296(sp)
 48c:	12c12603          	lw	a2,300(sp)
 490:	13012683          	lw	a3,304(sp)
 494:	13412703          	lw	a4,308(sp)
 498:	13812783          	lw	a5,312(sp)
 49c:	13c12803          	lw	a6,316(sp)
 4a0:	14012883          	lw	a7,320(sp)
 4a4:	14412903          	lw	s2,324(sp)
 4a8:	14812983          	lw	s3,328(sp)
 4ac:	14c12a03          	lw	s4,332(sp)
 4b0:	15012a83          	lw	s5,336(sp)
 4b4:	15412b03          	lw	s6,340(sp)
 4b8:	15812b83          	lw	s7,344(sp)
 4bc:	15c12c03          	lw	s8,348(sp)
 4c0:	16012c83          	lw	s9,352(sp)
 4c4:	16412d03          	lw	s10,356(sp)
 4c8:	16812d83          	lw	s11,360(sp)
 4cc:	16c12e03          	lw	t3,364(sp)
 4d0:	17012e83          	lw	t4,368(sp)
 4d4:	17412f03          	lw	t5,372(sp)
 4d8:	17812f83          	lw	t6,376(sp)
 4dc:	18010113          	addi	sp,sp,384
 4e0:	30046073          	csrsi	mstatus,8
 4e4:	30200073          	mret

000004e8 <ISR5_uart>:
 4e8:	00008067          	ret

000004ec <ISR6_addr_exception>:
 4ec:	00008067          	ret

000004f0 <__stack_init>:
 4f0:	000feffc                                ....
