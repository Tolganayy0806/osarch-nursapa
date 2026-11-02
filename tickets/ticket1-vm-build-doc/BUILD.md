# Build and Configuration Guide (Ticket 1)

## Step 1: Virtual Machines Provisioning
1. Created two virtual machines in VMware Workstation:
   - `lab01-ubuntu` (Ubuntu Guest OS)
   - `lab02-win11` (Windows 11 Guest OS)
2. Allocated resources (CPU cores and RAM) according to lab requirements (Evidence: `evidence/01-vm-cpu-ram.png`).
3. Configured virtual hard disks with appropriate sizing (Evidence: `evidence/02-disk-settings.png`).

## Step 2: Network Configuration
1. Attached virtual network adapters to **NAT** mode for both VMs to ensure internet access and local inter-VM communication (Evidence: `evidence/03-network-adapter.png`).
2. Verified guest operating system kernel/version details (Evidence: `evidence/04-guest-uname.txt`).

## Step 3: Network Connectivity Verification
1. Retrieved IP addresses:
   - Ubuntu: `192.168.134.129`
   - Windows 11: `192.168.134.131`
2. Executed bidirectional ping tests between `lab01-ubuntu` and `lab02-win11` with 0% packet loss (Evidence: `evidence/05-ping-between-guests.txt`).

## Step 4: Snapshot Baseline
1. Created a clean baseline snapshot named `clean-install` for recovery and future labs (Evidence: `evidence/06-snapshot-list.png`).
