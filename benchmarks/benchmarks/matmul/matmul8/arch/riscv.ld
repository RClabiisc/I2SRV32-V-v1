MEMORY
{
    rom     :   org = 0x000000    ,   len = 0x20000      
    ram     :   org = 0x020000    ,   len = 0xE0000
    vmem    :   org = 0x100000    ,   len = 0x80000
    vreg    :   org = 0x180000    ,   len = 0x00400
}

ENTRY(_mstart)
    __stacktop = ORIGIN(ram) + LENGTH(ram) - 0x1000 - 4;   /* Stack Top = 0x000F_EFFC */
/*    __stacktop = 2* ORIGIN(ram) - 4; */  /* Stack Top = 0x0003_FFFC */
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
    . = 0x100000;
    .vmem_data :
    {
       __VMEM_START = .;
       KEEP(*(.vmem_data))
       __VMEM_END = .;
    } > vmem

    /* Vector Register Section */
    . = 0x180000;
    .vreg_data :
    {
       __VREG_START = .;
       KEEP(*(.vreg_data))
       __VREG_END = .;
    } > vreg

        }   

