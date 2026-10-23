# Validations: Uniqueness

- Checks whether the input is already entered in the database.
- Can pass an optional `case_sensitive` parameter.

```ruby
validates :email, presence: true, uniqueness: true
validates :email, presence: true, uniqueness: { case_sensitive: false}
```
