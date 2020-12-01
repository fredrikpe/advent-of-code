CC=clang++-10
CFLAGS=-std=c++20 -O3 -Wall

all: bench run-solver

solve: solve.cpp
	$(CC) solve.cpp -o solve $(CFLAGS)

benchmark: benchmark.cpp
	$(CC) benchmark.cpp -o benchmark $(CFLAGS) -isystem benchmark/include -Lbenchmark/build/src -lbenchmark -lpthread

bench: benchmark
	./benchmark

run-solver: solve
	./solve

clean:
	rm -f solve benchmark
