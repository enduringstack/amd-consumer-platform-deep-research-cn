#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
report="$repo_dir/AMD_CONSUMER_PLATFORM_DEEP_RESEARCH.md"

[[ -f "$report" ]] || { echo "missing report: $report" >&2; exit 1; }

python3 - "$report" <<'PY'
import sys
from pathlib import Path

text = Path(sys.argv[1]).read_text(encoding="utf-8")
han = sum(
    "\u3400" <= ch <= "\u4dbf"
    or "\u4e00" <= ch <= "\u9fff"
    or "\uf900" <= ch <= "\ufaff"
    for ch in text
)
unicode_chars = len(text)
minimum = 50_000
print(f"Unicode characters: {unicode_chars}")
print(f"Han characters: {han}")
print(f"Required Han characters: {minimum}")
if han < minimum:
    raise SystemExit(f"FAIL: report has {han} Han characters; need at least {minimum}")
print("PASS: report length gate")
PY
