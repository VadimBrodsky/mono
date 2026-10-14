use std::io; // prelude - bring the io type from the standard library

fn main() {
    println!("Guess the number!");
    println!("Please input your guess.");

    // the ::new is an associated function on the String type
    let mut guess = String::new(); // mutable variable declaration

    // if we did not import std::io, could still call it via std::io::Stdin
    io::stdin()
        .read_line(&mut guess) // pass the mutable reference to guess
        .expect("Failed to read line"); // handle the Err of the read_line enum

    println!("You guessed: {guess}");  // interpolate {guess} into the message
}
