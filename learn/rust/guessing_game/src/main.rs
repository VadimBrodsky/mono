use std::io;   // prelude - bring the io type from the standard library
use rand::Rng; // Rng trait defined methods that random number generators implement
use std::cmp::Ordering;

fn main() {
    println!("Guess the number!");

    // get an OS thread random number in an inclusive range
    let secret_number = rand::thread_rng().gen_range(1..=10);
    // println!("The secret number is: {secret_number}");

    loop {
        println!("Please input your guess.");

        // the ::new is an associated function on the String type
        let mut guess = String::new(); // mutable variable declaration

        // if we did not import std::io, could still call it via std::io::Stdin
        io::stdin()
            .read_line(&mut guess) // pass the mutable reference to guess
            .expect("Failed to read line"); // handle the Err of the read_line enum


        // shadowed variable guess
        // convert a string into a u32 number
        let guess: u32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };

        println!("You guessed: {guess}");  // interpolate {guess} into the message

        // pattern matching
        match guess.cmp(&secret_number) {
            Ordering::Less => println!("Too small!"),
            Ordering::Greater => println!("Too big!"),
            Ordering::Equal => {
                println!("You win!");
                break;                    // exit the loop
            }
        }
    }
}
