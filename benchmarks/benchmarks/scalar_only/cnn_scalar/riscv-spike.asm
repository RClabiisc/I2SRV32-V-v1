
riscv-spike.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <main>:
   0:	ff010113          	addi	sp,sp,-16
   4:	00912223          	sw	s1,4(sp)
   8:	00100737          	lui	a4,0x100
   c:	0010d4b7          	lui	s1,0x10d
  10:	00100637          	lui	a2,0x100
  14:	000205b7          	lui	a1,0x20
  18:	50048513          	addi	a0,s1,1280 # 10d500 <Y>
  1c:	01000793          	li	a5,16
  20:	24070713          	addi	a4,a4,576 # 100240 <bias>
  24:	01c00693          	li	a3,28
  28:	00060613          	mv	a2,a2
  2c:	00058593          	mv	a1,a1
  30:	00112623          	sw	ra,12(sp)
  34:	00812423          	sw	s0,8(sp)
  38:	1b8000ef          	jal	ra,1f0 <conv2d>
  3c:	0010d437          	lui	s0,0x10d
  40:	00105737          	lui	a4,0x105
  44:	00100637          	lui	a2,0x100
  48:	02000793          	li	a5,32
  4c:	50048593          	addi	a1,s1,1280
  50:	88040513          	addi	a0,s0,-1920 # 10c880 <Y2>
  54:	01000813          	li	a6,16
  58:	a8070713          	addi	a4,a4,-1408 # 104a80 <bias2>
  5c:	00d00693          	li	a3,13
  60:	28060613          	addi	a2,a2,640 # 100280 <ker2>
  64:	488000ef          	jal	ra,4ec <layer2>
  68:	0010d6b7          	lui	a3,0x10d
  6c:	001055b7          	lui	a1,0x105
  70:	88040513          	addi	a0,s0,-1920
  74:	00a00713          	li	a4,10
  78:	80068693          	addi	a3,a3,-2048 # 10c800 <bias3>
  7c:	32000613          	li	a2,800
  80:	b0058593          	addi	a1,a1,-1280 # 104b00 <w3>
  84:	08d000ef          	jal	ra,910 <layer3>
  88:	00c12083          	lw	ra,12(sp)
  8c:	00812403          	lw	s0,8(sp)
  90:	0010d7b7          	lui	a5,0x10d
  94:	84a7a023          	sw	a0,-1984(a5) # 10c840 <output>
  98:	00412483          	lw	s1,4(sp)
  9c:	00000513          	li	a0,0
  a0:	01010113          	addi	sp,sp,16
  a4:	00008067          	ret
	...

000000c0 <boot>:
  c0:	00002fb7          	lui	t6,0x2
  c4:	800f8f93          	addi	t6,t6,-2048 # 1800 <__stack_init+0xaf8>
  c8:	300f9073          	csrw	mstatus,t6
  cc:	0340006f          	j	100 <_mstart>
  d0:	00000013          	nop
  d4:	00000013          	nop
  d8:	00000013          	nop
  dc:	00000013          	nop
  e0:	00000013          	nop
  e4:	00000013          	nop
  e8:	00000013          	nop
  ec:	00000013          	nop
  f0:	00000013          	nop
  f4:	00000013          	nop
  f8:	00000013          	nop
  fc:	00000013          	nop

00000100 <_mstart>:
 100:	00000297          	auipc	t0,0x0
 104:	0b428293          	addi	t0,t0,180 # 1b4 <trap_entry>
 108:	30529073          	csrw	mtvec,t0
 10c:	00000093          	li	ra,0
 110:	00000113          	li	sp,0
 114:	00000193          	li	gp,0
 118:	00000213          	li	tp,0
 11c:	00000293          	li	t0,0
 120:	00000313          	li	t1,0
 124:	00000393          	li	t2,0
 128:	00000413          	li	s0,0
 12c:	00000493          	li	s1,0
 130:	00000513          	li	a0,0
 134:	00000593          	li	a1,0
 138:	00000613          	li	a2,0
 13c:	00000693          	li	a3,0
 140:	00000713          	li	a4,0
 144:	00000793          	li	a5,0
 148:	00000813          	li	a6,0
 14c:	00000893          	li	a7,0
 150:	00000913          	li	s2,0
 154:	00000993          	li	s3,0
 158:	00000a13          	li	s4,0
 15c:	00000a93          	li	s5,0
 160:	00000b13          	li	s6,0
 164:	00000b93          	li	s7,0
 168:	00000c13          	li	s8,0
 16c:	00000c93          	li	s9,0
 170:	00000d13          	li	s10,0
 174:	00000d93          	li	s11,0
 178:	00000e13          	li	t3,0
 17c:	00000e93          	li	t4,0
 180:	00000f13          	li	t5,0
 184:	00000f93          	li	t6,0
 188:	00024197          	auipc	gp,0x24
 18c:	9a418193          	addi	gp,gp,-1628 # 23b2c <__global_pointer$>
 190:	000ff117          	auipc	sp,0xff
 194:	e6c10113          	addi	sp,sp,-404 # feffc <__stacktop>
 198:	00000297          	auipc	t0,0x0
 19c:	01c28293          	addi	t0,t0,28 # 1b4 <trap_entry>
 1a0:	00012503          	lw	a0,0(sp)
 1a4:	00000613          	li	a2,0
 1a8:	e59ff0ef          	jal	ra,0 <main>
 1ac:	0000006f          	j	1ac <_mstart+0xac>
 1b0:	00008067          	ret

000001b4 <trap_entry>:
 1b4:	1150006f          	j	ac8 <ISR5>
 1b8:	30200073          	mret
 1bc:	10d0006f          	j	ac8 <ISR5>
 1c0:	30200073          	mret
 1c4:	1050006f          	j	ac8 <ISR5>
 1c8:	30200073          	mret
 1cc:	0fd0006f          	j	ac8 <ISR5>
 1d0:	30200073          	mret
 1d4:	0f50006f          	j	ac8 <ISR5>
 1d8:	30200073          	mret
 1dc:	2090006f          	j	be4 <ISR6>
 1e0:	30200073          	mret
	...

