# Controller Redirecting Actions

The controller can redirect instead of rendering a view. 

This will send a request to a different controller and action. To do this rails uses a [HTTP redirect](<HTTP redirect.md>) that will change the address of the page, and will initiate a new request to the server.

This is done via the redirect_to action:

[redirect_to method](<redirect_to method.md>)
