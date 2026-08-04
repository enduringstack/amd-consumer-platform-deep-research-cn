#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_file="$repo_dir/research/sources-amd.md"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

find "$repo_dir/research" -maxdepth 1 -type f -name '*.md' ! -name 'sources-amd.md' -print0 \
  | xargs -0 grep -Eho '\[A[0-9]{3}\]' \
  | tr -d '[]' | sort -u > "$tmp_dir/used"
grep -Eo '^[-*] \[A[0-9]{3}\]' "$source_file" \
  | grep -Eo 'A[0-9]{3}' | sort -u > "$tmp_dir/defined"

comm -23 "$tmp_dir/used" "$tmp_dir/defined" > "$tmp_dir/undefined"
comm -13 "$tmp_dir/used" "$tmp_dir/defined" > "$tmp_dir/unused"

used_count="$(wc -l < "$tmp_dir/used" | tr -d ' ')"
defined_count="$(wc -l < "$tmp_dir/defined" | tr -d ' ')"
echo "used citation IDs: $used_count"
echo "defined source IDs: $defined_count"

failed=0
if [[ -s "$tmp_dir/undefined" ]]; then
  echo "FAIL: undefined citation IDs:" >&2
  cat "$tmp_dir/undefined" >&2
  failed=1
fi
if [[ -s "$tmp_dir/unused" ]]; then
  echo "FAIL: unused source IDs:" >&2
  cat "$tmp_dir/unused" >&2
  failed=1
fi
if (( defined_count < 60 )); then
  echo "FAIL: fewer than 60 defined sources" >&2
  failed=1
fi
(( failed == 0 )) || exit 1
echo "PASS: citation closure and minimum source count"
