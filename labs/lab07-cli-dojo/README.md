# Lab 7 — CLI dojo

Pair: Nursapa Tolganai (solo)          Driver first half: Nursapa Tolganai
Machine: Windows 11 guest VM (VMware) — `DESKTOP-4467D2D`, user `tolganay`
Shell: `cmd.exe` only (one elevated `cmd` for #18). No graphical tools were used.
Date: 2026-11-28

## Result

**20 of 20 solved.** Time = elapsed since the clock started at 15:58 (setup finished). The exact clock time of every challenge is in the `=====` headers of [evidence/output-all-challenges.txt](evidence/output-all-challenges.txt).

| # | Challenge | Command | Time |
|---|-----------|---------|------|
| 1 | Print the full path of the current directory | `cd` | 00:03 |
| 2 | Show the computer name and the logged-in account | `hostname & whoami` | 00:17 |
| 3 | Create `C:\dojo\logs\old` and `C:\dojo\backup` with one command | `mkdir C:\dojo\logs\old C:\dojo\backup` | 00:19 |
| 4 | One line: `notes.txt` with "dojo started" and the current time | `(echo dojo started& time /t) > C:\dojo\notes.txt` | 00:21 |
| 5 | Full path of the `ping` program | `where ping` | 00:22 |
| 6 | Only IPv4 address, default gateway and DNS servers | `ipconfig /all \| findstr /c:"IPv4" /c:"Default Gateway" /c:"DNS Servers"` | 00:24 |
| 7 | Save processes to `procs.txt`, print its line count | `tasklist > C:\dojo\procs.txt` then `find /c /v "" C:\dojo\procs.txt` | 00:26 |
| 8 | Start Notepad, find its PID, end it by PID | `start notepad` → `tasklist /fi "imagename eq notepad.exe"` → `taskkill /pid 3124 /f` | 00:31 |
| 9 | Only the ERROR lines of `app.log` | `findstr "ERROR" C:\dojo\logs\app.log` | 00:33 |
| 10 | Number of non-INFO lines in `app.log` | `type C:\dojo\logs\app.log \| find /v /c "INFO"` | 00:34 |
| 11 | Copy `app.log` to backup, size of both with one `dir` | `copy C:\dojo\logs\app.log C:\dojo\backup\` then `dir C:\dojo\logs\app.log C:\dojo\backup\app.log` | 00:36 |
| 12 | `dir C:\nothing-here`: nothing on screen, error in `errors.txt` | `dir C:\nothing-here > nul 2> C:\dojo\errors.txt` | 00:37 |
| 13 | One line: ping gateway once, print "gateway OK" / "gateway DOWN" | `ping -n 1 192.168.134.2 \| find "TTL=" > nul && echo gateway OK \|\| echo gateway DOWN` | 00:39 |
| 14 | Lines mentioning user1, case-insensitive, with line numbers | `findstr /i /n "user1" C:\dojo\logs\app.log` | 00:43 |
| 15 | `scores.txt` sorted from highest to lowest | `sort /r C:\dojo\scores.txt` | 00:44 |
| 16 | Only processes using more than 50 MB | `tasklist /fi "memusage gt 51200"` | 00:46 |
| 17 | Which process listens on TCP 135 (name, not PID) | `netstat -ano \| findstr /c:":135 " \| findstr LISTENING` then `tasklist /svc /fi "pid eq 932"` | 00:49 |
| 18 | `dojo.test` → 127.0.0.1, prove with ping, undo, prove again | elevated cmd: `copy hosts %TEMP%\hosts.bak`, `(echo.& echo 127.0.0.1 dojo.test) >> hosts`, `ipconfig /flushdns`, `ping -n 1 dojo.test`; undo: `copy /y %TEMP%\hosts.bak hosts`, `ipconfig /flushdns`, `ping -n 1 dojo.test` | 00:51 |
| 19 | Every file under `C:\dojo` with path and size in bytes | `for /r C:\dojo %f in (*) do @echo %~ff %~zf` | 00:54 |
| 20 | Mirror logs with robocopy, add/delete a file, print exit codes | `robocopy C:\dojo\logs C:\dojo\backup\logs /MIR /LOG+:C:\dojo\robocopy.log` then `echo %errorlevel%` (4 runs) | 00:54 |

## What I did

Setup (not scored), then every challenge in `cmd`. Selected commands with trimmed output:

```
C:\>ipconfig /all | findstr /c:"IPv4" /c:"Default Gateway" /c:"DNS Servers"
   IPv4 Address. . . . . . . . . . . : 192.168.134.131(Preferred)
   Default Gateway . . . . . . . . . : 192.168.134.2
   DNS Servers . . . . . . . . . . . : 192.168.134.2
```

```
C:\>type C:\dojo\logs\app.log | find /v /c "INFO"
11
```

```
C:\>netstat -ano | findstr /c:":135 " | findstr LISTENING
  TCP    0.0.0.0:135            0.0.0.0:0              LISTENING       932
C:\>tasklist /svc /fi "pid eq 932"
svchost.exe                    932 RpcEptMapper, RpcSs
```

```
C:\Windows\System32\drivers\etc>ping -n 1 dojo.test
Pinging dojo.test [127.0.0.1] with 32 bytes of data:
Reply from 127.0.0.1: bytes=32 time<1ms TTL=128
... after restoring hosts.bak and flushdns:
Ping request could not find host dojo.test. Please check the name and try again.
```

## Notes and explanations

- **#10** — 41 lines total, 30 are INFO, so 7 ERROR + 4 WARN = **11**. Piping through `type` makes `find` print only the number, without the file name.
- **#12** — `dir` writes "Volume in drive C…" to stdout (stream 1) and "File Not Found" to stderr (stream 2). `> nul` discards stdout, `2>` sends stderr to the file, so the screen stays empty.
- **#13** — `find "TTL="` matches only a real echo reply; `&&` runs when it succeeds, `||` when it fails, `> nul` hides ping's output.
- **#14** — 13 lines, not one: `findstr` matches substrings, so `user1` is also found inside `user10`…`user19` (11 INFO lines), plus one ERROR and one WARN line for user1. An exact match would be `findstr /i /n "user1\>"` (`\>` = end of word).
- **#15** — `sort /r` compares text, not numbers; it works here because all scores have two digits.
- **#16** — `memusage` is in KB: 50 MB × 1024 = 51200 KB (from `tasklist /?`).
- **#17** — port 135 is RPC Endpoint Mapper: process **svchost.exe**, PID 932, services **RpcEptMapper, RpcSs**.
- **#18** — the elevated prompt was opened with `powershell Start-Process cmd -Verb RunAs` (the UAC box was the only click). `echo.` adds a newline so the entry does not stick to the last line of `hosts`. The original file was restored from the backup.
- **#19** — documentation challenge, solved with `for /?`: `%~f` = full path, `%~z` = size in bytes, `/r` = recurse into subfolders.
- **#20** — documentation challenge, solved with `robocopy /?`. Robocopy exit codes are a bit mask, values below 8 are success:
  - run 1 → **1**: first mirror, files were copied;
  - run 2 → **1**: the new file `new.txt` was copied;
  - run 3 → **2**: `new.txt` was deleted from the source, so the destination had an extra file and `/MIR` removed it;
  - run 4 → **0**: source and destination identical, nothing to do.
  `/LOG+` appends to `robocopy.log` instead of overwriting it.

## What did not work the first time

- **Setup:** the first `for /l … >> C:\dojo\logs\app.log` line was pasted only partly (it ended at `login ok >>`), and cmd answered `The syntax of the command is incorrect`. Nothing had been written. I did `cd C:\dojo\logs` first and typed the shorter lines with `>> app.log` — the log then had the expected 41 lines.
- **#8:** `taskkill /pid 7340 /f` → `ERROR: The process "7340" not found`. I had used a PID from an example instead of the real one. `tasklist /fi "imagename eq notepad.exe"` showed PID 3124, and `taskkill /pid 3124 /f` worked (visible in ch08.png).
- **#17:** same mistake — `tasklist /svc /fi "pid eq 1052"` → `No tasks are running which match the specified criteria`. The real PID from `netstat` was 932 (visible in ch17.png).
- **Evidence file:** in my first attempt `output-all-challenges.txt` stayed empty because I created it in the editor instead of appending to it from `cmd`. This time every challenge was appended with `echo ===== #NN %time% ===== >> %EV%` and `[command] >> %EV% 2>&1`.

## Evidence

- [evidence/output-all-challenges.txt](evidence/output-all-challenges.txt) — header with clock time + output of every challenge #01–#20
- [evidence/screenshots/](evidence/screenshots/) — `ch01.png` … `ch20.png`, one terminal screenshot per challenge (command + output)