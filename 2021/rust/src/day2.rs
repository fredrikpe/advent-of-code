use crate::io_util;

pub fn part_1() -> i32 {
    part_1_impl(io_util::line_vec("../input/2-1.txt"))
}

fn part_1_impl(input: Vec<String>) -> i32 {
    let mut f = 0;
    let mut d = 0;
    for line in input {
        let split = line.split(' ').collect::<Vec<&str>>();
        match (split[0], split[1].parse::<i32>().unwrap()) {
            ("forward", n) => f += n,
            ("down", n) => d += n,
            ("up", n) => d -= n,
            _ => panic!("parsing error"),
        }
    }

    f * d
}

pub fn part_2() -> i32 {
    part_2_impl(io_util::line_vec("../input/2-1.txt"))
}

fn part_2_impl(input: Vec<String>) -> i32 {
    let mut aim = 0;
    let mut d = 0;
    let mut f = 0;
    for line in input {
        let split = line.split(' ').collect::<Vec<&str>>();
        match (split[0], split[1].parse::<i32>().unwrap()) {
            ("forward", n) => {
                f += n;
                d += aim * n
            }
            ("down", n) => aim += n,
            ("up", n) => aim -= n,
            _ => panic!("parsing error"),
        }
    }

    f * d
}
