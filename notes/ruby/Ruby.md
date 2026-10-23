## IRB
- Interactive Ruby Shell

```bash
irb
irb --simple-prompt
```

```ruby
# to import a file to IRB, in the same folder
require "filename.rb"
```


## Comments
- Ruby comments start with the pound sign `#` (also called the “hash mark” or “octothorpe”).
- Comments extend to the end of the line.


## Printing
- To print a string, the most commonly used Ruby function is `puts`.
- The puts method operates as a side-effect: the expression `puts "foo"` prints the string to the screen and then returns `nil` is a special Ruby value for “nothing at all”.
- Using puts automatically appends a newline character `\n` to the output.
- The related `print` method does not append a newline character.
- The `inspect` method can be used to return a string literal representation of the object it's called on.
- There is a shorthand for `puts object.inspect` by using `p object`.


```ruby
puts "hello"
print "hello"
```

```ruby
puts :name.inspect		# puts a literal object
p :name					# shorthand
```

## Object Types in Ruby
- Ruby is an object-oriented programming language.
- An object is the fundamental building block in Ruby.
- Objects are instances of a class.


### Object Types: Variables
- Variables are not objects - part of the Ruby language.
- Variables allow us to easily reference objects in Ruby.
- Variables point to objects.
- Variables will be undefined or act like an object.
- Variable in Ruby are all lowercase, underscore names.

```ruby
awesome_variable = 3
```


### Variables: Scope Indicators

| Scope    |  Syntax      |
| -------- | ------------ |
| Global   | `$variable`  |
| Class    | `@@variable` |
| Instance | `@variable`  |
| Local    | `variable`   |
| Block    | `variable`   |



### Object Types: Integers
- Integers - Fixnum and Bignum.

```ruby
1 + 1
x = 2
4 / 2
4 * 2
4 - 2
4 ** 2  # exponent
x += 2
```

```ruby
1234.class # what class is the integer => Fixnum
12345678901234567890.class # => Bignum
-200.abs # => 200
200.next # => 201
```


### Object Types: Floats
- Floating-point numbers (floats).
- Decimal numbers.
- Numbers with precision.
- Specify the decimal point to create a floating point number.

```ruby
1234.1234.class # => Float
1234.5678.round # => 1235
1234.5678.to_i  # => 1234
1234.5678.floor # => 1234
1234.5678.ceil  # => 1235
```


### Object Types: Strings
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


### Object Types: Arrays
- Array: an ordered, integer-indexed collection of objects.
- Any king of objects can go in an array (strings, numbers, other arrays, mixed types etc.)
- The square brackets for the array are optional.

```ruby
data_set = []
data_set = ["a", "b", "c"]
data_set[1] # => "b"
data_set[0] # => "a"
data_set[3] # => nil
data_set[0] = d
data_set  # => ["d", "b", "c"]
```

```ruby
data_set << "e" # appends an item to the end of the array
data_set.clear # clears out the array, same as data_set = []
```


#### Array Methods

```ruby
array = [1,2,3,4,5]
array.inspect          #=> "[1, 2, 3, 4, 5]"
array.length           #=> 5
array.to_s             #=> "[1, 2, 3, 4, 5]"
%w[foo bar baz]        #=> ["foo", "bar", "baz"]
array.join             #=> "12345"
array.join(", ")       #=> "1, 2, 3, 4, 5"
"1,2,3,4".split(',')   #=> ["1", "2", "3", "4"]
array.first            #=> 1
array.last             #=> 5
array.second           #=> 2  # only rails
array[2..-1]           #=> 3 to last
```

```ruby
array.reverse          #=> [5, 4, 3, 2, 1]
[3,1,4,7].sort         #=> [1, 3, 4, 7] // for simple arrays
[3,1,4,7].sort!        #=> [1, 3, 4, 7] // will save the changes
[3,3,2,1].uniq         #=> [3, 2, 1]
array.delete_at(2)     #=> 2  // "[1, 2, 4, 5]"
array.delete(4)        #=> 4  // "[1, 2, 3, 5]"
array.shuffle          #=> [5, 2, 1, 4, 3] 
```

```ruby
array << 3             # Append at the end
array << 2 << 5        # Append 2 values at the end
array.push(4)          # Same as append
array.pop              # Remove the last item
array.shift            # Remove the first item
array.unsift(1)        # Add to the beginning
```

