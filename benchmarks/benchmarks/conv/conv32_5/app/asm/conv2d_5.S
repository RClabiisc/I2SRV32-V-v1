# ----------------------------------------------------------------------
# Created  : 1st June 2021
# Engineer : Naveen Chander
# Research : DESE, IISc
# RV32IM Vector Assembly for Convolution of 32 x 32 Matrix with a 5 x 5 Kernel with 32 such filters
# Function Prototype
# void* conv2d_5(int output[], int matrix[], int kernel[5 * 5 * 32], int matsize);
# a0 : Output Address
# a1 : Input Matrix Address
# a2 : Input kernel Address
# a3 : Size of Matrix 
# ----------------------------------------------------------------------
# Program Defined 
# a4 : No. of Rows in The Kernl = 5
# a5 : No. of Filters : 32
# a6 : No. of Output Rows /2 =(a3 -4) /2
# a7 : No. of Output Matrix Rows = a3 - 4
# t1, t2, t3 : Loop Variables
# ----------------------------------------------------------------------
#.include "header.h"
    .text
    .align 2
    .globl conv2d_5

conv2d_5:
    addi sp, sp, -52
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
    sw   t6,48(sp)
# Program Starts
    li t0, 3
    csrc vxrm, t0           # vcxrm_csr : 00 => prod[31:0] 
    addi  a7, a3, -4        # Finding the Size of output matrix
    srli  a6, a7, 1         # a6 = Output_size/2
    li a5, 32               # Load vector Length with #FILT
    vsetvli t3, a5, e32, m4 # Vector Length = No. of Filters
# -------------------------------------#
# ------Vector Convoy #1--------------#
    vmul.vx  v0,  v0,  zero  # Clear1
    vmul.vx  v4,  v4,  zero  # Clear2
    vmul.vx  v8,  v8,  zero  # Clear3
    vmul.vx  v12, v12, zero  # Clear4
    vmul.vx  v16, v16, zero  # Clearr
    vadd.vx  v24, v20, zero  # Clear
    vadd.vx  v28, v24, zero  # Clear
# -------------------------------------#
# Alogorithm for Loading Start Element
# t0  : 0 ..  a6 (i)
# t1  : 0 ..  a6 (j)
# Input Matrix  : (matsize*i+j)*8  
# Output matrix : (output_size*i+j)*8*n_filt
# -------------------------------------#
    addi  t0, zero, 0       # Init Loop variable Mat Row(i)
OUTER_LOOP:    
    addi  t1, zero, 0       # Init Loop variable mat Col)j)
INNER_LOOP:
    #  Compute Output matrix Start Address
    mul   t2, t0, a7        # (output_size) *i
    slli  t3, t1, 1         # 2*j  
    add   t3, t3, t2        # (output_size)*i+2*j 
    slli  t5, t3, 7         # ((output_size)*i+j)*4*N_FILT 
    add   s10, a0, t5       # Start Address for Ouput matrix
    # Calculate IMG_START_ADDR
    mul   t2, t0, a3        # matsize*i
    slli  t3, t1, 1         # 2*j  
    add   t3, t3, t2        # matsize*i+2*j
    slli  t3, t3, 2         # 4 *(matsize*i+2*j)
    add   s0, a1, t3        # Start Address for Input matrix
#--------------------------------------------------------#
    li    a4, 5             # No. of ROWS in Kernel(N_KER_ROWS)
    addi  t2, zero, 0       # Init Loop Variable : Loops across Ker Rows
                            #  t2 :: row
    addi  t5, a2, 0         # First Kernel ROw Address in t5
    addi t6, s0, 0         # First Image Row Address in t6
#--------------------------------------------------------#
KER_ROW_LOOP:
    # Load Scalars from 1st Subrow
    lw  s5,  0(t6)           # Load img[0][0]
    lw  s6,  4(t6)           # Load img[0][1]
    lw  s7,  8(t6)           # Load img[0][2]
    lw  s8,  12(t6)          # Load img[0][4]
    lw  s9,  16(t6)          # Load img[0][5]
    lw  s11, 20(t6)          # Load img[0][6]
    # Compute 4 more Kernel Addresses
    li    t3, 128           # 4*32 
    add   s1, t5, t3        # 2nd kernel Element's Address
    add   s2, s1, t3        # 3rd kernel Element's Address
    add   s3, s2, t3        # 4th kernel Element's Address
    add   s4, s3, t3        # 5th kernel Element's Address
