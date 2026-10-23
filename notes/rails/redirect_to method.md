# redirect_to method

A controller method that is used to redirect pages:

```ruby
def other_hello
  redirect_to(:controller => 'demo', :action => 'index')
end
```

A Rails default debaviour is to assume that the action will be in the same controller if the `:controller` portion is unspecified.

```ruby
def other_hello
  redirect_to(:action => 'index')
end
```

Can also work with urls:

```ruby
def other_hello
  redirect_to("http://www.example.com")
end
```
