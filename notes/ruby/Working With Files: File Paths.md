# Working With Files: File Paths

- Absolute path: `/path/to/file`
- Relative path: `./../../path/to/file`
- Ruby Special variable `__FILE__`: the name of the file that we are in right now.
- To get the absolute path use `File.expand_path()`.

```ruby
File.expand_path(__FILE__) 		# Absolute file path
File.dirname(__FILE__) 			# File directory
```

```ruby
# go up one directory with relative paths
puts File.join(File.dirname(__FILE__), '..', "Folder\ With\ Spaces")
```
