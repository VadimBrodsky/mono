# Using Active Record

Create a Ruby class that's named after the table that you want to map, extend the Active Record `Base` class.

```ruby
class Book < ActiveRecord::Base
end
```

```ruby
book = Book.new

book.title = "Beginning Rails 4"
book.published = "Apress"
book.published_at = "2013-10-21"

book.save
```
