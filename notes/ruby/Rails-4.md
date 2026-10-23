# Installing Rails
1. Install Bundler gem first.
2. Rehash the rbenv environment to load bundler.
3. Install the Rails gem.
  - Optionally install without docs: `--no-ri --no-rdoc`
  - Install a specific version: `--version 4.0.0`
4. Install the MySQL gem.

```bash
gem install bundler
rbenv rehash
bundle -v
gem install rails
rbenv rehash
rails -v
gem install mysql2
```


# Creating Rails Project
- Navigate to the desired directory.
- Run the `rails new project_name` command.
- Can specify the database requirements with the `-d` flag.

```bash
rails new hello_app
rails new simple_cms -d mysql
```


# Bundler
- Used to maintain project dependencies.
- Can install with `--without production` to not install any  production gems in the development environment.
- If the version of the Rails Gem was updated need to update with Bundler.

```bash
bundle install
bundle install --without production
bundle update rails
```


# Accessing a Project
- Start the web server: `rails server` or `rails s`.
- Visit the `localhost:3000` site in the browser.


# Rails Console
- Rails comes with a modified version of IRB.
- It has access to all of Rails methods and the app database.
- By default it start in the development environment.
- To start the console in a sandbox use the `--sandbox` flag, all changes will be rolled back on exit.

```bash
rails console
rails c
```

```bash
rails console --sandbox
```


# Generate
- Rails `generate` command helps to create many things.
- To list all of the thing that rails can generate, run `rails generate`
- `rails generate GENERATOR [args] [options]`

```bash
rails generate
rails generate controller demo index
rails generate controller StaticPages home help
```


# Undoing Rails Generated Code

```bash
rails generate controller FooBarz baz qux
rails destroy controller Foobarz
```

```bash
rails generate model Foo bar:string baz:integer
rails destroy model Foo
```

```bash
rake db:migrate
rake db:rollback
rake db:migrate VERSION=0
```


# Scaffolding
- Rails has a scaffolding script that generates code for data models.

```bash
rails generate scaffold User name:string email:string
```


# Database Migration
- To update the database based on changes in the code run a migration.
- To make sure that the right version of Rake runs use the `bundle exec` addition.
- To see all available rake tasks run `bundle exec rake -T`.

```bash
bundle exec rake db:migrate
```


# Rails File Structure
- `app/` Most of the app code lives here
- `app/assets` application assets, processed by the Rails asset pipeline
- `app/assets/images`
- `app/assets/javascripts`
- `app/assets/stylesheets`
- `app/controllers` the controllers
- `app/controllers/concerns` common code that shared between controllers
- `app/helpers` code that helps with views
- `app/mailers` sending emails
- `app/models` the models
- `app/models/concerns` common code that shared between models
- `app/views` the views
- `bin/` stores the Rails commands and other binary executables
- `config/` Configuration files for the application
- `config/environments` settings for different environments
- `config/initializers` differing this that launch when app launches
- `config/locales` translation and internationalization
- `db/` code related to managing the database and db migrations
- `doc/` documentation for the app
- `lib/` storing libraries of code
- `lib/assets` different assets from library modules
- `lib/tasks`  rake tasks for the library modules
- `log/` application log files
- `public/` data accessible to the public, such as html error pages
- `test/` application tests
- `tmp/` temporary files that Rails generates
- `vendor/` third party plugin code that is not in gems
- `README.rdoc` A brief description of the application
- `Rakefile` Utility tasks available via the `rake` command
- `Gemfile` Gem requirements for the app
- `Gemfile.lock` A list of gems and their dependencies
- `config.ru` A configuration file for Rack Middleware
- `.gitignore` Patterns for files that should be ignored by Git.


# REST Architecture
- Representational State Transfer.
- REST is an architectural style for developing distributed, networked systems and software applications.
- In the context of Rails applications REST means that most application components are modeled as resources that can be:
	- Created, read, updated, and deleted—operations that correspond both to the CRUD operations of relational databases
	- Four fundamental HTTP request methods: `POST`, `GET`, `PATCH`, and `DELETE`.


# HTTP Operations
- `GET` is the most common HTTP operation, used for reading data on the web; it just means “get a page”,
- `POST` is the next most common operation; it is the request sent by your browser when you submit a form. In Rails applications, `POST` requests are typically used for creating things.
- `PATCH` and `DELETE`, are designed for updating and destroying things on the remote server. These requests are less common than `GET` and `POST` since browsers are incapable of sending them natively.


# Test Driven Development
- Behavior-driven development (BDD) is a variant of test-driven development (TDD) that emphasizes the behavior of the application rather than its precise implementation.
- Integration tests: known as request specs in the context of RSpec, allow us to simulate the actions of a user interacting with our application using a web browser.
- The defining quality of TDD is writing tests first, before the application code.
- By writing a failing test first and then implementing the application code to get it to pass, we increase our confidence that the test is actually covering the functionality we think.
- When you aren’t at all sure how to solve a given programming problem, it’s often useful to skip the tests and write only application code, just to get a sense of what the solution will look like.
- Once you see the general shape of the solution, you can then use TDD to implement a more polished version.

