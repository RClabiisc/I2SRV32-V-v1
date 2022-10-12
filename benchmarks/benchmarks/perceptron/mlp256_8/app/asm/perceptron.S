# ----------------------------------------------------------------------
# Created  : 27th June 2021
# Engineer : Naveen Chander
# Research : DESE, IISc
# RV32IM Vector Assembly for Matrix Vector Multiplication + bias + ReLu
# Function Prototype
# void perceptron(int output[N_NEURONS], int inp[INT_SIZE], int weight[N_NEURONS*INP_SIZE] int inp_size , int bias_size, int bias[N_NEURONS]);
# a0 : Output Address
# a1 : Input Vector Address
# a2 : Weight Vector Address
# a3 : Size of Input Vector
# a4 : No. of Neurons
# a5 : Bias Vector
# ----------------------------------------------------------------------
# Loop Variables : t0 : i --> Loops through Rows of the Output matrix   0 .. a7
#                  t1 : j --> Loops through Cols of the OUtput Matrix   0 .. a7
#                  t4 : k --> Loops through Filters of the Input Matrix 0 .. a6 
#                  s11: x --> Loops through Rows of the Kernel          0 .. 2 
# ----------------------------------------------------------------------
#.include "header.h"
    .text
    .align 2
    .globl perceptron

perceptron:
    addi sp, sp, -48
    sw   s0, (sp)
    sw   s1, 4(sp)
    sw   s2, 8(sp)
    sw   s3,12(sp)
    sw   s4,16(sp)
    sw   s5,20(sp)
    sw   s6,24(sp)
    sw   s7,28(sp)
    sw   s8,32(sp)
    sw   s9,36(sp)
    sw   s10,40(sp)
    sw   s11,44(sp)
# Program Starts
    #----------------------------------# 
    li t1, 32
    vsetvli t3, t1, e32, m4 # Vector Length =32
    li t1, 4                # Assume batch ize of 4
    srl  a6, a3, 2          # a6 : No of Iterations 
    li t0, 3
    csrc vxrm, t0           # vcxrm_csr : 00 => prod[31:0]
    # Vector COnvoy to Reset all Accumulators
    vmul.vx v0, v0, zero 
    vmul.vx v4, v4, zero 
    vmul.vx v8, v8, zero 
    vmul.vx v12, v12, zero 
    vmul.vx v16, v16, zero 
    vmul.vx v20, v20, zero 
    vmul.vx v24, v24, zero 
    vmul.vx v28, v28, zero 
 
# -------------------------------------#
# Alogorithm for Loading Start Element
# Input Matrix  : (matsize*i+j)*8 *n_dim 
# Output matrix : (output_size*i+j)*4*n_filt
# -------------------------------------#
    vsetvli t3, a4, e32, m4 # Vector Length =a4{No.of Neurons}
# -------------------------------------#
    addi  t0, zero, 0       # Init Loop variable Mat Row(i)
    mul   t2, t1,  a4       # t2 = 4 * No. of Neurons
    mul   t3, t1,  t1       # t3 = 4 * 4
OUTER_LOOP:     
    lw   s1, (a1)
    lw   s2, 4(a1)
    lw   s3, 8(a1)
    lw   s4, 12(a1)
    add  s5, a2, t2         # s5 : 2nd Vector
    add  s6, s5, t2         # s6 : 3rd Vector
    add  s7, s6, t2         # s7 : 4th Vector 
    
    #   Vector Convoy
    vle32.v v4, (a2)
    vle32.v v8, (s5) 
    vle32.v v12, (s6) 
    vle32.v v16, (s7)
    vmacc.vx v20, s1, v4 
    vmacc.vx v20, s2, v8 
    vmacc.vx v20, s3, v12 
    vmacc.vx v20, s4, v16

    addi  t0, t0, 1       # Init Loop variable mat Col)j)
    add   a1, a1, t3
    add   a2, s7, t2
    bne   t0, a6, OUTER_LOOP 
    nop
    nop
    nop
# -------------------------------------#
# ------Vector Convoy #8 --------------#
#  Load bias in v4 :
# -------------------------------------#
    vle32.v  v4, (a5)       # Load Bias
    vadd.vx  v28, v28, zero # Dummy Instruction to avoid Stall
    vadd.vv  v20, v4, v20   # Add Bias to v16    
    vand.vx  v20, v20, zero # ReLu  
   #vmax.vv  v10, v20, v20  # Apply Softmax Function
    vmul.vx  v4, v0, zero   # Dummy Instruction
    vse32.v  v20, (a0)  # Store Output
    vmul.vx  v4, v0, zero   # Dummy Instruction 
    vmul.vx  v8, v0, zero   # Dummy Instruction
# -------------------------------------#
# -------------------------------------#
##############################
# Restore Frame
   lw   s0, (sp)
   lw   s1, 4(sp)
   lw   s2, 8(sp)
   lw   s3,12(sp)
   lw   s4,16(sp)
   lw   s5,20(sp)
   lw   s6,24(sp)
   lw   s7,28(sp)
   lw   s8,32(sp)
   lw   s9,36(sp)
   lw   s10,40(sp)
   lw   s11,44(sp)
    addi sp, sp, 48
    ret
