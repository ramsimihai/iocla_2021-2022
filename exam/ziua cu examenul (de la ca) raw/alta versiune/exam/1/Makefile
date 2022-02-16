ASM = nasm
CC = gcc
CFLAGS = -Wall -m32 -Wno-implicit-function-declaration
LDFLAGS = -m32

.PHONY: all clean

all: file

file: file.o

file.o: file.asm
	$(ASM) -f elf32 -o $@ $<

clean:
	-rm -f *~
	-rm -f file.o file
