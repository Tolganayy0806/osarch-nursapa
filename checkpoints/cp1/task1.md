# Task 1 - Inventory and interpret

## 1a. This computer

| Figure | This computer | Command it came from |
| :--- | :--- | :--- |
| CPU model | Intel(R) Core(TM) 5 120U | `Get-CimInstance Win32_Processor` |
| Cores / logical processors | 10 cores / 12 logical processors | `Get-CimInstance Win32_Processor` |
| Hardware virtualization: supported? enabled in firmware? | `VirtualizationFirmwareEnabled: False`, `VMMonitorModeExtensions: False`, `SecondLevelAddressTranslationExtensions: False`; `HyperVisorPresent: True` / `CsHypervisorPresent: True` (active hypervisor layer reported) | `Get-CimInstance Win32_Processor`, `Get-CimInstance Win32_ComputerSystem`, `systeminfo` |
| Memory: total / available now | 15,993 MB total / 9,083 MB available | `systeminfo` |
| System disk: size, free space, SSD or HDD | 476.94 GB total, 361.78 GB free (`C:`), SSD (`WD PC SN5000S SDEQNSJ-512G-1002`) | `Get-Disk`, `Get-Volume -DriveLetter C`, `Get-PhysicalDisk` |
| Partition style of the system disk | GPT | `Get-Disk` |
| OS and version | Microsoft Windows 11 Pro, version 10.0.22631 (Build 22631) | `systeminfo` |

## 1b. A machine you have never seen: a thin-and-light laptop

### 1. Both guests?
- **Host assumption:** Windows 11 Home in S mode needs at least **2 threads** (1 physical core), **3–4 GB RAM**, and **10–15 GB** of free disk space for OS overhead and paging so the host stays responsive.
- **Guest 1 (from Lab 1):** `[REPLACE: e.g., 2 vCPUs, 2 GB RAM, 20 GB disk]` (from build log).
- **Guest 2 (from Lab 2):** `[REPLACE: e.g., 2 vCPUs, 4 GB RAM, 40 GB disk]` (from build log).
- **Arithmetic (CPU, memory, disk):**
  - **CPU:** `[Guest 1 vCPUs] + [Guest 2 vCPUs] + 2 host threads = [Total]` vs **4 threads** available (1.1 GHz base clock).
  - **Memory:** `[Guest 1 RAM] + [Guest 2 RAM] + 3.5 GB host = [Total]` vs **8 GB LPDDR4X** total.
  - **Disk:** `[Guest 1 disk] + [Guest 2 disk] = [Total]` vs **31 GB free** out of 128 GB eMMC.
- **Conclusion:** **No**, this laptop cannot reliably run both guests at the same time at their Lab 1–2 sizes because total RAM and free disk space exceed what is available after leaving enough resources for Windows 11 on the host (and the 1.1 GHz 2-core CPU will heavily bottleneck concurrent execution)[cite: 3].

### 2. Upgrade first
- **What to upgrade/change first and why:** Storage (**31 GB free** on 128 GB eMMC) and RAM (**8 GB**) are the primary bottlenecks for running two VMs concurrently, and Windows 11 Home in S mode also restricts installing third-party hypervisors[cite: 3].
- **Can it actually be upgraded on this machine?** **Nothing can be upgraded** hardware-wise because both the **8 GB LPDDR4X** memory and the **128 GB eMMC** storage are soldered directly to the motherboard[cite: 3].
- **What to do instead:** Switch out of Windows 11 S mode, free up disk space, run **only one guest at a time** (with reduced dynamically allocated disk/RAM) instead of running both concurrently, or move the lab VMs to a workstation with upgradeable RAM/NVMe storage or a cloud VM[cite: 3].
