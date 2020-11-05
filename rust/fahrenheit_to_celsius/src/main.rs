use std::io;

fn main() {
    println!("Input the Temperature in Fahrenheit:");
    let mut temp = String::new();
    loop {
        io::stdin().read_line(&mut temp).expect("Failed to read the line.");
        let temp: f64 = match temp.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };

        let temp: f64 = (temp - 32.0) / 1.8;

        println!("Temperature in Celsius = {}", temp);
        break;
    }
}
