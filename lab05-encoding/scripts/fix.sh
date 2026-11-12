#!/usr/bin/env bash
set -euo pipefail
SRC_ENC="CP1251"
IN=evidence/staff-broken.csv
OUT=evidence/staff-fixed.csv

{
iconv -f "$SRC_ENC" -t UTF-8 "$IN" | sed  's/\r$//'
} > "$OUT"

file -e csv "$OUT"
xxd -l 16 "$OUT"

