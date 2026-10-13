use std::io; // prelude - bring the io type from the standard library

fn main() {
    println!("Guess the number!");
    println!("Please input your guess.");

    // the ::new is an associated function on the String type
    let mut guess = String::new(); // mutable variable declaration

    io::stdin()
        .read_line(&mut guess)
        .expect("Failed to read line");

    println!("You guessed: {guess}");
}
