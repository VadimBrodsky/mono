# Generating Models

- To generate a [Rails model](<Rails Models.md>) run the [Rails Generate](<Rails Generate.md>) command.
- Model names are written in singular camel-case `ModelName`
- This will create a [migration file](<Migrate File.md>) in `db/migrate` 
  ** File name `date_create_users.rb`.
  ** Class name for the migration `CreateUsers` 
  ** Inherit from `ActiveRecord::Migration`
- Also creates a model file in `app/models`
  ** File name `user.rb`
  ** Class name `User`
  ** Inherits from [ActiveRecord::Base](<ActiveRecord::Base.md>)
- Migration names and classes are plular while Models are singular.
- File names, class names, and table names matter.

```bash
rails generate model User
```

The datbase [column](<../databases/DB Terms: Column.md>) definitions can also be specified:

```bash
rails generate model User name:string email:string
```
