#include <fstream>
#include <iostream>


template<class Function>
void parse_input_by_line(const std::string& path, Function f) {
    std::ifstream file(path);

    auto line = std::string{};
    while (std::getline(file, line)) {
        f(line);
    }
}
