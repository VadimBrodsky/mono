## Node expands JavaScript

- Better ways to organize code into reusable pieces
- Ways to deal with files and IO
- Ways to deal with databases
- Ability to communicate over HTTP
- Ability to accept requests and send responses
- Way to deal with work that takes a long time


## Modules Exports and Require

- Node uses Common JS modules
- All modules in Node get wrapped in IIFE functions, that get `require` and `module` as parameters
- The authored code is a the body of that function
- `require` is a function, that you pass a path to
- `module.exports` is what the require function returns
- `module.exports` cannot be referenced to something else, but can be mutated
- Node supports ES2015 modules as well


Node modules are wrapped in IIFE functions:

```javascript
(function (exports, require, module, __filename, __dirname) {
  var greet = function() {
    console.log('hello');
  };

  module.exports = greet;
});
```

And executed:

```javascript
fn(module.exports, require, module, filename, dirname);
```

Requiring native modules:

```javascript
const util = require('util');   // native modules do not need relative path

var name = 'Jon Snow';
ver greetng = util.format('You know nothing, %s', name);
util.log(greeting);
```

Using ES2015 modules in Node

```javascript
// greet.js
export function greet() {
  console.log('hello');
}

// app.js
import * as greetr from 'greet';
greet.greet();
```


## Events and Event Emitter

- Event: something that has happened in our app that we can respond to.
- Node has 2 different kinds of events
  - System events - from C++ Core (`libuv`)
  - Custom events - from JavaScript Core (Event Emitter)
- System events often trigger JavaScript events



## Error-First Callback

Callbacks take an error object as their first parameter.

- `null` if no error, otherwise will contain an object defining the error.
- This is a standard so we know in what order to place the parameters in the callbacks.

```javascript
doSomethingAsync(function(err, data){
  // callback
});
```


## Pipe

Connecting two separate streams by writing to one stream what is being read from another. For example, piping from a readable stream to a writable stream.
