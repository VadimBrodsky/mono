# Running Migration

- Need to run the migration in order to implement the changes in the [migration file](<Migrate File.md>).
- Rails will run all of the migration what were not yet run.
- Most migrations are reversible, which means we can “migrate down” and undo them with a single Rake task, called `db:rollback`.

Migrate up:

```bash
rake db:migrate
```

Migrate down to specific version:

```bash
rake db:migrate VERSION=0
rake db:migrate VERSION=20141110121423
```
