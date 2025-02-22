# Install SDRplay RSP1 on Linux (Ubuntu)

Based on:
- https://www.radiosrs.net/installing_drivers_sdrplay_and_HackRF_Ubuntu.html
- https://github.com/f4exb/sdrangel/wiki/Note-on-SDRPlay-RSP1-on-Linux

## Prerequisties
- Installed rtl-sdr and so on...  
`sudo apt install libusb-1.0-0 libusb-1.0-0-dev libfftw3-3 libfftw3-dev`

- Udev rules  
Create a new file:
`sudo featherpad /etc/udev/rules.d/xx-****.rules`  
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

## SDRplay API Installation
Download API 3.07 or later, RSP Control Library + Driver from https://www.sdrplay.com/downloads/ (SDRplay_RSP_API-Linux-3.xx.x.run)

`cd ~/Downloads` # or wherever you downloaded the file  
`chmod 755 SDRplay_RSP_API-Linux-3.xx.x.run`  
`sudo ./SDRplay_RSP_API-Linux-3.xx.x.run`  
`sudo ldconfig`  

To stop and start the API service, use the following commands...  
`sudo systemctl stop sdrplay`  
`sudo systemctl start sdrplay`  

Type `lsusb` and `Bus 001 Device 003: ID 1df7:3000` should be displayed.


## Build SoapySDR
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
### Install the Soapy SDR module for SDRPlay
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
Type these commands. If your SDR is listed, the hardest work is done!
```
SoapySDRUtil --info
SoapySDRUtil --probe="driver=sdrplay"
```
...to check 
