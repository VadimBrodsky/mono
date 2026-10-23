At the top level of a typical [Elm](Elm.md) application is a single view function, which accepts our current [[model]] as an argument and then return some `Html`. 

The [Elm Runtime](Elm%20Runtime.md) takes the `Html` returned by the view function and alters the page's actual [DOM](DOM) to match it.

The view function is often uses many helper functions, which help it do its job.