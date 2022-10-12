# ----------------------------------------------------------------------
# Created  : 13th May 2021
# Engineer : Naveen Chander
# Research : DESE, IISc
# Convolution + maxpool 2 {Layers 3 and 4}
# RV32IM Vector Assembly for Convolution + Maxpool2 of 13 x 13 x 16 Matrix with a 3 x 3 x 16  Kernel with 32 such filters
# Function Prototype
# void* layer2(int output[5][5][32], int matrix[13][13][16], int kernel[3][3][16][32], int matsize, int bias[32], int n_filters, int n_dim);
# a0 : Output Address
# a1 : Input Matrix Address
# a2 : Input kernel Address
# a3 : Size of Matrix 
# a4 : Input Bias
# a5 : Number of Filters
# a6 : Input Matrix Dimension
# ----------------------------------------------------------------------
# Loop Variables : t0 : i --> Loops through Rows of the Output matrix   0 .. a7
#                  t1 : j --> Loops through Cols of the OUtput Matrix   0 .. a7
#                  t4 : k --> Loops through Filters of the Input Matrix 0 .. a6 
#                  s11: x --> Loops through Rows of the Kernel          0 .. 2 
# ----------------------------------------------------------------------
#.include "header.h"
    .text
    .align 2
    .globl layer2

layer2:
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
    mul   t0, a5, a6        # n_filt * n_dim
    slli  t1, t0, 2         # 4 * n_filt * n_dim
    sw    t1, -4(sp)        # Store it in Stack  
    #----------------------------------# 
    addi  t0, a3, -2        # Finding the Size of output matrix
    srai  a7, t0, 1         # a7 <-- OUtput matrix Size <No. of iterations>
    vsetvli t3, a5, e32, m4 # Vector Length = No. of Filters
#------------------------------------#     
# -------------------------------------#
# Alogorithm for Loading Start Element
# t0  : 0 ..  a7 (i)
# t1  : 0 ..  a7 (j)
# Input Matrix  : (matsize*i+j)*8 *n_dim 
# Output matrix : (output_size*i+j)*4*n_filt
# -------------------------------------#
    addi  t0, zero, 0       # Init Loop variable Mat Row(i)
OUTER_LOOP:    
    addi  t1, zero, 0       # Init Loop variable mat Col)j)
INNER_LOOP:
    #  Compute Output matrix Start Address
    mul   t2, t0, a7        # output_size *i
    add   t3, t1, t2        # (output_size)*i+j 
    slli  t3, t3, 2         # ((output_size)*i+j)*4 
    mul   t5, t3, a5        # ((output_size)*i+j)*4 *N_FILT
    add   s10, a0, t5       # Start Address for Ouput matrix
    #--------------------------------------------------------#
    # -----------------Vector Convoy 1 : Reset Accumulators--#
    vmul.vx v4, v4,   zero  # Reset Accumulator
    vmul.vx v8, v8,   zero  # Reset Accumulator
    vmul.vx v12, v12, zero  # Reset Accumulator
    vmul.vx v16, v16, zero  # Reset Accumulator
    vmul.vx v20, v20, zero  # Reset Accumulator
    vmul.vx v24, v24, zero  # Reset Accumulator
    vmul.vx v28, v28, zero  # Reset Accumulator
    vmul.vx v28, v28, zero  # Reset Accumulator
    #--------------------------------------------------------#
    addi t4, zero, 0        # Loop Variable to iterate thru IMG_DIM
    #--------------------------------------------------------#
IMG_DIM_LOOP:               # To iterate through dim of the img    
    #Compute the start address of IMG in s0
    mul   t2, t0, a3        # matsize*i
    add   t3, t1, t2        # matsize*i+j
    slli  t3, t3, 3         # 8*(matsize*i+j)
    mul   t3, t3, a6        # n_dim*8*(matsize*i+j)
    add   s0, a1, t3        # Start Address without img_offset
    slli  t5, t4, 2         # 4*k
    add   s0, s0, t5        # Start Address for Input matrix
    #--------------------------------------------------------#
    # Compute the Start Address of the Kernel in s9
    mul  t3, t4, a5         # t3=n_filt x k
    slli t5, t3, 2          # t5=n_filt x k x 4
    add  s9, a2, t5         # K[0][0][k][:] 
    #--------------------------------------------------------#
    addi s11, zero, 0       # Init Loop Variable : Loops across Ker Rows
    #--------------------------------------------------------#
