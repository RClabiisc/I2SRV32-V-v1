# Tools Required
* Python3
* gcc
* RISC-V GCC Cross Compiler (https://github.com/riscv-collab/riscv-gnu-toolchain).

# Compiling the benchmark program 

- Use Makefile to make suitable changes.
- Use Scripts/run.sh to add/remove commands.  
- Linker Script is available in arch/riscv.ld
- The whole project is compiled using make command.
- The output binary contains –
  - xmem.coe 	 	
  - dmem_bank0.coe
  - dmem_bank1.coe
  - dmem_bank2.coe
  - dmem_bank3.coe
  - dmem_bank4.coe
  - dmem_bank5.coe
  - dmem_bank6.coe
  - dmem_bank7.coe
- If the code does not use Scratchpad memory, then only xmem.coe is sufficient to be copied into the MainMem IP’s .coe file.
- Else, DMEM Ips need to be loaded with the respective bank .coe files.

# Command to run

* **make all** command should enter in terminal on Ubuntu Machine, in the present working directory.
* Example: Goto matmul32 directory in terminal, and enter **make all**.

# Simulating the benchmark program

- Functional Simulation at the behavioural level is the quickest method of testing.
- Post Synth/Post Layout Functional Simulation can be run for carrying out Vectored power Analysis.
- It is NOT advised to run Post layout Timing Simulations as it might take hours together to just initiate a simulation!