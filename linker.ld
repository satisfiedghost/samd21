MEMORY
{
    flash (rx)  : ORIGIN = 0x00000000, LENGTH = 256K
    sram  (rxw) : ORIGIN = 0x20000000, LENGTH = 32K
}

STACK_SIZE = 0x2000;

SECTIONS
{
    .text : ALIGN(4)
    {
        FILL(0xFF)
        KEEP(*(.vectors))
        *(.text*)
    } > flash

    . = ALIGN(4);
    _etext = .;

    .data : ALIGN(4)
    {
        FILL(0xFF)
        _sdata = .;
        *(.data*)
        . = ALIGN(4);
        _edata = .;
    } > sram AT > flash

    .bss (NOLOAD) : ALIGN(4)
    {
        _sbss = .;
        __bss_start__ = .;
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
        __bss_end__ = .;
    } > sram

    .stack (NOLOAD) :
    {
        FILL(0xFF)
        . = ALIGN(8);
        _stack_top = .;
        . = . + STACK_SIZE;
        . = ALIGN(8);
    } > sram
}