# ------------------------------------------#
# ------Vector Convoy #2 and 3--------------#
    vle32.v  v4,   (t5)     # Load K[x][0] for all 32  Channels
    vle32.v  v8,   (s1)     # Load K[x][1] for all 32  Channels
    vle32.v  v12,  (s2)     # Load K[x][2] for all 32  Channels
    vle32.v  v16,  (s3)     # Load K[x][3] for all 32  Channels
    vle32.v  v20,  (s4)     # Load K[x][4] for all 32  Channels
    vmacc.vx v24, s5, v4    # v24 <-- v24 + img[x][0]*v4
    vmacc.vx v24, s6, v8    # v24 <-- v24 + img[x][1]*v8
    vmacc.vx v24, s7, v12   # v24 <-- v24 + img[x][2]*v12
    vmacc.vx v24, s8, v16   # v24 <-- v24 + img[x][3]*v16
    vmacc.vx v24, s9, v20   # v24 <-- v24 + img[x][4]*v20
    vmacc.vx v28, s6, v4    # v28 <-- v28 + img[x][2]*v4
    vmacc.vx v28, s7, v8    # v28 <-- v28 + img[x][3]*v8
    vmacc.vx v28, s8, v12   # v28 <-- v28 + img[x][4]*v12
    vmacc.vx v28, s9, v16   # v28 <-- v28 + img[x][5]*v16
    vmacc.vx v28, s11, v20  # v28 <-- v28 + img[x][6]*v20
    vadd.vx  v28, v28, zero # Dummy
# -------------------------------------#
    #Load Next Kernel Row Address
    slli  t3, a5, 2         # N_FILT*4
    mul   t4, a4, t3        # N_FILT*4*a4(N_KER_ROWS)
    add   t5, t5, t4        # t5 : Kernel Start Address 
# -------------------------------------#
    #Load Next Image Row Address
    slli  t3, a3, 2         # t3= matsize * 4
    add  t6, t6, t3       # Row Offset += matsize * 4
# -- Check for Loop Completion
    addi  t2, t2, 1         # INcrement Kernel Row Variable
    bne   t2, a4, KER_ROW_LOOP
# -------------------------------------#
# ------Vector Convoy #8 --------------#
#  output[i][j]     : s10 = s10
#  output[i][j+1]   : s1  = s10 + N_FILT * 4
# -------------------------------------#
#  Compute 3 Output Element Offsets
    slli t3, a5 , 2         # N_FILT*4
    add  s1, s10, t3        # s10 + N_FILT * 4
# -------------------------------------#
# ------Vector Convoy #4 --------------#
    vse32.v v24, (s10)
    vse32.v v28, (s1)
    vmul.vx v24, v24, zero  # Reset Accumulator
    vmul.vx v28, v28, zero  # Reset Accumulator
    vmul.vx v28, v26, zero  # Dummy 
    vmul.vx v28, v28, zero  # Dummy 
    vmul.vx v28, v26, zero  # Dummy 
    vmul.vx v28, v28, zero  # Dummy 
# -------------------------------------#
# One Element StorAGE cOMPLETED
# -------------------------------------#
    addi t1, t1, 1
    bne  t1, a6, INNER_LOOP     # Half the no. of output cols
    addi t0, t0, 1
    bne  t0, a7, OUTER_LOOP
# -------------------------------------#
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
   lw   t6,48(sp)
    addi sp, sp, 52
    ret
# .globl __stacktop
# .data
# .align 2
# .size __stacktop, 4
# .globl __maskreg
# .data
# .align 2
# .size __maskreg, 4
#__maskreg:
#.word 0x00080000
# .globl mask_data
# .data
# .align 2
# .size mask_data, 4
#mask_data:
#.word 0x03FFFFFF
