# Lab 5: Encoding Forensics

Operating Systems Architecture Laboratory Report.

## Objective
Investigation and resolution of text file encoding issues (`CP1251` to `UTF-8`) and line ending discrepancies (`CRLF` to `LF`), along with automation using shell scripts.

## Repository Structure
* `evidence/` — Directory containing execution results and verified files (including the fixed `staff-fixed.csv`).
* `scripts/` — Directory containing utility scripts (`fix.sh`) used for automated encoding conversion.

## Completed Steps
1. Performed diagnostics on the source file `staff-broken.csv` (identified `Windows-1251` encoding and `CRLF` carriage return characters).
2. Created and tested the `scripts/fix.sh` script to batch-convert text encodings to `UTF-8`.
3. Committed the results to the Git repository and successfully pushed them to GitHub.
