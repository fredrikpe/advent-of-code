#include <fstream>
#include <iostream>


template<class T, class LineTransform>
std::vector<T> parse_input_by_line(
        const std::string& path,
        LineTransform transform
) {
    std::ifstream file(path);

    auto result = std::vector<T>{};
    auto line = std::string{};
    while (std::getline(file, line)) {
        result.emplace_back(transform(line));
    }

    return result;
}
