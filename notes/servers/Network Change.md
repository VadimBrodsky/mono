# Biggie 

new IP `10.53.1.160`
address https://10.53.1.160:8006

```
vi /etc/networks/interfaces
vi /etc/hosts
systemctl restart networking
```

# PBS

new IP `10.53.1.161`
address https://10.53.1.161:8007

```
vi /etc/networks/interfaces
vi /etc/hosts
/etc/resolv.conf
```

# Unraid 

new IP `10.53.1.162`
address http://10.53.1.162

```
vi /boot/config/network.cfg
```

## Portiner

```
export PORTAINER_LICENSE_KEY=3-kQ9JgwETfQp7l/1zKj8a1pnkwQLGl3R6Wez6aWT3kEl6Xnmk2TV5AMxNAOS32DXfIDJ00ZHN/t+PthNI
docker-compose up -d
```