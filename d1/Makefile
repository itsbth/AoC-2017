all: solve
solve.o: solve.s
	yasm -f elf64 solve.s

solve: solve.o
	ld -o solve *.o