```ruby
array + [9, 10, 11]   # Add the two arrays
array - [9, 10]       # Removes the items
array - [2]           # Removes only one item same as delete
```


### Object Types: Hashes
- Hash: unordered, object-indexed collection of objects.
- Stored as a key-value pair, unordered collection.
- Indexed by a a key, not by a specific order.
- Called a dictionary in other languages.


#### Arrays VS Hashes
- Use arrays when the order is important.
- Use hashes whent the label is important.

```ruby
person = { 'first_name' => "Vadim", 'last_name' => "Brodsky"}
person['first_name']    #=> "Vadim"
person.key('Vadim')     #=> "first_name"
person['gender'] = 'M'  #=> "m" // will add the new key value pair
```

```ruby
person.keys             #=> ["first_name", "last_name"]
person.values           #=> ["Vadim", "Brodsky"]  // returns the values as an array
person.length           #=> 2
person.size             #=> 2 // same as length
```

```ruby
person.to_a             #=> [["first_name", "Vadim"], ["last_name", "Brodsky"]]
person.clear            #=> {}
person = {}             #=> {} // same as clear
```


### Object Types: Symbols
- Symbol: a label that is used to identify a piece of data.
- Stored in memory one time.
- Good for keys in hashes.

```ruby
:test
:test.object_id        #=> 197608
```

```ruby
hash = {:first_name => 'John', :last_name => 'Smith'}
hash[:first_name]
```

```ruby
 # As of Ruby 1.9 this is equivalent to the previous example
hash = {first_name: 'John', last_name: 'Smith'}

{ :name => "John" } == { name: "John" }
```


### Object Types: Booleans
- Boolean: True / False for comparisons.

| Operator                         | Syntax  |
| -------------------------------- |:-------:|
| Equal                            | `==`    |
| Less than                        | `<`     |
| Greater than                     | `>`     |
| Less than or equal to            | `<=`    |
| Greater than or equal to         | `>=`    |
| Not                              | `!`     |
| Not Equal                        | `!=`    |
| And                              | `&&`    |
| Or                               | <code>&#124;&#124;</code>  |
| Comparison* (spaceship operator) | `<=>`   |

*Comparison is not a boolean operator.

```ruby
true.class              #=> TrueClass
false.class             #=> FalseClass
1 > 2                   #=> false
x.nil?                  #=> false
2.between?(1,3)         #=> true
[1,3,4].empty?          #=> false
[1,2,3].include?(3)     #=> true
hash.has_key?('a')      #=> false
hash.has_value?('zz')   #=> false
```

#### Comparison Operator
- Compares two values.

```ruby
value1 <=> value2
```

| Return Value | Meaning    |
| ------------ | ---------- |
|  -1          | Less than  |
|   0          | Equal      |
|   1          | More than  |

```ruby
1 <=> 2		#=> -1
2 <=> 1		#=> 1
2 <=> 2		#=> 0
```


### Object Types: Ranges
- Ranges: range on numbers, like an array of all the numbers 1..10
- Inclusive range `1..10` == `1,2,3,4,5,6,7,8,9,10`
- Exclusive range `1...10` == `1,2,3,4,5,6,7,8,9`

```ruby
x = 1..10
y = 'a'..'m'
x.class                #=> Range
x.begin                #=> 1   // same as x.first
x.end                  #=> 10  // same as x.last
x.include(10)          #=> true
[*x]                   #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```


### Object Types: Constants
- Constants are similar to variables.
- Not true objects, point to objects.
- Constants are different than variables, a constant is _constant_.
- Any variable that starts with a capital letter is a constant in Ruby.
- Changing constants will present a warning, but will work.

```ruby
CONST = "This is a constant"
CONST = "Changed"   #=> warning: already initialized constant CONST
CONST               #=> "Changed"
```


### Object Types: Nil
- An empty object.
- Nil the only Ruby object that is `false` in a boolean context, apart from `false` itself.

```ruby
nil.nil?				#=> true
value.nil?			#=> false
"".nil?				#=> false
nil.to_i 			#=> 0
nil.to_s				#=> ""
nil.to_s.empty?		#=> true
```



## Control Structures
- Control structures provide the action in Ruby programming.
- What happens in which circumstance.

