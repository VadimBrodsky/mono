# Simple Route

- Also called the *Match Route*.
- Matching the string and sends it to the controller and action via get.
- Not very flexible.
- This also creates a named routes for use in controllers and views: `about_path` and `about_url`.
  * For most app link use `path`.
  * For redirects use `url`.

```ruby
# short form
get "demo/index"
```

```ruby
# long form
match "demo/index", :to => "demo#index", :via => :get
match '/about', to: 'static_pages#about', via : 'get'
```
