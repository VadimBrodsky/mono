# Classes: Subclass Overriding

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