### Control Structures: Conditionals
- If something true, do this.

```ruby
if boolean
	...
end
```

```ruby
if boolean
	...
else
	...
end
```

```ruby
if boolean
	...
elsif boolean
	...
else
	...
end
```

```ruby
if x < 10
	puts "Below 10"
elsif x > 20
	puts "Over 20"
else
	puts "10-20"
end
```

```ruby
puts "This is Vadim" if name == "Vadim"  # inline conditional
```

### Control Structures: Shorthand Conditionals
- unless
- case
- ternary operator
- or/or-equals

```ruby
unless boolean  # same as: if !boolean
	...
end
```

```ruby
case
when boolean
	...
when boolean
	...
else
	...
end
```

```ruby
case test_value
when value
	...
when value
	...
else
	...
end
```

```ruby
boolean ? code1 : code2
puts x==1 ? "one" : "not one"
```

```ruby
if y
	x = y
else
	x = z
end

x = y || z  # this is the shorthand for above
```

```ruby
unless x
	x = y
end

x || = y    # this is the shorthand for above
```


### Control Structures: Loops
- `break`: Terminate the whole loop.
- `next`: Jump to the next loop.
- `redo`: Redo this loop.
- `retry`: Start the whole loop over.

```ruby
loop do
	...
end
```

```ruby
x = 0
loop do
	x += 2
	break if x >= 20
	next if x == 6
	puts x
end 
```

```ruby
while boolean  # has implied conditional
	...
end
```

```ruby
until boolean  # while something is not true
	...
end
```

```ruby
x = 0
while x < 20
	x += 2
	puts x
end
```

```ruby
x = 0
puts x += 2 while x < 100

y = 3246
puts y /= 2 until y <= 1
```


### Control Structures: Iterators
- Similar to loops.
- Once for each item in a set of data.
- The curly braces `{...}` are shorthand for `do` and `end`.
- Control statements `break`, `next`, `redo` and `retry` work in iterators.
- Integers / floats iterate with: `times`, `upto`, `downto`, `step`
- Range iterate with: `each`, `step`
- String iterate with: `each`, `each_line`, `each_byte`
- Array iterate with: `each`, `each_index`, `each_with_index`
- Hash iterate with: `each`, `each_key`, `each_value`, `each_pair`

```ruby
5.times do
	puts "hello"
end
```

```ruby
1.upto(5) {puts "hello"}
5.downto(1) {puts "hello"}
(1..5).each {puts "hello"}
```

```ruby
1.upto(5) do |i|   # i is the number of each iterator
	puts "Hello " + i.to_s
end

# same as above
1.upto(5) {|i| puts "Hello " + i.to_s}
```

```ruby
fruits = ['banana', 'apple', 'pear']

fruits.each do |fruit|
	puts fruit.capitalize
end

# same as above
for fruit in fruits
	puts fruit.capitalize
end
```



### Control Structures: Code Blocks
- Block of code that executes multiple times.
- Usually between `do` and `end` or with the short form `{...}`
- Can use the value of the iteration with the `|i|` notation.
- Don't have access to block variables in the local scope.
- Do have access to local variable in the block scope.


#### Code Block Methods: Find
- `find` / `detect`: find the first match, return => Object or nil
- `find_all` / `select`: finds all matches, return => Array
- `any?`: find if any of the items match, return => Boolean
- `all?`: find if all of the items match, return => Boolean
- `delete_if`: delete the item in an array if, returns => Array

```ruby
(1..10).find {|i| i % 3 == 0}  #=> 3 // only the first match returns
(1..10).detect {|i| (1..10).include? (i * 3)}   #=> 1
```

```ruby
(1..10).find_all {|i| i % 3 == 0} #=> [3, 6, 9]
(1..10).select {|i| (1..10).include? (i * 3)}   #=> [1, 2, 3]
```

```ruby
(1..10).any? {|i| i % 3 == 0}     #=> true
(1..10).all? {|i| i % 3 == 0}     #=> false
```

```ruby
[*1..10].delete_if {|i| i % 3 == 0}   #=> [1, 2, 4, 5, 7, 8, 10]
```


#### Code Block Methods: Merge
- Used to merge Hashes together.
- The values passed to the function take precedence over the  calling hash.
- The code block can be supplied optionally, only called in case of a merge conflict.
- The block is used for conflict resolution.
- Use the `merge!` to save the changes of the operation.

