#include <iostream>

#include "1.h"
#include "2.h"

int main() {
    std::cout << "1: " << day1::part1() << std::endl;

    std::cout << "2-1: " << day2::part1(day2::parse_input()) << std::endl;
    std::cout << "2-2: " << day2::part2(day2::parse_input()) << std::endl;
}
