| Figure | This computer | Command it came from |
| :--- | :--- | :--- |
| CPU model | Intel(R) Core(TM) 5 120U[cite: 8] | `Get-CimInstance Win32_Processor`[cite: 8] |
| Cores / logical processors | 10 cores / 12 logical processors[cite: 8] | `Get-CimInstance Win32_Processor`[cite: 8] |
| Hardware virtualization: supported? enabled in firmware? | `VirtualizationFirmwareEnabled: False`, `VMMonitorModeExtensions: False`, `SecondLevelAddressTranslationExtensions: False`; `HyperVisorPresent: True` / `CsHypervisorPresent: True` (active hypervisor layer reported)[cite: 8] | `Get-CimInstance Win32_Processor`, `Get-CimInstance Win32_ComputerSystem`, `systeminfo`[cite: 8] |
| Memory: total / available now | 15,993 MB total / 9,083 MB available[cite: 8] | `systeminfo`[cite: 8] |
| System disk: size, free space, SSD or HDD | 476.94 GB total, 361.78 GB free (`C:`), SSD (`WD PC SN5000S SDEQNSJ-512G-1002`)[cite: 8, 9, 11] | `Get-Disk`, `Get-Volume -DriveLetter C`, `Get-PhysicalDisk`[cite: 8, 9, 11] |
| Partition style of the system disk | GPT[cite: 9] | `Get-Disk`[cite: 9] |
| OS and version | Microsoft Windows 11 Pro, version 10.0.22631 (Build 22631)[cite: 8] | `systeminfo`[cite: 8] |