000001f0 <conv2d>:
 1f0:	fa010113          	addi	sp,sp,-96
 1f4:	0d000793          	li	a5,208
 1f8:	00f12a23          	sw	a5,20(sp)
 1fc:	04060793          	addi	a5,a2,64
 200:	04812e23          	sw	s0,92(sp)
 204:	04912c23          	sw	s1,88(sp)
 208:	05212a23          	sw	s2,84(sp)
 20c:	05312823          	sw	s3,80(sp)
 210:	05412623          	sw	s4,76(sp)
 214:	05512423          	sw	s5,72(sp)
 218:	05612223          	sw	s6,68(sp)
 21c:	05712023          	sw	s7,64(sp)
 220:	03812e23          	sw	s8,60(sp)
 224:	03912c23          	sw	s9,56(sp)
 228:	03a12a23          	sw	s10,52(sp)
 22c:	03b12823          	sw	s11,48(sp)
 230:	00c12c23          	sw	a2,24(sp)
 234:	00e12e23          	sw	a4,28(sp)
 238:	02a12423          	sw	a0,40(sp)
 23c:	02b12623          	sw	a1,44(sp)
 240:	02012023          	sw	zero,32(sp)
 244:	02012223          	sw	zero,36(sp)
 248:	00f12423          	sw	a5,8(sp)
 24c:	02c12783          	lw	a5,44(sp)
 250:	00078c93          	mv	s9,a5
 254:	0e078293          	addi	t0,a5,224
 258:	07078f93          	addi	t6,a5,112
 25c:	02012783          	lw	a5,32(sp)
 260:	150c8b13          	addi	s6,s9,336
 264:	02512623          	sw	t0,44(sp)
 268:	03878793          	addi	a5,a5,56
 26c:	02f12023          	sw	a5,32(sp)
 270:	02412783          	lw	a5,36(sp)
 274:	000b0b93          	mv	s7,s6
 278:	00479793          	slli	a5,a5,0x4
 27c:	00f12823          	sw	a5,16(sp)
 280:	02812783          	lw	a5,40(sp)
 284:	00f12623          	sw	a5,12(sp)
 288:	01812703          	lw	a4,24(sp)
 28c:	01c12383          	lw	t2,28(sp)
 290:	00c12d03          	lw	s10,12(sp)
 294:	00072f03          	lw	t5,0(a4)
 298:	04072983          	lw	s3,64(a4)
 29c:	004caa03          	lw	s4,4(s9)
 2a0:	000cac03          	lw	s8,0(s9)
 2a4:	008ca903          	lw	s2,8(s9)
 2a8:	03498b33          	mul	s6,s3,s4
 2ac:	08072e83          	lw	t4,128(a4)
 2b0:	004fae03          	lw	t3,4(t6)
 2b4:	008fa883          	lw	a7,8(t6)
 2b8:	000fa483          	lw	s1,0(t6)
 2bc:	0c072303          	lw	t1,192(a4)
 2c0:	10072803          	lw	a6,256(a4)
 2c4:	0042a583          	lw	a1,4(t0)
 2c8:	00cfa403          	lw	s0,12(t6)
 2cc:	0082a683          	lw	a3,8(t0)
 2d0:	038f0c33          	mul	s8,t5,s8
 2d4:	14072503          	lw	a0,320(a4)
 2d8:	18072603          	lw	a2,384(a4)
 2dc:	1c072a83          	lw	s5,448(a4)
 2e0:	20072783          	lw	a5,512(a4)
 2e4:	03390db3          	mul	s11,s2,s3
 2e8:	016c0b33          	add	s6,s8,s6
 2ec:	00ccac03          	lw	s8,12(s9)
 2f0:	03ea0a33          	mul	s4,s4,t5
 2f4:	032e8933          	mul	s2,t4,s2
 2f8:	014d8a33          	add	s4,s11,s4
 2fc:	038e8db3          	mul	s11,t4,s8
 300:	01690b33          	add	s6,s2,s6
 304:	03e48c33          	mul	s8,s1,t5
 308:	014d8a33          	add	s4,s11,s4
 30c:	03c98933          	mul	s2,s3,t3
 310:	03ee0f33          	mul	t5,t3,t5
 314:	01890c33          	add	s8,s2,s8
 318:	033889b3          	mul	s3,a7,s3
 31c:	029304b3          	mul	s1,t1,s1
 320:	01e98f33          	add	t5,s3,t5
 324:	03c30db3          	mul	s11,t1,t3
 328:	01648b33          	add	s6,s1,s6
 32c:	03c80e33          	mul	t3,a6,t3
 330:	014d8a33          	add	s4,s11,s4
 334:	031e89b3          	mul	s3,t4,a7
 338:	016e0b33          	add	s6,t3,s6
 33c:	0002ae03          	lw	t3,0(t0)
 340:	01898c33          	add	s8,s3,s8
 344:	026e09b3          	mul	s3,t3,t1
 348:	01898c33          	add	s8,s3,s8
 34c:	02b809b3          	mul	s3,a6,a1
 350:	03d40eb3          	mul	t4,s0,t4
 354:	018989b3          	add	s3,s3,s8
 358:	02658333          	mul	t1,a1,t1
 35c:	01ee8f33          	add	t5,t4,t5
 360:	03180db3          	mul	s11,a6,a7
 364:	01e30f33          	add	t5,t1,t5
 368:	03068833          	mul	a6,a3,a6
 36c:	014d8a33          	add	s4,s11,s4
 370:	02850433          	mul	s0,a0,s0
 374:	01e80f33          	add	t5,a6,t5
 378:	00c2a803          	lw	a6,12(t0)
 37c:	02d50c33          	mul	s8,a0,a3
 380:	01440a33          	add	s4,s0,s4
 384:	02b60433          	mul	s0,a2,a1
 388:	013c0c33          	add	s8,s8,s3
 38c:	031508b3          	mul	a7,a0,a7
 390:	01440a33          	add	s4,s0,s4
 394:	02a80533          	mul	a0,a6,a0
 398:	000ba803          	lw	a6,0(s7)
 39c:	01688b33          	add	s6,a7,s6
 3a0:	008ba883          	lw	a7,8(s7)
 3a4:	030609b3          	mul	s3,a2,a6
 3a8:	004ba803          	lw	a6,4(s7)
 3ac:	01e50533          	add	a0,a0,t5
 3b0:	03c60e33          	mul	t3,a2,t3
 3b4:	018989b3          	add	s3,s3,s8
 3b8:	02c80633          	mul	a2,a6,a2
 3bc:	00c2a803          	lw	a6,12(t0)
 3c0:	016e0b33          	add	s6,t3,s6
 3c4:	02ba85b3          	mul	a1,s5,a1
 3c8:	00a60633          	add	a2,a2,a0
 3cc:	02da8433          	mul	s0,s5,a3
 3d0:	016585b3          	add	a1,a1,s6
 3d4:	02d786b3          	mul	a3,a5,a3
 3d8:	01440a33          	add	s4,s0,s4
 3dc:	03078833          	mul	a6,a5,a6
 3e0:	00b686b3          	add	a3,a3,a1
 3e4:	004ba583          	lw	a1,4(s7)
 3e8:	01480533          	add	a0,a6,s4
 3ec:	008ba803          	lw	a6,8(s7)
 3f0:	02ba85b3          	mul	a1,s5,a1
 3f4:	03078833          	mul	a6,a5,a6
 3f8:	013585b3          	add	a1,a1,s3
 3fc:	03588ab3          	mul	s5,a7,s5
 400:	00b805b3          	add	a1,a6,a1
 404:	00ca8633          	add	a2,s5,a2
 408:	00d55463          	bge	a0,a3,410 <conv2d+0x220>
 40c:	00068513          	mv	a0,a3
 410:	00a5d463          	bge	a1,a0,418 <conv2d+0x228>
 414:	00050593          	mv	a1,a0
 418:	00cba683          	lw	a3,12(s7)
 41c:	02d787b3          	mul	a5,a5,a3
 420:	00c787b3          	add	a5,a5,a2
 424:	00b7d463          	bge	a5,a1,42c <conv2d+0x23c>
 428:	00058793          	mv	a5,a1
 42c:	0003a683          	lw	a3,0(t2)
 430:	00d787b3          	add	a5,a5,a3
 434:	0af05863          	blez	a5,4e4 <conv2d+0x2f4>
 438:	00fd2023          	sw	a5,0(s10)
 43c:	00812783          	lw	a5,8(sp)
 440:	00470713          	addi	a4,a4,4
 444:	00438393          	addi	t2,t2,4
 448:	004d0d13          	addi	s10,s10,4
 44c:	e4f714e3          	bne	a4,a5,294 <conv2d+0xa4>
 450:	00c12703          	lw	a4,12(sp)
 454:	01012783          	lw	a5,16(sp)
 458:	008c8c93          	addi	s9,s9,8
 45c:	04070713          	addi	a4,a4,64
 460:	00e12623          	sw	a4,12(sp)
 464:	01412703          	lw	a4,20(sp)
 468:	01078793          	addi	a5,a5,16
 46c:	00f12823          	sw	a5,16(sp)
 470:	008f8f93          	addi	t6,t6,8
 474:	00828293          	addi	t0,t0,8
 478:	008b8b93          	addi	s7,s7,8
 47c:	e0f716e3          	bne	a4,a5,288 <conv2d+0x98>
 480:	0d070793          	addi	a5,a4,208
 484:	00f12a23          	sw	a5,20(sp)
 488:	02812783          	lw	a5,40(sp)
 48c:	2d800713          	li	a4,728
 490:	34078793          	addi	a5,a5,832
 494:	02f12423          	sw	a5,40(sp)
 498:	02412783          	lw	a5,36(sp)
 49c:	00d78793          	addi	a5,a5,13
 4a0:	02f12223          	sw	a5,36(sp)
 4a4:	02012783          	lw	a5,32(sp)
 4a8:	dae792e3          	bne	a5,a4,24c <conv2d+0x5c>
 4ac:	05c12403          	lw	s0,92(sp)
 4b0:	05812483          	lw	s1,88(sp)
 4b4:	05412903          	lw	s2,84(sp)
 4b8:	05012983          	lw	s3,80(sp)
 4bc:	04c12a03          	lw	s4,76(sp)
 4c0:	04812a83          	lw	s5,72(sp)
 4c4:	04412b03          	lw	s6,68(sp)
 4c8:	04012b83          	lw	s7,64(sp)
 4cc:	03c12c03          	lw	s8,60(sp)
 4d0:	03812c83          	lw	s9,56(sp)
 4d4:	03412d03          	lw	s10,52(sp)
 4d8:	03012d83          	lw	s11,48(sp)
 4dc:	06010113          	addi	sp,sp,96
 4e0:	00008067          	ret
 4e4:	000d2023          	sw	zero,0(s10)
 4e8:	f55ff06f          	j	43c <conv2d+0x24c>

