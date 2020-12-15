#include <benchmark/benchmark.h>

#include "1.h"
#include "2.h"
#include "3.h"
#include "4.h"
#include "5.h"
#include "11.h"
#include "14.h"

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
static void BM_3_2(benchmark::State& state) {
    auto input = day3::parse_input();
    for (auto _ : state) {
        benchmark::DoNotOptimize(day3::part2(input));
    }
}

static void BM_4_1(benchmark::State& state) {
    auto input = day4::parse_input_random();
    for (auto _ : state) {
        benchmark::DoNotOptimize(day4::part1(input));
    }
}
static void BM_4_2(benchmark::State& state) {
    auto input = day4::parse_input_random();
    for (auto _ : state) {
        benchmark::DoNotOptimize(day4::part2(input));
    }
}

static void BM_5_2(benchmark::State& state) {
    auto input = day5::parse_input();
    for (auto _ : state) {
        benchmark::DoNotOptimize(day5::part2(input));
    }
}
static void BM_5_2fast(benchmark::State& state) {
    auto input = day5::parse_input();
    for (auto _ : state) {
        benchmark::DoNotOptimize(day5::part2fast(input));
    }
}

static void BM_11_1(benchmark::State& state) {
    for (auto _ : state) {
        benchmark::DoNotOptimize(day11::part1());
    }
}
static void BM_11_2(benchmark::State& state) {
    for (auto _ : state) {
        benchmark::DoNotOptimize(day11::part2());
    }
}


BENCHMARK(BM_1_1);
BENCHMARK(BM_2_1);
BENCHMARK(BM_2_2);
BENCHMARK(BM_3_1);
BENCHMARK(BM_3_2);
BENCHMARK(BM_4_1);
BENCHMARK(BM_4_2);
BENCHMARK(BM_5_2);
BENCHMARK(BM_5_2fast);
BENCHMARK(BM_11_1);
BENCHMARK(BM_11_2);

BENCHMARK_MAIN();
