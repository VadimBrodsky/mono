To render an [[Elm]] application into part of the page.

```html
<head>
  <link rel="stylesheet" href="main.css">
  <script src="elm.js"></script>
</head>
<body>
  <div id="app"></div>
  <script>
    Elm.Main.init({ node: document.getElementById('app') });
  </script>
</body>
```