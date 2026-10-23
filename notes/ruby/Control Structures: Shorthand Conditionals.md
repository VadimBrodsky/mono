# Control Structures: Shorthand Conditionals

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
