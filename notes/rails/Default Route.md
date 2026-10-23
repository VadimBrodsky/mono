# Default Route

- More generic routing rule.
- Matches to contollers, actions and ids - `GET /students/edit/52`
- Uses a Regex match function.
- Can also pass a format for file type (json, xml etc.)
- No longer considered a best practice.

```ruby
:controller/:action/:id
match ':controller(/:action(/:id))', :via => :get
```

```ruby
match ':controller(/:action(/:id(.:format)))', ;via => :get
```
