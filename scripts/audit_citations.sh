#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

python3 - "$repo_dir" <<'PY'
import csv
import re
import sys
from collections import Counter
from pathlib import Path

repo = Path(sys.argv[1])
research = repo / "research"
source_file = research / "sources-amd.md"
csv_file = repo / "data" / "product-matrix.csv"
errors = []

source_text = source_file.read_text(encoding="utf-8")
definition_pattern = re.compile(r"^- \[(A\d{3})\]\s+.*?(https://\S+)", re.MULTILINE)
definitions = definition_pattern.findall(source_text)
defined_ids = [source_id for source_id, _ in definitions]
source_urls = [url.rstrip(".,;:，。；：") for _, url in definitions]

all_source_lines = [line for line in source_text.splitlines() if line.startswith("- [A")]
if len(definitions) != len(all_source_lines):
    errors.append("one or more source entries lack a valid Axxx ID or HTTPS URL")

duplicate_ids = sorted(source_id for source_id, count in Counter(defined_ids).items() if count > 1)
duplicate_urls = sorted(url for url, count in Counter(source_urls).items() if count > 1)
if duplicate_ids:
    errors.append("duplicate source IDs: " + ", ".join(duplicate_ids))
if duplicate_urls:
    errors.append("duplicate source URLs: " + ", ".join(duplicate_urls))

defined = set(defined_ids)
content_files = sorted(
    path for path in research.glob("*.md")
    if path.name not in {"sources-amd.md", "references.md"}
)
used = set()
for path in content_files:
    used.update(re.findall(r"\[(A\d{3})\]", path.read_text(encoding="utf-8")))

undefined = sorted(used - defined)
unused = sorted(defined - used)
if undefined:
    errors.append("undefined citation IDs: " + ", ".join(undefined))
if unused:
    errors.append("unused source IDs: " + ", ".join(unused))
if len(defined) < 60:
    errors.append(f"fewer than 60 unique source IDs: {len(defined)}")

csv_rows = 0
with csv_file.open(encoding="utf-8", newline="") as handle:
    reader = csv.DictReader(handle)
    if not reader.fieldnames or "source_id" not in reader.fieldnames:
        errors.append("CSV is missing the source_id column")
    else:
        expected_columns = len(reader.fieldnames)
        for lineno, row in enumerate(reader, 2):
            csv_rows += 1
            if None in row or len(row) != expected_columns:
                errors.append(f"CSV row {lineno} has malformed column count")
                continue
            source_id = (row.get("source_id") or "").strip()
            if not source_id:
                errors.append(f"CSV row {lineno} has empty source_id")
            elif not re.fullmatch(r"A\d{3}", source_id):
                errors.append(f"CSV row {lineno} has invalid source_id format: {source_id}")
            elif source_id not in defined:
                errors.append(f"CSV row {lineno} uses undefined source_id: {source_id}")
if csv_rows < 46:
    errors.append(f"CSV has fewer than 46 product rows: {csv_rows}")

print(f"content files audited: {len(content_files)}")
print(f"used citation IDs: {len(used)}")
print(f"unique defined source IDs: {len(defined)}")
print(f"unique source URLs: {len(set(source_urls))}")
print(f"CSV product rows audited: {csv_rows}")
print("NOTE: this gate validates citation structure only; semantic evidence mapping requires human review.")

if errors:
    for error in errors:
        print("FAIL:", error, file=sys.stderr)
    raise SystemExit(1)
print("PASS: citation definitions, URLs,正文 usage, and CSV source linkage")
PY
