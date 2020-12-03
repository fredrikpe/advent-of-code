#include <benchmark/benchmark.h>

#include "1.h"
#include "2.h"
#include "3.h"

static void BM_1_1(benchmark::State& state) {
    for (auto _ : state) {
        benchmark::DoNotOptimize(day1::part1());
    }
}

static void BM_2_1(benchmark::State& state) {
    auto input = day2::parse_input();
    for (auto _ : state) {
        benchmark::DoNotOptimize(day2::part1(input));
    }
}
static void BM_2_2(benchmark::State& state) {
    auto input = day2::parse_input();
    for (auto _ : state) {
        benchmark::DoNotOptimize(day2::part2(input));
    }
}

static void BM_3_1(benchmark::State& state) {
    auto input = day3::parse_input();
    for (auto _ : state) {
        benchmark::DoNotOptimize(day3::part1(input));
    }
}




BENCHMARK(BM_1_1);
BENCHMARK(BM_2_1);
BENCHMARK(BM_2_2);
BENCHMARK(BM_3_1);
BENCHMARK_MAIN();
