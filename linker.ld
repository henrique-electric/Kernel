/* Minimal linker script for an AArch64 bare-metal kernel. */
OUTPUT_ARCH(aarch64)
ENTRY(_start)

SECTIONS
{
    /* Common load address for AArch64 board bootloaders (for example, QEMU virt). */
    . = 0x40080000;

    .text : ALIGN(16)
    {
        KEEP(*(.text.boot))
        *(.text .text.*)
    }

    .rodata : ALIGN(16)
    {
        *(.rodata .rodata.*)
    }

    .data : ALIGN(16)
    {
        *(.data .data.*)
    }

    .bss (NOLOAD) : ALIGN(16)
    {
        __bss_start = .;
        *(.bss .bss.*)
        *(COMMON)
        __bss_end = .;
    }

    /DISCARD/ :
    {
        *(.comment)
        *(.note .note.*)
        *(.eh_frame .eh_frame.*)
    }
}
