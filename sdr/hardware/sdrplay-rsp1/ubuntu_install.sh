#!/bin/bash

SDRPLAY_API_VERSION=3.15.2

if ! [ -x "$(command -v lsb_release)" ]; then
    echo "Command 'lsb_release' not found"
    exit 1
fi

if [ `lsb_release -is` != 'Ubuntu' ]; then
    echo The script only works for Ubuntu
    exit 1
fi

(lsusb | grep SDRplay) && echo "ERROR: Disconnect SDRplay from USB" && exit 1



update_udev_rules() {
    filename=$1
    cat > $filename <<- EOM
SUBSYSTEM=="usb",ENV{DEVTYPE}=="usb_device",ATTRS{idVendor}=="1df7",ATTRS{idProduct}=="2500",MODE:="0666"
SUBSYSTEM=="usb",ENV{DEVTYPE}=="usb_device",ATTRS{idVendor}=="1df7",ATTRS{idProduct}=="3000",MODE:="0666"
SUBSYSTEM=="usb",ENV{DEVTYPE}=="usb_device",ATTRS{idVendor}=="1df7",ATTRS{idProduct}=="3010",MODE:="0666"
SUBSYSTEM=="usb",ENV{DEVTYPE}=="usb_device",ATTRS{idVendor}=="1df7",ATTRS{idProduct}=="3020",MODE:="0666"
SUBSYSTEM=="usb",ENV{DEVTYPE}=="usb_device",ATTRS{idVendor}=="1df7",ATTRS{idProduct}=="3030",MODE:="0666"
SUBSYSTEM=="usb",ENV{DEVTYPE}=="usb_device",ATTRS{idVendor}=="1df7",ATTRS{idProduct}=="3050",MODE:="0666"
SUBSYSTEM=="usb",ENV{DEVTYPE}=="usb_device",ATTRS{idVendor}=="1df7",ATTRS{idProduct}=="3060",MODE:="0666"
EOM
    service udev restart
}

update_modprobe_blacklist() {
    filename=$1
    cat > $filename <<- EOM
blacklist sdr_msi3101
blacklist msi001
blacklist msi2500
EOM
    (lsmod | grep -x '^msi001 .*') && (rmmod msi001)
    (lsmod | grep -x '^msi2500 .*') && (rmmod msi2500)
    systemctl restart systemd-modules-load.service
}

install_sdrplay_api() {
    filename=SDRplay_RSP_API-Linux-$SDRPLAY_API_VERSION.run
    rm -rf $filename \
    && wget https://www.sdrplay.com/software/$filename \
    && chmod 755 $filename \
    && ./$filename \
    && ldconfig \
    && systemctl stop sdrplay \
    && systemctl start sdrplay
}

install_soapy_sdr() {
    rm -rf SoapySDR \
    && git clone https://github.com/pothosware/SoapySDR.git \
    && cd SoapySDR \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j4 \
    && make install \
    && cd ../.. \
    && ldconfig
}

install_soapy_sdr_play() {
    rm -rf SoapySDRPlay \
    && git clone https://github.com/pothosware/SoapySDRPlay.git \
    && cd SoapySDRPlay \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j4 \
    && make install \
    && cd ../.. \
    && sudo ldconfig
}

check_driver() {
    echo Check driver exists
    SoapySDRUtil --check=sdrplay
}

install_rsptcp_server() {
    rm -rf RSPTCPServer \
    && git clone https://github.com/SDRplay/RSPTCPServer.git \
    && cd RSPTCPServer \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install \
    && cd ../..
}

##################

UBUNTU_RELEASE=`lsb_release -rs`
case $UBUNTU_RELEASE in

    "22.04")
        ## TO CHECK!!!
        apt install -y libusb-1.0-0 libusb-1.0-0-dev libfftw3-3 libfftw3-dev git cmake build-essential
        ;;

    "24.10")
        # apt install -y libusb-1.0-0 libusb-1.0-0-dev libfftw3-bin libfftw3-dev git cmake build-essential
        # update_udev_rules "/etc/udev/rules.d/66-sdrplay.rules"    
        # update_modprobe_blacklist "/etc/modprobe.d/blacklist-sdrplay.conf"        
        # install_sdrplay_api
        # install_soapy_sdr
        # install_soapy_sdr_play
        # check_driver
        install_rsptcp_server
        ;;

    *)
        echo Unsupported Ubuntu version $UBUNTU_RELEASE
        exit 1
        ;;

esac
