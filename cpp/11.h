#include <vector>
#include <algorithm>
#include <numeric>

#include "input_parser.h"

namespace day11 {

constexpr int LINE_LENGTH = 90;
constexpr int OLB = 5;

enum SeatState {
    Floor = 0,
    Empty = 1,
    Occupied = 2,
};

using Row = std::array<SeatState, LINE_LENGTH>;
using Seats = std::vector<Row>;

SeatState next_state(
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
    if (state == Occupied && occupied >= OLB) {
        return Empty;
    }
    return state;
}

std::array<SeatState, 8> surroundings_by_box(int x, int y, const Seats& seats) {
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

std::array<SeatState, 8> surroundings_by_line_of_sight(
        int x, int y, const Seats& seats
) {
    auto out_of_bounds = [&seats](auto i, auto j) {
        return i < 0 || i >= seats.size() || j < 0 || j >= LINE_LENGTH;
    };
    auto first_encounter = [&](int incr_i, int incr_j) {
        int i = x + incr_i;
        int j = y + incr_j;
        while (!out_of_bounds(i, j)) {
            if (seats[i][j] != Floor) {
                return seats[i][j];
            }
            i += incr_i;
            j += incr_j;
        }
        return Floor;
    };

    return std::array<SeatState, 8>{{
        first_encounter(1, 0),
        first_encounter(-1, 0),
        first_encounter(0, 1),
        first_encounter(0, -1),
        first_encounter(1, 1),
        first_encounter(1, -1),
        first_encounter(-1, 1),
        first_encounter(-1, -1)
    }};
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

template <typename Surroundings>
int solve(Surroundings surroundings) {
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
        changed = false;
        auto next_seats = current_seats;
        for (int i=0; i<seats.size(); i++) {
            for (int j=0; j<LINE_LENGTH; j++) {
                next_seats[i][j] = next_state(
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

int part1() {
    return solve(surroundings_by_box);
}

int part2() {
    return solve(surroundings_by_line_of_sight);
}
}
