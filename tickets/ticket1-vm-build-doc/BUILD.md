# Build Document: Setting up Test VMs for New Developers
**Target Audience:** Aigerim (Office Manager)  
**Goal:** Rebuild Linux and Windows guest environments from scratch.

---

## Step 1. Creating a New Virtual Machine
1. Open **VirtualBox** on your host machine.
2. Click the **New** button at the top to launch the creation wizard.
3. Enter a descriptive name (e.g., `Dev-Test-Linux`), select the ISO image file, and choose the Linux/Windows distribution.
> **Evidence:** `evidence/01-new-vm-wizard.png`  
> *Why:* Naming the VM clearly and providing the correct ISO upfront prevents configuration errors later during installation.

## Step 2. Allocating Hardware Resources
1. Set the Memory (RAM) allocation to **2048 MB (2 GB)**.
2. Set the processor count to **2 CPU cores**.
> *Why:* Based on our host machine's total capacity (16 GB RAM), allocating 2 GB leaves enough resources for the host OS to run smoothly while giving the guest enough juice to compile code.

## Step 3. Configuring Virtual Hard Disk
1. Select **Create a virtual hard disk now**.
2. Set the disk size to **20 GB** and choose **VDI (VirtualBox Disk Image)** with *Dynamically allocated* storage.
> **Evidence:** `evidence/02-disk-settings.png`  
> *Why:* Dynamic allocation saves physical disk space on the host, growing only as the developer writes files inside the guest.

## Step 4. Setting Up Network Adapter
1. In the VM settings, navigate to **Network** -> **Adapter 1**.
2. Attached to: **NAT**.
> **Evidence:** `evidence/03-network-adapter.png`  
> *Why:* The corporate network filters by physical MAC addresses. Using NAT hides the VM behind the host's IP address, allowing instant internet access without triggering network blocks.
