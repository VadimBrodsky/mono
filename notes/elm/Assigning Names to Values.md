- Normally, once we assign a name to a value, that name cannot be reassigned later to a different value in the same scope.
- Assignment in Elm works like the JavaScript `const` keyword.
- The only exception is the [Elm Repl](Elm%20Repl.md) where you can override a previous assignment.
- You can assign names not only to literal values but also to expressions.

#### Naming conventions
- The name must begin with a lowercase letter, after that it can be a mix of letters, numbers, and underscores.
- By convention, all letters should be in one uninterrupted sequence.
	- Acceptable: `map4`
	- Unacceptable: `map4ever`
  - Never use `snake_case` or `SCREAMING_SNAKE_CASE` to name values, use `camelCase` instead.