use crate::io_util;

pub fn part_1() -> usize {
    part_1_impl(io_util::line_by_parser("../input/1-1.txt", |s| {
        s.parse::<i32>().unwrap()
    }))
}

fn part_1_impl(lines: Vec<i32>) -> usize {
    lines
        .as_slice()
        .windows(2)
        .filter(|ws| ws[0] < ws[1])
        .count()
}

pub fn part_2() -> i32 {
    let lines = io_util::line_by_parser("../input/1-2.txt", |s| s.parse::<i32>().unwrap());

    part_2_impl(lines)
}

fn part_2_impl(lines: Vec<i32>) -> i32 {
    lines
        .as_slice()
        .windows(3)
        .collect::<Vec<&[i32]>>()
        .windows(2)
        .filter(|ws| ws[0].iter().sum::<i32>() < ws[1].iter().sum::<i32>())
        .count() as i32
}

#[cfg(test)]
mod tests {
    use crate::day1::*;

    #[test]
    fn p1() {
        let t = part_1_impl(vec![199, 200, 208, 210, 200, 207, 240, 269, 260, 263]);
        assert_eq!(t, 7);
    }

    #[test]
    fn p2() {
        let t = part_2_impl(vec![199, 200, 208, 210, 200, 207, 240, 269, 260, 263]);
        assert_eq!(t, 5);
    }
}
