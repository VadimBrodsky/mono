# ERb Debug Information

- Add this to the view template to see debug info.

```erb
<%= debug(params) if Rails.env.development? %>
```
