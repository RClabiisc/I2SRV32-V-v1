# void *bcd2ascii(void* dst, const void* src, size_t n)
#
# a0 = dst, a1 = src, a2 = n
#
#            n: size of src
# return value: dst + n*2

# Alternative declaration:
#
# struct Void_Pair { void *fst; void *snd; };
# typedef struct Void_Pair Void_Pair;
# Void_Pair bcd2ascii(void* dst, const void* src, size_t n);
#
# return value: (Void_Pair){dst + n * 2, src + n}

# Regarding the comments:
# Register content is written right-to-left, starting with the
# least-significant element - enclosed by | |.
# Nibbles (i.e. 4 bit byte halves) are sometimes denoted by variables
# g, h, i, j, ...

# On a RISC-V "V" implementation with VLEN=128 bits, each
# loop iteration converts 64 input bytes, i.e. 128 digits.
# Since each iteration executes 14 instruction, it has a
# throughput of 9 digits per instruction.
# In contrast to that, an SSSE3 implementation with a similar number of
# instructions only converts 8 input bytes per iteration. 

# 2020, Georg Sauthoff <mail@gms.tf>, LGPLv3+

    .text                     # Start text section
    .align 2                  # align 4 byte instructions by 2**2 bytes
    .global bcd2ascii         # define global function symbol
bcd2ascii:

    # ## Prepare 16 element ASCII character lookup table

    li a6, 16                 # load immediate (pseudo instruction)
    vsetvli t0, a6, e8, m8    # switch to 8 bit element size,
                              # i.e. 4 groups of 8 registers
    # assert t0 == 16

    vid.v v8                  # store Vector Element Indices,
                              # i.e. v8 = | 16, ..., 2, 1, 0 |
    vmsgtu.vi v0, v8, 9       # set mask-bit if greater than unsigned immediate
    # --> v0 = | 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 |

    li a7, 48                 # load immediate, i.e. '0'
    vadd.vx v8, v8, a7        # add that scalar to each element

    addi a7, a7, -9           # add immediate, i.e. set to 39 == 'a'-'0'-10,
                              # i.e. to arrive at 'a', 'b', ...
    vadd.vx v8, v8, a7, v0.t  # masked add for the additional offset

    # The final lookup table is then:
    # --> v8 = | 'f', ...,  'b', 'a', '9',  ... , '2', '1', '0' |

    # ## Main load, convert and store loop
.Loop:                        # local symbol name because of .L prefix
    vsetvli a3, a2, e16, m8   # switch to 16 bit element size,
                              # 4 groups of 8 registers
    # --> a3 = min(a2, 8*vlenb/2)
    vlbu.v v16, (a1)          # Load a3 unsigned bytes,
                              # one byte per 16 bit element, zero-extend,
                              # starting at addr stored in a1
    # --> v16 = | 0, a1[vlenb/2-1], ..., 0, a1[1], 0, a1[0] |, ...,
    #     v23 = | 0, a1[a3-1],       ...,  0, a1[7*vlenb/2] |
    # --> v16 = | ... 00mn 00kl 00ij 00gh |

    add a1, a1, a3            # increment src by read elements
    sub a2, a2, a3            # decrement n

    vsll.vi v24, v16, 8       # shift-left-logical each element by 8 bits
    # --> v24 = | ... mn00 kl00 ij00 gh00 |

    vsrl.vi v16, v16, 4       # shift-right-logical each element by 4 bits
    # --> v16 = | ... 000m 000k 000i 000g |

    slli a3, a3, 1            # shift left logical by immediate,
                              # i.e. to double the number of vector elements
    vsetvli t4, a3, e8, m8    # switch to 8 bit element size,
                              # 4 groups of 8 registers

    vand.vi v24, v24, 0xf     # and each element with 0x0f,
                              # i.e. zero-out the high nibbles
    # --> v24 = | ... 0n 00 0l 00 0j 00 0h 00 |
    vor.vv  v16, v16, v24     # or each element
    # --> v16 = | ... 0n 0m 0l 0k 0j 0i 0h 0g |

    # look up ASCII values
    vrgather.vv v24, v8, v16  # vd[i] = (vs1[i] >= VLMAX) ? 0 : vs2[vs1[i]]
    # --> v24[i] = (v16[i] >= VLMAX) ? 0 : v8[v16[i]]

    vsb.v v24, (a0)           # write result to dst
    # --> a0[0] = v24[0], a0[1] = v24[1], ..., a0[vl-1] = v24[vlenb-1], ...,
    #     a0[vlenb*7] = v31[0],           ..., a0[a3-1] = v31[vlenb-1]
    # --> a0[0..a3-1] = [ 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n' ]
    add  a0, a0, a3           # increment dst
    bnez a2, .Loop            # branch to loop head if not equal to zero
    ret
