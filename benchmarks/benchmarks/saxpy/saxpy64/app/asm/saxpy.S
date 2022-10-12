# ----------------------------------------------------------------------
# Created  : 10th June 2021
# Engineer : Naveen Chander
# Research : DESE, IISc
# RV32IM Vector Assembly for Y = a*X + Y                           
# Function Prototype
# void matmul32(int y_vec[], int a, int x_vec[], int size);
# a0 : Output Address
# a1 : Scalar A
# a2 : B Vector Address
# a3 : Size of Vector
# ----------------------------------------------------------------------
# 
# ----------------------------------------------------------------------
#.include "header.h"
    .text
    .align 2
    .globl saxpy

saxpy:
#    addi sp, sp, -44
#    sw   s0, (sp)
#    sw   s1, 4(sp)
#    sw   s2, 8(sp)
#    sw   s3,12(sp)
#    sw   s4,16(sp)
#    sw   s5,20(sp)
#    sw   s6,24(sp)
#    sw   s7,28(sp)
#    sw   s8,32(sp)
#    sw   s9,36(sp)
#    sw   s10,40(sp)
# Program Starts
    li t0, 3
    csrc vxrm, t0           # vcxrm_csr : 00 => prod[31:0]
    addi t1, a3, -1         # n-1
    srli a4, t1, 6          # Divide by MVL(=64)
    addi a4, a4, 1          # No. of iterations
    li t0, 63               # MVL - 1  :  6'b111111
    and a5, a3, t0          # Remainder vector Length
# -------------------------------------#
    addi  t0, zero, 0       # Init Loop variable to 0
LOOP: 
    vsetvli t3, a5, e32, m4 # Vector Length = Remainder vl
# ------Vector Convoy #2--------------#
    vle32.v  v8,  (a2)       # Load X
    vle32.v  v16, (a0)       # Load Y
    vmul.vx  v24,  v8,  a1   # v24 <- aX
    vadd.vv  v24, v24, v16   # v24 <- aX + Y
    vse32.v  v24, (a0)
    vadd.vx  v8,  v8,  zero  # Clear Accumulator 3
    vadd.vx  v16, v16, zero  # Clear Accumulator 4
    vadd.vx  v24, v24, zero  # Clear Result Vector
# -------------------------------------#
    li   a5, 64             # a5 = 64
    addi t0, t0, 1          # Increment Loop Variable
    addi a0, a0, 256        # Bump Y POinter
    addi a2, a2, 256        # Bump X POinter
    bne  t0, a4, LOOP
#------------------------------------#     
##############################
# Restore Frame
#   lw   s0, (sp)
#   lw   s1, 4(sp)
#   lw   s2, 8(sp)
#   lw   s3,12(sp)
#   lw   s4,16(sp)
#   lw   s5,20(sp)
#   lw   s6,24(sp)
#   lw   s7,28(sp)
#   lw   s8,32(sp)
#   lw   s9,36(sp)
#   lw   s10,40(sp)
#    addi sp, sp, 44
    nop
    nop
    ret
