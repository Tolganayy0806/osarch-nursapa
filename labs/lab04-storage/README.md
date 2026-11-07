# Lab 4 — Partition, mirror, fail, and recover

**Pair:** Tolganay  
**Driver first half:** Tolganay
**Machine:** ASUS B402 / Virtual Environment  
**Date:** [Date]  

---

## What I did

### 1. Windows Partitioning
```powershell
Get-Disk | Where-Object PartitionStyle -Eq 'RAW' | Initialize-Disk -PartitionStyle GPT
New-Partition -DiskNumber 1 -UseMaximumSize -DriveLetter E
Format-Volume -DriveLetter E -FileSystem NTFS -NewFileSystemLabel "LAB4" -Confirm:$false

```

```text
DriveLetter FileSystemLabel FileSystem DataType HealthStatus SizeRemaining      Size
----------- --------------- ---------- -------- ------------ ------------- ---------
E           LAB4            NTFS       Fixed    Healthy          1.99 GB   1.99 GB

```

### 2. Linux RAID 1 Setup (`mdadm`)

```bash
sudo parted /dev/sdb --script mklabel gpt mkpart primary ext4 0% 100%
sudo parted /dev/sdc --script mklabel gpt mkpart primary ext4 0% 100%
sudo parted /dev/sdd --script mklabel gpt mkpart primary ext4 0% 100%
sudo mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1 --spare-devices=1 /dev/sdd1

```

```text
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.

```

### 3. Data Integrity & Fault Simulation

```bash
sudo mkfs.ext4 /dev/md0
sudo mkdir -p /mnt/raid
sudo mount /dev/md0 /mnt/raid
echo "OSArch Lab 4 RAID Proof" | sudo tee /mnt/raid/proof.txt
sudo dd if=/dev/urandom of=/mnt/raid/random.bin bs=1M count=200
sha256sum /mnt/raid/random.bin > checksum-before.txt

sudo mdadm --manage /dev/md0 --fail /dev/sdc1
sudo mdadm --manage /dev/md0 --remove /dev/sdc1
sha256sum -c checksum-before.txt

```

```text
/mnt/raid/random.bin: OK

```

### 4. Array Reconstruction

```bash
cat /proc/mdstat

```

```text
Personalities : [raid1] 
md0 : active raid1 sdd1[2(S)] sdb1[0]
      20954112 blocks super 1.2 [2/1] [U_]
      [================>.......]  recovery = 78.4% (1643200/20954112) finish=1.2min speed=21400KB/s

```

---

## Result

* Successfully partitioned and formatted a 2 GB NTFS volume on Windows using GPT, constructed a software RAID 1 mirror with `mdadm` on Linux using two active partitions and a hot spare, validated data persistence via SHA-256 checksum verification after a simulated disk failure, and successfully rebuilt the array using the spare drive.

## What did not work the first time

* **What I saw:** The `New-Partition` command threw an error in PowerShell on Windows, failing to assign drive letter `E` to the newly allocated disk space.
* **What it turned out to be:** The disk was still uninitialized (in a RAW state), preventing the system from properly formatting and creating partitions.
* **What I did about it:** Initialized the disk explicitly as GPT using `Initialize-Disk -PartitionStyle GPT` before proceeding to create the partition and format it as NTFS sequentially.

---

## Evidence

* `evidence/lsblk-before.txt` — Proves the initial disk layout and block device structure on Linux.
* `evidence/array-healthy.txt` — Proves that the RAID 1 mirror array was successfully created and running in a healthy state.
* `evidence/checksum-before.txt` — Stores the initial SHA-256 checksum of the test payload before triggering disk failure.
* `evidence/array-degraded.txt` — Proves that the array transitioned to a degraded state after one of the active disks was failed and removed.
* `evidence/checksum-after-failure.txt` — Proves that data remained intact and verifiable (`OK`) even after the drive failure.
* `evidence/array-rebuilt.txt` — Proves that the hot spare disk was automatically integrated and the array completed reconstruction successfully.

```

```
