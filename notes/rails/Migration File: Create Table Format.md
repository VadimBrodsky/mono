# Migration File: Create Table Format

## Generic:

```ruby
create_table "table" do |t|
  t.column "name", :type, options
  t.type "name", options
end
```

## Long Form:

```ruby
create_table :users do |t|
  t.column "first_name", :string
end
```

## Short Form:

```ruby
create_table :users do |t|
  t.string :name
```
