#pragma once

#include <fstream>
#include <vector>
#include <string>
#include <algorithm>
#include <random>


static auto RNG = std::default_random_engine{};

template<class Function>
void parse_input_by_line(const std::string& path, Function f) {
    std::ifstream file(path);

    auto line = std::string{};
    while (std::getline(file, line)) {
        f(line);
    }
}

template<class Function>
void parse_input_by_random_line(const std::string& path, Function f) {
    auto lines = std::vector<std::string>{};
    parse_input_by_line(path, [&lines](auto& line) { lines.push_back(line); });

    std::shuffle(std::begin(lines), std::end(lines), RNG);
    for (auto& rline : lines) {
        f(rline);
    }
}
