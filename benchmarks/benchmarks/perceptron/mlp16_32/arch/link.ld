/* */

OUTPUT_ARCH( "riscv" )

_STACK_SIZE = DEFINED(_STACK_SIZE) ? _STACK_SIZE : 0x8000;
/*_HEAP_SIZE = DEFINED(_HEAP_SIZE) ? _HEAP_SIZE : 0x8000;*/

/*****************************************************************************
 * Define memory layout
 ****************************************************************************/
MEMORY {
	imem : ORIGIN = 0x00000000, LENGTH = 0x00020000
	dmem : ORIGIN = 0x00020000, LENGTH = 0x00020000
    vmem : ORIGIN = 0x00040000, LENGTH = 0x20000
    vreg : ORIGIN = 0x00080000, LENGTH = 0x400
}

/* Specify the default entry point to the program */

ENTRY(_mstart)
    __stacktop = ORIGIN(dmem) + LENGTH(dmem) - 4;   /* Stack Top = 0x0003_FFFC */

/*****************************************************************************
 * Define the sections, and where they are mapped in memory 
 ****************************************************************************/
SECTIONS {
	.text : {
		. = ALIGN(4);
	    *boot.o(.text);
		*(.text);
		*(.text.*);
		. = ALIGN(4);
	} > imem

	.init : {
		. = ALIGN(4);
	   KEEP (*(.init))
		. = ALIGN(4);
	} > imem

    .fini : {
		. = ALIGN(4);
       KEEP (*(.fini))
		. = ALIGN(4);
    } > imem

    .rodata : {
       . = ALIGN(4);
       __rodata_start = .;
       *(.rodata)
       *(.rodata.*)
       *(.gnu.linkonce.r.*)
       . = ALIGN(4);
       __rodata_end = .;
	} > dmem

	.sbss : {
       . = ALIGN(4);
	   __sbss_start = .;
	   *(.sbss)
	   *(.sbss.*)
	   *(.gnu.linkonce.sb.*)
       . = ALIGN(4);
	   __sbss_end = .;
	} > dmem
	
    .sdata : {
        _gp = . + 0x800;
        *(.srodata.cst16) *(.srodata.cst8) *(.srodata.cst4) *(.srodata.cst2) *(.srodata*)
        *(.sdata .sdata.* .gnu.linkonce.s.*)
     }	> dmem

	.sbss2 : {
       . = ALIGN(4);
	   __sbss2_start = .;
	   *(.sbss2)
	   *(.sbss2.*)
	   *(.gnu.linkonce.sb2.*)
       . = ALIGN(4);
	   __sbss2_end = .;
	} > dmem

	.data : {
	   . = ALIGN(4);
	   __data_start = .;
	   *(.data)
	   *(.data.*)
	   *(.gnu.linkonce.d.*)
       . = ALIGN(4);
	   __data_end = .;
	} > dmem

    .bss : {
       . = ALIGN(4);
       __bss_start = .;
       *(.bss)
       *(.bss.*)
       *(.gnu.linkonce.b.*)
       *(COMMON)
       . = ALIGN(4);
       __bss_end = .;
    } > dmem


/* Generate Vector Memory and Vector Reg definitions */
    /* Vector Memory Section */
    . = 0x40000;
    .vmem_data :
    {
       __VMEM_START = .;
       KEEP(*(.vmem_data))
       __VMEM_END = .;
    } > vmem

    /* Vector Register Section */
    . = 0x80000;
    .vreg_data :
    {
       __VREG_START = .;
       KEEP(*(.vreg_data))
       __VREG_END = .;
    } > vreg
/* Generate Stack and Heap definitions */
/*    .stack : {
       . = ALIGN(4);
       _stack_end = .;
       . += _STACK_SIZE;
       . = ALIGN(4);
       _stack = .;
       __stack = _stack;
    } > dmem
    
    _end = .;
*/
}
