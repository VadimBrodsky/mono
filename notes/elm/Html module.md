In [Elm](Elm.md), we usually describe a "Virtual DOM node", as `Html` for short. This name comes from the `Html` module.

When describing how a page looks in [Elm](Elm.md), we don't write markup. Instead we call functions to create representations of [DOM Nodes](../DOM/Nodes.md). 

The most flexible of the Html function is the `node`. It's argument line up neatly with the analogous  markup.

```elm
--   <button class="funky" id="submitter">Submit</button>
node "button" [ class "funky", id "submitter" ] [ text "Submit"]
```

- A call to the `node` function passing 3 arguments: the string `"button"`, a list of attributes and a list of child nodes.
- A call to the `class` function, passing `"funky"`.
- A call to the `id` functions, passing `"submitter"`.
- A call to the `text` function, passing `"Submit"`.

The `Html` module provides a variety of intuitively named functions that let you avoid calling `node` directly:

```elm
node "img" [ src "logo.png" ] []   -- using the node function
      img  [ src "logo.png" ] []   -- using the img function
```

It's a best practice to use functions like `img`  as much as possible, and fall back to `node` only when no alternative is available.

- A list of attributes - if an element has no attributes, we pass `[]`
- A list of child DOM nodes - if an element has no children, we pass `[]`
- If an element has no attributes and no children we pass `[] []`

```elm
h1 [] [ text "Photo Groove"]
img [ src "1.jpeg"] []
br [] []
```