```ruby
h1 = { "a" => 111, "b" => 222 }
h2 = { "b" => 333, "c" => 444 }
h1.merge(h2) 				#=> {"a"=>111, "b"=>333, "c"=>444}
h2.merge(h1) 				#=> {"b"=>222, "c"=>444, "a"=>111}
```

```ruby
h1.merge(h2) {|key, old, new| old * 2}  
#=> {"a"=>111, "b"=>444, "c"=>444}
```

```ruby
h1.merge(h2) do |key, old, new|
	if old < new
		old
	else
		new
	end
end
#=> {"a"=>111, "b"=>222, "c"=>444}

# Or using the shorthand
h1.merge(h2) {|k,o,n| o < n ? o : n}
#=> {"a"=>111, "b"=>222, "c"=>444}
```

```ruby
h1.merge!(h2)
h1
#=> {"a"=>111, "b"=>333, "c"=>444}
```


#### Code Block Methods: Collect
- Use either `collect` or `map`.
- Works best with Arrays, Hashes and Ranges.
- Applies the instructions of the code block to each value in the array.
- Need to be explicit on the returns, otherwise it will return `nil`.
- Number of items in == number of items out.
- Always returns an Array.
- Use `collect!` to save the effect on the original object.

```ruby
array = [1, 2, 3, 4, 5]
array.collect {|i| i + 1} 	#=> [2, 3, 4, 5, 6]

["apple", "banana", "orange"].map {|fruit| fruit.capitalize}
#=> ["Apple", "Banana", "Orange"]
```

```ruby
["apple", "banana", "orange"].map {|fruit| fruit.capitalize if fruit == 'banana'}
#=> [nil, "Banana", nil]
# Only returns the matched conditions.
```

```ruby
["apple", "banana", "orange"].map do |fruit|
	if fruit == 'banana'
		fruit.capitalize
	else
		fruit
	end
end
#=> ["apple", "Banana", "orange"]
```

```ruby
hash = { "a" => 111, "b" => 222, "c" => 333 }
hash.map {|k,v| k.capitalize} 	#=> ["A", "B", "C"]
```


#### Code Block Methods: Sort
- Sort does a comparison using the `<=>` operator.
- The comparison operator decides which direction the value goes.
- If the operation is on a single property use `sort_by`.
- To save the result use `sort!`.
- Can sort Hashes as well as Arrays, but Ruby converts it to an Array.

```value1 <=> value2```

| Comparison Result | Meaning   | Action      |
|:-----------------:|:---------:|:-----------:|
|        -1         | Less than | Moves left  |
|         0         | Equal     | Stays       |
|         1         | More than | Moves right |

```ruby
array = [3 ,1, 5, 2, 4]
array.sort { |v1,v2| v1 <=> v2 } 	# default sorting
array.sort 							# same as above but shorter
#=> [1, 2, 3, 4, 5]
```

```ruby
array.sort { |v1,v2| v2 <=> v1 }
array.sort.reverse
#=> [5, 4, 3, 2, 1]
```

```ruby
fruits = ["banana", "apple", "orange", "pear"]
fruits.sort 	# alphabetical sort
#=> ["apple", "banana", "orange", "pear"]

fruits.sort {|fruit1,fruit2| fruit1.length <=> fruit2.length}
#=> ["pear", "apple", "orange", "banana"]

fruits.sort_by{|fruit| fruit.length} 	#shorthand version
#=> ["pear", "apple", "orange", "banana"]
```

```ruby
hash = { "a" => 555, "b" => 333, "c" => 222, "d" => 111 }
hash.sort {|item1, item2| item1[1] <=> item2[1] }
# sort by values of the hash
#=> [["d", 111], ["c", 222], ["b", 333], ["a", 555]]
```


#### Code Block Methods: Inject
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



## Methods

### Methods: Calling Methods
- Object method that are applied to an object use the `.` notation.
- Object methods can be chained.
- To call a stand-alone method just call it's name, like a variable.
- Methods have to be defined before they are called.
- Parentheses for method parameters are optional.
- When hashes are the last argument in a function call, the curly braces are optional.

```ruby
"hello".reverse.capitalize
method_name
```


