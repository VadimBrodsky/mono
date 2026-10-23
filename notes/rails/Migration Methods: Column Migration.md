# Migration Methods: Column Migration

## Add column
- Takes the long-form [column format](<Migration File: Create Table Format.md>).

```ruby
add_column(table, column, type, options)
```

## Remove Column:

```ruby
remove_column(table, column)
```

## Rename Column:

```ruby
rename_column(table, column, new_name)
```

## Change Column:
- This will overwrite any previously set types or options.

```ruby
change_column(table, columns, type, options)
```
