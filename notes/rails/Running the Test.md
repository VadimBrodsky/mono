# Running the Test

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
