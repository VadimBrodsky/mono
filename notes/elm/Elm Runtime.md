The [[Elm]] runtime is handling:
- Adding and removing event listeners for any events our code depends on.
- Stores and manages application state.
- Use the [Elm](Elm/Elm.md) runtime to bind to existing HTML and allowing [Incremental adoption](Elm/Incremental%20adoption.md).
 
## Virtual DOM
The `view` builds fresh `Html` values after every `update`. [[Elm]] does not actually re-create the entire [[DOM]] structure of the page every time. Instead it compares the `Html` it got this time to the `Html` it got the last time and updated only the parts of the page that are different between the two requested representations.

- Updates are batched to avoid expensive repaints and layout reflows.
- Application sate is far less likely to get out of sync with the page.
- Replying application state changes effectively replays user interface changes.