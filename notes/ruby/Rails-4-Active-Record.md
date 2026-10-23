# Active Record
Active Record is the Ruby object-relational mapping (ORM) library that handles the database abstraction and interaction for Rails.

- It maps tables to classes, table rows to object, table columns to object attributes.
- Active Record lets you model real-world things in your code.


## Using Active Record
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

## Active Record Conventions
Active Record achieves its zero-configuration by the use of conventions:

- Class names are singluar; table names are plural.
- Tables contain an identity column named `id`.

If the table name contains underscores, the class name is assumed to be in Camel Case. All tables are assumed to have a unique columnd named `id` that is acting as the table's primary key.

```ruby
Article.column_names
#=> ["id", "title", "body", "published_at", "created_at", "updated_at", "excerpt", "location"]
```

```ruby
Article
#=> Article(id: integer, title: string, body: text, published_at: datetime, created_at: datetime, updated_at: datetime, excerpt: string, location: string)
```

```ruby
Article.methods.size
#=> 549
```

```ruby
Article.count
#=> 5
```

## Active Record: CRUD

### Create
Creating new objects that will add new records to the database.

```ruby
article = Article.new
#=> #<Article id: nil, title: nil, body: nil, published_at: nil, created_at: nil, updated_at: nil, excerpt: nil, location: nil>
```

To check the attributes of the object use `attributes` method returns a hash. To see if the object was not saved yet use the `new_record?` method.

```ruby
article.new_record?
#=> true
article.attributes
#=> {"body"=>nil, "created_at"=>nil, "excerpt"=>nil, "location"=>nil, "published_at"=>nil, "title"=>nil, "updated_at"=>nil}
article
#=> #<Article id: nil, title: nil, body: nil, published_at: nil, created_at: nil, updated_at: nil, excerpt: nil, location: nil>
```

To add data to the object use the attribute accessor methods.

```ruby
article.title = 'RailsConf'
article.body = 'RailsConf is the official gathering for Rails developers..'
article.published_at = '2013-04-13'
```

To save the object in the database use the `save` method. It returns `true` for success and `false` for failure.

```ruby
article.save
```

The above can be done in fewer lines:

```ruby
article = Article.new(:title => "Introduction to Active Record", :body => "Active Record is Rails...", :published_at => Date.today)
article.save
```

Objects can be created in one step, instead of returning `true` or `false` it returns an `Article` object.

```ruby
Article.create(:title => "RobyConf 2013", :body => "The annual...", :published_at => '2013-04-13')
```


### Read
Every model class understand the class `find` method. The `find` method can be called in 4 ways:

- `find(:id)`: finds a single record by its unique `id` or multiple records if `:id` is an attay of ids.
- `all`: finds all records in the table.
- `first`: finds the first record.
- `last`: finds the last record.

```ruby
article = Article.find(3)
#=> #<Article id: 3 ...>
```

Active Record raises a `RecordNotFound` exception when it cannot find any records with the provided `id`.

```ruby
begin
  Article.find(1037)
rescue ActiveRecord::RecordNotFound
  puts "We couldn't find that record"
end
```

To get the first record from the database by using the `first` method. This always returns exactly one item, unless the table is empty it will return `nil`. It's not necessarily the first record  in the table, it depends on the database software and the default order in which the records are retireived.

```ruby
Article.first
#=> #<Article id: 1 ...>
```

The `last` method works exactly the same as `first`, but records are retireived in the inverse order of `first`.

```ruby
Article.last
#=> #<Article id: 5 ...>
```

To retreive all of the records from the database use the `all` method.

```ruby
articles = Article.all
#=> [#<Article id: 1, ...> #<Article id: 2, ...> ...]

articles.first.title
```

```ruby
articles = Article.order("published_at DESC")
```

To find a record based on other criteria, conditions that correspond to the SQL `WHERE` clause.

```ruby
Article.where(:title => 'RailsConf').first
Article.where(:title => 'RailsConf').all
```