# Red, Green, Refactor
- First write a failing test, represented in many testing tools by the color red.
- Implement code to get the test to pass, represented by the color green.
- Refactor the code, changing its form without changing its function.

# Request Spec
- Integration tests (request spec) are done with Rspec in Rails.
- Rails creates these tests in the `spec/requests/` folder.

```bash
rails generate integration_test static_pages
```

## Writing the Test
- RSpec uses the general malleability of Ruby to define a domain-specific language (DSL) built just for testing.
- The `describe` lines are for human readers only.

```ruby
 # spec/requests/static_pages_spec.rb
require 'spec_helper'

describe "Static pages" do
  describe "Home Page" do
	it "should have the content 'Sample App'" do
	  visit '/static_pages/home'
	  expect(page).to have_content('Sample App')
	end
  end
end
```

## Running the Test
- To get the test to run need to add the Capybara DSL to the RSpec helper file.

```ruby
 # spec/spec_helper.rb
 RSpec.configure do |config|
   .
   .
   .
   config.include Capybara::DSL
 end
```

```bash
bundle exec rspec spec/requests/static_pages_spec.rb
bundle exec rspec spec
bundle exec rake spec
```


# Embedded Ruby - ERb
- ERb is the primary template system in Rails.
- The `<% ... %>` tag executes the code inside.
- The `<%= ... %>` tag executes and inserts the result into the template.

```erb
<body>
<%= yield %>
</body>
```


## ERb Helper: Yield
- The `yield` method inserts the contents of each page into the site layout.

```erb
<div class="container">
	<%= yield %>
</div>
```


## ERb Helper: Link_To
- Rails helper `link_to` creates links as anchor tags.
- `<%= link_to "link text", 'url', {options: "hash"} %>`

```erb
<%= link_to "sample app", '#', id: "logo" %>
```


## ERb Helper: Image_Tag
- Rails helper `image_tag` creates an `img` tag.
- Rails will always include an `alt` attribute even if one wasn't given, using the filename.
- Rails knows to look for images in the `/app/assets/images/` folder.
- `<%= image_tag("file_name.jpg", options: "hash") %>`

```erb
<%= image_tag("rails.png", alt: "Rails") %>
<%= link_to image_tag("rails.png", alt: "Rails"), 'http://rubyonrails.org/' %>
```


## ERb Helper: Render
- Used to render partials in ERb files.
- Partials are usually named with a leading `_`.
- Examples: `/app/views/layouts/_shim.html.erb`.

```erb
<%= render 'layouts/shim' %>
```


## ERb Debug Information
- Add this to the view template to see debug info.

```erb
<%= debug(params) if Rails.env.development? %>
```

## ERb Forms
- Rails has a built-in `form_for` function.

```erb
<%= form_for(@user) do |f| %>

  <%= f.label :name %>
  <%= f.text_field :name %>

  <%= f.label :email %>
  <%= f.text_field :email %>

  <%= f.label :password %>
  <%= f.password_field :password %>

  <%= f.label :password_confirmation, "Confirmation" %>
  <%= f.password_field :password_confirmation %>

  <%= f.submit "Create my account", class: "btn btn-large btn-primary" %>
<% end %>
```


# Asset Pipeline
- Improves production and management of static assets such as CSS, JavaScript and Images.
- Primary 3 features: asset directories, manifest files, and pre-processor engines.
- With the asset pipeline, in production all the application stylesheets get rolled into `application.css`, all the application JavaScript code gets rolled into `javascripts.js`, and all such files (including those in lib/assets and vendor/assets) are minified.


## Asset Pipeline: Asset Directories
- `app/assets`: assets specific to the current application.
- `lib/assets`: assets for libraries written by your dev team.
- `vendor/assets`: assets from third-party vendors.


## Asset Pipeline: Manifest Files
- Once the assets are in their logical locations, you can use manifest files to tell Rails (via the Sprockets gem) how to combine them to form single files. 
- This applies to CSS and JavaScript but not to images.
- `/app/assets/stylesheets/application.css`
	- `*= require_tree .`: ensures that all CSS files in the current directory (including the tree subdirectories) are included into the application CSS.
	- `*= require_self`: specifies where in the loading sequence the CSS in `application.css` itself gets included.

```css
/*
 *= require_self
 *= require_tree .
 */
```


## Asset Pipeline: Preprocessor Engines
- We tell Rails which processor to use using filename extensions.
- The preprocessor engines can be chained, with the code running from right to left.
- This is achieved with the correct file extensions.

