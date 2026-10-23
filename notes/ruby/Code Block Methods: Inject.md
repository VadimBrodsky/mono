# Code Block Methods: Inject

- Inject is an accumulator - store the value for the next round.
- Use the `memo` variable to store the result between the iterations.
- Inject can receive a starting number as a parameter.
- If no starting number is declared the first iteration will be used as a starter.
- Careful about conditionals that can sore `nil` in `memo`.

```ruby
# Sum of all the numbers
(1..10).inject {|memo, n| memo + n} 		#=> 55
```

```ruby
array = [*1..10]
sum = array.inject(100) {|memo, n| memo + n} 	#=> 155
product = array.inject {|memo, n| memo * n} 	#=> 3628800
```

```ruby
fruits = ["banana", "apple", "orange", "pear"]
longest_word = fruits.inject do |memo, fruit|
	if memo.length > fruit.length
		memo
	else
		fruit
	end
end
# gets the longest word
#=> "orange"
```
