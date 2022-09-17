#First, we are going to start by updating the Raspberry Pi- 

sudo apt update -y
sudo apt dist-upgrade -y
sudo rpi-update #After you get the prompt, press 'Y' 

sudo reboot #Run this command after all the above commands are done 

#Installation of Prerequiste software and libraries- 
sudo apt install libqmi-utils && udhcpc

#Enable UART for communication
sudo raspi-config #Select Interfacing Options > P6 Serial > No Reboot 