### Methods: Defining Methods
- Method names can have question marks `?` - convention for tests and booleans.

```ruby
def method_name
	...
end

def add
	puts 1 + 1
end

def over_five?
	value = 3
	puts value > 5 ? 'over 5' : 'not over 5'
end
```


### Methods: Variable Scope
- Local method variables have the scope local to the method only.
- Method names and variable names can look the same, be careful.
- Global `$variable`, class `@@variable` and instance `@variable` can span the scope of the method.


### Methods: Arguments
- Comma separated list if values that are passed into the methods.
- Values are passed into the method when it is called.
- When multiple arguments are defined, their order is important.
- The parentheses for the arguments are optional.
- Methods with arguments typically use parentheses.
- Methods without arguments typically do not use parentheses.

```ruby
def welcome(name)
	puts "Hello #{name}"
end

welcome("Vadim")
#=> Hello Vadim

welcome "Vadim" 	# without parentheses
#=> Hello Vadim
```

```ruby
def add(n1, n2)
	puts n1 + n2
end

add(5, 2)
#=> 7
```

#### Methods: Argument Default Values
- Default behavior for the method, so it will not break if the argument is missing when the method is called.
- Make the required arguments first in the argument list.

```ruby
def welcome(name="Friend")
	puts "Hello #{name}"
end
```

### Methods: Return Values
- All methods have a return value.
- Implicit return - the return value for the method is the last operation of the method.
- Explicit return - exits the method and reruns the value using the `return` keyword.
- Returns can work with `if` statements -- `return if x`.
- Can only return 1 object from a method.

```ruby
def welcome(name="Friend")
	return "Hello #{name}!"
end
```

```ruby
def add_and_subtract(n1=0, n2=0)
	add = n1 + n2
	sub = n1 - n2
	return add, sub 	#=> This is an array, the brackets are optional
end

add, sub = add_and_subtract(8, 3)	#=> Double assignment to an array
```

### Methods: Operators are Methods
- Common operators in the Ruby language are methods.
- Ruby uses syntactic sugar to make the common operators appears like operators.
- Common variables can be used as methods with any custom class.

```ruby
8 + 2 == 8.+(2)
8 * 2 == 8.*(2)
8 / 2 == 8./(2)
8 ** 2 == 8.**(2)
```

```ruby
array << 4			# array.<<(4)
array[2] 			# array.[](2)
array[2] = 'x' 		# array.[]=(2,'x')
```

```ruby
"hello" * 5 		# "hello".*(5)
5 * "hello" 		# 5.*("hello")
```





## Classes
- Classes define what an object is and what an object can do.
- Class names start with a capital letter and use camel case.
- Group code into discreet, well-categorized areas.
- Objects carry around their class's code.
- Allows for complex behaviors using simple statements.
- Correspond to read-world objects.


### Classes: Defining and Using Classes
```ruby
class NameOfClass
	...
end
```

```ruby
class Animal
	def make_noise
		"Moo!"
	end
end

animal = Animal.new 	#=> #<Animal:0x007f9e7d1a9dc0>
animal.make_noise 		#=> "Moo!"
```


### Classes: Instances
- An object created from a class.
- The instance is created and returned with the `new` method.
- Evey time an object is crated it is a different object.
- Like a "While You Were Out" pad.

```ruby
animal1 = Animal.new
animal2 = Animal.new
```


### Classes: Attributes
- Values that persists inside of an instance. 
- A special kind of variable - `@variable`.
- Never has access to instance variables outside of the instance.
- Only the methods of the class have access to instance variables.

```ruby
class Animal
	def set_noise(noise)
		@noise = noise 
	end

	def make_noise
		@noise
	end
end

animal1 = Animal.new
animal1.set_noise("Moo!")
puts animal1.make_noise 	#=> "Moo!"

animal2 = Animal.new
animal.set_noise("Whoof!")
puts animal2.make_noise 	#=> "Whoof!"
```


### Classes: Reader / Writer Methods
- Same as getters / setters in other languages.
- Give access control over the instance variables.
- Ruby has syntactic sugar to make the reader and writer method more concise.

```ruby
class Animal
	def noise=(noise) 		# same as above but shorter
		@noise = noise
	end

	def noise 				# same as above but shorter
		@noise
	end
end

animal = Animal.new 		
animal.noise = "Moo!" 		# like assigning a variable
puts animal.noise
```


