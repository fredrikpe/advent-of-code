#include <vector>
#include <limits>
#include <algorithm>

#include "input_parser.h"

namespace day5 {

std::vector<int> parse_input() {
    auto list = std::vector<int>{};

    parse_input_by_line("../input/5.txt", [&](auto& line) {
            if (line.size() == 0) {
                return;
            }
            std::transform(line.begin(), line.end(), line.begin(), [](auto c) {
                    if (c == 'B' || c == 'R') {
                        return '1';
                    }
                    return '0';
                });
            auto row = stoi(line.substr(0, 7), 0, 2);
            auto column = stoi(line.substr(7, 10), 0, 2);
            list.push_back(row*8 + column);
    });
    return list;
}

std::vector<int> parse_input_random() {
    auto list = std::vector<int>{};
    parse_input_by_random_line("../input/4.txt", [&](auto& line) {
    });
    return list;
}

int part1(const std::vector<int>& input) {
    return *std::max_element(input.begin(), input.end());
}

int part2fast(std::vector<int> input) {
    int sum = 0;
    int min = std::numeric_limits<int>::max();
    int max = 0;

    for (int i : input) {
        if (i < min) min = i;
        if (i > max) max = i;
        sum += i;
    }
    return (input.size() + 1) * (max + min) / 2 - sum;
}

int part2(std::vector<int> input) {
    std::sort(input.begin(), input.end());
    return *std::adjacent_find(
            input.begin(),
            input.end(),
            [](auto rhs, auto lhs) { return std::abs(rhs - lhs) > 1; }
    ) + 1;
}
}
