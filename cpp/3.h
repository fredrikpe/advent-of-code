#include <vector>
#include <numeric>

#include "input_parser.h"

namespace day3 {

using TreeGrid = std::vector<std::array<bool, 31>>;

TreeGrid parse_input() {
    auto grid = TreeGrid{};

    parse_input_by_line(
            "../input/3-1.txt",
            [&grid](auto& line) {
                auto row = std::array<bool, 31>{};
                for (int i=0; i<line.size(); i++) {
                    if (line[i] == '#') {
                        row[i] = true;
                    }
                }
                grid.push_back(row);
            }
    );
    return grid;
}

struct Slope {
    int x;
    int y;
};

long trees_encountered(const TreeGrid& input, Slope slope) {
    auto total = 0;
    for (int y=slope.y, x=slope.x; y<input.size(); y+=slope.y, x+=slope.x) {
        if (input[y][x % 31]) {
            total++;
        }
    }
    return total;
}

int part1(const TreeGrid& input) {
    return trees_encountered(input, {.x=3, .y=1});
}

long part2(const TreeGrid& input) {
    return
        trees_encountered(input, {.x=1, .y=1}) *
        trees_encountered(input, {.x=3, .y=1}) *
        trees_encountered(input, {.x=5, .y=1}) *
        trees_encountered(input, {.x=7, .y=1}) *
        trees_encountered(input, {.x=1, .y=2});
}

} // day3
