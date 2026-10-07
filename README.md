#### \# Lab 0 - Inventory your own machine

#### Pair: Nursapa 

#### Driver first half: Nursapa

#### Machine: Windows 11 

#### Date: 07.10.2026

#### \# What I did

```powershell

Get-CimInstance Win32\_Processor | Out-File -FilePath "labs\\lab00-inventory\\evidence\\cpu.txt"

Get-CimInstance Win32\_PhysicalMemory | Out-File -FilePath "labs\\lab00-inventory\\evidence\\memory.txt"

Get-Volume | Out-File -FilePath "labs\\lab00-inventory\\evidence\\disk.txt"

Get-CimInstance Win32\_BIOS

systeminfo

\## Result 

| What | Value | Where I got it | 

| :--- | :--- | :--- |

&#x20;| CPU Model \& Cores | Intel Core i5 | 'Get-CimInstance Win32\_Processor' |

&#x20;| Total RAM \& Modules | 8 GB | 'Get-CimInstance Win32\_PhysicalMemory' | 

| Disk Free Space | 100 GB | 'Get-Volume' |

&#x20;| Firmware Type \& Ver | UEFI | 'Get-CimInstance Win32\_BIOS' | 

| Hardware Virtualization | Enabled | 'systeminfo' |



\## What did not work the first time 

1\. The 'cd Desktop'command failed initially because the path was located inside  'OneDrive\\Desktop'. 

2\. Used '/' instead of the pipe symbol '|' in the 'Out-File'command,which resulted in a synax error.  



\## Evidence 

\- \[evidence/cpu.txt](evidence/cpu.txt) — CPU information

\- \[evidence/memory.txt](evidence/memory.txt) — RAM information

&#x20;-\[evidence/disk.txt](evidence/disk.txt) — Disk information