### Classes: Attribute Methods
- For classes that have many attributes Ruby provides a shortcut.
- Using the attribute `attr_*` methods.
- `attr_reader`: creates a reader method.
- `attr_writer`: creates a writer method.
- `attr_accessor`: creates both a reader and a writer method.

```ruby
attr_reader :name

#same as
def name
	@name
end
```

```ruby
atte_writer :name

#same as
def name=(value)
	@name = value
end
```

```ruby
attr_accessor :name

#same as both
def name
	@name
end

def name=(value)
	@name = value
end
```

```ruby
#can create multiple instance variables and methods at once
attr_accessor :name
attr_writer :color
attr_reader :legs, :arms
```


### Classes: Initialize Method
- Methods that run when the object is being initialized.
- Use the `initialize` class method.
- Can pass arguments to the `initialize` method, the `new` method uses them.

```ruby
class Animal
	def initialize(noise, legs, arms)
		@noise = noise
		@legs = legs
		@arms = arms
		puts "A new animal has been instantiated."
	end
end

animal = Animal.new("Moo", 4, 0)
```


### Classes: Class Methods
- A method that can be called on a class, even without an instance of the class.
- Example: `Animal.new`.
- Using the `self` keyword, that applies to the object that we are currently in.

```ruby
def self.method_name
	...
end
```

```ruby
class Animal
	...
	def self.all_species
		['cat', 'cow', 'dog', 'duck', 'horse', 'pig']
	end

	def self.create_with_attributes(noise, color)
		animal = self.new(noise)
		animal.color = color
		return animal
	end
	...
end

puts Animal.all_species
animal2 = Animal.create_with_attributes('black', 'quack')
```


### Classes: Class Attributes
- Store values that apply to the class generally.
- Using the class variable `@@variable`.
- Persists any time we have the class, even without the variables.
- Information that is general for the whole class.
- Keep track of all of the objects with `@@total`.
- Keep track of all the instances with an array of class attributes.
- Cannot access the class attributes outside of the class, only with class methods.

```ruby
class Animal
	...
	@@species = ['cat', 'cow', 'dog', 'duck', 'horse', 'pig']
	@@curent_animals = []

	def self.all_species
		@@species
	end

	def initialize
		@@current_animals << self
	end
	...
end

puts Animal.all_species
puts Animal.current_animals.inspect 	# would not work, need class method
```


### Classes: Class Reader / Writer Method
- Same as with instance variables, class variables (attributes) need setter and getter methods.

```ruby
def self.animals 				# reader
	@@animals
end

def self.animals=(array=[]) 	# writer
	@@animals = array
end
```


### Classes: Inheritance
- Bestowal of methods and attributes of another class.
- Superclass / parent => subclass / children.
- In Ruby we can inherit from only 1 superclass at a time, there are no multiple inheritances.

```ruby
class Cow < Animal
end

betsy = Cow.new("Moo!")
betst.class 		# Cow
```


### Classes: Subclass Overriding
- To overwrite the parent class methods or attributes.
- Methods can be overwritten by using the same method name in the definition of a new method.
- The last definition always wins.

```ruby
class Cow < Animal
	def color
		"The cow's color is #{@color}."	
	end	
end
```

```ruby
class Array 		# overriding Ruby's built in-class
	def to_s
		self.join(', ')
	end
end
```


### Classes: Accessing the Superclass
- To change the behavior of a superclass' method without completely overriding it.
- The keyword `super` is used for that.
- It returns the result of the original method to where `super` is called.

```ruby
class Pig < Animal
	def noise
		parent_noise = super
		return "Hello and also #{parent_noise}"
	end
end

wilbur = Pig.new
wilbur.make_noise
```



## Modules
- Are wrappers around Ruby code.
- Modules can't be instantiated.
- Modules are used in conjunction with classes.


### Modules: Namespaces
- Namespacing allows for class names that don't conflict.
- Use a namespace wrapper and double colons `ModuleName::ClassName`.
- Keep class name distinct from standard Ruby classes.
- Disambiguating your own class definitions.
- Ensure classes used in open source code won't conflict.

```ruby
module Romantic 		# Module wrapper
	class Date
		...
	end
end

dinner = Romantic::Date.new 	# Module date
dinner.date = Date.new 			# Ruby date
```


