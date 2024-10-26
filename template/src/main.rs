use postgres::{Client, NoTls};
use std::fs;


pub fn read_input<'a>() -> String {
    let file_path = String::from(
        "main.sql",
    );
    let contents = fs::read_to_string(&file_path)
        .expect(&format!("File {} does not exist but it should!", file_path))
        .trim().to_string();
    contents
}


fn main() -> Result<(), Box<dyn std::error::Error>> {
    println!("This is the template Rust code");
    let mut client = Client::connect("postgresql://postgres:localpass@localhost:5432/adventofsql", NoTls)?;

    let binding = client.simple_query(&read_input()).unwrap();
    let mut res = binding.iter();

    while let Some(row) = res.next() {
        println!("row: {:?}", row);
    }

    Ok(())
    }