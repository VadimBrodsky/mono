When writing a multiline literal the convention in [[Elm]] is to write trailing commas in front. This helps avoiding simple mistakes as forgetting a comma would still yield valid Elm code but with undesired logic.

```elm
rules = [
    rule "Do not talk about Sandwitch Club."
    , rule "Do NOT talk about Sandwitch Club."
	, rule "No earing in the common area."
]
```

It may feel different at first, but the comma-first style gives you one less potential error to worry about  once you get used to it.