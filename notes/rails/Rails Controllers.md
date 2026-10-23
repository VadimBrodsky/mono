# Rails Controllers

When the action is empty Rails will render the corresponding view by default. This action can by specified explicitly by the [Controller Action to Render Template](<Controller Action to Render Template.md>)

```ruby
def hello
end
```

```ruby
def show
  @user = User.find(params[:id])
end
```
