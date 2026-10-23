# Migration File: Table Column Options

- How large a value can be -- `:limit`
- A default value -- `:default`
- Can it have no value at all -- `:null`

```ruby
:limit     => size
:default   => value
:null      => true/false

# for decimal columns
:precision => number
:scale     => number
```
