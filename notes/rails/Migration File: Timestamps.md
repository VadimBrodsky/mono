# Migration File: Timestamps

- `t.timestamps`: is a special command that creates two columns called `created_at` and `updated_at`, which are timestamps that automatically record when a given user is created and updated.
- Rails has special columns for creation and updates.
- Rails automatiaclly populates and updates these columns.

```ruby
t.datetime "created_at"
t.datetime "updated_at"
```

The shorthand for these columns:

```ruby
t.timestamps
```
