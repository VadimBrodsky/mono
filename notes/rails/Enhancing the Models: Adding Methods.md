# Enhancing the Models: Adding Methods

The primary way to enhance models is to add methods, this is also called as adding *domain logic*.

All of the logic for a particular table is contained in one place: the model. The model *encapsulates* all of the domain logic.

There is no difference between the methods that Active Record creates and the one you define.

```ruby
class Article < ActiveRecord::Base
  def long_title
    "#{title} - #{published_at}"
  end
end
```

Models that keep model related logic in the model are called _fat models_. Acting as intelligent objects giving information about itself.
