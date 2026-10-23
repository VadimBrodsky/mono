# Asset Pipeline: Preprocessor Engines

- We tell Rails which processor to use using filename extensions.
- The preprocessor engines can be chained, with the code running from right to left.
- This is achieved with the correct file extensions.

```
foobar.js.coffee -- run through CoffeeScript processor
foobar.js.erb.coffee -- run through CoffeeScript and ERb
```
