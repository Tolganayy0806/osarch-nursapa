# Task 3 - Diagnose

## Investigation Transcript

| # | Evidence file (command) | What I expected | What I found | What I concluded |
| :--- | :--- | :--- | :--- | :--- |
| 1 | `00-README.txt` | Mapping of evidence files to commands run on `office-srv` | `[Paste summary from 00-README.txt]` | Identified which commands produced each evidence file (`00-README.txt`). |
| 2 | `03-df-h.txt` / `04-free-h.txt` | Normal disk space and free memory | `[Exact disk and memory figures found]` | `[Dead end or finding + exact filename]` |
| 3 | `06-systemctl-list-timers.txt` / `07-systemctl-status-nightly-report.txt` / `08-systemctl-cat-nightly-report.txt` | Timer/service scheduled and unit definition visible | `[Exact timer/service state and unit content]` | `[Conclusion + exact filename]` |
| 4 | `09-journalctl-nightly-report.txt` / `12-journalctl-p-err-b.txt` | Logs showing why `/var/log/nightly-report.log` is not updated | `[Exact journal entries or errors found]` | `[Conclusion + exact filename]` |
| 5 | `16-cat-nightly-report-sh.txt` / `17-cat-A-nightly-report-sh.txt` / `18-head-1-od-c.txt` / `19-run-by-hand.txt` | Valid script, line endings, and manual run behavior | `[Exact script lines, control chars, and manual run output]` | `[Conclusion + exact filename]` |
| 6 | `13-ls-l-usr-local-bin.txt` / `14-ls-l-var-log.txt` / `15-tail-nightly-report-log.txt` / `21-apt-history.txt` / `22-bash-history-aigerim.txt` | Permissions, log tail, and recent changes from last week | `[Exact permissions, log tail, and history entries]` | `[Conclusion + exact filename]` |

## Root cause
`[1-2 clear sentences stating the exact root cause of why /var/log/nightly-report.log is not receiving reports every 2 minutes, citing the supporting evidence file(s).]`

## Fix
1. `[Exact command 1]`
2. `[Exact command 2]`
3. `[Exact command 3]`

## Verification
- **Commands:** `[Exact commands to verify the fix works now and persists after a reboot]`
- **Expected output:** `[Expected command output showing new log lines in /var/log/nightly-report.log and persistence across reboot]`