000004ec <layer2>:
 4ec:	f6010113          	addi	sp,sp,-160
 4f0:	000017b7          	lui	a5,0x1
 4f4:	80078793          	addi	a5,a5,-2048 # 800 <layer2+0x314>
 4f8:	06e12623          	sw	a4,108(sp)
 4fc:	0a000713          	li	a4,160
 500:	04e12c23          	sw	a4,88(sp)
 504:	04f12623          	sw	a5,76(sp)
 508:	fffff737          	lui	a4,0xfffff
 50c:	000047b7          	lui	a5,0x4
 510:	80070713          	addi	a4,a4,-2048 # ffffe800 <__VREG_END+0xffe7e800>
 514:	80078793          	addi	a5,a5,-2048 # 3800 <__stack_init+0x2af8>
 518:	08812e23          	sw	s0,156(sp)
 51c:	08912c23          	sw	s1,152(sp)
 520:	09212a23          	sw	s2,148(sp)
 524:	09312823          	sw	s3,144(sp)
 528:	09412623          	sw	s4,140(sp)
 52c:	09512423          	sw	s5,136(sp)
 530:	09612223          	sw	s6,132(sp)
 534:	09712023          	sw	s7,128(sp)
 538:	07812e23          	sw	s8,124(sp)
 53c:	07912c23          	sw	s9,120(sp)
 540:	07a12a23          	sw	s10,116(sp)
 544:	07b12823          	sw	s11,112(sp)
 548:	06a12223          	sw	a0,100(sp)
 54c:	06c12423          	sw	a2,104(sp)
 550:	04b12a23          	sw	a1,84(sp)
 554:	04012823          	sw	zero,80(sp)
 558:	06012023          	sw	zero,96(sp)
 55c:	04e12423          	sw	a4,72(sp)
 560:	02f12a23          	sw	a5,52(sp)
 564:	05012783          	lw	a5,80(sp)
 568:	00579793          	slli	a5,a5,0x5
 56c:	04f12e23          	sw	a5,92(sp)
 570:	05412783          	lw	a5,84(sp)
 574:	04f12223          	sw	a5,68(sp)
 578:	05c12783          	lw	a5,92(sp)
 57c:	06412703          	lw	a4,100(sp)
 580:	04012023          	sw	zero,64(sp)
 584:	00279793          	slli	a5,a5,0x2
 588:	00f707b3          	add	a5,a4,a5
 58c:	02f12e23          	sw	a5,60(sp)
 590:	06c12783          	lw	a5,108(sp)
 594:	00002737          	lui	a4,0x2
 598:	02f12c23          	sw	a5,56(sp)
 59c:	06812783          	lw	a5,104(sp)
 5a0:	00e787b3          	add	a5,a5,a4
 5a4:	02f12823          	sw	a5,48(sp)
 5a8:	04412b83          	lw	s7,68(sp)
 5ac:	000017b7          	lui	a5,0x1
 5b0:	9c078793          	addi	a5,a5,-1600 # 9c0 <layer3+0xb0>
 5b4:	04812703          	lw	a4,72(sp)
 5b8:	00fb86b3          	add	a3,s7,a5
 5bc:	03012783          	lw	a5,48(sp)
 5c0:	00000c13          	li	s8,0
 5c4:	000c0a93          	mv	s5,s8
 5c8:	00e783b3          	add	t2,a5,a4
 5cc:	04c12703          	lw	a4,76(sp)
 5d0:	80078a13          	addi	s4,a5,-2048
 5d4:	00012823          	sw	zero,16(sp)
 5d8:	00e78733          	add	a4,a5,a4
 5dc:	00e12423          	sw	a4,8(sp)
 5e0:	00002737          	lui	a4,0x2
 5e4:	80070713          	addi	a4,a4,-2048 # 1800 <__stack_init+0xaf8>
 5e8:	00e787b3          	add	a5,a5,a4
 5ec:	00f12623          	sw	a5,12(sp)
 5f0:	00000c93          	li	s9,0
 5f4:	00000d13          	li	s10,0
 5f8:	000a0f93          	mv	t6,s4
 5fc:	00068c13          	mv	s8,a3
 600:	8003ae83          	lw	t4,-2048(t2)
 604:	0c0ba783          	lw	a5,192(s7)
 608:	000bab03          	lw	s6,0(s7)
 60c:	740ba683          	lw	a3,1856(s7)
 610:	02f12223          	sw	a5,36(sp)
 614:	036e8b33          	mul	s6,t4,s6
 618:	680ba783          	lw	a5,1664(s7)
 61c:	00c12f03          	lw	t5,12(sp)
 620:	00d12c23          	sw	a3,24(sp)
 624:	00f12e23          	sw	a5,28(sp)
 628:	00812783          	lw	a5,8(sp)
 62c:	800f2683          	lw	a3,-2048(t5)
 630:	040c2a03          	lw	s4,64(s8)
 634:	8007a503          	lw	a0,-2048(a5)
 638:	0007a603          	lw	a2,0(a5)
 63c:	000f2783          	lw	a5,0(t5)
 640:	03412f03          	lw	t5,52(sp)
 644:	000c2d83          	lw	s11,0(s8)
 648:	3c0ba583          	lw	a1,960(s7)
 64c:	01e38f33          	add	t5,t2,t5
 650:	380ba803          	lw	a6,896(s7)
 654:	0003ae03          	lw	t3,0(t2)
 658:	800fa303          	lw	t1,-2048(t6)
 65c:	000fa883          	lw	a7,0(t6)
 660:	6c0ba703          	lw	a4,1728(s7)
 664:	700ba283          	lw	t0,1792(s7)
 668:	040ba983          	lw	s3,64(s7)
 66c:	340ba483          	lw	s1,832(s7)
 670:	080ba903          	lw	s2,128(s7)
 674:	400ba403          	lw	s0,1024(s7)
 678:	03612023          	sw	s6,32(sp)
 67c:	01412a23          	sw	s4,20(sp)
 680:	03b12423          	sw	s11,40(sp)
 684:	080c2d83          	lw	s11,128(s8)
 688:	000f2f03          	lw	t5,0(t5)
 68c:	0c0c2b03          	lw	s6,192(s8)
 690:	03d98a33          	mul	s4,s3,t4
 694:	080f8f93          	addi	t6,t6,128
 698:	03612623          	sw	s6,44(sp)
 69c:	02012b03          	lw	s6,32(sp)
 6a0:	004b8b93          	addi	s7,s7,4
 6a4:	004c0c13          	addi	s8,s8,4
 6a8:	015b0b33          	add	s6,s6,s5
 6ac:	00812a83          	lw	s5,8(sp)
 6b0:	08038393          	addi	t2,t2,128
 6b4:	080a8a93          	addi	s5,s5,128
 6b8:	01512423          	sw	s5,8(sp)
 6bc:	03d48ab3          	mul	s5,s1,t4
 6c0:	01aa0d33          	add	s10,s4,s10
 6c4:	00c12a03          	lw	s4,12(sp)
 6c8:	080a0a13          	addi	s4,s4,128
 6cc:	01412623          	sw	s4,12(sp)
 6d0:	03d80eb3          	mul	t4,a6,t4
 6d4:	019a8ab3          	add	s5,s5,s9
 6d8:	01012c83          	lw	s9,16(sp)
 6dc:	03c90a33          	mul	s4,s2,t3
 6e0:	019e8eb3          	add	t4,t4,s9
 6e4:	033e09b3          	mul	s3,t3,s3
 6e8:	01aa0d33          	add	s10,s4,s10
 6ec:	030e0cb3          	mul	s9,t3,a6
 6f0:	016989b3          	add	s3,s3,s6
 6f4:	03c58e33          	mul	t3,a1,t3
 6f8:	015c8ab3          	add	s5,s9,s5
 6fc:	01de0eb3          	add	t4,t3,t4
 700:	02412e03          	lw	t3,36(sp)
 704:	02b30cb3          	mul	s9,t1,a1
 708:	03c30a33          	mul	s4,t1,t3
 70c:	015c8cb3          	add	s9,s9,s5
 710:	03230933          	mul	s2,t1,s2
 714:	01aa0d33          	add	s10,s4,s10
 718:	02640333          	mul	t1,s0,t1
 71c:	013909b3          	add	s3,s2,s3
 720:	01d30eb3          	add	t4,t1,t4
 724:	01c12303          	lw	t1,28(sp)
 728:	03088a33          	mul	s4,a7,a6
 72c:	03130ab3          	mul	s5,t1,a7
 730:	01aa0d33          	add	s10,s4,s10
 734:	019a8cb3          	add	s9,s5,s9
 738:	02e50ab3          	mul	s5,a0,a4
 73c:	029884b3          	mul	s1,a7,s1
 740:	019a8cb3          	add	s9,s5,s9
 744:	031708b3          	mul	a7,a4,a7
 748:	013489b3          	add	s3,s1,s3
 74c:	02b50a33          	mul	s4,a0,a1
 750:	01d88eb3          	add	t4,a7,t4
 754:	03050833          	mul	a6,a0,a6
 758:	01aa0a33          	add	s4,s4,s10
 75c:	02a28533          	mul	a0,t0,a0
 760:	013809b3          	add	s3,a6,s3
 764:	02560ab3          	mul	s5,a2,t0
 768:	01d50eb3          	add	t4,a0,t4
 76c:	02812503          	lw	a0,40(sp)
 770:	02b60b33          	mul	s6,a2,a1
 774:	01812583          	lw	a1,24(sp)
 778:	019a8ab3          	add	s5,s5,s9
 77c:	02860433          	mul	s0,a2,s0
 780:	013b09b3          	add	s3,s6,s3
 784:	02c58633          	mul	a2,a1,a2
 788:	01440a33          	add	s4,s0,s4
 78c:	02e68d33          	mul	s10,a3,a4
 790:	01d60eb3          	add	t4,a2,t4
 794:	01412603          	lw	a2,20(sp)
 798:	02a68cb3          	mul	s9,a3,a0
 79c:	014d0a33          	add	s4,s10,s4
 7a0:	02668b33          	mul	s6,a3,t1
 7a4:	015c8ab3          	add	s5,s9,s5
 7a8:	02e78733          	mul	a4,a5,a4
 7ac:	013b0b33          	add	s6,s6,s3
 7b0:	02578d33          	mul	s10,a5,t0
 7b4:	01670b33          	add	s6,a4,s6
 7b8:	02f60cb3          	mul	s9,a2,a5
 7bc:	014d0d33          	add	s10,s10,s4
 7c0:	025f02b3          	mul	t0,t5,t0
 7c4:	015c8cb3          	add	s9,s9,s5
 7c8:	01628ab3          	add	s5,t0,s6
 7cc:	02c12b03          	lw	s6,44(sp)
 7d0:	02c686b3          	mul	a3,a3,a2
 7d4:	03b787b3          	mul	a5,a5,s11
 7d8:	01d686b3          	add	a3,a3,t4
 7dc:	02bf0733          	mul	a4,t5,a1
 7e0:	00d787b3          	add	a5,a5,a3
 7e4:	03ed8db3          	mul	s11,s11,t5
 7e8:	01a70d33          	add	s10,a4,s10
 7ec:	036f0f33          	mul	t5,t5,s6
 7f0:	019d8cb3          	add	s9,s11,s9
 7f4:	00ff07b3          	add	a5,t5,a5
 7f8:	00f12823          	sw	a5,16(sp)
 7fc:	03012783          	lw	a5,48(sp)
 800:	e1f790e3          	bne	a5,t6,600 <layer2+0x114>
 804:	01012703          	lw	a4,16(sp)
 808:	000a8c13          	mv	s8,s5
 80c:	000c8793          	mv	a5,s9
 810:	00ecd463          	bge	s9,a4,818 <layer2+0x32c>
 814:	00070793          	mv	a5,a4
 818:	01a7d463          	bge	a5,s10,820 <layer2+0x334>
 81c:	000d0793          	mv	a5,s10
 820:	0187d463          	bge	a5,s8,828 <layer2+0x33c>
 824:	000c0793          	mv	a5,s8
 828:	03812703          	lw	a4,56(sp)
 82c:	00072703          	lw	a4,0(a4)
 830:	00e787b3          	add	a5,a5,a4
 834:	0cf05663          	blez	a5,900 <layer2+0x414>
 838:	03c12703          	lw	a4,60(sp)
 83c:	00f72023          	sw	a5,0(a4)
 840:	00470713          	addi	a4,a4,4
 844:	02e12e23          	sw	a4,60(sp)
 848:	03812703          	lw	a4,56(sp)
 84c:	04012783          	lw	a5,64(sp)
 850:	00470713          	addi	a4,a4,4
 854:	02e12c23          	sw	a4,56(sp)
 858:	03012703          	lw	a4,48(sp)
 85c:	00178793          	addi	a5,a5,1
 860:	04f12023          	sw	a5,64(sp)
 864:	00470713          	addi	a4,a4,4
 868:	02e12823          	sw	a4,48(sp)
 86c:	02000713          	li	a4,32
 870:	d2e79ce3          	bne	a5,a4,5a8 <layer2+0xbc>
 874:	04412703          	lw	a4,68(sp)
 878:	05c12783          	lw	a5,92(sp)
 87c:	08070713          	addi	a4,a4,128
 880:	04e12223          	sw	a4,68(sp)
 884:	05812703          	lw	a4,88(sp)
 888:	02078793          	addi	a5,a5,32
 88c:	04f12e23          	sw	a5,92(sp)
 890:	cef714e3          	bne	a4,a5,578 <layer2+0x8c>
 894:	0a070713          	addi	a4,a4,160
 898:	04e12c23          	sw	a4,88(sp)
 89c:	05412703          	lw	a4,84(sp)
 8a0:	06012783          	lw	a5,96(sp)
 8a4:	68070713          	addi	a4,a4,1664
 8a8:	04e12a23          	sw	a4,84(sp)
 8ac:	05012703          	lw	a4,80(sp)
 8b0:	01a78793          	addi	a5,a5,26
 8b4:	06f12023          	sw	a5,96(sp)
 8b8:	00570713          	addi	a4,a4,5
 8bc:	04e12823          	sw	a4,80(sp)
 8c0:	08200713          	li	a4,130
 8c4:	cae790e3          	bne	a5,a4,564 <layer2+0x78>
 8c8:	09c12403          	lw	s0,156(sp)
 8cc:	09812483          	lw	s1,152(sp)
 8d0:	09412903          	lw	s2,148(sp)
 8d4:	09012983          	lw	s3,144(sp)
 8d8:	08c12a03          	lw	s4,140(sp)
 8dc:	08812a83          	lw	s5,136(sp)
 8e0:	08412b03          	lw	s6,132(sp)
 8e4:	08012b83          	lw	s7,128(sp)
 8e8:	07c12c03          	lw	s8,124(sp)
 8ec:	07812c83          	lw	s9,120(sp)
 8f0:	07412d03          	lw	s10,116(sp)
 8f4:	07012d83          	lw	s11,112(sp)
 8f8:	0a010113          	addi	sp,sp,160
 8fc:	00008067          	ret
 900:	03c12783          	lw	a5,60(sp)
 904:	0007a023          	sw	zero,0(a5)
 908:	00078713          	mv	a4,a5
 90c:	f35ff06f          	j	840 <layer2+0x354>

