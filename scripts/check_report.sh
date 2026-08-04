#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
report="$repo_dir/AMD_CONSUMER_PLATFORM_DEEP_RESEARCH.md"

[[ -f "$report" ]] || { echo "missing report: $report" >&2; exit 1; }

python3 - "$report" <<'PY'
import sys
import re
from collections import Counter
from pathlib import Path

text = Path(sys.argv[1]).read_text(encoding="utf-8")
han = sum(
    "\u3400" <= ch <= "\u4dbf"
    or "\u4e00" <= ch <= "\u9fff"
    or "\uf900" <= ch <= "\ufaff"
    for ch in text
)
unicode_chars = len(text)
minimum = 52_000
print(f"Unicode characters: {unicode_chars}")
print(f"Han characters: {han}")
print(f"Required Han characters: {minimum}")
if han < minimum:
    raise SystemExit(f"FAIL: report has {han} Han characters; need at least {minimum}")

headings = []
for lineno, line in enumerate(text.splitlines(), 1):
    match = re.match(r"^(#{1,6})\s+\S", line)
    if match:
        headings.append((lineno, len(match.group(1)), line))

if not headings or headings[0][0] != 1 or headings[0][1] != 1:
    raise SystemExit("FAIL: report must begin with exactly one level-1 title")
counts = Counter(level for _, level, _ in headings)
if counts[1] != 1:
    raise SystemExit(f"FAIL: expected exactly one H1; found {counts[1]}")
if counts[2] < 2 or counts[3] < 2:
    raise SystemExit(
        f"FAIL: expected multiple H2/H3 headings; found H2={counts[2]} H3={counts[3]}"
    )
for (previous_line, previous_level, _), (line, level, raw) in zip(headings, headings[1:]):
    if level > previous_level + 1:
        raise SystemExit(
            f"FAIL: heading level jumps from H{previous_level} at line {previous_line} "
            f"to H{level} at line {line}: {raw}"
        )

print("Heading counts:", " ".join(f"H{level}={counts[level]}" for level in range(1, 7)))
print("PASS: report length and heading structure gates")
PY
