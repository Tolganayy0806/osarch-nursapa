# Ticket 1 — Test machine for new developer

## 1. What was asked
> "Hi, we have someone starting on Monday and he needs a test computer set up. Nothing special, just so he can try things without breaking anything. Can you write down how to do it so I can do the next one myself? Thanks"[cite: 3]

## 2. What was actually needed
The request left out critical technical parameters required to provision functional virtual machines: the host’s hardware capacity (available RAM and disk space), the specific Linux distribution version, and whether the virtual machines required internet access or internal connectivity. Furthermore, the office manager assumed a single generic machine type would suffice, whereas standard development workflows require both a Linux environment (for backend tools and scripts) and a Windows environment (for testing enterprise applications). I assumed a dual-guest setup (Ubuntu Server and Windows 11) allocated proportionally from the host's 16 GB RAM and 512 GB NVMe SSD, utilizing NAT network mode to ensure safe internet isolation while allowing inter-guest visibility.

## 3. What I did
1. Verified host hardware specifications (Intel Core 5 120U, 16 GB RAM, 512 GB SSD) via Lab 0 data[cite: 32].
2. Calculated and allocated safe resource limits: 2 vCPUs and 2 GB RAM for Ubuntu Server; 2 vCPUs and 4 GB RAM for Windows 11, ensuring the host retains at least 9 GB of idle memory for system stability.
3. Installed Ubuntu Server LTS using the local ISO, configured a static snapshot named `clean-install`.
4. Installed Windows 11 Enterprise evaluation edition.
5. Configured network adapters to NAT mode to grant internet access and inter-guest communication without triggering campus MAC-filtering blocks.
6. Tested bidirectional connectivity via ping and verified kernel/OS releases.
7. Simulated a failure by modifying network configurations, confirmed system disruption, and successfully rolled back to the `clean-install` snapshot.

## 4. Evidence
- [evidence/01-new-vm-wizard.png](evidence/01-new-vm-wizard.png) — Hypervisor configuration wizard and initial virtual machine setup parameters.
- [evidence/02-disk-settings.png](evidence/02-disk-settings.png) — Virtual disk size allocation and virtual storage configuration.
- [evidence/03-network-adapter.png](evidence/03-network-adapter.png) — Network adapter configuration set to NAT mode.
- [evidence/04-guest-uname.txt](evidence/04-guest-uname.txt) — Proves the Linux guest system build and kernel version via `uname -a`.
- [evidence/05-ping-between-guests.txt](evidence/05-ping-between-guests.txt) — Proves successful bidirectional network packet transmission between Linux and Windows guests.
- [evidence/06-snapshot-list.png](evidence/06-snapshot-list.png) — Proves the existence of the `clean-install` snapshot used for system recovery.

## 5. What I would do differently
Next time, I would provision the Ubuntu Server virtual machine with a slightly larger primary virtual disk (e.g., 30 GB instead of 20 GB) to accommodate extensive package installations and multiple container tests without triggering disk pressure warnings later in the development cycle.
