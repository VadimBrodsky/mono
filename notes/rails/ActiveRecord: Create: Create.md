# ActiveRecord: Create: Create

- Objects can be created in one step using the class method `create`
- Instead of returning `true` or `false` it returns an `Article` object.
- Up to you to check if this is indeed a new object or not.

```ruby
Article.create(:title => "RobyConf 2013", :body => "The annual...", :published_at => '2013-04-13')
```
