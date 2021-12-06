use crate::io_util;

pub fn part_1() -> i32 {
    part_1_impl(io_util::line_vec("../input/3-1.txt"))
}

fn part_1_impl(input: Vec<String>) -> i32 {
    let (gamma, epsilon) = gamma_epsilon(input);
    i32::from_str_radix(gamma.as_str(), 2).unwrap()
        * i32::from_str_radix(epsilon.as_str(), 2).unwrap()
}

fn gamma_epsilon(input: Vec<String>) -> (String, String) {
    let mut counts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    let size = input.len();

    for line in input {
        for (i, c) in line.chars().enumerate() {
            counts[i] += if c == '1' { 1 } else { 0 };
        }
    }

    (
        counts
            .iter()
            .map(|c| if c > &(&size / 2) { '1' } else { '0' })
            .collect::<String>(),
        counts
            .iter()
            .map(|c| if c > &(&size / 2) { '0' } else { '1' })
            .collect::<String>(),
    )
}

pub fn part_2() -> i32 {
    part_2_impl(io_util::line_vec("../input/3-1.txt"))
}

fn part_2_impl(input: Vec<String>) -> i32 {
    let oxygen = find_match(input.clone(), true);
    let co2 = find_match(input, false);

    i32::from_str_radix(oxygen.as_str(), 2).unwrap() * i32::from_str_radix(co2.as_str(), 2).unwrap()
}

fn find_match(input: Vec<String>, most_common: bool) -> String {
    let mut cur = input;
    let mut pos = 0;
    loop {
        let count = cur
            .iter()
            .filter(|s| s.chars().nth(pos) == Some('1'))
            .count();

        let mc = if most_common {
            (count as f32) >= cur.len() as f32 / 2.0
        } else {
            (count as f32) < cur.len() as f32 / 2.0
        };

        cur = cur
            .into_iter()
            .filter(|s| (s.chars().nth(pos) == Some('1')) == mc)
            .collect();

        if cur.len() == 1 {
            return cur[0].clone();
        }
        pos += 1;
    }
}

#[cfg(test)]
mod tests {
    use crate::day3::*;

    #[test]
    fn p2() {
        let t = part_2_impl(vec![
            "00100".to_string(),
            "11110".to_string(),
            "10110".to_string(),
            "10111".to_string(),
            "10101".to_string(),
            "01111".to_string(),
            "00111".to_string(),
            "11100".to_string(),
            "10000".to_string(),
            "11001".to_string(),
            "00010".to_string(),
            "01010".to_string(),
        ]);
        assert_eq!(230, t);
    }
}
