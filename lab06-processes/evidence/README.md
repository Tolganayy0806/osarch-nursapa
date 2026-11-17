# Lab 6: Processes and Memory Management

## Driver first half: Nursapa Tolganay
## Pair: none
## Machine: ASUS B402 (Host), Ubuntu Server & Windows 11 Enterprise (Guests)
## Date: 2026-11-17

## What I did

1. **One process, three tools comparison:**
   - Selected a running process and located it simultaneously in Task Manager, Process Explorer on the Windows guest, and `htop` on the Linux guest[cite: 20].
   - Recorded its PID, parent PID (PPID), memory allocations, and open file descriptors/handles across the tools[cite: 20].
   - Analyzed discrepancies in naming conventions and metrics reported by the tools (e.g., Virtual Size vs. VIRT, Working Set vs. RES)[cite: 16].

2. **Memory pressure test & OOM Killer execution:**
   - Took a snapshot of the Linux guest prior to inducing memory exhaustion[cite: 21].
   - Measured baseline memory usage with `free -h`[cite: 21].
   - Ran a gradual memory-allocation Python script (100 MB per second) to force the system into memory pressure and swapping[cite: 21]:
     ```bash
     python3 -c "import time; a=[]; 
     while True:
         a.append(b'x' * 100_000_000)
         print(len(a) * 100, 'MB', flush=True)
         time.sleep(1)"
     ```
   - Monitored the transition from cache shrinkage to active swapping, system thrashing, and final process termination[cite: 18, 20].

3. **Kernel and Windows system event log extraction:**
   - Extracted the kernel's OOM killer response log:
     ```bash
     sudo dmesg -T | grep -i oom > ~/labs/lab06-processes/evidence/kernel-log-extract.txt
     ```
   - Captured final memory metrics to `memory-pressure.txt` using `free -h` during and after the test[cite: 21].
   - Located the corresponding resource exhaustion event (ID 2004) in the Windows event logs.

---

## Result

- **Three-Tool Disagreement Analysis:**
  - `htop` displays virtual memory as `VIRT` and resident physical memory as `RES`, while treating individual threads as separate rows by default[cite: 16, 17].
  - Process Explorer uses *Virtual Size* and *Working Set*, while providing granular details on process handles in its lower pane[cite: 16, 17].
  - Task Manager summarizes memory usage primarily through the *Working Set* and *Commit size* metrics in the Details tab.

- **Memory Pressure Experiment Summary:**
  - Initial `free -h` figures showed healthy available memory backed by Linux page caching[cite: 17, 21].
  - As memory allocation scaled up, the cache shrank, swap utilization increased (`swapon --show`), and responsiveness degraded into thrashing before the OOM killer terminated the resource-heavy Python process[cite: 17, 18].

---

## What did not work the first time

During the extraction of kernel logs via `dmesg`, running the command without root privileges initially failed with a `read kernel buffer failed: Operation not permitted` error. This was successfully resolved by prefixing the command with `sudo` and authenticating properly, allowing the OOM logs to be accurately piped into `kernel-log-extract.txt`. Furthermore, when pushing initial code changes to GitHub, a remote branch conflict occurred (`fetch first`), which was resolved by performing a clean rebase (`git pull origin main --rebase`) before pushing the finalized evidence files.

---

## Evidence

- [evidence/htop.png](evidence/htop.png) — `htop` process monitoring and resource breakdown[cite: 12]
- [evidence/process-explorer.png](evidence/process-explorer.png) — Process Explorer view showing process details and handles[cite: 12]
- [evidence/task-manager.png](evidence/task-manager.png) — Task Manager metrics comparison[cite: 8]
- [evidence/memory-pressure.txt](evidence/memory-pressure.txt) — `free -h` figures recorded before, during, and after the memory pressure test[cite: 12, 21]
- [evidence/kernel-log-extract.txt](evidence/kernel-log-extract.txt) — Extracted system logs verifying the Linux kernel OOM killer action[cite: 12]
