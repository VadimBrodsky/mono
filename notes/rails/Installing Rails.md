# Installing Rails

# Installing Rails
# Install Bundler gem first.
# Rehash the rbenv environment to load bundler.
# Install the Rails gem.
#* Optionally install without docs: `--no-ri --no-rdoc`
#* Install a specific version: `--version 4.0.0`
# Install the MySQL gem.

```bash
gem install bundler
rbenv rehash
bundle -v
gem install rails
rbenv rehash
rails -v
gem install mysql2
```
