# Lab 6: Processes and Memory Management

- **Driver first half:** Nursapa Tolganay
- **Pair:** none
- **Machine:** ASUS B402 (Host), Ubuntu Server & Windows 11 Enterprise (Guests)
- **Date:** 2026-11-17

## What I did

1. **One process, three tools comparison:**
   - Located processes across `htop` on the Linux guest and Task Manager / Process Explorer on the Windows guest.
   - Compared PID/PPID, memory metrics, and open handles/file descriptors.
   - Noted differences in metric names and units (such as `VIRT` vs. Virtual Size and `RES` vs. Working Set).

2. **Memory pressure test & OOM Killer execution:**
   - Captured a VMware snapshot of the Linux guest before testing memory exhaustion.
   - Recorded baseline memory usage with `free -h`.
   - Ran a 100 MB/s memory-allocation loop in Python to trigger memory pressure and swap activity:
     ```bash
     python3 -c "import time; a=[]; while True: a.append(b'x' * 100_000_000); print(len(a) * 100, 'MB', flush=True); time.sleep(1)"
     ```
   - Observed cache shrinkage, swap usage, responsiveness changes, and process termination/kernel response.

3. **Kernel and system log extraction:**
   - Saved kernel log output to `~/labs/lab06-processes/evidence/kernel-log-extract.txt`.
   - Recorded `free -h` outputs before, during, and after the test in `~/labs/lab06-processes/evidence/memory-pressure.txt`.

## Result

- **Three-Tool Disagreement Analysis:** `htop` reports `VIRT` and `RES` (and can show threads separately), while Windows tools report metrics such as Working Set, Commit, and Virtual Size along with handle details.
- **Memory Pressure Experiment Summary:** Available memory and page cache dropped as allocation grew, swap absorbed part of the pressure, and memory exhaustion led to process termination or kernel memory-pressure logs.

## What did not work the first time

- Running `dmesg` without `sudo` failed with a permission error on the kernel log buffer, which resolved once run with `sudo`.
- Pushing to `origin main` initially failed with a non-fast-forward / `fetch first` rejection and a conflict in `evidence/memory-pressure.txt`, which was resolved by pulling with rebase (`git pull --rebase origin main`), keeping the resolved file, finishing the rebase, and pushing.

## Evidence

- `evidence/htop.png` — `htop` process monitoring view
- `evidence/process-explorer.png` — Process Explorer view
- `evidence/task-manager.png` — Task Manager view
- `evidence/memory-pressure.txt` — `free -h` outputs before, during, and after the memory pressure test
- `evidence/kernel-log-extract.txt` — Kernel log extract from the memory pressure test
