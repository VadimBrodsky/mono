# Classes: Class Reader / Writer Method

Same as with instance variables, class variables (attributes) need setter and getter methods.

```ruby
def self.animals    # reader
	@@animals
end

def self.animals=(array=[])    # writer
	@@animals = array
end
```
