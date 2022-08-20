# I2SRV32-V RISC-V Vector Processor
This is a synthesizable RV32GV RISC-V core written in the Verilog and VHDL hardware construction language, implemented and tested on Xilinx Virtex-7 FPGA VC707 Evaluation Kit. Created at Reconfigurable Computation Lab, Department of Electronic System Engineering, Indian Institute of Science (IISc), Bengalure.

## Overview

### Top Level FPGA RTL Wrapper

**![img](https://lh4.googleusercontent.com/rWtm8E1jWkbEpSeksE1jcZVacJE6J6sQqPsAM4gKMUzqXyunLDknmV2iZJjvWiCOu2fuxdE-G0z5XUTGGmv7zLYJivndlb5uwWVw8e2ubo0kE0RsV6Ip9QUWWOFU3RVZDymOsxj1W-bADbeL3GwEZ5g)**

### High Level Microarchitecture

![img](https://lh5.googleusercontent.com/JgpjnRMokKWKHIJEYXBDjrwQQruAlcj8fXRrfbCDrZDGurbAQOXUDfo6HzLzWb31tGfT89JA9GEGOkFd8fsG0QNDtX_63UXBx8OWe9Gj9jho-gjPylFGYR4570xBua3lFG0tJS3F3ug5_rHHlYeXoKo)

## Features

This repository features the FPGA RTL for an ultra-low power microcontroller-class RISC-V Vector Processor that can be used to speed up data-parallel Workloads such as Deep Learning, Cryptography etc., on remote, portable IoT devices.

### Highlights

1. Performance improvement of upto 40.7x over the scalar-only core using about 20% more power and 80% more hardware resources.

2. Consists of a RISC-V (G) Core that is interfaced to Systolic Array based Vector Unit.

3. ISA Support: RISC-V Vector ISA 1.0 + Few custom instructions.

4. Microarchitecture
   * Single -core, single-issue, in-order, 5-stage pipeline.
   * Separate Instructions and Data Cache (8KB, 2-way Set associative).
   * Main Memory : 1MB scalar memory + 512kB Vector Scratchpad memory.
   * Main memory and Peripherals are connected to the core through Wishbone Bus.
   * Peripheral: UART 1 port (with Flow Control) taken from http://www.opencores.org/cores/uart16550/.
   * Vector Accelerator: Systolic Array based 8-lane Integer vector unit with 512kB Scratchpad memory.

6. Clock : 50 MHz on Xilinx Vertex-7 FPGA.

7. Power consumption on FPGA: 597 mW (while running CNN for digit recognition on MNIST dataset).

8. Can be used as a RISC-V(G) core by disabling the vector unit to support backward compatibility.

   

## Design Space

|                    **Parameter**                     |                      **Specification**                       |
| :--------------------------------------------------: | :----------------------------------------------------------: |
|                  **Vector Memory**                   |                   512 KB Scratchpad Memory                   |
|                    **Memory Map**                    | While migrating between the CPUs, the linker file in  *arch/riscv.ld* of the benchmark program should be changed accordingly ![image](https://user-images.githubusercontent.com/91065965/185728904-a722b839-981b-49a9-b1e2-5cf3a007c3a7.png)|
|              **Benchmark** **Programs**              |     XAPY (or SAXPY) , PERCEPTRON, CONV, CNN, MATMUL, MLP     |
|            **Compiling**  **Scalar Code**            | Depending upon which code runs properly on the CPU, *gcc -O3/gcc-O2*  have been set in the *Makefiles* |
| **Scratchpad Memory Experiments on Scalar Programs** | All Benchmark programs have separate folders named – SPRAM and NO_SPRAM which contain scalar codes that use (do not use) scratchpad memory |
|          **Compiling** **Vector** **Code**           |                 NOT compiled using *gcc -O3*                 |

## Interfaces
|   Name    |        Description        |
| :-------: | :-----------------------: |
| clk_in1_n |   Clock Input negative    |
| clk_in1_p |    Clock input postive    |
|  rst_in   | Async reset, active-high. |
| srx_pad_i |    Receiver Input pin     |
| stx_pad_o |  Transmitter Output pin   |
|  int_in   |   3-bit Interrupt input   |
|    cts    |       clear to send       |
|    rts    |      request to send      |

## Prerequisites

- ​	PC with *Ubuntu 20.04*
- ​	*Xilinx Vivado* 2020.2 with server license.  
  - Note that support for VC707 is removed from 2020.3 onwards.
- ​	RISC-V GNU Toolchain
  - *riscv-gnu-toolchain* GitHub Version Name: **RVV_INTRINSIC**
    - To be compiled specifically for 32-bit targets
  - *riscv-isa-sim* SPIKE simulator
  - *riscv-pk* Proxy Kernel is required to run SPIKE.

## Contents of the Repository

The repository is organized as follows-

* Overview of the work is provided in a powerpoint presentation
* **Source Code**
  * RTL Source and Wrapper  in Verilog/VHDL
  * Test Bench RTL
  * IPs
  * README file
* **Benchmark Suite**
  * 6 Benchmark programs consisting of matrix Multiplication, Convolution, Multi-layer Perceptron, CNN etc.,
  * Excel Sheet with Benchmark Figures obtained for various workloads.
  * Benchmark Source codes and executables to reproduce the values.
  * Readme file describing how to compile and simulate the benchmarks.
* **Demo**
  * Demo Video showcasing an image recognition task performed by the vector processor
  * FPGA .BIT file
  * Drivers required for setting up the demo mentioned in note.txt.
  * Demo Video
* **Studies: Neural Network Profiling** 
  * **.c** source codes for the Neural Networks that were used to study the benefits of using data parallel architectures to run different NN topologies

