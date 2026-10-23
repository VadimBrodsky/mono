# Root Route

- When you go to the root of the application and have nothing to match.
- Homepage of the application.
- Use the `root` method.

```ruby
root :to => "demo#index"
root "demo#index"
root 'static_pages#home'
```
