# CellularNetworkTester

CNT is a Low-cost LTE Test Device for testing LTE Network Performance. This repository can be used to built a tester that emulates connecting multiple mobile devices to a network. This is a flexible and scalable project. Supplementary files also include a guide to use Parallel-ssh to simultaneously check network parameters between mobile device and server(s). This repository explicitly helps establish an interaction between sim7600x (4G HAT-B) module with Raspberry Pi Zero. CNT allows you to make a Raspberry Pi a Low-cost Cellular Test Device for testing 2G/3G/4G Network Performance. This project was designed for 4G performance. Though Raspberry Pi is used as the core of the current tester, the interaction and steps remain the same across all models. Use of Raspberry Pi Zero-W helps setting up wireless connections on the Pi with ease which is largely nedded during the testing stages.  

Prerequisities: 
| Category          | Description                                                                                       |
| ----------------- |:--------------------------------------------------------------------------------------------------|
| [Hardware]        | Raspberry Pi Zero W, MicroSD card + reader                                                        |
| [Sofware]         | Raspberry Pi OS Lite                                                                              |
| [System]          | 32-bit                                                                                            |
| [Kernel Version]  | 5.15                                                                                              |
| [Module]          | sim7600x-4G HAT(B)                                                                                |
| [Software]optional| Parallel-ssh, iperf3                                                                              |
| [Other]           | configured SIMcard                                                                                |

## Setup 
Setup your Raspberry Pi with Raspberry Pi OS Lite- 
1. Download the Raspberry Pi Imager- [Raspberry Pi Imager](https://www.raspberrypi.com/software/) 
2. Load the Raspberry Pi OS Lite onto the MicroSD Card using the imager, keep the following setting modifications in mind:
   -Enable SSH 
   -Set Username and Password 
   -Configure wirless LAN (to establish WiFi connectivity)
3. Insert the MicroSD in the SD slot on the Pi 
4. Power up the Pi and check its connectivity to the network using ``` ip -c a ```
