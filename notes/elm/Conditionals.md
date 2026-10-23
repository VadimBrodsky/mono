- You write `/=` instead of `!==`.
- To negate values, use [[Elm]]'s [[not function]] instead of the JavaScript `!` prefix.
- All of the other logical operators are follow JavaScript.

```elm
1 + 1 == 2           -- True : Bool
1 + 1 /= 2           -- False : Bool
not (1 + 1 == 2)     -- False : Bool
pi <= 0 || pi >= 10  -- False : Bool
3 < pi && pi < 4     -- True : Bool
```