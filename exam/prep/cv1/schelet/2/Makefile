ASM = nasm
ASM_FLAGS = -f elf32 -g -Fdwarf
CC = gcc
LDFLAGS = -m32

.PHONY: all clean

all: sum_parts

sum_parts: sum_parts.o

sum_parts.o: sum_parts.asm
	$(ASM) $(ASM_FLAGS) -o $@ $<

clean:
	-rm -f *~
	-rm -f sum_parts.o sum_parts
