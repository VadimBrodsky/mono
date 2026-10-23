# Validations: Presence

- Checks if the data entered is not blank.

```ruby
#/app/models/user.rb
validates :name, presence: true
```

```ruby
user.valid?
user.errors.full_messages
```
