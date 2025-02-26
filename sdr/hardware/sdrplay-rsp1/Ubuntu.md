# Install SDRplay RSP1 on Linux (Ubuntu 22.04)

Based on:
- https://www.radiosrs.net/installing_drivers_sdrplay_and_HackRF_Ubuntu.html
- https://github.com/f4exb/sdrangel/wiki/Note-on-SDRPlay-RSP1-on-Linux
- https://www.sdrplay.com/docs/SDRplay_RSP_TCP_Server_Guide.pdf

## Simple way
<span style="color:red;font-weight:bold">You do this at your own risk!</span>  
Use script `sudo ubuntu_install.sh`

## Manual approach
### Prerequisties
- Installed rtl-sdr and so on...  
- 22.04 `apt install -y libusb-1.0-0 libusb-1.0-0-dev libfftw3-3 libfftw3-dev`
- 24.10 `apt install -y libusb-1.0-0 libusb-1.0-0-dev libfftw3-bin libfftw3-dev`

- Udev rules  
Create a new file:
`sudo vim /etc/udev/rules.d/xx-****.rules`  
Paste this line into `rules` file:
`SUBSYSTEM=="usb",ENV{DEVTYPE}=="usb_device",ATTRS{idVendor}=="1df7",ATTRS{idProduct}=="2500",MODE:="0666"`  
Save the file.  
Once this file is in place you should reset the udev system by typing:  
`sudo service udev restart`

- Modules  
Edit /etc/modprobe.d/blacklist.conf (or other) and add:  
    ```
    blacklist sdr_msi3101
    blacklist msi001
    blacklist msi2500
    ```
    then run:
    ```
    sudo rmmod msi001 msi2500
    sudo systemctl restart systemd-modules-load.service
    ```

### SDRplay API Installation
Download API 3.07 or later, RSP Control Library + Driver from https://www.sdrplay.com/downloads/ (SDRplay_RSP_API-Linux-3.xx.x.run)

`cd ~/Downloads` # or wherever you downloaded the file
`wget https://www.sdrplay.com/software/SDRplay_RSP_API-Linux-3.15.2.run`
`chmod 755 SDRplay_RSP_API-Linux-3.xx.x.run`  
`sudo ./SDRplay_RSP_API-Linux-3.xx.x.run`  
`sudo ldconfig`  

To stop and start the API service, use the following commands...  
`sudo systemctl stop sdrplay`  
`sudo systemctl start sdrplay`  

Type `lsusb` and `Bus 001 Device 003: ID 1df7:3000` should be displayed.


### SoapySDR
```
cd ~/
git clone https://github.com/pothosware/SoapySDR.git
cd SoapySDR
mkdir build
cd build
cmake ..
make -j4
sudo make install
sudo ldconfig
```

### Soapy SDRPlay
```
cd ~/
git clone https://github.com/pothosware/SoapySDRPlay.git
cd SoapySDRPlay
mkdir build
cd build
cmake ..
make -j4
sudo make install
sudo ldconfig
```
Check:
```
SoapySDRUtil --info
SoapySDRUtil --check=sdrplay
```

### RSPTTCPServer
```
git clone https://github.com/SDRplay/RSPTCPServer.git
cd RSPTCPServer
mkdir build
cd build
cmake ..
make
sudo make install
```
Run server:
```
rsp_tcp -E -a 0.0.0.0
```