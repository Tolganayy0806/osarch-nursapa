# Lab 4 Partition, mirror, fail, recover
Driver first half: Tolganay
Pair: none
Machine: lab01, guest Ubuntu
Date: 07.11.2026

## What I did
- Created and formatted partitions on Linux extra disks.
- Assembled them into a software RAID 1 mirror using mdadm.
- Wrote a test file and recorded its checksum.
- Simulated a disk failure and confirmed data integrity.
- Rebuilt the array with a spare disk.

## Result
Layout before and after disk failure is documented in the evidence folder.

## Question: Your colleague deleted the wrong file from the mirror an hour ago. Does RAID 1 help? Why?
No, RAID 1 does not help against accidental deletion because a mirror instantly replicates any changes—including file deletions—across all drives. To recover from human error, you need a proper backup or file snapshot, not a storage redundancy array.

## What did not work the first time
The array initially showed a degraded state during the failover simulation, which required manually failing and removing the faulty virtual disk before adding the spare to trigger the automatic rebuild.

## Evidence
- [evidence/lsblk-before.txt](evidence/lsblk-before.txt) layout before RAID configuration
- [evidence/mdadm-detail.txt](evidence/mdadm-detail.txt) healthy array details
- [evidence/mdadm-failed.txt](evidence/mdadm-failed.txt) state after simulated disk failure
- [evidence/lsblk-after-raid.txt](evidence/lsblk-after-raid.txt) layout after rebuilding the array
