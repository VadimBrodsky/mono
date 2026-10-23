# Installing raspi-config Utility on other Linux Distros

Based on [snubbergbg](https://github.com/snubbegbg/install_raspi-config)

```bash
cd /tmp
wget http://archive.raspberrypi.org/debian/pool/main/r/raspi-config/raspi-config_20150131-5_all.deb
sudo apt-get install libnewt0.52 whiptail parted triggerhappy lua5.1
sudo dpkg -i raspi-config_20121028_all.deb
```