00000910 <layer3>:
 910:	00050e93          	mv	t4,a0
 914:	00008537          	lui	a0,0x8
 918:	fd010113          	addi	sp,sp,-48
 91c:	d0050513          	addi	a0,a0,-768 # 7d00 <__stack_init+0x6ff8>
 920:	ffff8e37          	lui	t3,0xffff8
 924:	00068813          	mv	a6,a3
 928:	00810313          	addi	t1,sp,8
 92c:	00a58533          	add	a0,a1,a0
 930:	00000893          	li	a7,0
 934:	300e0e13          	addi	t3,t3,768 # ffff8300 <__VREG_END+0xffe78300>
 938:	00a00f13          	li	t5,10
 93c:	000e8693          	mv	a3,t4
 940:	01c507b3          	add	a5,a0,t3
 944:	00000613          	li	a2,0
 948:	0006a703          	lw	a4,0(a3)
 94c:	0007a583          	lw	a1,0(a5)
 950:	02878793          	addi	a5,a5,40
 954:	00468693          	addi	a3,a3,4
 958:	02b70733          	mul	a4,a4,a1
 95c:	00e60633          	add	a2,a2,a4
 960:	fef514e3          	bne	a0,a5,948 <layer3+0x38>
 964:	00082783          	lw	a5,0(a6)
 968:	00188893          	addi	a7,a7,1
 96c:	00480813          	addi	a6,a6,4
 970:	00c78633          	add	a2,a5,a2
 974:	fff64793          	not	a5,a2
 978:	41f7d793          	srai	a5,a5,0x1f
 97c:	00f67633          	and	a2,a2,a5
 980:	00c32023          	sw	a2,0(t1)
 984:	00450513          	addi	a0,a0,4
 988:	00430313          	addi	t1,t1,4
 98c:	fbe898e3          	bne	a7,t5,93c <layer3+0x2c>
 990:	00812783          	lw	a5,8(sp)
 994:	00c12703          	lw	a4,12(sp)
 998:	00000513          	li	a0,0
 99c:	00e7d663          	bge	a5,a4,9a8 <layer3+0x98>
 9a0:	00070793          	mv	a5,a4
 9a4:	00100513          	li	a0,1
 9a8:	01012703          	lw	a4,16(sp)
 9ac:	00e7d663          	bge	a5,a4,9b8 <layer3+0xa8>
 9b0:	00070793          	mv	a5,a4
 9b4:	00200513          	li	a0,2
 9b8:	01412703          	lw	a4,20(sp)
 9bc:	00e7d663          	bge	a5,a4,9c8 <layer3+0xb8>
 9c0:	00070793          	mv	a5,a4
 9c4:	00300513          	li	a0,3
 9c8:	01812703          	lw	a4,24(sp)
 9cc:	00e7d663          	bge	a5,a4,9d8 <layer3+0xc8>
 9d0:	00070793          	mv	a5,a4
 9d4:	00400513          	li	a0,4
 9d8:	01c12703          	lw	a4,28(sp)
 9dc:	00e7d663          	bge	a5,a4,9e8 <layer3+0xd8>
 9e0:	00070793          	mv	a5,a4
 9e4:	00500513          	li	a0,5
 9e8:	02012703          	lw	a4,32(sp)
 9ec:	00e7d663          	bge	a5,a4,9f8 <layer3+0xe8>
 9f0:	00070793          	mv	a5,a4
 9f4:	00600513          	li	a0,6
 9f8:	02412703          	lw	a4,36(sp)
 9fc:	00e7d663          	bge	a5,a4,a08 <layer3+0xf8>
 a00:	00070793          	mv	a5,a4
 a04:	00700513          	li	a0,7
 a08:	02812703          	lw	a4,40(sp)
 a0c:	00e7d663          	bge	a5,a4,a18 <layer3+0x108>
 a10:	00070793          	mv	a5,a4
 a14:	00800513          	li	a0,8
 a18:	02c12703          	lw	a4,44(sp)
 a1c:	00e7d463          	bge	a5,a4,a24 <layer3+0x114>
 a20:	00900513          	li	a0,9
 a24:	03010113          	addi	sp,sp,48
 a28:	00008067          	ret

