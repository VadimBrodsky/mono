# ActiveRecord: Delete: Destroy

Firstly you need to find the record to destroy it. After the `destroy` method the object is transitioning from being *hydrated* (all attributes retained) to *frozen* (can't modify attributes).

```ruby
article = Article.last
article.destroy
```

```ruby
Article.last.destroy
Article.destroy(1)
```
