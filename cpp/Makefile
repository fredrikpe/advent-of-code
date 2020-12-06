CC=clang++-10
CFLAGS=-std=c++20 -O3 -Wall

SOLUTION_HEADERS=1.h 2.h 3.h 4.h 5.h 6.h

all: bench run


solve: solve.cpp input_parser.h $(SOLUTION_HEADERS)
	$(CC) solve.cpp -o solve $(CFLAGS)

benchmark: benchmark.cpp input_parser.h $(SOLUTION_HEADERS)
	$(CC) benchmark.cpp -o benchmark $(CFLAGS) -isystem benchmark/include -Lbenchmark/build/src -lbenchmark -lpthread

bench: benchmark
	./benchmark

run: solve
	./solve

clean:
	rm -f solve benchmark
