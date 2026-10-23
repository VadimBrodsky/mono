## Installing MySQL
- Option 1: From the [MySQL website](http://dev.mysql.com/downloads/mysql/).
- Option 2: From Homebrew.

```bash
brew install mysql
```

## Post Install
- To launch at login: `ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents`
- To load now, without restart: `launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist`


## Control MySQL
- To start, stop, restart and see status:

```bash
mysql.server start
mysql.server stop
mysql.server restart
mysql.server stop
```


## Connect to MySQL
- To connect to the database from the command line.
- To exit from MySQL run: `exit`.

```bash
mysql -u root
mysql -u -p root
```


## Setting the Password
- Setting the password for the `root` user.

```bash
mysqladmin -u root password
mysqladmin -u -p root password
```