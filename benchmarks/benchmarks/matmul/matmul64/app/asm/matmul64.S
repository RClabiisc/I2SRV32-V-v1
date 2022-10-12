# ----------------------------------------------------------------------
# Created  : 2nd June 2021
# Engineer : Naveen Chander
# Research : DESE, IISc
# RV32IM Vector Assembly for Matrix Multiplication of 32 x 32 Matrices                               
# Function Prototype
# void matmul32(int output[], int matA[], int matB[], int matsize);
# a0 : Output Address
# a1 : A Matrix Address
# a2 : B kernel Address
# a3 : Size of Matrix 
# ----------------------------------------------------------------------
# 
# ----------------------------------------------------------------------
#.include "header.h"
    .text
    .align 2
    .globl matmul64

matmul64:
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
    li t0, 3
    csrc vxrm, t0           # vcxrm_csr : 00 => prod[31:0] 
    vsetvli t3, a3, e32, m4 # Vector Length = Matrix Dimension
    srli a6, a3, 2          # a6 = 64/4 =16
#------------------------------------#     
# Algo : 
# Load 64 Scalars from a Row in MatA
# Load entire matB as 64 Vectors
# Use 64 vmacc.vx to compute one Row of the Output
#------------------------------------#     
# ------Vector Convoy #2--------------#
    vmul.vx  v0,  v0,  zero  # Clear Accumulator 1
    vmul.vx  v8,  v8,  zero  # Clear Accumulator 2
    vmul.vx  v16, v8,  zero  # Clear Accumulator 3
    vmul.vx  v24, v12, zero  # Clear Accumulator 4
    vmul.vx  v0,  v0,  zero  # Clear Accumulator 1
    vmul.vx  v8,  v8,  zero  # Clear Accumulator 2
    vmul.vx  v16, v16, zero  # Clear Accumulator 3
    vmul.vx  v24, v24, zero  # Clear Accumulator 4
# -------------------------------------#
# Alogorithm for Loading Start Element
# t0  : 0 ..  a6 (i)
# t1  : 0 ..  a6 (j)
# Input Matrix  : (matsize*i+j)*8  
# Output matrix : (output_size*i+j)*8*n_filt
# -------------------------------------#
    addi  t0, zero, 0       # Init Loop variable Mat Row(i)
OUTER_LOOP:    
    addi  t1, zero, 0       # Init Loop variable <Block_Num>
    # Mat A Row Start Address
    slli t3, t0, 8
    add  a4, a1, t3          
    # mat B Start Address of 1st Row
    addi a5, a2, 0          
INNER_LOOP:                 # Loops through all columns in a row
                            # Bump by 4 columns <16 times>
    # Load the ith Block of Matrix B
    li      t3, 256         # Row Offset
    add     s1, a5, t3      # 2nd Sub-Row Address  
    add     s2, s1, t3      # 3rd Sub-Row Address 
    add     s3, s2, t3      # 4th Sub-Row Address 
    # Load 4 adj elements of mat A
    lw   s4, (a4)           # a[i][j]
    lw   s5, 4(a4)          # a[i][j+1]
    lw   s6, 8(a4)          # a[i][j+2]
    lw   s7, 12(a4)         # a[i][j+3]
# -------------------------------------#
# ------Vector Convoy #2--------------#
    vle32.v   v8,  (a5)      # Load 1st Row of Mat B
    vle32.v  v16,  (s1)      # Load 2nd Row of mat B
    vmacc.vx v24, s4, v8     # a[i][j]*Row1
    vmacc.vx v24, s5, v16    # a[i][j]*Row2
    vle32.v   v8,  (s2)      # Load 3rd Row of mat B
    vle32.v  v16,  (s3)      # Load 4th Row of mat B
    vmacc.vx v24, s6, v8     # a[i][j]*Row3
    vmacc.vx v24, s7, v16    # a[i][j]*Row4
# -------------------------------------#
    # Bump Mat B Address
    li    t3, 1024          # i * 64 * 4 * 4
    add   a5, a5, t3        # matB's Start Address of ith Block
    # Bump Mat A Address
    li    t3, 16            # i * 4 * 4
    add   a4, a4, t3        # Start Address of ith Block of matA
# -------------------------------------#
    addi t1, t1, 1
    bne t1, a6, INNER_LOOP
# -------------------------------------#
    vse32.v v24, (a0)
    vmul.vx v8,  v8,  zero  # Reset Accumulator
    vmul.vx v16, v16, zero  # Reset Accumulator
    vmul.vx v24, v24, zero  # Reset Accumulator
    vmul.vx v16, v16, zero  # Reset Accumulator
    vmul.vx v24, v24, zero  # Reset Accumulator
    vmul.vx v16, v16, zero  # Reset Accumulator
    vmul.vx v24, v24, zero  # Reset Accumulator
# -------------------------------------#

# -------------------------------------#
# One Element StorAGE cOMPLETED
# -------------------------------------#
    addi a0, a0, 256
    addi t0, t0, 1
    bne  t0, a3, OUTER_LOOP
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