00000a2c <softmax>:
 a2c:	00052783          	lw	a5,0(a0)
 a30:	00452683          	lw	a3,4(a0)
 a34:	00050713          	mv	a4,a0
 a38:	00000513          	li	a0,0
 a3c:	00d7d663          	bge	a5,a3,a48 <softmax+0x1c>
 a40:	00068793          	mv	a5,a3
 a44:	00100513          	li	a0,1
 a48:	00872683          	lw	a3,8(a4)
 a4c:	00d7d663          	bge	a5,a3,a58 <softmax+0x2c>
 a50:	00068793          	mv	a5,a3
 a54:	00200513          	li	a0,2
 a58:	00c72683          	lw	a3,12(a4)
 a5c:	00d7d663          	bge	a5,a3,a68 <softmax+0x3c>
 a60:	00068793          	mv	a5,a3
 a64:	00300513          	li	a0,3
 a68:	01072683          	lw	a3,16(a4)
 a6c:	00d7d663          	bge	a5,a3,a78 <softmax+0x4c>
 a70:	00068793          	mv	a5,a3
 a74:	00400513          	li	a0,4
 a78:	01472683          	lw	a3,20(a4)
 a7c:	00d7d663          	bge	a5,a3,a88 <softmax+0x5c>
 a80:	00068793          	mv	a5,a3
 a84:	00500513          	li	a0,5
 a88:	01872683          	lw	a3,24(a4)
 a8c:	00d7d663          	bge	a5,a3,a98 <softmax+0x6c>
 a90:	00068793          	mv	a5,a3
 a94:	00600513          	li	a0,6
 a98:	01c72683          	lw	a3,28(a4)
 a9c:	00d7d663          	bge	a5,a3,aa8 <softmax+0x7c>
 aa0:	00068793          	mv	a5,a3
 aa4:	00700513          	li	a0,7
 aa8:	02072683          	lw	a3,32(a4)
 aac:	00d7d663          	bge	a5,a3,ab8 <softmax+0x8c>
 ab0:	00068793          	mv	a5,a3
 ab4:	00800513          	li	a0,8
 ab8:	02472703          	lw	a4,36(a4)
 abc:	00e7d463          	bge	a5,a4,ac4 <softmax+0x98>
 ac0:	00900513          	li	a0,9
 ac4:	00008067          	ret

