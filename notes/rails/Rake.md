# Rake

- Rake is a simple Ruby helper program.
- Performs tasks by running scripts.
- Similar  to Unix's make program.

```base
rake command
```

To get a list of all the available Rake commands run:

```bash
rake -T
rake -T db # only the database tasks
```

Rake can also accept [Rails Environments](<Rails Environments.md>) variables:

```bash
rake db:schema:dump RAILS_ENV=production
```
