#include <vector>

#include "input_parser.h"

namespace day3 {

alias TreeGrid = std::vector<std::array<bool, 31>>;

TreeGrid parse_input() {
    auto grid = TreeGrid{};

    return parse_input_by_line<Password>(
        "../input/2-1.txt",
        [](auto& line) {
        }
    );
}

int part1(const std::vector<int>& input) {
    return 0;
}

int part2(const std::vector<int>& input) {
    return 0;
}

} // day3
