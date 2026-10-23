# Migration File: Primary Key

- Rails automatically adds an `id` -- primary key to all tables by default.
- Its auto-incrementing.
- To turn off this default -- pass an option:

```ruby
crate_table :users, {:id => false} do |t|
  ...
end
```
