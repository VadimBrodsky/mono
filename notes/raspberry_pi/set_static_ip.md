# Setting a Static IP on the Raspberry PI

Based on the Stack Overflow [Answer](http://raspberrypi.stackexchange.com/questions/37920/how-do-i-set-up-networking-wifi-static-ip) and on [Circuit Basics Article](http://www.circuitbasics.com/how-to-set-up-a-static-ip-on-the-raspberry-pi/)

1. Find out the default gateway IP - `route -ne`
2. Find out the IP address of the domain name servers - `cat /etc/resolv.conf`
3. Edit the network configuration file

```bash
# /etc/dhcpd.conf

interface eth0
static ip_address=10.0.9.99
static routers=10.0.9.1
static domain_name_servers=10.0.9.1
```

4. reboot the PI - `sudo reboot`
5. test internet connection - `ping www.google.com`

