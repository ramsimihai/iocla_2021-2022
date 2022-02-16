ASM = nasm
ASM_FLAGS = -f elf32 -g -Fdwarf
CFLAGS = -Wall -m32 -fno-stack-protector -mpreferred-stack-boundary=2 -fno-PIC
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: test strchr

test: test.o marks.o

test.o: test.c

strchr: strchr.o

strchr.o: strchr.asm
	$(ASM) $(ASM_FLAGS) -o $@ $<

clean:
	-rm -f *~
	-rm -f test.o test
	-rm -f strchr.o strchr
