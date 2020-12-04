#include <vector>
#include <optional>
#include <cstdlib>

#include "input_parser.h"

namespace day4 {

enum Field { NOT_PRESENT, VALID, INVALID };

struct Passport {
    Field byr;
    Field iyr;
    Field eyr;
    Field hgt;
    Field hcl;
    Field ecl;
    Field pid;
};

template <typename Validator>
void validate_field(
        Field& field,
        const std::string target,
        const std::string& line,
        Validator v
) {
    auto start = line.find(target);
    if (start == std::string::npos) {
        return;
    }

    auto from_target = line.substr(start + target.size());
    auto end = from_target.find(" ");
    auto value = end == std::string::npos
        ? from_target
        : from_target.substr(0, end);
    field = v(value) ? VALID : INVALID;
};

bool parse_line(const std::string& line, Passport& passport) {
    if (line == "") {
        return true;
    }

    validate_field(passport.byr, "byr:", line, [](auto& value) {
            //byr (Birth Year) - four digits; at least 1920 and at most 2002.
            auto i = strtod(value.c_str(), nullptr);
            return i >= 1920 && i <= 2002;
    });
    validate_field(passport.iyr, "iyr:", line, [](auto& value) {
            //iyr (Issue Year) - four digits; at least 2010 and at most 2020.
            auto i = strtod(value.c_str(), nullptr);
            return i >= 2010 && i <= 2020;
    });
    validate_field(passport.eyr, "eyr:", line, [](auto& value) {
            //eyr - four digits; at least 2020 and at most 2030.
            auto i = strtod(value.c_str(), nullptr);
            return i >= 2020 && i <= 2030;
    });
    validate_field(passport.hgt, "hgt:", line, [](auto& value) {
        // hgt (Height) - a number followed by either cm or in:
        // If cm, the number must be at least 150 and at most 193.
        // If in, the number must be at least 59 and at most 76.
        if (value.size() < 4) return false;
        auto unit = value.substr(value.size() - 2, value.size());
        if (unit == "in") {
            auto i = strtod(value.substr(0, value.size()-2).c_str(), nullptr);
            return i >= 59 && i <= 76;
        } else if (unit == "cm") {
            auto i = strtod(value.substr(0, value.size()-2).c_str(), nullptr);
            return i >= 150 && i <= 193;
        }
        return false;
    });
    validate_field(passport.hcl, "hcl:", line, [](auto& value) {
        //hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
        return value.size() == 7 && value[0] == '#' && std::all_of(
                value.begin() + 1,
                value.end(),
                [](auto c) {
                    return (c >= 97 && c <= 102) || (c >= 48 && c <= 57);
                });
    });
    validate_field(passport.ecl, "ecl:", line, [](auto& value) {
        //ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
        return value == "amb" || value == "blu" || value == "brn"
            || value == "gry" || value == "grn" || value == "hzl"
            || value == "oth";
    });
    validate_field(passport.pid, "pid:", line, [](auto& value) {
        //pid (Passport ID) - a nine-digit number, including leading zeroes.
        return value.size() == 9 && std::all_of(
                value.begin(), value.end(),
                [](auto c) { return c >= 48 && c <= 57; });
    });
    return false;
}

std::vector<Passport> parse_input() {
    auto list = std::vector<Passport>{};
    auto cur_passport = Passport{};
    parse_input_by_line("../input/4.txt", [&](auto& line) {
        if (parse_line(line, cur_passport)) {
            list.push_back(cur_passport);
            cur_passport = Passport{};
        }
    });
    return list;
}

std::vector<Passport> parse_input_random() {
    auto list = std::vector<Passport>{};
    auto cur_passport = Passport{};
    parse_input_by_random_line("../input/4.txt", [&](auto& line) {
        if (parse_line(line, cur_passport)) {
            list.push_back(cur_passport);
            cur_passport = Passport{};
        }
    });
    return list;
}

int part1(const std::vector<Passport>& input) {
    return std::count_if(input.begin(), input.end(), [](auto& p) {
        return p.byr != NOT_PRESENT &&
            p.iyr != NOT_PRESENT &&
            p.eyr != NOT_PRESENT &&
            p.hgt != NOT_PRESENT &&
            p.hcl != NOT_PRESENT &&
            p.ecl != NOT_PRESENT &&
            p.pid != NOT_PRESENT;
    });
}

int part2(const std::vector<Passport>& input) {
    return std::count_if(input.begin(), input.end(), [](auto& p) {
        return
            p.byr == VALID &&
            p.iyr == VALID &&
            p.eyr == VALID &&
            p.hgt == VALID &&
            p.hcl == VALID &&
            p.ecl == VALID &&
            p.pid == VALID;
    });
}

} // day4
