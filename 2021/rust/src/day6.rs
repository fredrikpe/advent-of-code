use crate::io_util;

pub fn part_1() -> i64 {
    part_1_impl(io_util::line_vec("../input/6-1.txt")[0].clone(), 80)
}

fn part_1_impl(input: String, n: i32) -> i64 {
    let mut fish_count: [i64; 9] = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    for c in input.split(',').collect::<Vec<&str>>().iter() {
        fish_count[c.parse::<i32>().unwrap() as usize] += 1;
    }

    for _ in 0..n {
        let zero = fish_count[0];

        fish_count[0] = fish_count[1];
        fish_count[1] = fish_count[2];
        fish_count[2] = fish_count[3];
        fish_count[3] = fish_count[4];
        fish_count[4] = fish_count[5];
        fish_count[5] = fish_count[6];
        fish_count[6] = fish_count[7] + zero;
        fish_count[7] = fish_count[8];
        fish_count[8] = zero;
    }

    fish_count.iter().sum()
}

pub fn part_2() -> i64 {
    part_1_impl(io_util::line_vec("../input/6-1.txt")[0].clone(), 256)
}
