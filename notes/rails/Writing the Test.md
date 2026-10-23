# Writing the Test

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
