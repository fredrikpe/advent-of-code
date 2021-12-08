use crate::io_util;

type Word = Vec<char>;

fn parser_1(s: String) -> Vec<Word> {
    let (_, right) = s.split_once(" | ").unwrap();
    right
        .split(' ')
        .map(|s| s.chars().collect::<Word>())
        .collect()
}

fn parser_2(s: String) -> (Vec<Word>, Vec<Word>) {
    let (left, right) = s.split_once(" | ").unwrap();
    (
        left.split(' ')
            .map(|s| s.chars().collect::<Word>())
            .collect(),
        right
            .split(' ')
            .map(|s| s.chars().collect::<Word>())
            .collect(),
    )
}

pub fn part_1() -> i32 {
    part_1_impl(
        io_util::line_by_parser("../input/8-1.txt", parser_1)
            .into_iter()
            .flatten()
            .collect(),
    )
}

fn part_1_impl(input: Vec<Word>) -> i32 {
    input
        .iter()
        .filter(|n| matches!(n.len(), 2 | 7 | 3 | 4))
        .count() as i32
}

pub fn part_2() -> i32 {
    part_2_impl(io_util::line_by_parser("../input/8-1.txt", parser_2))
}

fn part_2_impl(input: Vec<(Vec<Word>, Vec<Word>)>) -> i32 {
    input.into_iter().map(solve_output).sum()
}

fn c_all(v: &[char], cs: &[char]) -> bool {
    for c in cs {
        if !v.contains(c) {
            return false;
        }
    }
    true
}

fn c_one_of(v: &[char], cs: &[char]) -> bool {
    let mut b = false;
    for c in cs {
        if v.contains(c) {
            b = !b;
        }
    }
    b
}

fn missing_n(v: &[char], cs: &[char], n: i32) -> bool {
    cs.iter().filter(|c| !v.contains(c)).count() as i32 == n
}

fn equal(a: &[char], b: &[char]) -> bool {
    if a.len() != b.len() {
        return false;
    }
    for x in a {
        if !b.contains(x) {
            return false;
        }
    }
    true
}

fn solve_output(input: (Vec<Word>, Vec<Word>)) -> i32 {
    let (left, right) = input;

    let one = left.iter().find(|s| s.len() == 2).unwrap();
    let three = left.iter().find(|s| s.len() == 5 && c_all(s, one)).unwrap();
    let four = left.iter().find(|s| s.len() == 4).unwrap();
    let six = left
        .iter()
        .find(|s| s.len() == 6 && c_one_of(s, one))
        .unwrap();
    let seven = left.iter().find(|s| s.len() == 3).unwrap();
    let eight = left.iter().find(|s| s.len() == 7).unwrap();
    let nine = left
        .iter()
        .find(|s| s.len() == 6 && missing_n(four, s, 2))
        .unwrap();
    let zero = left
        .iter()
        .find(|s| s.len() == 6 && !equal(nine, s) && !equal(six, s))
        .unwrap();
    let five = left
        .iter()
        .find(|s| s.len() == 5 && missing_n(s, six, 1))
        .unwrap();
    let two = left
        .iter()
        .find(|s| s.len() == 5 && !equal(five, s) && !equal(three, s))
        .unwrap();

    let nums = vec![zero, one, two, three, four, five, six, seven, eight, nine];

    let mut output: i32 = 0;
    for (i, n) in right.iter().rev().enumerate() {
        for (j, m) in nums.iter().enumerate() {
            if equal(m, n) {
                output += j as i32 * 10_i32.pow(i as u32);
            }
        }
    }

    output
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn p2() {
        let input: Vec<(Vec<Word>, Vec<Word>)> = vec![
            "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe",
            "edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc",
            "fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg",
            "fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb",
            "aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea",
            "fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb",
            "dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe",
            "bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef",
            "egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb",
            "gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce",
        ]
            .iter()
            .map(|s| parser_2(s.to_string()))
            .collect();

        assert_eq!(61229, part_2_impl(input));
    }
}
