#include <benchmark/benchmark.h>

#include "1.h"

static void BM_1_1(benchmark::State& state) {
    for (auto _ : state) {
        solve_1_1();
    }
}


BENCHMARK(BM_1_1);
BENCHMARK_MAIN();