### Update
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
article = Article.first
article.update_attributes(:title => "RailsConf2014", :published_at => 1.day.ago)
#=> true
```


### Delete
There are two styles of row deletion: `destroy` and `delete`.  The `destroy` style works on the instance. The `delete` style operates on the class.

Firstly you need to find the record to destroy it. After the `destroy` method the object is transitioning from being _hydrated_ (all attributes retained) to _frozen_ (can't modify attributes).

```ruby
article = Article.last
article.destroy
```

```ruby
Article.last.destroy
Article.destroy(1)
```

The `delete` family of methods differs from `destroy` in that they don't instantiate or perform callbacks on the object they are deleting. They remove the row immediately from the database.

```ruby
Article.delete(4)
Article.dete([5, 6])
```

Deleting with conditions allows to delete all rows that match a condition.

```ruby
Article.delete_all("published_at" < '2011-01-01')
```

The method `delete_all` without arguments will delete all of the records in the table.

```ruby
Article.delete_all
```


## Model Errors
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

## Enhancing Your Models
Model enhancement: endowing the models with attributes and capabilities that go beyond the `ActiveRecord::Base` subclass.

Models relate to each other with _associations_.  Models also pertain requirements that tell the model what it should expect to be saved in the database.


### Adding Methods
The primary way to enhance models is to add methods, this is also called as adding _domain logic_.

All of the logic for a particular table is contained in one place: the model. The model _encapsulates_ all of the domain logic.

There is no difference between the methods that Active Record creates and the one you define.

```ruby
class Article < ActiveRecord::Base
  def long_title
    "#{title} - #{published_at}"
  end
end
```

Models that keep model related logic in the model are called _fat models_. Acting as intelligent objects giving information about itself.


### Using Associations
Defines the way models relate and interact with one another, by relating the different tables in the database. In a relational database the tables relate by using a foreign key reference in one table to the primary key of another table.

Rails uses a convention of naming the foreign key column in singular lowercase name of the target class with `_id` appended.

`Books` => `book` => `book_id`

```ruby
#{singular_name_of_parent_class}_id
```

The table that is doing the referencing is the one that needs to create the foreign-key column. The model that contains the "belongs-to" needs to have the foreign key column.

#### Declaring Associations
Model associations are creating using methods:

- `has_one`
- `has_many`
- `belongs_to`
- `has_and_belongs_to_many`

```ruby
class Message < ActiveRecord::Base
  has_many :attachments
end

class Attachment < ActiveRecord::Base
  belongs_to :message
end
```

Active Record expects to find a table called attachments that has a field `message_id`. Associations work in both directions `Message.first.attachments` and `Attachment.first.message`.


#### One-to-One Associations
A row in one table is related to exactly one row in another table. This is achieved using the `has_one` and `belongs_to` methods.

```ruby
class User < ActiveRecord::Base
  has_one :profile
end
```

```ruby
class Profile < ActiveRecord::Base
  belongs_to :user
end
```

Assignment can be used to create the associations between the objects.

```ruby
user = User.create(:email => 'user@example.com' ...)
profile = Profile.create(:name => 'John Doe' ...)
user.profile = profile
```

This can be done in one step, using the `create_#{association_name}` method.

```ruby
user.create_profle :name => 'Jane Doe', :birthday => nil ...
```

##### Methods added by the has_one associations

| Method                                | Description                        |
|:--------------------------------------|:-----------------------------------|
| `user.profile`                        | Returns the associated (Profile) object, `nil` is returned if none is found. |
| `user.profile=(profile)`              | Assigns the associated (profile) object, extracts the primary key, sets is as the foreign key. |
| `user.profile.nil?`                   | Returns `true` if no associated Profile object. |
| `user.build_profile(attributes={})`   | Returns a new profile object that has been instantiated with attributes and linked to user though a foreign key but hasn't yet been saved. |
| `user.create_profile(attributes={})`  | Returns a new profile object that has been instantiated with attributes and linked to user through a foreign key and that has been already saved. |


##### Options for the has_one declaration:

| Option        | Description                   | Example          |
|:--------------|:------------------------------|:-----------------|
|`:class_name`  | Specified the class name of the association. Used when the class name can't be inferred from the association name. |`has_one :profile, :class_name => 'Account'`  |
|`:conditions`  | Specified the conditions that the associated object must meet in order to be included as a `WHERE SQL` fragments.  |`has_one :profile, :conditions => "active=1"` |
|`:foreign_key` | Specified the foreign key used for the association in the event that i doesn't adhere to the convention of being the lowercase singular name of the target class with `_id` appended. | `has_one :profile, :foreign_key => 'account_id'` |
|`:order`       | Specified the order in which the associated object is picked as an `ORDER BY SQL` fragment. | `has_one :profile, :order => 'created_at DESC'` |
|`:dependent`   | Specified that the associated object should be removed when this object is. | `has_one :profile, :dependent => :destroy` |

- If `:dependent` set to `:destroy` the association object is deleted using the destroy method.
- If `:dependent`  set to `:delete` the associated object is deleted without calling its destroy method.
- If `:dependent`  set to `:nullify` the associated object's foreign key is set to `NULL`.


#### One-to-Many Associations
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

##### Methods added by the has_many associations

| Method                                | Description                        |
|:--------------------------------------|:-----------------------------------|
| `user.articles`                       | returns an array of all the associated articles. An empty array is returned if no articles are found. |
| `user.articles=(articles)`            | replaces the articles collection with the one supplied. |
| `user.articles << article`            | adds one or more articles to the collection and saves their foreign keys. |
| `user.articles.delete(articles)`      | removes one or more articles from the collection by setting their foreign keys to `NULL`. |
| `user.articles.empty?`                | returns true if there is no associated article objects for this user. |
| `user.articles.size`                  | returns the number of associated article objects for this user. |
| `user.article_ids`                    | returns an array of associated article ids. |
| `user.articles.clear`                 | clears all associated objects from the association by setting their foreign keys to `NULL`. |
| `user.articles.find`                  | performs a find that is automatically scoped off the association, it finds only within items that belong to user. |
| `user.articles.build(attributes={})`  | returns a new article object that has been instantiated with attributres and linked to user though a foreign key but hasn't yet been saved. |
| `user.articles.create(attributes={})` | returns a new article object that has been instantiated with attributes and linked to user through a foreign key and has already been saved. |


##### Options for the has_many declaration:

| Option        | Description                   | Example          |
|:--------------|:------------------------------|:-----------------|
| `:class_name` | specifies the class name of the association. Used when the class name can't be inferred from the association name. | `has_many :articles, :class_name => 'Post'` |
| `:conditions` | specifies the conditions that the associated objects must meet in order to be included as a `WHERE SQL` fragment. | `has_namy :articles, :conditions => "active=1"` |
| `:foreign_key`| specifies the foreign key used for the association if it doesn't adhere to convention of being a lowercase, singular name of the target class with `_id` appended. | `has_many :articles, :foreign_key => 'post_id'` |
| `:order`      | specifies the order in which the associated objects are returned as an `ORDER BY` SQL fragment. | `has_many :articles, :order => "published_at DESC"` |
| `:dependent`  | specifies that the associated objects should be removed when this object is. | `has_many :articles, :dependent => :destroy` |

- If `:dependent` set to `:destroy` the association objects are deleted using the destroy method.
- If `:dependent`  set to `:delete` the associated objects are deleted without calling its destroy method.
- If `:dependent`  set to `:nullify` the associated objects' foreign key is set to `NULL`.


#### Many-to-Many Associations
Two tables are connected to multiple rows on both sides, categories and articles in a blog.

The has_and_belongs_to_many (habtm) association works by relying on a join table that keeps a reference to the foreign keys involved in the relationship.

The table name is formed from the names of each table in alphabetical order, separated by an underscore.


#### Rich Many-to-Many Associations
If when you are modelling a many-to-many association and need to put additional data on the join model. The `had_and_belongs_to_many` association falls short, because it uses a join table and does not have a model on which to operate.

To achieve this a _rich_ many-to-many association using `has_many :through` can be created.


### Seeding Data
Rails creates a file `db/seeds.rb` that defines the data that is always needed in the database.

Creates default user and categories:

```ruby
user = User.create :email => 'jane@example.com', :password => '1234'
Category.create[{:name => 'Programming'}, {:name => 'Event'}, {:name => 'TV'}]
```

To load the seed data:

```bash
rake db:seed
```

If the seed file was modified and the seed data needs to be reloaded run the following. It will recreate the database and add the seed data.

```bash
rake db:setup
```