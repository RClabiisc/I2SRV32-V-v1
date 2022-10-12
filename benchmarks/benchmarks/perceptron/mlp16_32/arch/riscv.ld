MEMORY
{
    rom     :   org = 0x0000,    len = 0x20000
    ram     :   org = 0x20000,   len = 0x20000
    vmem    :   org = 0x40000,   len = 0x20000
    vreg    :   org = 0x80000,   len = 0x400
}

ENTRY(_mstart)
    __stacktop = ORIGIN(ram) + LENGTH(ram) - 4;   /* Stack Top = 0x0003_FFFC */
SECTIONS {
    . = 0x0;
    .text : 
    { 
         KEEP(*(.stack))
         KEEP(*(.text)) 
    } > rom
    .rodata : { *(.rodata) }  > rom
    . = 0x20000;
    .sdata : { *(.sdata) }  > ram
    .data : { *(.data) }    > ram
    .sbss  : { *(.sbss) } > ram
    .bss  : { *(.bss) *(COMMON) } > ram
   
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

        }   

