# Object Types: Strings

- Sequence of characters.
- Characters that are strung together to create words of sentences.
- Double quoted strings do additional evaluation via interpolation using the special syntax `#{}`.

```ruby
greeting = "Hello"
target = 'world'
greeting + ' ' + target # => Hello world
"Yo " * 3 # => Yo Yo Yo
'I\'m escaped.'
puts "I want to say #{greeting} #{target}."
puts "1 + 1 = #{1 + 1}"
```

```ruby
"Hello".reverse
"Hello".capitalize
"Hello".downcase
"Hello".upcase
"Hello".length
```

```ruby
# Daisy chaining methods on an object:
"Hello".reverse.upcase # => "OLLEH"
```
