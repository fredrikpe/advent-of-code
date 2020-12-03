CC=clang++-10
CFLAGS=-std=c++20 -O3 -Wall

all: bench run

solve: solve.cpp 1.h 2.h 3.h
	$(CC) solve.cpp -o solve $(CFLAGS)

benchmark: benchmark.cpp 1.h 2.h 3.h
	$(CC) benchmark.cpp -o benchmark $(CFLAGS) -isystem benchmark/include -Lbenchmark/build/src -lbenchmark -lpthread

bench: benchmark
	./benchmark

run: solve
	./solve

clean:
	rm -f solve benchmark
