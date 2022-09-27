<div align="center">
   <img width="600" height="400" src="https://github.com/Beamlink/CellularNetworkTester/blob/main/medusa.jpg" alt="A USB hub with somewhat messy cables running to a number of small boards with attached antennae.  This device is named Medusa, and is the original version of CNT designed in-house to test the Beamlink Network">
</div>

# CellularNetworkTester (aka Project Medusa)

Meet Medusa - don't worry, you can look at her.  Originally built to run internal tests on the [Beamlink Network](https://beamlink.io), Medusa solves the problem of requiring advanced simulation tools or a large number of expensive phones to test an LTE cellular network.  At a high level, she's a USB hub connecting 30 or so Raspberry Pi based cell phone emulators that ping each other and a base station back and forth to gather a plethora of test data like latency and throughput.  Since we couldn't find any other affordable solutions to this problem, we decided to open source Medusa so you too may easily test your cell networks

## Technical Overview

CNT is a Low-cost LTE Test Device for testing LTE Network Performance. This repository can be used to build a tester that emulates connecting multiple mobile devices to a network. This is a flexible and scalable project. Supplementary files also include a guide to use Parallel-SSH to simultaneously check network parameters between mobile device and server(s). This repository explicitly helps establish an interaction between sim7600x (4G HAT-B) module with Raspberry Pi Zero-W. CNT allows you to make a Raspberry Pi a Low-cost Cellular Test Device for testing 2G/3G/4G Network Performance. This project was designed for 4G performance. Altough Raspberry Pi is used as the core of the current tester, the interaction and steps remain the same across all models. Use of Raspberry Pi Zero-W helps setting up wireless connections on the Pi with ease which is largely needed during the testing stages.  

Sim7600x 4G Hat- (B) is a 4G Communication module, it also posseses GPS and GNSS positining capabilities. Supports LTE CAT4 up to 150Mbps (downlink transfer) and supports a wide range of IoT Applications. SIM7600 comes with a Qualcomm MDM9607 chipset.

The installation of prerequisite software and libraries: libqmi-utils and udhcpc are covered in [sim7600setup](https://github.com/Beamlink/CellularNetworkTester/blob/main/sim7600setup)[^1]
- **libqmi-utils**- helps establish a connection with Qualcomm-based modems
- **udhcpc**- used for modem DHCP Leasing 
The cellular network gives a unique IP to the HAT and the Pi will have its own IP. This is used to solve IP addressing conflicts between the Pi and the HAT.


## Prerequisities: 
| Category          | Description                                                                                       |
| ----------------- |:--------------------------------------------------------------------------------------------------|
| [Hardware]        | Raspberry Pi Zero-W, MicroSD card + reader                                                        |
| [Sofware]         | Raspberry Pi OS Lite                                                                              |
| [System]          | 32-bit                                                                                            |
| [Kernel Version]  | 5.15                                                                                              |
| [Module]          | [sim7600x-4G HAT(B)](https://www.waveshare.com/product/sim7600g-h-4g-hat-b.htm)                   |
| [Software]optional| Parallel-SSH, iperf3                                                                              |
| [Other]           | configured SIMcard (for 2G/3G/4G LTE connections)                                                 |

## Setup 

Setup your Raspberry Pi with Raspberry Pi OS Lite- 
1. Download the Raspberry Pi Imager- [Raspberry Pi Imager](https://www.raspberrypi.com/software/) 
2. Load the Raspberry Pi OS Lite onto the MicroSD Card using the imager, keep the following setting modifications in mind:
   - Enable SSH 
   - Set Username and Password 
   - Configure wireless LAN (to establish WiFi connectivity)
3. Insert the MicroSD card into the SD slot on the Pi
4. Power up the Pi and check its connectivity to the network using ``` ip -c a ```
5. Check SSH 
6. Refer to [Sim7600setup](https://github.com/Beamlink/CellularNetworkTester/blob/main/sim7600setup). 

After testing the connectivity, connect the sim7600x to the Raspberry Pi, using this [reference image](https://forums.raspberrypi.com/viewtopic.php?t=323177). 

## Implementation and Configuration

Once the setup is done, on your system, create a bash file and copy the raw contents of **rpi/lte_test.sh** onto the file. 

Things to keep in mind- 
- Have root priviledges before entering any commands
- It is essential to start by unloading the option and qmi_wwan driver and then forcefully load the qmi module to utilize the qmi_wwan 
- Changing the default MTU from 1500 to 1430 is crucial to avoid any qmi call failed errors
- Do not put the wlan interface down if you are connected through SSH across WiFi as this will end your SSH session
- The interface number (wwan0/ wwan1/ ...) may change for each system, do check the interface before entering it in the bash file 

After system specific modifications, run the bash file in the same directory the above file is created in. 

## Test your tester 

To check if the connectivity to the internet is established via qmi_wwan use can perform a ping test by forcefully direct traffic through wwan interface to any desired internet IP address. Refer to [ssh_ltetest.sh](ssh_ltetest.sh). 

## Example - Set Up Network

```
ssh rpi@192.168.1.2
cd /home/rpi
git clone https://github.com/Beamlink/CellularNetworkTester.git
cd CellularNetworkTester/rpi
ip -c a
#Add a route that goes from the raspberry pi (which we are logged into to) TO the coordinating computer via the WWAN interface listed in the previous command.
sudo route add 192.168.1.3 via 10.0.0.3
#Allow execution of the bash file
sudo chmod u+x lte_test.sh
#Execute the bash file
sudo ./lte_test.sh
#Test Connectivity
ping 192.168.1.3
```
## iPerf Tests

To emulate multiple mobile devices connected to a network, we can run simultaneous ping tests from all sources and record the network parameters using iPerf3. 
For simultaneous ping test, we would need parallel-ssh on our systems. Follow this [parallel-ssh guide](https://www.cyberciti.biz/cloud-computing/how-to-use-pssh-parallel-ssh-program-on-linux-unix/) and [parallel-ssh manual](https://manpages.ubuntu.com/manpages/focal/man1/parallel-ssh.1.html).

*Note- most recent ubuntu systems do not recognize pssh, hence replace pssh with parallel-ssh* 

Once the parallel ssh is set up, download [iPerf3](https://linuxhint.com/install-iperf3-ubuntu/). Refer to [iperf3_cleint.sh](https://github.com/Beamlink/CellularNetworkTester/blob/main/iperf3_client.sh) and [iperf3_server.sh](https://github.com/Beamlink/CellularNetworkTester/blob/main/iperf3_server.sh) to get commands to initate the iperf tests. 

Things to remember- 
- Always run the server iperf command first, as the client initiates the connection to a server that has a port listening for connection requests
- Open multiple ports on the server to accomodate simulatenous connection with multiple clients 
- By default iperf3 runs TCP Connections, you can use -U flag to test UDP network parameters 
- Based on your system requirments you can envoke various [iperf3 flags](https://iperf.fr/iperf-doc.php) in your command. 

Finally, checkout [parallel-ssh.sh](https://github.com/Beamlink/CellularNetworkTester/blob/main/parallel-ssh.sh) and run the command to begin simultaneous ping test. 

[^1]: https://developers.telnyx.com/docs/v2/wireless/tutorials/sim7600
