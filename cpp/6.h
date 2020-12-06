#include <vector>
#include <algorithm>
#include <numeric>

#include "input_parser.h"

namespace day6 {

int part1() {
    int total = 0;
    unsigned int questions = 0;

    parse_input_by_line("../input/6.txt", [&](auto& line) {
            if (line.size() == 0) {
                total += __builtin_popcount(questions);
                questions = 0;
                return;
            }
            for (auto c : line) {
                questions |= 1UL << (c - 97);
            }
    });
    return total;
}

int part2() {
    int total = 0;
    unsigned int all_answered = -1;

    parse_input_by_line("../input/6.txt", [&](auto& line) {
            if (line.size() == 0) {
                total += __builtin_popcount(all_answered);
                all_answered = -1;
                return;
            }

            unsigned int individual_answers = 0;
            for (auto c : line) {
                individual_answers |= 1UL << (c - 97);
            }
            all_answered &= individual_answers;
    });
    return total;
}
}
