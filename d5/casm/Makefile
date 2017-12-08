CFLAGS = -O3 -march=native -Wall -Werror
LDFLAGS = -flto
all: main main_2

solve.o: solve.s
	yasm -f elf64 $<

main: main.c solve.o
	$(CC) -o $@ $< solve.o $(CFLAGS) $(LDFLAGS)

main_2: main.c solve.o
	$(CC) -o $@ $< solve.o -DPART_2 $(CFLAGS) $(LDFLAGS)
