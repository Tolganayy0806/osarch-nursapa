# Lab 1 — Your first virtual machine

Pair: none                    Driver first half: Tolganay
Machine:lab01-ubuntu
Date:17.10.2026

## What I did

Steps, with commands in code blocks. Not prose about the steps.

```
lsb_release -a
Distributor ID: -a
Description:	Ubuntu 26.04.1 LTS
Release:        26.04
Codename:       resolute

```
```
nproc
2
```
```
free -h
               total   used   free   shared   buff/cache   available
Mem:            3.3G   535Mi   2.5G   1.5Mi        424Mi        2.7G
Swap:             0B      0B     0B 
```
```
df -h /
Filesystem                         Size  Used  Avail  Use% Mounted on
/dev/mapper/ubuntu--vg-ubuntu--lv  9.8G  3.4G   6.0G   36% /
```
```
ip a
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    inet 192.168.134.129/24 brd 192.168.134.255 score global dynamic ens33
```

 Result



 Resource justification

My host has 12 threads, 16 GB of RAM and 400 GB free on the VM volume (Lab 0).
Idle, the host already uses about 8 GB of RAM.
I gave the guest 2 vCPU of my 12 threads because running ubuntu does not require much resources.
I gave it 4 GB of my 16 GB RAM because for ubuntu it was enough, and I keep 12 GB for the Windows guest in Lab 2.
I gave it a 20 GB dynamically allocated disk of my 400 GB free because it was enough to run the virtual machine.

 What did not work the first time

At first,connecting to the network inside the virtual machine took a moment to initialize,but running the network commands confirmed that the dynamic IP address was correctly assigned via DHCP.

 Evidence

evidence/ — screenshots proving the virtual machine setup and terminal commands execution. 
