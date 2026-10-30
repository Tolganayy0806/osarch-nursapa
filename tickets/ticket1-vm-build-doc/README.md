# Ticket 1 — Test machine for new developer

## 1. What was asked
> "Hi, we have someone starting on Monday and he needs a test computer set up. Nothing special, just so he can try things without breaking anything. Can you write down how to do it so I can do the next one myself? Thanks"

## 2. What was actually needed
- **Physical PC vs. VM:** The request says "a test computer", but a physical PC is unnecessary and expensive for temporary sandboxing. We assumed a virtual machine (VM) running on the host system so it can be easily snapshotted, reset, or destroyed.
- **Real reader of BUILD.md:** The actual reader is Aigerim (the office manager), who has never opened a hypervisor before, *not* the developer. Therefore, every step must assume zero prior technical knowledge, with clear UI explanations rather than brief shorthand commands.
- **Missing details in the request:** The request omitted host resource limits, OS distributions (Linux and Windows guests), network access requirements, and memory/disk allocations. We calculated resources based on our host machine's specs (16 GB RAM) and assigned safe allocations (e.g., 2–4 GB RAM per VM).

## 3. What I did
1. Opened the hypervisor (VirtualBox) and initiated the New VM wizard.
2. Allocated resources based on host capacity (calculated from Lab 0/2 data).
3. Configured virtual hard disk settings (VDI, dynamically allocated).
4. Configured the network adapter to **NAT** to bypass network MAC filtering while providing internet access.
5. Installed the operating systems and verified connectivity (ping tests between guests and to the internet).
6. Created an initial snapshot for system recovery.

## 4. Evidence
- [evidence/01-new-vm-wizard.png](evidence/01-new-vm-wizard.png) — Proof of the initial VM creation wizard settings.
- [evidence/02-disk-settings.png](evidence/02-disk-settings.png) — Proof of virtual disk allocation and format.
- [evidence/03-network-adapter.png](evidence/03-network-adapter.png) — Proof of network adapter configured to NAT.
- [evidence/04-guest-uname.txt](evidence/04-guest-uname.txt) — Proves the guest OS is running and responds to kernel queries.
- [evidence/05-ping-between-guests.txt](evidence/05-ping-between-guests.txt) — Proves both guests can reach the internet and see each other.
- [evidence/06-snapshot-list.png](evidence/06-snapshot-list.png) — Proves a clean recovery snapshot was created.

## 5. What I would do differently
Next time, I would script the initial VM provisioning using Vagrant to automate resource allocation and speed up multi-OS deployment for future employees.

## AI Assistant Declaration
| Tool / Assistant | How it was used |
| :--- | :--- |
| Gemini | Helped structure the five-section report and format the Markdown templates. |
