# One-to-Many Associations

A row in one table is related to one or more rows in another table.

For `has_one` and `has_many` associations, adding a `belongs_to` on the other side of the association is recommended.

The `belongs_to` declaration always goes in the class with the foreign key.

```ruby
class Article < ActiveRecord::Base
  belongs_to :user
end
```

```ruby
class User < ActiveRecod::Base
  has_one  :profile
  has_many :articles
end
```
