use std::fs::File;
use std::io::{BufReader, BufRead};
use std::path::Path;

pub fn line_vec(filename: impl AsRef<Path>) -> Vec<String> {
    let file = File::open(filename)
        .expect("no such file");
    let buf = BufReader::new(file);
    buf.lines()
        .map(|l| l.expect("Could not parse line"))
        .filter(|l| l.len() > 0)
        .collect()
}

pub fn line_by_parser<P, U>(
    filename: impl AsRef<Path>,
    parser: P
) -> Vec<U>
where P: Fn(String) -> U {
    let file = File::open(filename).expect("no such file");
    let buf = BufReader::new(file);

    buf.lines()
        .map(|l| l.expect("Could not parse line"))
        .filter(|l| l.len() > 0)
        .map(|s| parser(s))
        .collect()
}
