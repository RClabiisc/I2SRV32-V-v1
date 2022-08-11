# ----------------------------------------------------------------------
# Created  : 12th May 2021
# Engineer : Naveen Chander
# Research : DESE, IISc
# RV32IM Vector Assembly for Convolution + Maxpool2 of 32 x 32 Matrix with a 3 x 3 Kernel with 16 such filters
# Function Prototype
# void* conv2d(int output[13][13][16], int matrix[28][28], int kernel[3][3][16], int matsize, int bias[16], int n_filters);
# a0 : Output Address
# a1 : Input Matrix Address
# a2 : Input kernel Address
# a3 : Size of Matrix 
# a4 : Input Bias
# a5 : Number of Filters
# ----------------------------------------------------------------------
# 
# ----------------------------------------------------------------------
#.include "header.h"
    .text
    .align 2
    .globl conv2d

conv2d:
    addi sp, sp, -44
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
# Program Starts
    addi  t0, a3, -2        # Finding the Size of output matrix
    srai  a6, t0, 1         # a6 <-- OUtput matrix Size <No. of iterations>
    vsetvli t3, a5, e32, m4 # Vector Length = No. of Filters
#------------------------------------#     
    slli  t3, a5, 2         # SIze of one Kernel element for all channels     
    add   s1, a2, t3        # 2nd kernel Element's Address
    add   s2, s1, t3        # 3rd kernel Element's Address
    add   s3, s2, t3        # 4th kernel Element's Address
    add   s4, s3, t3        # 5th kernel Element's Address
    add   s5, s4, t3        # 6th kernel Element's Address
    add   s6, s5, t3        # 7th kernel Element's Address
    add   s7, s6, t3        # 8th kernel Element's Address
    add   s8, s7, t3        # 9th kernel Element's Address
# ------Vector Convoy #1--------------#
    vle32.v  v2,  (a2)      # Load K[0][0] for all 16 Channels
    vle32.v  v4,  (s1)      # Load K[0][1] for all 16 Channels
    vle32.v  v6,  (s2)      # Load K[0][2] for all 16 Channels
    vle32.v  v8,  (s3)      # Load K[1][0] for all 16 Channels
    vle32.v  v10,  (s4)     # Load K[1][1] for all 16 Channels
    vle32.v  v12,  (s5)     # Load K[1][2] for all 16 Channels
    vle32.v  v14,  (s6)     # Load K[2][0] for all 16 Channels
    vle32.v  v16,  (s7)     # Load K[2][1] for all 16 Channels
# -------------------------------------#
# ------Vector Convoy #2--------------#
    vle32.v  v18,  (s8)      # Load K[2][2] for all 16 Channels
    vle32.v  v20,  (a4)      # Load Bias    for all 16 Channels
    vmul.vx  v22, v22, zero  # Clear Accumulator 1
    vmul.vx  v24, v24, zero  # Clear Accumulator 2
    vmul.vx  v26, v26, zero  # Clear Accumulator 3
    vmul.vx  v28, v28, zero  # Clear Accumulator 4
    vmul.vx  v30, v30, zero  # Clear Result Vector
    vadd.vx  v28, v28, zero  # Dummy Instruction
# -------------------------------------#
# Alogorithm for Loading Start Element
# t0  : 0 ..  a6 (i)
# t1  : 0 ..  a6 (j)
# Input Matrix  : (matsize*i+j)*8  
# Output matrix : (output_size*i+j)*4*n_filt
# -------------------------------------#
    addi  t0, zero, 0       # Init Loop variable Mat Row(i)
OUTER_LOOP:    
    addi  t1, zero, 0       # Init Loop variable mat Col)j)
INNER_LOOP:
    mul   t2, t0, a3        # matsize*i
    add   t3, t1, t2        # matsize*i+j
    slli  t3, t3, 3         # 8(i+j)
    add   s0, a1, t3        # Start Address for Input matrix
    #  Compute Output matrix Start Address
    mul   t2, t0, a6        # output_size *i
    add   t3, t1, t2        # (output_size)*i+j 
    slli  t3, t3, 2         # ((output_size)*i+j)*4 
    mul   t5, t3, a5        # ((output_size)*i+j)*4 *N_FILT
    add   s10, a0, t5       # Start Address for Ouput matrix
    # Load Scalars from 1st Subrow
    lw  s1, 0(s0)           # Load img[0][0]
    lw  s2, 4(s0)           # Load img[0][1]
    lw  s3, 8(s0)           # Load img[0][2]
    lw  s4, 12(s0)          # Load img[0][3]
# -------------------------------------#
# ------Vector Convoy #3--------------#
    vmacc.vx v22, s1, v2    # v22 <-- v22 + img[0][0]*v2
    vmacc.vx v22, s2, v4    # v22 <-- v22 + img[0][1]*v4
    vmacc.vx v22, s3, v6    # v22 <-- v22 + img[0][2]*v6
    vmacc.vx v24, s2, v2    # v24 <-- v24 + img[0][1]*v2
    vmacc.vx v24, s3, v4    # v24 <-- v24 + img[0][2]*v4
    vmacc.vx v24, s4, v6    # v24 <-- v24 + img[0][3]*v6
    vadd.vx  v28, v28, zero # Dummy Instruction
    vadd.vx  v28, v28, zero # Dummy Instruction
