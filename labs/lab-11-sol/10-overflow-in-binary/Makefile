CC=gcc
CFLAGS=-m32 -masm=intel -fno-stack-protector

all: overflow_in_binary overflow_in_binary.asm

overflow_in_binary: overflow_in_binary.o
	$(CC) $(CFLAGS) -o $@ $<

overflow_in_binary.o: overflow_in_binary.c

overflow_in_binary.asm: overflow_in_binary.c
	$(CC) $(CFLAGS) -S -o $@ $^

clean:
	rm -f *.o *.asm overflow_in_binary
