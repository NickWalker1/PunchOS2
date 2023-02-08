C_SOURCES = $(wildcard src/kernel/*.c src/lib/*.c src/drivers/*.c)
HEADERS   = $(wildcard src/kernel/*.h src/lib/*.h src/drivers/*.h)

ASM_SOURCES = $(wildcard src/boot/*.asm)

ASM_OBJ =${ASM_SOURCES:.asm=.o}
OBJ=${C_SOURCES:.c=.o}


GCC_FLAGS= -m32 -std=gnu99 -ffreestanding -O0 -nostdlib -Wall -Wextra 
LD_FLAGS = -melf_i386

all: os.iso

GCC=gcc
LD =ld

#Local
QEMU=qemu-system-i386
GRUB=grub-mkrescue


run: all
	$(QEMU) -cdrom os.iso -D ./log.txt -d cpu_reset


os.iso: os.bin
	cp $< isodir/boot/os.bin
	$(GRUB) -o $@ isodir

os.bin: $(OBJ) $(ASM_OBJ)
	$(LD) -T link.ld $(LD_FLAGS)

%.o: %.asm
	nasm -felf32 $< -o $@

%.o : %.c ${HEADERS} 
	$(GCC) -c $< -o $@ $(GCC_FLAGS) -I./src/lib -I./src/drivers

clean:
	rm -f *.iso *.bin 
	rm -f src/*/*.o
	rm -f isodir/boot/*.bin
