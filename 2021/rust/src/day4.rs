use crate::io_util;

fn board_line(s: &str) -> [(i32, bool); 5] {
    let nums = s
        .split_whitespace()
        .map(|c| c.parse::<i32>().unwrap())
        .collect::<Vec<i32>>();

    [
        (nums[0], false),
        (nums[1], false),
        (nums[2], false),
        (nums[3], false),
        (nums[4], false),
    ]
}

#[derive(Debug)]
struct Board {
    board: [[(i32, bool); 5]; 5],
}

impl Board {
    fn tick(&mut self, n: i32) {
        for line in &mut self.board {
            for mut num in line {
                if num.0 == n {
                    num.1 = true;
                }
            }
        }
    }

    fn score(&self) -> i32 {
        self.board
            .iter()
            .map(|l| l.iter().map(|s| if s.1 { 0 } else { s.0 }).sum::<i32>())
            .sum()
    }

    fn has_bingo(&self) -> bool {
        self.board[0].iter().all(|l| l.1)
            || self.board[1].iter().all(|l| l.1)
            || self.board[2].iter().all(|l| l.1)
            || self.board[3].iter().all(|l| l.1)
            || self.board[4].iter().all(|l| l.1)
            || self.board.iter().all(|l| l[0].1)
            || self.board.iter().all(|l| l[1].1)
            || self.board.iter().all(|l| l[2].1)
            || self.board.iter().all(|l| l[3].1)
            || self.board.iter().all(|l| l[4].1)
    }
}

pub fn part_1() -> i32 {
    let mut lines = io_util::line_vec("../input/4-1.txt");
    part_1_impl(lines.remove(0), lines)
}

fn part_1_impl(first_line: String, lines: Vec<String>) -> i32 {
    let bingo_numbers = first_line
        .split(',')
        .map(|s| s.parse::<i32>().unwrap())
        .collect::<Vec<i32>>();

    let mut boards = lines
        .as_slice()
        .chunks(5)
        .map(|w| Board {
            board: [
                board_line(&w[0]),
                board_line(&w[1]),
                board_line(&w[2]),
                board_line(&w[3]),
                board_line(&w[4]),
            ],
        })
        .collect::<Vec<Board>>();

    for num in bingo_numbers {
        for board in &mut boards {
            board.tick(num);
        }

        let winner = boards.iter().find(|b| b.has_bingo());
        if let Some(w) = winner {
            return w.score() * num;
        }
    }

    panic!("No solution found!")
}

pub fn part_2() -> i32 {
    let mut lines = io_util::line_vec("../input/4-1.txt");
    part_2_impl(lines.remove(0), lines)
}

fn part_2_impl(first_line: String, lines: Vec<String>) -> i32 {
    let bingo_numbers = first_line
        .split(',')
        .map(|s| s.parse::<i32>().unwrap())
        .collect::<Vec<i32>>();

    let mut boards = lines
        .as_slice()
        .chunks(5)
        .map(|w| Board {
            board: [
                board_line(&w[0]),
                board_line(&w[1]),
                board_line(&w[2]),
                board_line(&w[3]),
                board_line(&w[4]),
            ],
        })
        .collect::<Vec<Board>>();

    for num in bingo_numbers {
        for board in &mut boards {
            board.tick(num);
        }
        if boards.len() == 1 {
            return num * boards[0].score();
        }

        boards.retain(|b| !b.has_bingo());
    }

    panic!("No solution found!")
}

#[cfg(test)]
mod tests {
    use super::*;

    fn line1() -> String {
        "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1".to_string()
    }

    fn lines() -> Vec<String> {
        vec![
            "22 13 17 11  0".to_string(),
            "8  2 23  4 24".to_string(),
            "21  9 14 16  7".to_string(),
            "6 10  3 18  5".to_string(),
            "1 12 20 15 19".to_string(),
            "3 15  0  2 22".to_string(),
            "9 18 13 17  5".to_string(),
            "19  8  7 25 23".to_string(),
            "20 11 10 24  4".to_string(),
            "14 21 16 12  6".to_string(),
            "14 21 17 24  4".to_string(),
            "10 16 15  9 19".to_string(),
            "18  8 23 26 20".to_string(),
            "22 11 13  6  5".to_string(),
            "2  0 12  3  7".to_string(),
        ]
    }

    #[test]
    fn p1() {
        let t = part_1_impl(line1(), lines());
        assert_eq!(4512, t);
    }

    #[test]
    fn p2() {
        let t = part_2_impl(line1(), lines());
        assert_eq!(1924, t);
    }
}
