# params hash

- The `params` hash contains all GET and POST variables, including controller and action as set in [Rails Parameters](<Rails Parameters.md>).
- The 'params' hash is a HashWithIndifferentAccess.
- Parameters are always strings, if numbers are needed an explicit conversion must be done: `@page.to_1`

It is primarily used in the controller:

```ruby
def hello
  @id = params['id'].to_i
  @page = params[:page].to_i
end
```
