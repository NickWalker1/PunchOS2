/* The bootloader will look at this image and start execution at the symbol
   designated as the entry point. */
ENTRY(_start)
 
KERNEL_VIRT_BASE = 0xC0000000;

INPUT
(
    src/boot/boot.o 
    src/kernel/kernel.o
    src/drivers/low_level.o
    src/lib/debug.o
    src/lib/string.o
    src/lib/int.o
    src/lib/stdio.o
)

OUTPUT
(
    os.bin
)
/* Tell where the various sections of the object files will be put in the final
   kernel image. */
SECTIONS
{
	/* Begin putting sections at 1 MiB, a conventional place for kernels to be
	   loaded at by the bootloader. */
	. = 1M;
 
	/* First put the multiboot header, as it is required to be put very early
	   early in the image or the bootloader won't recognize the file format.
	   Next we'll put the .text section. */
	.multiboot.data :
	{
		*(.multiboot.data)
	}
    
	.multiboot.text :
	{
		*(.multiboot.text)
	}

    
	/* Now align with higher half addresses */
    . += KERNEL_VIRT_BASE;


    /* Note when using labels, ensure to use with & as it's a label not a variable
     *otherwise will return garbage data. */
	
    _TEXT_SECTION_START = .;  
	.text ALIGN(4K) : AT(ADDR(.text) - KERNEL_VIRT_BASE)
    {
        *(.text)
    }
    _TEXT_SECTION_END = .;


    _RODATA_SECTION_START = .;
	.rodata ALIGN(4K) : AT(ADDR(.rodata) - KERNEL_VIRT_BASE)
    {
        *(.rodata)
    }
    _RODATA_SECTION_END = .;


    _DATA_SECTION_START = .;
	.data ALIGN(4K) : AT(ADDR(.data) - KERNEL_VIRT_BASE)
    {
        *(.data)
    }
    _DATA_SECTION_END = .;


	.bss ALIGN(4K) : AT(ADDR(.bss) - KERNEL_VIRT_BASE)
    {
        _BSS_SECTION_START = .;
        *(.bss)
        _BSS_SECTION_END = .;
    }


    _KERNEL_END = .;
}
