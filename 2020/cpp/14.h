#include <vector>
#include <algorithm>
#include <numeric>
#include <unordered_map>
#include <bitset>

#include "input_parser.h"

namespace day14 {

constexpr char INPUT_FILE[] = "../input/14.txt";

std::bitset<36> apply_mask(std::bitset<36> bitset, const std::string& bitmask) {
    for (int i=0; i<36; i++) {
        if (bitmask[i] != 'X') {
            bitset[35 - i] = bitmask[i] == '1';
        }
    }
    return bitset;
}
 
template <typename Part>
long solve(Part part) {
    auto bitmask = std::string{};

    auto memory = std::vector<long>(66000, 0);

    parse_input_by_line(INPUT_FILE, [&](auto& line) {
        if (line.substr(0, 3) == "mas") {
            bitmask = line.substr(7, line.size());
        } else {
            auto i = line.find("]");
            auto index = stoi(line.substr(4, i - 1));
            auto value = std::bitset<36>(stol(line.substr(i + 4, line.size())));
            part(value, bitmask, index, memory);
        }
    });

    return std::accumulate(memory.begin(), memory.end(), 0L,
            [](long a, long b) {
                return a + b;
            }
    );
}

long part1() {
    return solve([](
                std::bitset<36> value,
                const std::string& bitmask,
                auto index,
                std::vector<long>& memory
        ) {
            value = apply_mask(value, bitmask);
            memory[index] = value.to_ulong();
        }
    );
}
}
