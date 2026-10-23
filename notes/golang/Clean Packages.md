## Hide Internal Logic

If you're familiar with the pillars of OOP, this is a practice in _encapsulation_.

We create an API by only exposing the function(s) that the application-level needs to know about. All other logic is unexported to keep a clean separation of concerns. The application doesn’t need to know how to classify an image, just the result of the classification.

## Don't Change APIs

The unexported functions within a package can and should change often for testing, refactoring, and bug fixing.

A well-designed library will have a stable API so that users aren’t receiving breaking changes each time they update the package version. In Go, this means not changing exported function’s signatures.

## Don't Export Functions from the Main Package

A `main` package isn't a library, there's no need to export functions from it.

## Packages Should Not Know About Dependents

Perhaps one of the most important and most broken rules is that a package shouldn’t know anything about its dependents. In other words, a package should never have specific knowledge about a particular application that uses it.
