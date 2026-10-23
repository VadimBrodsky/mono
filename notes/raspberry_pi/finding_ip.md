# Finding the IP of the Raspberry PI on the Network

Based on the Raspberry PI [Remote Access docs](https://www.raspberrypi.org/documentation/remote-access/ip-address.md)

## Using NMAP

```bash
hostname -I             # find out the ip address
```

```bash
nmap -sn 10.0.9.0/24    # scan the whole subnet
```

