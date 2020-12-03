#include <vector>
#include <algorithm>

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

int part1(const TreeGrid& input) {
    auto cur_x = 0;
    return std::count_if(input.begin() + 1, input.end(), [&cur_x](auto& row) {
        cur_x += 3;
        return row[cur_x % 31];
    });
}

int part2(const std::vector<int>& input) {
    return 0;
}

} // day3
