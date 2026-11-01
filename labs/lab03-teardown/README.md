# Lab 3 - Teardown, and the same machine from the command line

Driver first half: Tolganay
Pair: none
Machine: ASUS ExpertBook B3402FVA (Host), Ubuntu 26.04 (Guest VM)
Date: 2026-11-01

## What I did
- Identified the exact laptop model on the host (ASUS ExpertBook B3402FVA) and found its service manual.
- Extracted hardware specifications on Windows via PowerShell (`windows-specs.txt`) and on the Ubuntu VM (`linux-specs.png`).
- Created a 3-OS/environment comparison table showing how firmware attributes map across tools.

## Result

### OS Comparison Table
| Fact | Windows (Host) | Linux (VM Guest) |
| :--- | :--- | :--- |
| **CPU Model** | Get-CimInstance Win32_Processor -> Name | lscpu -> Model name |
| **Physical Cores** | NumberOfCores | Core(s) per socket |
| **Logical CPUs** | NumberOfLogicalProcessors (12) | CPU(s) |
| **Total Memory** | TotalPhysicalMemory (~16 GB) | free -h (total) |
| **Disk Interface** | Get-PhysicalDisk -> BusType | lsblk -> TRAN |
| **Motherboard** | Win32_BaseBoard -> Product (B3402FVA) | dmidecode -> 440BX Desktop Reference Platform (Virtual) |

*Note: The Linux guest correctly reflects the virtualized hardware parameters (VMware hypervisor board), while the host reveals the true physical ASUS ExpertBook hardware.*

## What did not work the first time
- Initially, copying text out of the VMware Linux guest terminal via clipboard had restrictions, so the Linux command output was successfully captured and documented via terminal screenshot evidence (`linux-specs.png`).

## Evidence
- [evidence/windows-specs.txt](evidence/windows-specs.txt) - PowerShell hardware transcript from the host.
- [evidence/linux-specs.png](evidence/linux-specs.png) - Terminal output from the Ubuntu VM guest.
