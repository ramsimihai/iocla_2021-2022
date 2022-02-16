NASM = nasm
AFILES = sum_array.asm sum_array_square.asm
OBJS = $(AFILES:.asm=.o) 
ASM_FLAGS = -f elf32 -g
LD=gcc
LDFLAGS = -m32 -g
BINARIES = sum_array sum_array_square

all : $(BINARIES)

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

clean: 
	rm -f *.o $(BINARIES) *.s
	rm -f *~ 