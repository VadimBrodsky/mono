# Rails Parameters

Use the [params hash](<params hash.md>) to access the passed parameters.

```ruby
{ :controller => 'demo',
  :action => 'hello',
  :id => 1,
  :page => 3,
  :name => 'vadim' }
```

The `id` is special because is is part of the [Default Route](<Default Route.md>) and positioned on the right side of the `?`.
