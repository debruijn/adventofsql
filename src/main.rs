use postgres::{Client, NoTls};
use std::fs;

pub fn read_input<'a>(filename: String) -> String {
    let file_path = filename;
    let contents = fs::read_to_string(&file_path)
        .expect(&format!("File {} does not exist but it should!", file_path))
        .trim()
        .to_string();
    contents
}

fn run(day_str: &str) -> Result<(), Box<dyn std::error::Error>> {
    let mut client = Client::connect(
        "postgresql://postgres:localpass@localhost:5432/adventofsql",
        NoTls,
    )?;

    let day_int = str::parse::<isize>(day_str).unwrap();

    let input_file = format!("2024/{}/advent_of_sql_day_{}.sql", day_str, day_int);
    client.simple_query(&read_input(input_file)).unwrap();

    let puzzle_file = format!("2024/{}/main.sql", day_str);
    let binding = read_input(puzzle_file.clone());
    let commands = binding.split_inclusive(';'); // .nth_back(1).unwrap();
    let n_cmd = commands.clone().count();

    for (ind, cmd) in commands.enumerate() {
        let binding = client.query(cmd, &[]).unwrap();
        let mut res: String = String::new();

        if ind == n_cmd - 1 {
            let col_name = binding.get(0).unwrap().columns().get(0).unwrap().name();
            for x in binding.iter() {
                if res.len() > 0 {
                    res.push_str(", ")
                }
                res.push_str(x.try_get::<&str, &str>(col_name).unwrap())
            }
            println!("Answer {}: {}", day_str, res);
        }
    }
    Ok(())
}

fn main() {
    let run_for = vec!["00"];
    for day_str in run_for.iter() {
        run(day_str).expect("Filenames should exist");
    }
}
