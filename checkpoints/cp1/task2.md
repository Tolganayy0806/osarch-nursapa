# Task 2 - Plan and justify

## Allocation & Arithmetic

### Host baseline (from Task 1a)
- **CPU:** 10 cores / 12 logical processors (Intel(R) Core(TM) 5 120U)
- **Memory:** 15,993 MB total (9,083 MB available at capture)
- **Disk (`C:`):** 476.94 GB total SSD, 361.78 GB free
- **Reserved for host (Windows 11 Pro):** 4 logical processors, 4,096 MB RAM, ~30 GB free disk space

### Guest 1: Ubuntu Server
- **vCPU:** 2
- **Memory:** 2,048 MB (2 GB)
- **Disk:** 25 GB, dynamically allocated
- **Network:** 1 adapter in Bridged mode

### Guest 2: Windows 11
- **vCPU:** 4
- **Memory:** 6,144 MB (6 GB)
- **Disk:** 60 GB, dynamically allocated
- **Network:** 1 adapter in Bridged mode (or NAT)

### Totals and remaining for host
- **CPU:** 2 (Ubuntu Server) + 4 (Windows 11) = 6 vCPUs allocated to guests; 6 logical processors remain unallocated on the host (4 reserved for the host, 2 spare).
- **Memory:** 2,048 MB + 6,144 MB = 8,192 MB allocated to guests; ~7,801 MB remains out of 15,993 MB total (with ~4,096 MB reserved for the host, ~3,705 MB remains as headroom).
- **Disk:** 25 GB + 60 GB = 85 GB maximum virtual disk size across both guests; with dynamically allocated disks, initial usage is much smaller and ~276.78+ GB remains free on `C:` out of 361.78 GB.
- **Feasibility:** Both guests fit concurrently on this host while keeping the host responsive, without needing to drop either guest.

## Justification
- **Network mode:** **Bridged** mode connects the Ubuntu Server VM directly to the local network with its own IP address, giving it internet access and allowing direct SSH access from the host without extra port-forwarding rules.
- **CPU and RAM allocation:** A headless Ubuntu Server runs comfortably with 2 vCPUs and 2,048 MB RAM, while Windows 11 gets 4 vCPUs and 6,144 MB RAM, leaving 6 logical processors and ~7.8 GB of raw RAM margin so the host OS remains responsive.
- **Disk allocation:** Using **dynamically allocated** virtual disks on the SSD avoids pre-allocating full sizes upfront and preserves plenty of free space on `C:`.

## Verification plan
- **SSH access from host to Ubuntu Server:**
  - Command: `ssh <username>@<ubuntu_ip>`
  - Expected result: Prompted for password/key and logged into the Ubuntu Server shell with no timeout or connection refused error.
- **Resources and internet inside Ubuntu Server:**
  - Commands: `nproc`, `free -h`, `df -h`, `ping -c 2 1.1.1.1`
  - Expected result: `nproc` outputs `2`, `free -h` shows ~`2.0Gi` memory, `df -h` shows root filesystem space, and `ping` replies with 0% packet loss.
- **Resources and internet inside Windows 11 guest:**
  - Commands: `(Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors`, `[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB,2)`, `Test-NetConnection 1.1.1.1 -Port 53`
  - Expected result: Logical processors equal `4`, memory is ~`6` GB, and `TcpTestSucceeded : True`.
