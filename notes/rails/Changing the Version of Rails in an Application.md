# Changing the Version of Rails in an Application

To change the version of rails:

- Generate a new app with `new`.
- Change the Rails gem version in the `Gemfile`.
- Run `rake rails:update`.
- Overwrite the conflicting files.

```bash
rails new my_app
bundle install
rake rails:update
```
