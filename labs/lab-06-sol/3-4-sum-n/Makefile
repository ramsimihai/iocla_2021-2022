NASM = nasm
AFILES = sum_n.asm suma_n_square.asm suma_n_square_stack.asm
OBJS = $(AFILES:.asm=.o) 
ASM_FLAGS = -f elf32 -g
LD=gcc
LDFLAGS = -m32 -g
BINARIES = sum_n suma_n_square suma_n_square_stack

all : $(BINARIES)

%.o : %.asm
	$(NASM) $(ASM_FLAGS) -o $@ $<

clean: 
	rm -f *.o $(BINARIES) *.s
	rm -f *~ 