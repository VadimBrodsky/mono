# ActiveRecord: Update: Update_Attributes

Allows for mass assignment of attributes to be updates all at once.

```ruby
article = Article.first
article.update_attributes(:title => "RailsConf2014", :published_at => 1.day.ago)
#=> true
```

```ruby
subject = Subject.find(2)
subject.update_attributes(:name => "Next Subject", :visible => true)
#=> true
```
