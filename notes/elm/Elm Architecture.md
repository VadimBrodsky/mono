A data flow architecture that [[Elm]] uses. The [[Elm Runtime]] is optimized for applications to follow it.
- [View function](View%20function.md)
  
## Model
Storing the application state outside of the [DOM](DOM), and propagate changes from that independent state over to the [DOM](DOM) as necessary.
  
The model represents the state of an [Elm](Elm.md) application.
  
```elm
urlPrefix =
"http://elm-in-action.com/"

view model =
div [ class "context" ]
	[ h1 [] [ text "Photo Groove" ]
	, div [ id "thumbnails" ] (List.map viewThumbnail model)
	]

viewThumbnail thumb =
img [ src (urlPrefix ++ thumb.url) ] []

main =
view initialModel

initialModel =
[ { url = "1.jpeg" }
, { url = "2.jpeg" }
, { url = "3.jpeg" }
]
```

## Update
An `update` function translates messages into our desired model. A message is a value used to pass information from part of the system to another. Update messages are often sent as a response to a user's actions
  
A message should describe what happened, for example "the user clicked a photo".

If we receive an unrecognized message in an update function, we return the original model. Whatever else happens the `update` function must always return a new model, even if it happens to be the old model.
  
```elm
update msg model =
  if msg.description == "ClickedPhoto" then
	  { model | selectedUrl = msg.data }

  else
	  model
```
To interact with browser events need access to the `Browser` module:
```elm
import Browser

main =
  Browser.sandbox
	  { init = initialModel  -- a value that can anything
	  , view = view          -- a function that takes a model and returns an Html node
	  , update = update      -- a function that takes a message and return a new model
	  }
```