Like JavaScript ternaries, Elm if-expression require 3 ingredients:
1. A condition
2. A branch to evaluate if the condition passes
3. A branch to evaluate otherwise

Each part must be an expression, and if the whole if-expression evaluates to the result of whichever branch got evaluated. You get an error if any of the 3 parts is missing, make sure to specify an `else`  branch every time.

```elm
if elfCount == 1 then
  "elf"
else
  (if elfCount >= 0 then "elves" else "anti-elves")
```

same as:
```elm
if elfCount == 1 then
  "elf"
else if elfCount >= 0 then
  "elves"
else
  "anti-elves"
```
This works because the `else` branch of an if-expression must be an expression, and expressions are expressions themselves.