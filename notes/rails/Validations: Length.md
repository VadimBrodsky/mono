# Validations: Length

- Checks the length of the entered data.
- Using the `:length` and the `:maximum` parameters.

```ruby
#/app/models/user.rb
validates :name, length: { maximum: 50 }
```
