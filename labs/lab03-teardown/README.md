# Lab 3 - Teardown, and the same machine from the command line

Driver first half: Tolganay
Pair: none
Machine: Host (ASUS ExpertBook B3402FVA)
Date: 30.10.2026

## What I did
- Identified the exact laptop model using PowerShell (`ASUS EXPERTBOOK B3402FVA`).
- Located the official user manual and specifications on the ASUS support site.
- Analyzed physical components (memory, storage, CPU) and documented their connections and limits.
- Extracted hardware specifications from the operating system into `windows-specs.txt`.
- Built a multi-environment command comparison table showing hardware facts and their respective fields.

## Result
### 1. The Machine
- **Exact Model:** ASUS ExpertBook B3402FVA
- **How found:** Executed `Get-CimInstance Win32_ComputerSystem | Format-List *` in PowerShell, which returned `Model : ASUS EXPERTBOOK B3402FVA_B3402FVA`.
- **Manual Source:** ASUS Official Support site (User Manual and official specifications page used since a traditional public service teardown manual is not published for this model).

### 2. Components
1. **Memory (RAM):**
   - **What:** 16 GB DDR4 SODIMM module (SK Hynix, 3200 MT/s).
   - **Connects to:** CPU memory controller on the system board.
   - **Limits:** Limited by module capacity and available slots.
2. **Storage (SSD):**
   - **What:** WD PC SN5000S 512 GB NVMe SSD.
   - **Connects to:** M.2 slot via PCIe interface.
   - **Limits:** Standard M.2 2280 form factor.
3. **Processor (CPU):**
   - **What:** Intel Core 5 120U (10 cores, 12 threads).
   - **Connects to:** BGA socket directly on the system board.
   - **Limits:** Soldered, non-upgradable.

### 3. Upgrade Verdict
| Component | Manual / Specs says | OS says | Verdict |
| :--- | :--- | :--- | :--- |
| **Memory** | SODIMM slot supported | 16 GB DDR4 (SK Hynix) | **Partly:** Can be upgraded by replacing or adding memory modules depending on physical slot availability. |
| **Storage** | M.2 2280 PCIe NVMe slot | BusType: NVMe, 512 GB | **Yes:** Fully upgradable to any standard M.2 2280 NVMe drive. |
| **CPU** | Integrated / BGA package | Intel Core 5 120U | **No:** Soldered directly to the system board, cannot be upgraded by the user. |

### 4. Three-OS / Command Comparison Table
| Fact | Windows (PowerShell) | Linux (VM) | Value / Note |
| :--- | :--- | :--- | :--- |
| **CPU Model** | `Get-CimInstance Win32_Processor` -> `Name` | `lscpu` -> `Model name` | Intel Core 5 120U |
| **Logical CPUs** | `NumberOfLogicalProcessors = 12` | `CPU(s) = 2` | Host utilizes 12 threads; VM has a restricted allocation. |
| **Total Memory** | `Win32_ComputerSystem` -> `TotalPhysicalMemory` | `free -h` -> `total` | ~16 GB physical RAM on host. |
| **Disk Interface** | `Get-PhysicalDisk` -> `BusType = NVMe` | `lsblk` -> `TRAN = nvme` | NVMe storage protocol. |

*Note on differences:* Field names differ significantly between Windows CIM classes and Linux utility outputs (`lscpu`, `lsblk`). Furthermore, values in a Linux VM reflect the hypervisor's virtualized hardware rather than the host's physical specs.

## What did not work the first time
When initially running the hardware commands in PowerShell, properties were truncated by default, making it difficult to inspect all parameters. This was resolved by appending `| Format-List *` to each command as specified in the lab brief.

## Evidence
- [evidence/windows-specs.txt](evidence/windows-specs.txt) — Full hardware specifications extracted via PowerShell (with sensitive serial numbers redacted).
- [evidence/photos/component-layout.png](evidence/photos/component-layout.png) — Official support page and specification layout for ASUS ExpertBook B3402FVA.
