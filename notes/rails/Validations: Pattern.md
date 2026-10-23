# Validations: Pattern

- Checks if the input matches a certain pattern.
- Uses RegEx for pattern matching.

```ruby
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
```
