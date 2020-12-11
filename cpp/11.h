#include <vector>
#include <algorithm>
#include <numeric>

#include "input_parser.h"

namespace day11 {

constexpr int LINE_LENGTH = 90;

enum SeatState {
    Floor = 0,
    Empty = 1,
    Occupied = 2,
};

using Row = std::array<SeatState, LINE_LENGTH>;
using Seats = std::vector<Row>;

SeatState applyt(
        const SeatState& state,
        const std::array<SeatState, 8>& surroundings
) {
    if (state == Floor) {
        return Floor;
    }
    auto occupied = std::count_if(
            surroundings.begin(),
            surroundings.end(),
            [](auto s) {
                return s == Occupied;
            }
    );
    if (state == Empty && occupied == 0) {
        return Occupied;
    }
    if (state == Occupied && occupied > 3) {
        return Empty;
    }
    return state;
}

std::array<SeatState, 8> surroundings(int x, int y, const Seats& seats) {
    auto result = std::array<SeatState, 8>{};
    int c = 0;
    for (
            int xm=std::max(x - 1, 0);
            xm<=std::min<int>(x + 1, seats.size() - 1);
            xm++
        ) {
        for (
                int ym=std::max(y - 1, 0);
                ym<=std::min(y + 1, LINE_LENGTH - 1);
                ym++
            ) {
            if (xm == x && ym == y) {
                continue;
            }
            result[c++] = seats[xm][ym];
        }
    }

    return result;
}

void print_seats(const Seats& seats) {
    std::cout << std::endl;
    for (auto r : seats) {
        for (auto s : r) {
            char c = s == Occupied
                ? '#'
                : (s == Empty) ? 'L' : '.';
            std::cout << c;
        }
        std::cout << std::endl;
    }
    std::cout << std::endl;
    std::cout << std::endl;
}

int part1() {
    auto seats = Seats{};

    parse_input_by_line("../input/11.txt", [&](auto& line) {
            auto row = Row{};
            for (int i=0; i<LINE_LENGTH; i++) {
                if (line[i] == 'L') {
                    row[i] = Empty;
                } else {
                    row[i] = Floor;
                }
            }
            seats.push_back(row);
    });

    bool changed = true;
    auto current_seats = seats;

    while (changed) {
        auto next_seats = current_seats;
        changed = false;
        for (int i=0; i<seats.size(); i++) {
            for (int j=0; j<LINE_LENGTH; j++) {
                next_seats[i][j] = applyt(
                        current_seats[i][j],
                        surroundings(i, j, current_seats)
                );
                if (next_seats[i][j] != current_seats[i][j]) {
                    changed = true;
                }
            }
        }
        current_seats = next_seats;
    }

    int c = 0;
    for (auto& row : current_seats) {
        for (auto& s : row) {
            if (s == Occupied) {
                c++;
            }
        }
    }
    return c;
}
}