KER_ROW_LOOP:               # Loops thrices to sweep three rows of Kernel
    # Compute Start Address of 3 adjacent kernels{s9, t5, t6}
    lw   t2, -4(sp)         # Load Kernel Displacement from Stack
    add  t5, s9, t2         # K[x][1][k][:]
    add  t6, t5, t2         # K[x][2][k][:] 
    #--------------------------------------------------------#
    # Load Scalars from 1st and 2nd Subrows in s1 .. s8
    lw   s1, 0(s0)           # Load img[x][0]
    lw   s2, 64(s0)          # Load img[x][1]
    lw   s3, 128(s0)         # Load img[x][2]
    lw   s4, 192(s0)         # Load img[x][3]
    # Head to Next Sub row
    mul  t2, a3, a6
    slli t2, t2, 2           # Displacement for img[x][0] -> img[x+1][0] 
    add  s0, s0, t2          # Address of next sub row
    lw   s5, 0(s0)           # Load img[x+1][0]
    lw   s6, 64(s0)          # Load img[x+1][1]
    lw   s7, 128(s0)         # Load img[x+1][2]
    lw   s8, 192(s0)         # Load img[x+1][3]
    #--------------------------------------------------------#
    # ------Vector Convoy #1 and 2             --------------#
    vle32.v  v4,  (s9)      # Load K[x][0] for all Channels
    vle32.v  v8,  (t5)      # Load K[x][1] for all Channels
    vle32.v  v12,  (t6)     # Load K[x][2] for all Channels
    vmacc.vx v16, s1, v4    # v16 <-- v16 + k[x][0]*img[x][0]
    vmacc.vx v16, s2, v8    # v16 <-- v16 + k[x][1]*img[x][1]
    vmacc.vx v16, s3, v12   # v16 <-- v16 + k[x][2]*img[x][2]
    vmacc.vx v20, s2, v4    # v20 <-- v20 + k[x][0]*img[x][0]
    vmacc.vx v20, s3, v8    # v20 <-- v20 + k[x][1]*img[x][1]
    vmacc.vx v20, s4, v12   # v20 <-- v20 + k[x][2]*img[x][2]
    vmacc.vx v24, s5, v4    # v24 <-- v24 + k[x][0]*img[x][0]
    vmacc.vx v24, s6, v8    # v24 <-- v24 + k[x][1]*img[x][1]
    vmacc.vx v24, s7, v12   # v24 <-- v24 + k[x][2]*img[x][2]
    vmacc.vx v28, s6, v4    # v28 <-- v28 + k[x][0]*img[x][0]
    vmacc.vx v28, s7, v8    # v28 <-- v28 + k[x][1]*img[x][1]
    vmacc.vx v28, s8, v12   # v28 <-- v28 + k[x][2]*img[x][2]
    vadd.vx  v28, v28, zero # Dummy Instruction
    #--------------------------------------------------------#
    addi    s11, s11, 1     # GoTo Next Row in Kernel
    lw      t2, -4(sp)      # Load Row Offset
    add     s9, t6, t2      # Get Next Row Start Address
    li      t2, 3
    bne     s11, t2, KER_ROW_LOOP
    #--------------------------------------------------------#
    addi    t4, t4, 1       # k=k+1
    bne     t4, a6, IMG_DIM_LOOP
    nop
    nop
    #--------------------------------------------------------#
# -------------------------------------#
# ------Vector Convoy #8 --------------#
#  Load bias in v4 :
#  v16, v20, v24, v28 :Add bias + ReLu
# -------------------------------------#
    vle32.v  v4, (a4)
    vadd.vx  v28, v28, zero # Dummy Instruction to avoid Stall
    vadd.vv  v16, v4, v16  # Add Bias to v16    
    vadd.vv  v20, v4, v20  # Add Bias to v20    
    vadd.vv  v24, v4, v24  # Add Bias to v24    
    vadd.vv  v28, v4, v28  # Add Bias to v28
    vand.vx  v16, v16, zero #ReLu  
    vand.vx  v20, v20, zero #ReLu  
# -------------------------------------#
# ------Vector Convoy #9 --------------#
#  Find the Max Vector; Store in (s10)
# -------------------------------------#
    vand.vx v24, v24, zero  #ReLu  
    vand.vx v28, v28, zero  #ReLu  
    vand.vv  v8, v16, v20   # v8 <-- max(v16,v20)
    vand.vv  v8, v8,  v24   # v8 <-- max(v8,v24)
    vand.vv  v8, v8,  v28   # v8 <-- max(v8,v28)
    vse32.v  v8, (s10)      # Store one Vector in OUtput Matrix
    vand.vv  v8, v8,  v8    # Dummy
    vand.vv  v8, v8,  v8    # Dummy

# -------------------------------------#
# One Element StorAGE cOMPLETED
# -------------------------------------#
    addi t1, t1, 1
    bne  t1, a7, INNER_LOOP
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
    addi sp, sp, 48
    ret
