#include <vector>

#include "input_parser.h"

namespace day2 {

struct Password {
    std::string pw;
    char letter;
    int low;
    int high;
};

std::vector<Password> parse_input() {
    return parse_input_by_line<Password>(
        "../input/2-1.txt",
        [](auto& line) {
            auto low = line.substr(0, line.find("-"));
            auto rest = line.substr(line.find("-") + 1);
            auto high = rest.substr(0, rest.find(" "));
            rest = rest.substr(rest.find(" ") + 1);
            auto letter = rest.substr(0, rest.find(":"));
            auto pw = rest.substr(rest.find(":") + 2);

            return Password{
                    .pw = pw,
                    .letter = letter[0],
                    .low = stoi(low),
                    .high = stoi(high),
            };
        }
    );
}

int char_count(const std::string& pw, char letter) {
    return std::count_if(
            pw.begin(),
            pw.end(),
            [letter](auto c) { return c == letter; } 
    );
}

int part1(const std::vector<Password>& input) {
    return std::count_if(
            input.begin(),
            input.end(),
            [](auto& pw) {
                auto count = char_count(pw.pw, pw.letter);
                return pw.low <= count && count <= pw.high;
            }
    );
}

int part2(const std::vector<Password>& input) {
    return std::count_if(
            input.begin(),
            input.end(),
            [](auto& pw) {
                return (pw.pw[pw.low - 1] == pw.letter)
                        != (pw.pw[pw.high - 1] == pw.letter);
            }
    );
}
}
