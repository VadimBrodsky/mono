# Creating a New MySQL User

It's a bad practice to use the root database user for the applicaiton. Create an app user name instead.

This will create the user and will grant privileges.

```SQL
GRANT ALL PRIVILEGES ON db_name.*
TO 'username'@'localhodt'
IDENTIFIED BY 'password';
```

To verify:

```sql
SHOW GRANTS FOR 'username'@'localhost';
```