# -------------------------------------#
    # Load Scalars from 2nd Sub-row
    slli t3, a3, 2          # Addr bump for next row
    add  s0, s0, t3         # Jump to First Col of next row 
    lw  s1, 0(s0)           # Load img[1][0]
    lw  s2, 4(s0)           # Load img[1][1]
    lw  s3, 8(s0)           # Load img[1][2]
    lw  s4, 12(s0)          # Load img[1][3]
    # -------------------------------------#
    # Load Scalars from 3rd Sub-row
    add  s0, s0, t3         # Jump to First Col of next row 
    lw  s5, 0(s0)           # Load img[2][0]
    lw  s6, 4(s0)           # Load img[2][1]
    lw  s7, 8(s0)           # Load img[2][2]
    lw  s8, 12(s0)          # Load img[2][3]
# -------Vector Convoy #4, 5 and 6--------------#
    vmacc.vx v22, s1, v8    # v22 <-- v22 + img[1][0]*v8
    vmacc.vx v22, s2, v10   # v22 <-- v22 + img[1][1]*v10
    vmacc.vx v22, s3, v12   # v22 <-- v22 + img[1][2]*v12
    vmacc.vx v24, s2, v8    # v24 <-- v24 + img[1][1]*v8
    vmacc.vx v24, s3, v10   # v24 <-- v24 + img[1][2]*v10
    vmacc.vx v24, s4, v12   # v24 <-- v24 + img[1][3]*v12
    vmacc.vx v26, s1, v2    # v26 <-- v26 + img[1][0]*v2
    vmacc.vx v26, s2, v4    # v26 <-- v26 + img[1][1]*v4
    vmacc.vx v26, s3, v6    # v26 <-- v26 + img[1][2]*v6
    vmacc.vx v28, s2, v2    # v28 <-- v28 + img[1][1]*v2
    vmacc.vx v28, s3, v4    # v28 <-- v28 + img[1][2]*v4
    vmacc.vx v28, s4, v6    # v28 <-- v28 + img[1][3]*v2

    vmacc.vx v22, s5, v14   # v22 <-- v22 + img[2][0]*v14
    vmacc.vx v22, s6, v16   # v22 <-- v22 + img[2][1]*v16
    vmacc.vx v22, s7, v18   # v22 <-- v22 + img[2][2]*v18
    vmacc.vx v24, s6, v14   # v24 <-- v24 + img[2][1]*v14
    vmacc.vx v24, s7, v16   # v24 <-- v24 + img[2][2]*v16
    vmacc.vx v24, s8, v18   # v24 <-- v24 + img[2][3]*v18
    vmacc.vx v26, s5, v8    # v26 <-- v26 + img[2][0]*v8
    vmacc.vx v26, s6, v10   # v26 <-- v26 + img[2][1]*v10
    vmacc.vx v26, s7, v12   # v26 <-- v26 + img[2][2]*v12
    vmacc.vx v28, s6, v8    # v28 <-- v28 + img[2][1]*v8
    vmacc.vx v28, s7, v10   # v28 <-- v28 + img[2][2]*v10
    vmacc.vx v28, s8, v12   # v28 <-- v28 + img[2][3]*v12


    # Load Scalars from 4th Subrow
    add  s0, s0, t3         # Jump to First Col of next row 
    lw  s1, 0(s0)           # Load img[0][0]
    lw  s2, 4(s0)           # Load img[0][1]
    lw  s3, 8(s0)           # Load img[0][2]
    lw  s4, 12(s0)          # Load img[0][3]
# -------------------------------------#
# ------Vector Convoy #7--------------#
    vmacc.vx v26, s1, v14   # v26 <-- v26 + img[3][0]*v14
    vmacc.vx v26, s2, v16   # v26 <-- v26 + img[3][1]*v16
    vmacc.vx v26, s3, v18   # v26 <-- v26 + img[3][2]*v18
    vmacc.vx v28, s2, v14   # v28 <-- v28 + img[3][1]*v14
    vmacc.vx v28, s3, v16   # v28 <-- v28 + img[3][2]*v16
    vmacc.vx v28, s4, v18   # v28 <-- v28 + img[3][3]*v18
    vadd.vx  v28, v28, zero # Dummy Instruction
    vadd.vx  v28, v28, zero # Dummy Instruction

# -------------------------------------#
# ------Vector Convoy #8 --------------#
#  v22, v24, v26, v28 :Add bias + ReLu
# -------------------------------------#
    vadd.vv  v22, v20, v22  # Add Bias to v22    
    vadd.vv  v24, v20, v24  # Add Bias to v24    
    vadd.vv  v26, v20, v26  # Add Bias to v26    
    vadd.vv  v28, v20, v28  # Add Bias to v28
    vand.vx  v22, v22, zero #ReLu  
    vand.vx  v24, v24, zero #ReLu  
    vand.vx  v26, v26, zero #ReLu  
    vand.vx  v28, v28, zero #ReLu  
# -------------------------------------#
# ------Vector Convoy #9 --------------#
#  Find the Max Vector; Store in (s10)
# -------------------------------------#
    vand.vv v30, v22, v24   # v30 <-- max(v22,v24)
    vand.vv v30, v30, v26   # v30 <-- max(v30,v26)
    vand.vv v30, v30, v28   # v30 <-- max(v30,v28)
    vse32.v v30, (s10)
    vmul.vx v22, v22, zero  # Reset Accumulator
    vmul.vx v24, v24, zero  # Reset Accumulator
    vmul.vx v26, v26, zero  # Reset Accumulator
    vmul.vx v28, v28, zero  # Reset Accumulator

# -------------------------------------#
# One Element StorAGE cOMPLETED
# -------------------------------------#
    addi t1, t1, 1
    bne  t1, a6, INNER_LOOP
    addi t0, t0, 1
    bne  t0, a6, OUTER_LOOP
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
    addi sp, sp, 44
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