00000ac8 <ISR5>:
 ac8:	30047073          	csrci	mstatus,8
 acc:	e8010113          	addi	sp,sp,-384
 ad0:	10112023          	sw	ra,256(sp)
 ad4:	10212223          	sw	sp,260(sp)
 ad8:	10312423          	sw	gp,264(sp)
 adc:	10412623          	sw	tp,268(sp)
 ae0:	10512823          	sw	t0,272(sp)
 ae4:	10612a23          	sw	t1,276(sp)
 ae8:	10712c23          	sw	t2,280(sp)
 aec:	10812e23          	sw	s0,284(sp)
 af0:	12912023          	sw	s1,288(sp)
 af4:	12a12223          	sw	a0,292(sp)
 af8:	12b12423          	sw	a1,296(sp)
 afc:	12c12623          	sw	a2,300(sp)
 b00:	12d12823          	sw	a3,304(sp)
 b04:	12e12a23          	sw	a4,308(sp)
 b08:	12f12c23          	sw	a5,312(sp)
 b0c:	13012e23          	sw	a6,316(sp)
 b10:	15112023          	sw	a7,320(sp)
 b14:	15212223          	sw	s2,324(sp)
 b18:	15312423          	sw	s3,328(sp)
 b1c:	15412623          	sw	s4,332(sp)
 b20:	15512823          	sw	s5,336(sp)
 b24:	15612a23          	sw	s6,340(sp)
 b28:	15712c23          	sw	s7,344(sp)
 b2c:	15812e23          	sw	s8,348(sp)
 b30:	17912023          	sw	s9,352(sp)
 b34:	17a12223          	sw	s10,356(sp)
 b38:	17b12423          	sw	s11,360(sp)
 b3c:	17c12623          	sw	t3,364(sp)
 b40:	17d12823          	sw	t4,368(sp)
 b44:	17e12a23          	sw	t5,372(sp)
 b48:	17f12c23          	sw	t6,376(sp)
 b4c:	341022f3          	csrr	t0,mepc
 b50:	16512e23          	sw	t0,380(sp)
 b54:	1ac000ef          	jal	ra,d00 <ISR5_uart>
 b58:	30047073          	csrci	mstatus,8
 b5c:	17c12283          	lw	t0,380(sp)
 b60:	34129073          	csrw	mepc,t0
 b64:	10012083          	lw	ra,256(sp)
 b68:	10c12203          	lw	tp,268(sp)
 b6c:	11012283          	lw	t0,272(sp)
 b70:	11412303          	lw	t1,276(sp)
 b74:	11812383          	lw	t2,280(sp)
 b78:	11c12403          	lw	s0,284(sp)
 b7c:	12012483          	lw	s1,288(sp)
 b80:	12412503          	lw	a0,292(sp)
 b84:	12812583          	lw	a1,296(sp)
 b88:	12c12603          	lw	a2,300(sp)
 b8c:	13012683          	lw	a3,304(sp)
 b90:	13412703          	lw	a4,308(sp)
 b94:	13812783          	lw	a5,312(sp)
 b98:	13c12803          	lw	a6,316(sp)
 b9c:	14012883          	lw	a7,320(sp)
 ba0:	14412903          	lw	s2,324(sp)
 ba4:	14812983          	lw	s3,328(sp)
 ba8:	14c12a03          	lw	s4,332(sp)
 bac:	15012a83          	lw	s5,336(sp)
 bb0:	15412b03          	lw	s6,340(sp)
 bb4:	15812b83          	lw	s7,344(sp)
 bb8:	15c12c03          	lw	s8,348(sp)
 bbc:	16012c83          	lw	s9,352(sp)
 bc0:	16412d03          	lw	s10,356(sp)
 bc4:	16812d83          	lw	s11,360(sp)
 bc8:	16c12e03          	lw	t3,364(sp)
 bcc:	17012e83          	lw	t4,368(sp)
 bd0:	17412f03          	lw	t5,372(sp)
 bd4:	17812f83          	lw	t6,376(sp)
 bd8:	18010113          	addi	sp,sp,384
 bdc:	30046073          	csrsi	mstatus,8
 be0:	30200073          	mret

