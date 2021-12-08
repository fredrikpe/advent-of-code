use crate::io_util;

pub fn part_1() -> i32 {
    by_median(
        io_util::line_by_parser("../input/7-1.txt", |s| {
            s
                .split(',')
                .map(|st| st.parse::<i32>().unwrap())
                .collect::<Vec<i32>>()
        }).remove(0))
}

fn by_median(mut input: Vec<i32>) -> i32 {
    let half = input.len() / 2;
    input.sort();
    let median = input[half];
    input
        .iter()
        .map(|d| fuel_consumption_1(*d, median))
        .sum()
}

fn fuel_consumption_1(start: i32, target: i32) -> i32 {
    (start - target).abs()
}

fn fuel_consumption_2(start: i32, target: i32) -> i32 {
    let n = (start - target).abs();
    n * (n + 1) / 2
}

fn total_fuel_consumption_2(input: &Vec<i32>, target: i32) -> i32 {
    input
        .iter()
        .map(|d| fuel_consumption_2(*d, target))
        .sum()
}

fn brute_force(input: Vec<i32>) -> i32 {
    let mut min = total_fuel_consumption_2(&input, 0);
    for i in 1..=(*&input.len() as i32) {
        let t = total_fuel_consumption_2(&input, i as i32);
        if t < min {
            min = t as i32;
        }
    }

    min
}

pub fn part_2() -> i32 {
    brute_force(
        io_util::line_by_parser("../input/7-1.txt", |s| {
            s
                .split(',')
                .map(|st| st.parse::<i32>().unwrap())
                .collect::<Vec<i32>>()
        }).remove(0))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn p2() {
        let t = brute_force(vec![16,1,2,0,4,2,7,1,2,14]);
        assert_eq!(t, 168);
    }

    #[test]
    fn p1() {
        let t = by_median(vec![16,1,2,0,4,2,7,1,2,14]);
        assert_eq!(t, 37);
    }
}
