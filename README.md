# CellularNetworkTester

CNT is a Low-cost LTE Test Device for testing LTE Network Performance. This repository can be used to built a tester that emulates connecting multiple mobile devices to a network. This is a flexible and scalable project. Supplementary files also include a guide to use Parallel-ssh to simultaneously check network parameters between mobile device and server(s). This repository explicitly helps establish an interaction between sim7600x (4G HAT-B) module with Raspberry Pi Zero-W. CNT allows you to make a Raspberry Pi a Low-cost Cellular Test Device for testing 2G/3G/4G Network Performance. This project was designed for 4G performance. Altough Raspberry Pi is used as the core of the current tester, the interaction and steps remain the same across all models. Use of Raspberry Pi Zero-W helps setting up wireless connections on the Pi with ease which is largely nedded during the testing stages.  

## Prerequisities: 
| Category          | Description                                                                                       |
| ----------------- |:--------------------------------------------------------------------------------------------------|
| [Hardware]        | Raspberry Pi Zero-W, MicroSD card + reader                                                        |
| [Sofware]         | Raspberry Pi OS Lite                                                                              |
| [System]          | 32-bit                                                                                            |
| [Kernel Version]  | 5.15                                                                                              |
| [Module]          | sim7600x-4G HAT(B)                                                                                |
| [Software]optional| Parallel-ssh, iperf3                                                                              |
| [Other]           | configured SIMcard (for 2G/3G/4G LTE connections)                                                                                |

## Setup 

Setup your Raspberry Pi with Raspberry Pi OS Lite- 
1. Download the Raspberry Pi Imager- [Raspberry Pi Imager](https://www.raspberrypi.com/software/) 
2. Load the Raspberry Pi OS Lite onto the MicroSD Card using the imager, keep the following setting modifications in mind:
   - Enable SSH 
   - Set Username and Password 
   - Configure wirless LAN (to establish WiFi connectivity)
3. Insert the MicroSD in the SD slot on the Pi 
4. Power up the Pi and check its connectivity to the network using ``` ip -c a ```
5. Check SSH 

After testing the connectivity, connect sim7600x onto the Raspberry Pi, use this [reference image](https://forums.raspberrypi.com/viewtopic.php?t=323177). 

## Implementation 

Once the setup is done, on your system, create a bash file and copy the raw contents of ** rpi/lte_test.sh ** onto the file. 

Things to keep in mind- 
- Have root priviledges before entering any commands
- It is essential to start by unloading the option and qmi_wwan driver and then forcefully load the qmi module to utilize the qmi_wwan 
- Changing the default MTU from 1500 to 1430 is crucial to avoid any qmi call failed errors
- Do not put the wlan down if you are connected through SSH 

## Test your tester 

To check if the connectivity to the internet is established via qmi_wwan use can perform a ping test by forcefully direct traffic through wwan interface to any desired internet IP address. Refer to [ssh_ltetest.sh](ssh_ltetest.sh). 