00000be4 <ISR6>:
 be4:	30047073          	csrci	mstatus,8
 be8:	e8010113          	addi	sp,sp,-384
 bec:	10112023          	sw	ra,256(sp)
 bf0:	10212223          	sw	sp,260(sp)
 bf4:	10312423          	sw	gp,264(sp)
 bf8:	10412623          	sw	tp,268(sp)
 bfc:	10512823          	sw	t0,272(sp)
 c00:	10612a23          	sw	t1,276(sp)
 c04:	10712c23          	sw	t2,280(sp)
 c08:	10812e23          	sw	s0,284(sp)
 c0c:	12912023          	sw	s1,288(sp)
 c10:	12a12223          	sw	a0,292(sp)
 c14:	12b12423          	sw	a1,296(sp)
 c18:	12c12623          	sw	a2,300(sp)
 c1c:	12d12823          	sw	a3,304(sp)
 c20:	12e12a23          	sw	a4,308(sp)
 c24:	12f12c23          	sw	a5,312(sp)
 c28:	13012e23          	sw	a6,316(sp)
 c2c:	15112023          	sw	a7,320(sp)
 c30:	15212223          	sw	s2,324(sp)
 c34:	15312423          	sw	s3,328(sp)
 c38:	15412623          	sw	s4,332(sp)
 c3c:	15512823          	sw	s5,336(sp)
 c40:	15612a23          	sw	s6,340(sp)
 c44:	15712c23          	sw	s7,344(sp)
 c48:	15812e23          	sw	s8,348(sp)
 c4c:	17912023          	sw	s9,352(sp)
 c50:	17a12223          	sw	s10,356(sp)
 c54:	17b12423          	sw	s11,360(sp)
 c58:	17c12623          	sw	t3,364(sp)
 c5c:	17d12823          	sw	t4,368(sp)
 c60:	17e12a23          	sw	t5,372(sp)
 c64:	17f12c23          	sw	t6,376(sp)
 c68:	341022f3          	csrr	t0,mepc
 c6c:	16512e23          	sw	t0,380(sp)
 c70:	094000ef          	jal	ra,d04 <ISR6_addr_exception>
 c74:	30047073          	csrci	mstatus,8
 c78:	17c12283          	lw	t0,380(sp)
 c7c:	34129073          	csrw	mepc,t0
 c80:	10012083          	lw	ra,256(sp)
 c84:	10c12203          	lw	tp,268(sp)
 c88:	11012283          	lw	t0,272(sp)
 c8c:	11412303          	lw	t1,276(sp)
 c90:	11812383          	lw	t2,280(sp)
 c94:	11c12403          	lw	s0,284(sp)
 c98:	12012483          	lw	s1,288(sp)
 c9c:	12412503          	lw	a0,292(sp)
 ca0:	12812583          	lw	a1,296(sp)
 ca4:	12c12603          	lw	a2,300(sp)
 ca8:	13012683          	lw	a3,304(sp)
 cac:	13412703          	lw	a4,308(sp)
 cb0:	13812783          	lw	a5,312(sp)
 cb4:	13c12803          	lw	a6,316(sp)
 cb8:	14012883          	lw	a7,320(sp)
 cbc:	14412903          	lw	s2,324(sp)
 cc0:	14812983          	lw	s3,328(sp)
 cc4:	14c12a03          	lw	s4,332(sp)
 cc8:	15012a83          	lw	s5,336(sp)
 ccc:	15412b03          	lw	s6,340(sp)
 cd0:	15812b83          	lw	s7,344(sp)
 cd4:	15c12c03          	lw	s8,348(sp)
 cd8:	16012c83          	lw	s9,352(sp)
 cdc:	16412d03          	lw	s10,356(sp)
 ce0:	16812d83          	lw	s11,360(sp)
 ce4:	16c12e03          	lw	t3,364(sp)
 ce8:	17012e83          	lw	t4,368(sp)
 cec:	17412f03          	lw	t5,372(sp)
 cf0:	17812f83          	lw	t6,376(sp)
 cf4:	18010113          	addi	sp,sp,384
 cf8:	30046073          	csrsi	mstatus,8
 cfc:	30200073          	mret

00000d00 <ISR5_uart>:
 d00:	00008067          	ret

00000d04 <ISR6_addr_exception>:
 d04:	00008067          	ret

00000d08 <__stack_init>:
 d08:	000feffc                                ....
