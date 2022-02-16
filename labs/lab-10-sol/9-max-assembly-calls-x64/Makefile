ASM = nasm
CFLAGS = -Wall -no-pie
LDFLAGS = -no-pie
ASMFLAGS = -f elf64

.PHONY: all clean

all: mainmax

mainmax: main.o max.o
	$(CC) $(LDFLAGS) -o $@ $^

main.o: main.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

max.o: max.c

clean:
	-rm -f *~
	-rm -f main.o max.o
	-rm -f mainmax
