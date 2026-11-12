# Lab 5 — Encoding forensics

## Diagnosis (before the fix)
file says:      (from evidence/file-before.txt)
First 16 bytes: (from evidence/hexdump-before.txt, with the table:
                 offset | bytes | what they are)

| Offset | Bytes | What they are |
| :--- | :--- | :--- |
| 00-03 | c8 e0 2c 25 | First characters and comma separator |

Encoding:     CP1251 — evidence: single-byte Cyrillic code points and correct decoding of Kazakh letters via iconv
Line ending:  CRLF — evidence: cat -A shows ^M$ at line ends
BOM:          absent — evidence: does not start with EF BB BF

## What each application was doing wrong
Excel:        assumed system default ANSI encoding because it mapped single-byte CP1251 bytes into incorrect mojibake characters.
LibreOffice:  guessed an alternative character set during CSV import, resulting in a different incorrect visual output.
cat:          printed raw bytes directly to a UTF-8 terminal without translation, causing unreadable characters.

## Fix
Command / script: scripts/fix.sh
Changed: encoding CP1251 -> UTF-8; line ending changed to LF;
         BOM absent / kept without BOM because standard Linux tools process non-BOM files cleanly.

## Verification
file after:   (from evidence/file-after.txt)
Opened in:    Excel (Desktop version), LibreOffice Calc, cat on Ubuntu
              — evidence/opens-correctly.png
