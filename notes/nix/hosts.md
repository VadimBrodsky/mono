# Start Rails Server on a Domain Mapped in Hosts File


## Edit Hosts File

1. `vim nano /etc/hosts/`
2. Add line `127.0.0.1 www.example.com`
3. Refresh DNS setting with `sudo dscacheutil -flushcache`


## Start rails on the correct port

`rails s` will work with `http://www.example.com:3000`, to map to `80` start rails with `sudo rails s --port=80`
