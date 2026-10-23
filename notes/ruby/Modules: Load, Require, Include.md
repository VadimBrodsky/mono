# Modules: Load, Require, Include

- Modules are usually kept in separate files.
- Modules can be serves as code libraries.
- Need to have a way to load modules and files into other Ruby files.
- `load`: loads a source file every time it is called, returns `true` if the file loaded successfully.
- `require`: loads a source file only once, keeps track of the file and will not load it again.
- `include`: uses exclusively for including module mixins, nothing to do with files.

```ruby
load 'contact_info.rb' 		# loading a dependency
```