### Modules: Mix-Ins
- Ruby only allows to inherit from one superclass.
- If additional functionality is needed, it can be placed into a module and mixed in.
- Reuse the same code in multiple places, using the `include` statement.
- Make sure the module definition comes before the class that it's being used in.
- Can use Ruby's built-in modules like `enumerable`.

```ruby
module ContactInfo
	attr_accessor :first_name, :last_name, :city, :state, :zip_code

	def full_name
		return @first_name + " " @last_name
	end
end

class Person
	include ContactInfo  		# load the ContactInfo module
end

class Teacher
	include ContactInfo
	attr_accessor :lesson_plans
end

class Student < Person 			# inherits the module behavior from Person
	attr_accessor :books, :grades
end
```

```ruby
class ToDoList

	include Enumerable 			# load Ruby's Enumerable mixin

	attr_accessor :items

	def initialize
		@items = []
	end

	def each
		@items.each {|item| yield item} 	# use the each functionality
	end
end

list = ToDoList.new
list.select {|i| i.length > 6} 		# use the select method directly on the object
```


### Modules: Load, Require, Include
- Modules are usually kept in separate files.
- Modules can be serves as code libraries.
- Need to have a way to load modules and files into other Ruby files.
- `load`: loads a source file every time it is called, returns `true` if the file loaded successfully.
- `require`: loads a source file only once, keeps track of the file and will not load it again.
- `include`: uses exclusively for including module mixins, nothing to do with files.

```ruby
load 'contact_info.rb' 		# loading a dependency
```





## Working With Files


### Working With Files: Input / Output Basics
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


### Working With Files: Cross Platform
- File path separators
	- Unix, Linux, Mac path separator: `/`
	- Windows path separator: `\`
	- The `File.join()` method avoids the OS differences.
- File permissions
	- `chmod`: change permissions on unix.
	- `chown`: change owner on unix.

```ruby
File.join('path', 'to', 'folder', 'file.rb')

# Starting with a blank '' will create a path
File.join('', 'Users', 'vadim', 'Desktop', 'rube_files')
```


### Working With Files: File Paths
- Absolute path: `/path/to/file`
- Relative path: `./../../path/to/file`
- Ruby Special variable `__FILE__`: the name of the file that we are in right now.
- To get the absolute path use `File.expand_path()`.

```ruby
File.expand_path(__FILE__) 		# Absolute file path
File.dirname(__FILE__) 			# File directory
```

```ruby
# go up one directory with relative paths
puts File.join(File.dirname(__FILE__), '..', "Folder\ With\ Spaces")
```


### Working With Files: Accessing Files
- Two ways of opening a file.
- `File.new`: 
	- Creates a new instance of the `File` object, the file exists while the object exists.
	- Accepts the file name and the writing mode.
- `File.open`
	- Uses a block to perform actions.
	- At the end it closes the file automatically.
	- Accepts the file name and the writing mode.

```ruby
file = File.new('file_name.rb', 'w')
file.close
```

```ruby
File.open('file1.txt', 'r') do |file|
	# read the data from the file
end
```


### Working With Files: File Modes
- Most useful are `r` to read, `w` to start new file, `r+` to read and write, `a` to add something at the end.

| Access Mode | Description                  | Read & Write |
|:-----------:|:-----------------------------|:------------:|
|     `r`     | Read from start (must exist) |     `r+`     |
|     `w`     | Truncate / Write from start  |     `w+`     |
|     `a`     | Append / Write from end      |     `a+`     |

- `r`: reads from the start, the file must exist. 
- `w`: writes from the start, will create the file if it doesn't exist. If the file exists it will overwrite it.
- `a`: append to the end of a file
- `r+`: read and write from the file without erasing everything, starting at the beginning of the file.
- `w+`: read and write from the file but will truncate everything first.
- `a+`: read and write from the file without truncating, starting at the end of the file.


### Working With Files: Writing
- Before writing the data to the file, Ruby waits for the file to be closed first.
- Write to the hard drive only once in batch.

```ruby
file = File.new('test_file.txt', 'w')
file.puts "abcd"
file.close
```

```ruby
file.puts "abcd" 		# puts string with line break
file.print "abcd" 		# puts string whiteout line break
file.write "abcd" 		# like print but returns the number of characters
file << "abcd" 			# like print but returns the object
```


### Working With Files: Reading
- Cannot use `chomp` automatically with `gets`, if it's the end of the file there is nothing to get -- `chomp` will cause an error.

```ruby
file = File.new('test_file.txt', 'r')
file.gets 				#=> "abcd\n"
file.gets.chomp 		#=> "abcdabcdabcd"
file.gets 				#=> nil
```

```ruby
file.gets 			# reads from the pointer position to end of line
file.read(4) 		# read 4 characters
```

```ruby
File.open('file1.txt', 'r') do |file|
	while line = file.gets
		puts "** " + line.chomp.reverse + " **"
	end
