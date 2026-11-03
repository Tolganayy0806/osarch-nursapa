# Feedback on Nursapa Tolganay's BUILD.md
Reviewer: Marzhan Amantay
Commit reviewed: https://github.com/Tolganayy0806/osarch-nursapa/blob/f077ea8bd845e73ceb464715f09802080e459756/tickets/ticket1-vm-build-doc/BUILD.md
Hypervisor I used: VMware Workstation Pro, version 26H1

## First step where I got stuck
Step number: None
What the step says: N/A
What I did: Followed the configuration steps from initial wizard to final network verification.
What happened / what I had to guess: The installation finished without unresolvable roadblocks. 

## Other places I hesitated
- Step 5 (Networking): When choosing between Bridged and NAT, I paused to confirm whether the guest subnet would collide with local adapter ranges. The explanation of internal NAT translation clarified why external routing works without MAC conflicts.
- Step 6 (OpenSSH Setup): During user profile setup, it was easy to accidentally skip the OpenSSH checkbox; emphasizing that checkbox with an explicit visual warning helps ensure SSH is not omitted.

## Settings I would not have chosen without the document
- Deferring the ISO installation source to bypass VMware Easy Install automation.
- Disabling full disk space preallocation to preserve host SSD capacity via thin provisioning.
- Forcing NAT adapter assignment to avoid campus network MAC registration blocks.

## One thing that worked well
- The inclusion of explicit verification commands (uname -a, ping, and snapshot checks) after key stages made it immediate and obvious whether the deployment succeeded.
