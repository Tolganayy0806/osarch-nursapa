# Lab 7 — CLI dojo

Pair: Nursapa Tolganai
Driver first half: Nursapa Tolganai
Machine: Windows 11 VM (VMware) — DESKTOP-4467D2D (`tolganay`)
Date: 2026-11-26

## What I did

```text
## What I did


```

cd
C:\Users\Tolganay

```


```

hostname & whoami
DESKTOP-4467D2D
desktop-4467d2d\tolganay

```


```

mkdir C:\dojo\logs\old C:\dojo\backup

```


```

(echo dojo started & time /t) > C:\dojo\notes.txt
dojo started
11:33 AM

```


```

where ping
C:\Windows\System32\PING.EXE

```


```

findstr "ERROR" C:\dojo\logs\app.log
ERROR disk quota exceeded for user1
...
ERROR disk quota exceeded for user7

```


```

findstr "ERROR" C:\dojo\logs\app.log | find /c /v ""
7

```


```

findstr /R "^[89][0-9] ^100" C:\dojo\scores.txt
95 aidos
88 dana

```


```

copy C:\dojo\logs*.log C:\dojo\backup

C:\dojo\logs\app.log
1 file(s) copied.

```


```

move C:\dojo\notes.txt C:\dojo\backup

1 file(s) moved.

```


```

del C:\dojo\backup\notes.txt

```

```
```
<command>
<output, trimmed>
```

## Result

## Result

All 11 CLI dojo challenges were completed in Command Prompt (`cmd`) on the Windows 11 VM: created directories, wrote `notes.txt` with a timestamp, located `ping.exe`, filtered log errors and counted matches (7), filtered scores >= 80 (`95 aidos`, `88 dana`), copied `.log` files to `C:\dojo\backup\`, moved `notes.txt` into `C:\dojo\backup\`, and deleted it.

## What did not work the first time

- For Challenge #8, the initial `findstr /R "^8[0-9] \|^9[0-9] \|^100 " C:\dojo\scores.txt` pattern matched only `88 dana` because of how `\|` and spaces were parsed by `findstr`. Switching to `findstr /R "^[89][0-9] ^100" C:\dojo\scores.txt` returned both `95 aidos` and `88 dana`.

## Evidenceы

## Evidence

- [evidence/output-all-challenges.txt](evidence/output-all-challenges.txt) — combined outputs for challenges #01 through #11.
- [evidence/screenshots/ch01.png](evidence/screenshots/ch01.png) — proves current working directory (`cd`).
- [evidence/screenshots/ch02.png](evidence/screenshots/ch02.png) — proves computer name and current user (`hostname & whoami`).
- [evidence/screenshots/ch03.png](evidence/screenshots/ch03.png) — proves creation of `C:\dojo\logs\old` and `C:\dojo\backup`.
- [evidence/screenshots/ch04.png](evidence/screenshots/ch04.png) — proves `C:\dojo\notes.txt` contains `dojo started` and current time.
- [evidence/screenshots/ch05.png](evidence/screenshots/ch05.png) — proves full path to `PING.EXE` (`where ping`).
- [evidence/screenshots/ch06.png](evidence/screenshots/ch06.png) — proves all `ERROR` lines from `C:\dojo\logs\app.log`.
- [evidence/screenshots/ch07.png](evidence/screenshots/ch07.png) — proves count of `ERROR` lines in `C:\dojo\logs\app.log` (`7`).
- [evidence/screenshots/ch08.png](evidence/screenshots/ch08.png) — proves lines with scores >= 80 from `C:\dojo\scores.txt`.
- [evidence/screenshots/ch09.png](evidence/screenshots/ch09.png) — proves `.log` files copied from `C:\dojo\logs` to `C:\dojo\backup`.
- [evidence/screenshots/ch10.png](evidence/screenshots/ch10.png) — proves `C:\dojo\notes.txt` moved into `C:\dojo\backup`.
- [evidence/screenshots/ch11.png](evidence/screenshots/ch11.png) — proves `C:\dojo\backup\notes.txt` deleted.

