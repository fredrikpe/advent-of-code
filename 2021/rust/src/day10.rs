use crate::io_util;


fn score1(c: char) -> i32 {
    match c {
        ')' => 3,
        ']' => 57,
        '}' => 1197,
        '>' => 25137,
        _ => panic!("error"),
    }
}

fn score2(s: &str) -> i64 {
    let mut t = 0_i64;
    for c in s.chars().rev() {
        t *= 5;
        match c {
            '(' => t += 1,
            '[' => t += 2,
            '{' => t += 3,
            '<' => t += 4,
            _ => panic!("error"),
        }
    }

    t
}

fn corrupted(line: &str) -> Option<char> {
    let mut opened: Vec<char> = vec!();

    for c in line.chars() {
        match c {
            ')' => { if opened.pop() != Some('(') { return Some(')') } }
            ']' => { if opened.pop() != Some('[') { return Some(']') } }
            '}' => { if opened.pop() != Some('{') { return Some('}') } }
            '>' => { if opened.pop() != Some('<') { return Some('>') } }
            '(' => opened.push('('),
            '[' => opened.push('['),
            '{' => opened.push('{'),
            '<' => opened.push('<'),
            _ => panic!("error"),
        }
    }
    
    None
}

fn inco(line: &str) -> String {
    let mut opened: String = "".to_string();

    for c in line.chars() {
        match c {
            ')' => { if opened.pop() != Some('(') { panic!() } }
            ']' => { if opened.pop() != Some('[') { panic!() } }
            '}' => { if opened.pop() != Some('{') { panic!() } }
            '>' => { if opened.pop() != Some('<') { panic!() } }
            '(' => opened.push('('),
            '[' => opened.push('['),
            '{' => opened.push('{'),
            '<' => opened.push('<'),
            _ => panic!("error"),
        }
    }
    
    opened
}



pub fn part_1() -> i32 {
    part_1_impl("../input/10.txt")
}

fn part_1_impl(filename: &str) -> i32 {
    let lines = io_util::line_vec(filename);

    lines
        .into_iter()
        .map(|line| corrupted(&line))
        .flatten()
        .map(|c| score1(c))
        .sum()
}

pub fn part_2() -> i64 {
    part_2_impl("../input/10.txt")
}

fn part_2_impl(filename: &str) -> i64 {
    let lines = io_util::line_vec(filename);

    let mut scores = lines
        .into_iter()
        .filter(|line| corrupted(&line).is_none())
        .map(|line| inco(&line))
        .map(|c| score2(&c))
        .collect::<Vec<i64>>();
    scores.sort();

    scores[scores.len() / 2]
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn p1() {
        let t = part_1_impl("../input/10-test.txt");
        assert_eq!(t, 26397);
    }

    #[test]
    fn p2() {
        let t = part_2_impl("../input/10-test.txt");
        assert_eq!(t, 288957);
    }
}
