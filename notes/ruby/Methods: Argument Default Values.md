# Methods: Argument Default Values

- Default behavior for the method, so it will not break if the argument is missing when the method is called.
- Make the required arguments first in the argument list.

```ruby
def welcome(name="Friend")
	puts "Hello #{name}"
end
```
