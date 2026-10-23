# ActiveRecord: Update: Find/Save

Updaing a record is similar to creating a record, the attributes can be updates one at a time and then save the result or update all attrbitues in one action.

When the record is updates, an SQL `UPDATE` statement is constructed behind the scenes.

```ruby
article = Article.first
article.title = "Rails 4.1 Book"
article.published_at = Time.now
article.save
#=> true
```

```ruby
subject = Subject.find(1)
subject.name = "Initial Subject"
subject.save
#=> true
```
