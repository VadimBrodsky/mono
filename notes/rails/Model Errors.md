# Model Errors

A helper family of methods that ask the model associated with the form for its list of errors (error collection). Usually errors occur on the `save` method if there are data validation problems.

```ruby
article.errors.any?
article.save
article.errors.size
article.errors.full_mesages
article.errors.messages(:title)
```

```ruby
article.valid?
```
