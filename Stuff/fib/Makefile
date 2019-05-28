all: killme


killme: killme.o fib1.o
	gcc -o killme fib1.o killme.o

killme.o:	killme.s
	gcc -c killme.s

fib1.o:	fib1.s
	gcc -g -c fib1.s

killme.s:	killme.c
	gcc -O2 -S killme.c


clean:	
	rm -f killme *.o killme.s