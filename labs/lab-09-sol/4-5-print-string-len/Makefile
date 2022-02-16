NASM = nasm
AFILES = print-string-len.asm print-rev-string.asm 
OBJS = $(AFILES:.asm=.o) 
ASM_FLAGS = -f elf32 -g
LD=gcc
LDFLAGS = -m32 -g
BINARIES = print-string-len print-rev-string

all : $(BINARIES)

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

print-string-len: print-string-len.o
	$(LD) $(LDFLAGS) -o $@ $^

print-rev-string: print-rev-string.o
	$(LD) $(LDFLAGS) -o $@ $^

clean: 
	rm -f *.o $(BINARIES) *.s
	rm -f *~ 
