# Install RTL-SDR on Linux (Ubuntu 24.04)

https://www.rtl-sdr.com/rtl-sdr-quick-start-guide/


1. Purge the previous driver (???):
```
sudo apt purge ^librtlsdr
sudo rm -rvf /usr/lib/librtlsdr* /usr/include/rtl-sdr* /usr/local/lib/librtlsdr* /usr/local/include/rtl-sdr* /usr/local/include/rtl_* /usr/local/bin/rtl_* 
```

2. Install the latest drivers:
```
sudo apt-get install libusb-1.0-0-dev git cmake pkg-config
git clone https://github.com/osmocom/rtl-sdr
cd rtl-sdr
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON
make
sudo make install
sudo cp ../rtl-sdr.rules /etc/udev/rules.d/
sudo ldconfig
```

3. Blacklist the DVB-T TV drivers.
```
echo 'blacklist dvb_usb_rtl28xxu' | sudo tee --append /etc/modprobe.d/blacklist-dvb_usb_rtl28xxu.conf
```

4. Reboot


## Ubuntu 22.10 notes
```
sudo apt install librtlsdr-dev librtlsdr2 rtl-433 rtl-sdr soapysdr0.8-module-rtlsdr welle.io
```
