NOME = quick_sum

all: main.c $(NOME).o
	gcc -m32 -c main.c
	gcc -m32 main.o $(NOME).o -o $(NOME)
	rm -rf *.o

%.o: %.asm
	nasm -f elf32 $<