```
foobar.js.coffee -- run through CoffeeScript processor
foobar.js.erb.coffee -- run through CoffeeScript and ERb
```


# Rails Server Request Handling
- Browser => Web Server => Public => Rails Framework
- If the request is satisfied by the public static file the Rails framework would not be accessed.


# Rails Routes
- Rails Routing => Controller => Model => Database => Controller => View
- To see all of the active routes in the app use `rake routes` command
- Routes are processed top-top-bottom in the `routes.rb` file.
- Basic route types:
  - Simple route (match route)
  - Default route
  - Root route
  
```bash
rake routes
```


## Simple, Match Route
- Matching the string and sends it to the controller and action via get.
- Not very flexible.
- This also creates a named routes for use in controllers and views: `about_path` and `about_url`.
	- For most app link use `path`.
	- For redirects use `url`.

```ruby
get "demo/index"
```

```ruby
match "demo/index", :to => "demo#index", :via => :get
match '/about', to: 'static_pages#about', via : 'get'
```


## Default Route
- More generic routing rule.
- Uses a Regex match function.
- Can also pass a format for file type (json, xml etc.)

```ruby
:controller/:action/:id
match ':controller(/:action(/:id))', :via => :get
```

```ruby
match ':controller(/:action(/:id(.:format)))', ;via => :get
```


## Root Route
- When you go to the root of the application and have nothing to match.
- Homepage of the application.
- Use the `root` method.

```ruby
root :to => "demo#index"
root "demo#index"
root 'static_pages#home'
```



# Models
- Communicates and abstracts the database.
- Solves the persistence problem.

```bash
rails generate controller Users new
rails generate controller Users new --no-test-framework
rails generate model User name:string email:string
```


## Migrate File
- Migrations provide a way to alter the structure of the database incrementally, so that our data model can adapt to changing requirements.
- Migration file is prefixed by a timestamp based on when the migration was generated.
- `/db/migrate/[timestamp]_create_users.rb`
- The migration consists of a `change` method that determines the change to be made to the database.
- `t.timestamps`: is a special command that creates two columns called `created_at` and `updated_at`, which are timestamps that automatically record when a given user is created and updated.
- We can run the migration, known as “migrating up”, using the rake command.
- Most migrations are reversible, which means we can “migrate down” and undo them with a single Rake task, called `db:rollback`.
- `rake test:prepare`: ensures that the data model from the development database, `db/development.sqlite3, is reflected in the test database `db/test.sqlite3`, assuming that SQLite is used locally.


```ruby
class CreateUsers < ActiveRecord::Migration
  def change
	create_table :users do |t|
	  t.string :name
	  t.string :email

	  t.timestamps
	end
  end
end

```

```bash
bundle exec rake db:migrate
bundle exec rake db:rollback
```

```bash
bundle exec rake test:prepare
```


## Model File
- Model files are stores in `app/models/`.
- `User.new`: creates a new user object.


```ruby
user1 = User.new(name: "John Doe", email: "jd@email.com")
user1.save
user1.name 			#=> "John Doe"
user2 = User.create(name: "Jane Doe", email: "janed@mail.com")
user1.destroy
```

```ruby
User.find(1)
User.find_by_email("jd@email.com")
User.find_by(email: "jd@email.com")  # Rails 4.0 preferred method
```

```ruby
User.first
User.all
User.count
```

```ruby
user1
user1.email = "test@test.com"
# user1.reload.email
user1.save
```

```ruby
user2.update_attributes(name: "Jenny Doe", email: "jend@mail.com")
user2.update_attribute(:name, "Jane Doe")
```

## Validations: Presence
- Checks if the data entered is not blank.

```ruby
#/app/models/user.rb
validates :name, presence: true
```

```ruby
user.valid?
user.errors.full_messages
```

## Validations: Length
- Checks the length of the entered data.
- Using the `:length` and the `:maximum` parameters.

```ruby
#/app/models/user.rb
validates :name, length: { maximum: 50 }
```

## Validations: Pattern
- Checks if the input matches a certain pattern.
- Uses RegEx for pattern matching.

```ruby
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
```

## Validations: Uniqueness
- Checks whether the input is already entered in the database.
- Can pass an optional `case_sensitive` parameter.

```ruby
validates :email, presence: true, uniqueness: true
validates :email, presence: true, uniqueness: { case_sensitive: false}
```

## Password
- Use `bcrypt-ruby` gem for password hashing.
- Add `password_digest` column to the table.
- Use the `has_secure_password` function.

```ruby
#Gemfile
gem 'bcrypt-ruby', '3.1.2'
```

```bash
bundle install
rails generate migration add_password_digest_to_users password_digest:string
bundle exec rake db:migrate
bundle exec rake test:prepare
```

```ruby
#/app/models/user.rb
has_secure_password
```

# Controller

```ruby
def show
	@user = User.find(params[:id])
end
```