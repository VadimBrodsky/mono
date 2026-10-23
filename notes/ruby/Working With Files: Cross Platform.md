# Working With Files: Cross Platform

- File path separators
  ** Unix, Linux, Mac path separator: `/`
  ** Windows path separator: `\`
  ** The `File.join()` method avoids the OS differences.
- File permissions
  ** `chmod`: change permissions on unix.
  ** `chown`: change owner on unix.

```ruby
File.join('path', 'to', 'folder', 'file.rb')

# Starting with a blank '' will create a path
File.join('', 'Users', 'vadim', 'Desktop', 'rube_files')
```
