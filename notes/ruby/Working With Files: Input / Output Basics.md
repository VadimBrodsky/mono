# Working With Files: Input / Output Basics

- Input / Output of a ruby program.
- The `gets` method receives input from the user.
- Use `chomp` to remove the trailing `\n`.
- Use `chop` to remove the last character.

```ruby
input = gets 		#=> "Hello.\n"
input.chomp 		#=> "Hello."
input.chop 			#=> "Hello"

print input 		#=> "Hello"
puts input 			#=> "Hello\n"
```