end
```

```ruby
File.open('file1.txt', 'r') do |file|
	file.each_line { |line| puts line.upcase }
end
```


### Working With Files: File Pointer
- Similar to a file pointer in a text editor.
- Overwrites text at a position.
- Use it for both writing and reading.
- The pointer position: `file.pos` start with `0`.

```ruby
file.pos 			# current position of the pointer
file.read(3)
file.pos 			#=> 3
file.pos = 13 		# move pointer to position 13
file.eof? 			# Boolean enf of file check
file.rewind 		# Go back to start, sams as assigning 0
file.pos += 6 		# Go forward 6
file.pos += 100 	# set the pointer beyond the end of the file
```

```ruby
file.lineno 		# how many times gets was called
```


### Working With Files: Renaming and Deleting
- Need read and write to the file, as well as write permissions for the directory.

#### File Class:
- Standard file class.
- `rename`
- 'delete', `unlink`

#### FileUtils Class:
- Ruby Standard library: `require fileutils`
- `cp`, `copy`
- `mv`, `move`
- `rm`, `remove`
- `cd`, `chmod`, `chown`, `pwd`, `ln`, `touch`, `mkdir`, `rmdir`


```ruby
File.rename('file_to_rename.txt', 'new_file_name.txt')
File.delete('new_file_name.txt')
```

```ruby
require fileutils 		# Ruby built-in library
FileUtils.copy('file_to_copy.txt', 'copied.txt')
```


### Working With Files: Examining File Details
- Class methods on the `File` class.
- File instance use the `stat` object to access information.

```ruby
file = 'testfile.txt'
File.exist?(file) 		# does it exist
File.file?(file) 		# is it a file
File.directory?(file) 	# is it a directory
File.readable?(file) 	# readable permission
File.writable?(file) 	# writable permission
File.executable?(file) 	# executable permission
File.size(file) 		# in bytes, corresponds to string length
File.dirname(file) 		# folder name
File.expand_path(file) 	# full path
File.basename(file) 	# reverse of expand, file name
File.extname(file) 		# extension of the file
File.atime(file) 		# last accessed time - read or write
File.mtime(file) 		# last modified time - write
File.ctime(file) 		# last status change time, NOT created time
```

```ruby
myfile.stat 			# returns a file stat object
myfile.stat.size
myfile.stat.readable?
```


### Working With Files: Directories
- Ruby has a direcotry class: `Dir`.
- `Dir.pwd`: print working directory.
- `Dir.chdir`: change directory, like `cd` in bash.
- `Dir.entries(folder name)`: array of the files in a folder.

```ruby
File.dirname(__FILE__)
Dir.pwd
Dir.chdir('..')
Dir.chdir('', 'Users', "Desktop")
Dir.entries('.')
```

```ruby
Dir.entries('.').each do |entry|
	print entry + ': '
	if File.file?(entry) && File.readable?(entry)
		File.open(entry, 'r') do |file|
			puts file.gets
		end
	else
		puts
	end
end
```

```ruby
Dir.foreach('.') {|entry| puts entry}
```

```ruby
Dir.mkdir('temp_direcotry')
Dir.delete('temp_direcotry') 	# need permissions and has to be empty
```





## Ruby Methods

### exit!
- Will stop the script and exit to the command line.
- Stops right away.
- `exit!`

### Left and Right Justify
- Add characters to a string until reaches a defined length.
- Useful for command line output justification.

```ruby
"Hello".ljust(30, "#")
#=> "Hello#########################"
```

```ruby
"Hello".rjust(30, "#")
#=> "#########################Hello"
```