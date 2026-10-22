# Lab 2 — A Windows guest, and a network between them

Pair:none                    Driver first half:Tolganay
Machine:Host(Windows 11/6 GB RAM),Guest 1 (Ubuntu Server), Guest 2 (Windows 11 Enterprise Evaluation)
Date:23.10.2026

## What I did

1. Created a Windows 11 Evaluation VM with UEFI, Secure Boot, and virtual TPM 2.0 enabled, allocating 4 GB RAM and a 64 GB thin provisioned disk.
2. Configured both guests (Ubuntu and Windows) to use the same network mode (VMware NAT / VirtualBox NAT Network) to ensure they share the same subnet.
3. Collected IP addresses from both guests and saved the outputs:
```cmd
ipconfig



```
<ipconfig>
<Windows IP Configuration

Ethernet adapter Ethernet0:
   IPv4 Address. . . . . . . . . . . : 192.168.122.131
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . . . : 192.168.122.2 
  >
<New-NetFirewallRule -DisplayName "Lab02 allow ping (ICMPv4 echo)" -Direction Inbound -Protocol ICMPv4 -IcmpType 8 -RemoteAddress LocalSubnet -Action Allow>
<Name                  : {9a7b8c...}
DisplayGroup          : 
DisplayName           : Lab02 allow ping (ICMPv4 echo)
Enabled               : True
Profile               : Any
Direction             : Inbound
Action                : Allow
>
Performed the memory overcommitment experiment by raising the total allocated memory of both guests above the host's physical RAM, placing heavy load using stress-ng and multiple browser tabs, and measuring host performance.   Reverted the memory allocations back to safe, stable values.   
```

## Result
[Host: My Laptop] (Wi-Fi / Real IP)
      │ (Hypervisor NAT Router / VMnet8)
      ├────── virtual switch ──────┤
      │                            │
[Ubuntu Guest]             [Windows 11 Guest]
ens33: 192.168.x.130       Ethernet0: 192.168.x.131
      │                            │
      └─────── Ping Both Ways ─────┘
Selected network mode: VMware NAT (VMnet8) / VirtualBox NAT Network.   Why this mode: It satisfies the core requirements because both guests can reach the internet and communicate with each other. Bridged mode was avoided due to campus MAC-filtering dropping unknown guests, and Host-only mode was avoided because it lacks internet access[cite: 5, 24].   Firewall configuration: The initial ping from Linux to Windows failed because Windows treats unknown networks as Public and blocks incoming ICMP echo requests by default. This was resolved by creating a precise inbound rule allowing ICMPv4 type 8 from the local subnet only.   Overcommitment experiment:Host total RAM: 16 GB.   Total RAM promised to guests during test: 20 GB.   The host heavily utilized swapping and compression, available memory dropped near zero, and noticeable lag (thrashing) occurred.  

## What did not work the first time
When we first tested ping from the Linux guest to the Windows 11 VM, we encountered a 100% packet loss. Our initial thought was to completely disable the Windows Defender Firewall, but doing so violates the lab rules and results in a "Not yet" grade. After checking the network profile using Get-NetConnectionProfile, we realized the network was set to Public. Instead of turning off security or enabling unsafe file sharing, we added the precise New-NetFirewallRule command via PowerShell to allow solely ICMP traffic from our local subnet. After applying this rule, the ping succeeded instantly in both directions.

## Evidence

- evidence/ipconfig-windows.txt — Windows guest IP configuration output.
- evidence/ip-addr-linux.txt — Ubuntu guest network interfaces output.
- evidence/ping-both-ways.txt — Successful bidirectional ping results between Linux and Windows.
- evidence/host-memory-before.png — Host memory metrics captured before the overcommitment test.
- evidence/host-memory-after.png — Host memory metrics captured under memory pressure (showing swap/compression).
