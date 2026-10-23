# ERb Helper: Image_Tag

- Rails helper `image_tag` creates an `img` tag.
- Rails will always include an `alt` attribute even if one wasn't given, using the filename.
- Rails knows to look for images in the `/app/assets/images/` folder.
- `<%= image_tag("file_name.jpg", options: "hash") %>`

```erb
<%= image_tag("rails.png", alt: "Rails") %>
<%= link_to image_tag("rails.png", alt: "Rails"), 'http://rubyonrails.org/' %>
```
