use crate::io_util;

enum Direction {
    Up,
    Left,
    Right,
    Down,
}

use Direction::{Down, Left, Right, Up};

#[derive(Debug)]
struct Map {
    data: Vec<Vec<i32>>,
}

type Pos = (usize, usize);

impl Map {
    fn find_basins(&self) -> Vec<Vec<Pos>> {
        let mut basins: Vec<Vec<Pos>> = vec![];

        for i in 0..self.data.len() {
            for j in 0..self.data[0].len() {
                if self.local_minimum((i, j)) {
                    basins.push(self.explore_basin((i, j)));
                }
            }
        }

        basins
    }

    fn at(&self, pos: Pos) -> i32 {
        self.data[pos.0][pos.1]
    }

    fn explore_basin(&self, pos: Pos) -> Vec<Pos> {
        let mut visited = vec![pos];
        let mut stack: Vec<Pos> = vec![];

        let mut cur_pos = pos;
        loop {
            self.step_all(cur_pos)
                .into_iter()
                .filter_map(|o| o)
                .for_each(|new_pos| {
                    if self.at(new_pos) != 9
                        && !visited.contains(&new_pos)
                        && self.at(cur_pos) <= self.at(new_pos)
                    {
                        visited.push(new_pos);
                        stack.push(new_pos);
                    }
                });

            if stack.is_empty() {
                return visited;
            }
            cur_pos = stack.pop().unwrap();
        }
    }

    fn step_all(&self, pos: Pos) -> [Option<Pos>; 4] {
        [
            self.step(Up, pos),
            self.step(Right, pos),
            self.step(Left, pos),
            self.step(Down, pos),
        ]
    }

    fn step(&self, direction: Direction, pos: Pos) -> Option<Pos> {
        let x = pos.0;
        let y = pos.1;
        match direction {
            Up => {
                if x > 0 {
                    Some((x - 1, y))
                } else {
                    None
                }
            }
            Right => {
                if y < self.data[0].len() - 1 {
                    Some((x, y + 1))
                } else {
                    None
                }
            }
            Left => {
                if y > 0 {
                    Some((x, y - 1))
                } else {
                    None
                }
            }
            Down => {
                if x < self.data.len() - 1 {
                    Some((x + 1, y))
                } else {
                    None
                }
            }
        }
    }

    fn local_minimum(&self, pos: Pos) -> bool {
        let value = self.data[pos.0][pos.1];

        self.step_all(pos)
            .into_iter()
            .filter_map(|o| o)
            .filter(|pos| self.data[pos.0][pos.1] <= value)
            .count()
            == 0
    }
}

pub fn part_1() -> i32 {
    let map = Map {
        data: io_util::line_by_parser("../input/9.txt", |s| {
            s.chars()
                .map(|c| c.to_digit(10).unwrap() as i32)
                .collect::<Vec<i32>>()
        }),
    };
    part_1_impl(&map)
}

fn part_1_impl(map: &Map) -> i32 {
    (0..map.data.len())
        .map(|i| {
            (0..map.data[0].len())
                .filter(|j| map.local_minimum((i, *j)))
                .map(|j| map.data[i][j] + 1)
                .sum::<i32>()
        })
        .sum()
}

pub fn part_2() -> usize {
    let map = Map {
        data: io_util::line_by_parser("../input/9.txt", |s| {
            s.chars()
                .map(|c| c.to_digit(10).unwrap() as i32)
                .collect::<Vec<i32>>()
        }),
    };
    part_2_impl(&map)
}

fn part_2_impl(map: &Map) -> usize {
    let mut basins = map.find_basins();
    basins.sort_by(|a, b| b.len().cmp(&a.len()));

    basins[0].len() * basins[1].len() * basins[2].len()
}

#[cfg(test)]
mod tests {
    use super::*;

    fn test_map() -> Map {
        Map {
            data: vec![
                vec![2, 1, 9, 9, 9, 4, 3, 2, 1, 0],
                vec![3, 9, 8, 7, 8, 9, 4, 9, 2, 1],
                vec![9, 8, 5, 6, 7, 8, 9, 8, 9, 2],
                vec![8, 7, 6, 7, 8, 9, 6, 7, 8, 9],
                vec![9, 8, 9, 9, 9, 6, 5, 6, 7, 8],
            ],
        }
    }

    #[test]
    fn p1() {
        let t = part_1_impl(&test_map());
        assert_eq!(t, 15);
    }

    #[test]
    fn p2() {
        let t = part_2_impl(&test_map());
        assert_eq!(t, 1134);
    }
}
