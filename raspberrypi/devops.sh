#!/usr/bin/env bash

# to get information on all hardware-related things.
cat /proc/cpuinfo


cat /proc/meminfo # displays details about the Raspberry Pi's memory.
cat /proc/partitions # reveals the size and number of partitions on your SD card or HDD.
cat /proc/version # shows the software version of the Raspberry Pi.


# help to find out the board number
# boards have some specific configurational numbers. This number is needed to get spare parts for the board. 
cat /sys/firmware/devicetree/model



vcgencmd measure_temp # reveals the CPU temperature (vital if you're concerned about airflow).
vcgencmd get_mem arm && vcgencmd get_mem gpu # will reveal the memory split between the CPU and GPU, which can be adjusted in the config screen.
free -o -h # will display the available system memory/RAM details.
top d1 # checks the load on your CPU, displaying details for all cores.
df -h # is a great way to quickly check the free disk space on your Raspberry Pi.

# To check connected devices
ls /dev/sda* # displays a list of partitions on the SD card. For a Raspberry Pi with a HDD attached, substitute sda* with hda*.
lsusb # displays all attached USB devices. This is crucial for connecting a hard disk drive or other USB hardware that requires configuration.
lsblk # is another list command you can use. This displays information about all attached block devices (storage that reads and writes in blocks). 

# Stop/Start commands
startx # will start the Raspberry Pi GUI (graphic user environment) and return you to the default Raspbian desktop.
sudo shutdown -h now # will commence the shutdown process with immediate effect. Schedule a timed shutdown with the format: sudo shutdown -h 21:55
sudo reboot # is for restarting the Raspberry Pi from the command line.

https://www.makeuseof.com/tag/9-things-wanted-know-raspberry-pi/
https://www.makeuseof.com/tag/raspberry-pi-vpn-travel-router/

#sudo apt-get update
#sudo apt-get upgrade
#sudo apt-get dist-upgrade
#sudo rpi-update
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade # && sudo rpi-update