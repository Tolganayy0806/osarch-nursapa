# Peer Review on Ticket 1 (VM Build Document)

* Reviewer: Marzhan Amantay
* Author of BUILD.md: Tolganay Nursapa
* Host Platform tested on: ASUS VivoBook 15 X515EA (Windows 11)
* Date: 02.11.2026
* Verdict: PASS (Reproduced successfully)

---

## 1. Literal Execution Log

I walked through the provided BUILD.md document step-by-step:

* Step 1–2 (VM Setup): Wizard choices followed exactly as written.
* Step 3 (Storage Configuration): Disk allocation set properly without preallocating full storage.
* Step 4–5 (Hardware & Network): Configured RAM, vCPUs, and NAT adapter correctly.
* Step 6–7 (OS & Connectivity): Installed base system, verified OpenSSH service, and tested network reachability.
* Step 8 (Snapshot Baseline): Snapshot taken and verified in Snapshot Manager.

---

## 2. Issues / First Point of Friction

* First point stuck: No blocking issues encountered.
* Recommendation: Ensure all justification blocks (Why X and not Y) clearly mention the risk of campus Wi-Fi MAC filtering when configuring the network adapter.

---

## 3. Conclusion

The documentation is completely reproducible for an external user without prior hypervisor knowledge.
