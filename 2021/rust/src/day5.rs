use crate::io_util;

#[derive(Debug)]
struct Line {
    x1: i32,
    x2: i32,
    y1: i32,
    y2: i32,
}

impl Line {
    fn points_on_line(&self) -> Vec<(i32, i32)> {
        let x_step = if self.x1 == self.x2 {
            0
        } else if self.x2 > self.x1 {
            1
        } else {
            -1
        };
        let y_step = if self.y1 == self.y2 {
            0
        } else if self.y2 > self.y1 {
            1
        } else {
            -1
        };
        let mut x = self.x1;
        let mut y = self.y1;
        let mut v: Vec<(i32, i32)> = vec![];
        loop {
            v.push((x, y));

            if x == self.x2 && y == self.y2 {
                return v;
            }

            x += x_step;
            y += y_step;
        }
    }
}

pub fn part_1() -> usize {
    part_1_impl(
        io_util::line_by_parser("../input/5-1.txt", |s| {
            let (xy1, xy2) = s.split_once(" -> ").unwrap();
            let (x1, y1) = xy1.split_once(',').unwrap();
            let (x2, y2) = xy2.split_once(',').unwrap();
            Line {
                x1: x1.parse::<i32>().unwrap(),
                x2: x2.parse::<i32>().unwrap(),
                y1: y1.parse::<i32>().unwrap(),
                y2: y2.parse::<i32>().unwrap(),
            }
        })
        .into_iter()
        .filter(|l| l.x1 == l.x2 || l.y1 == l.y2)
        .collect::<Vec<Line>>(),
        999,
    )
}

fn part_1_impl(lines: Vec<Line>, n: i32) -> usize {
    let mut counts = (0..=n)
        .map(|_| (0..=n).map(|_| 0).collect::<Vec<i32>>())
        .collect::<Vec<Vec<i32>>>();

    for line in &lines {
        for point in line.points_on_line() {
            counts[point.1 as usize][point.0 as usize] += 1;
        }
    }

    counts
        .iter()
        .map(|c| c.iter().filter(|cc| **cc >= 2).count())
        .sum()
}

pub fn part_2() -> usize {
    part_1_impl(
        io_util::line_by_parser("../input/5-1.txt", |s| {
            let (xy1, xy2) = s.split_once(" -> ").unwrap();
            let (x1, y1) = xy1.split_once(',').unwrap();
            let (x2, y2) = xy2.split_once(',').unwrap();
            Line {
                x1: x1.parse::<i32>().unwrap(),
                x2: x2.parse::<i32>().unwrap(),
                y1: y1.parse::<i32>().unwrap(),
                y2: y2.parse::<i32>().unwrap(),
            }
        }),
        999,
    )
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn p2() {
        let t = part_1_impl(
            vec![
                Line {
                    x1: 0,
                    y1: 9,
                    x2: 5,
                    y2: 9,
                },
                Line {
                    x1: 8,
                    y1: 0,
                    x2: 0,
                    y2: 8,
                },
                Line {
                    x1: 9,
                    y1: 4,
                    x2: 3,
                    y2: 4,
                },
                Line {
                    x1: 2,
                    y1: 2,
                    x2: 2,
                    y2: 1,
                },
                Line {
                    x1: 7,
                    y1: 0,
                    x2: 7,
                    y2: 4,
                },
                Line {
                    x1: 6,
                    y1: 4,
                    x2: 2,
                    y2: 0,
                },
                Line {
                    x1: 0,
                    y1: 9,
                    x2: 2,
                    y2: 9,
                },
                Line {
                    x1: 3,
                    y1: 4,
                    x2: 1,
                    y2: 4,
                },
                Line {
                    x1: 0,
                    y1: 0,
                    x2: 8,
                    y2: 8,
                },
                Line {
                    x1: 5,
                    y1: 5,
                    x2: 8,
                    y2: 2,
                },
            ],
            9,
        );

        assert_eq!(t, 12);
    }

    #[test]
    fn p1() {
        let t = part_1_impl(
            vec![
                Line {
                    x1: 0,
                    y1: 9,
                    x2: 5,
                    y2: 9,
                },
                Line {
                    x1: 8,
                    y1: 0,
                    x2: 0,
                    y2: 8,
                },
                Line {
                    x1: 9,
                    y1: 4,
                    x2: 3,
                    y2: 4,
                },
                Line {
                    x1: 2,
                    y1: 2,
                    x2: 2,
                    y2: 1,
                },
                Line {
                    x1: 7,
                    y1: 0,
                    x2: 7,
                    y2: 4,
                },
                Line {
                    x1: 6,
                    y1: 4,
                    x2: 2,
                    y2: 0,
                },
                Line {
                    x1: 0,
                    y1: 9,
                    x2: 2,
                    y2: 9,
                },
                Line {
                    x1: 3,
                    y1: 4,
                    x2: 1,
                    y2: 4,
                },
                Line {
                    x1: 0,
                    y1: 0,
                    x2: 8,
                    y2: 8,
                },
                Line {
                    x1: 5,
                    y1: 5,
                    x2: 8,
                    y2: 2,
                },
            ]
            .into_iter()
            .filter(|l| l.x1 == l.x2 || l.y1 == l.y2)
            .collect::<Vec<Line>>(),
            9,
        );

        assert_eq!(t, 5);
    }
}
