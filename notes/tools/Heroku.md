- [Getting Started with Ruby on Heroku](https://devcenter.heroku.com/articles/getting-started-with-ruby#introduction)
- [Heroku Developer Center](https://devcenter.heroku.com/)
- [Heroku CLI Commands](https://devcenter.heroku.com/articles/heroku-command)
- [Managing SSH keys](https://devcenter.heroku.com/articles/keys)

## Adding The Heroku Gems
- Add to the Gemfile
- Update with Bundler

```ruby
group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end
```

```bash
bundle install --without production
git commit -a -m "Update Gemfile.lock for Heroku"
```


## Logging in to Heroku

```bash
heroku login
```


## Creating a New App

```bash
heroku create
```


## Deploying to Heroku

```bash
git push heroku master
```

## Migrate the Database on Heroku

```bash
heroku run db:migrate
```


## Renaming the Heroku App Domain

```bash
heroku rename new-name
```


## Opening the App in the Browser

```bash
heroku open
```

## Viewing the Logs

```bash
heroku logs
```

## Console

```bash
heroku run console
```