- When creating an [Elm](Elm.md) project a main module must be created as the entry point.
- We are exposing only a specific top-level value - `main` for other modules to import
- Only exposed values can be accessed by other modules.
- As a general rule, its best for our modules to expose as little as possible.

```elm
module PhotoGroove exposing (main)
```

Future modules in out project will be able to import this `PhotoGroove` module just as they would `String` or `Html`

```elm
import PhotoGroove exposing (main)
```

There are several ways of importing modules into your code:
1. Qualified style - we included the module name right in the function call.
2. Unqualified style - we included an import declaration that exposed the elements directly into the global scope of our module, allowing to use these functions without the module prefix.
  -  Using `exposing (..)` means expose everything

```elm
-- Qualified style
import Html
div = Html.div

-- Unqualified style
import Html exposing (div, h1, img, text)
```

Downsides of Unqualified Imports
- Unqualified names can become ambiguous.
- Unqualified imports are less self-documenting

```elm
import String exposing (..)
import List exposing (..)

reverse   -- this blows up becasue of ambiguous name
```

Its a best practice to write things in a qualified way by default.