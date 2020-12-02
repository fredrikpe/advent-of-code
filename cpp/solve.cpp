#include <iostream>

#include "1.h"
#include "2.h"

int main() {
    std::cout << "1: " << solve_1_1() << std::endl;

    std::cout << "2-1: " << solve_2_1(parse_input_2_1()) << std::endl;
    std::cout << "2-2: " << solve_2_2(parse_input_2_1()) << std::endl;
}
