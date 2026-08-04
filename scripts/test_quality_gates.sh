#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_root="$(mktemp -d)"
trap 'rm -rf "$tmp_root"' EXIT

make_audit_fixture() {
  local name="$1"
  local target="$tmp_root/$name"
  mkdir -p "$target/scripts" "$target/research" "$target/data"
  cp "$repo_dir/scripts/audit_citations.sh" "$target/scripts/"
  cp "$repo_dir"/research/*.md "$target/research/"
  cp "$repo_dir/data/product-matrix.csv" "$target/data/"
  printf '%s\n' "$target"
}

expect_failure() {
  local name="$1" pattern="$2"
  shift 2
  local output="$tmp_root/$name.output"
  if "$@" >"$output" 2>&1; then
    echo "FAIL: $name unexpectedly passed" >&2
    exit 1
  fi
  if ! grep -Fq "$pattern" "$output"; then
    echo "FAIL: $name did not report expected pattern: $pattern" >&2
    sed -n '1,120p' "$output" >&2
    exit 1
  fi
  echo "PASS negative: $name"
}

set_second_row_source_id() {
  local csv_file="$1" replacement="$2"
  awk -F, -v OFS=, -v replacement="$replacement" \
    'NR == 2 { $NF = replacement } { print }' \
    "$csv_file" > "$csv_file.tmp"
  mv "$csv_file.tmp" "$csv_file"
}

bash "$repo_dir/scripts/audit_citations.sh"
bash "$repo_dir/scripts/check_report.sh"

fixture="$(make_audit_fixture undefined_citation)"
printf '\n负向测试事实。[A999]\n' >> "$fixture/research/editorial.md"
expect_failure undefined_citation "undefined citation IDs: A999" bash "$fixture/scripts/audit_citations.sh"

fixture="$(make_audit_fixture duplicate_id)"
printf '%s\n' '- [A001] Duplicate ID. https://example.com/duplicate-id' >> "$fixture/research/sources-amd.md"
expect_failure duplicate_id "duplicate source IDs: A001" bash "$fixture/scripts/audit_citations.sh"

fixture="$(make_audit_fixture duplicate_url)"
first_url="$(grep -Eo 'https://[^ ]+' "$fixture/research/sources-amd.md" | head -1)"
printf '%s\n' "- [A999] Duplicate URL. $first_url" >> "$fixture/research/sources-amd.md"
printf '\n负向测试事实。[A999]\n' >> "$fixture/research/editorial.md"
expect_failure duplicate_url "duplicate source URLs:" bash "$fixture/scripts/audit_citations.sh"

fixture="$(make_audit_fixture reference_only)"
printf '%s\n' '- [A999] Reference-only source. https://example.com/reference-only' >> "$fixture/research/sources-amd.md"
printf '\n[A999]\n' >> "$fixture/research/references.md"
expect_failure reference_only "unused source IDs: A999" bash "$fixture/scripts/audit_citations.sh"

fixture="$(make_audit_fixture empty_csv_source)"
set_second_row_source_id "$fixture/data/product-matrix.csv" ""
expect_failure empty_csv_source "empty source_id" bash "$fixture/scripts/audit_citations.sh"

fixture="$(make_audit_fixture invalid_csv_source)"
set_second_row_source_id "$fixture/data/product-matrix.csv" "BAD"
expect_failure invalid_csv_source "invalid source_id format: BAD" bash "$fixture/scripts/audit_citations.sh"

fixture="$(make_audit_fixture undefined_csv_source)"
set_second_row_source_id "$fixture/data/product-matrix.csv" "A999"
expect_failure undefined_csv_source "undefined source_id: A999" bash "$fixture/scripts/audit_citations.sh"

title_fixture="$tmp_root/broken_title"
mkdir -p "$title_fixture/scripts"
cp "$repo_dir/scripts/check_report.sh" "$title_fixture/scripts/"
cp "$repo_dir/AMD_CONSUMER_PLATFORM_DEEP_RESEARCH.md" "$title_fixture/"
perl -pi -e 'if ($. == 1) { s/^# /##### / }' "$title_fixture/AMD_CONSUMER_PLATFORM_DEEP_RESEARCH.md"
expect_failure broken_title "report must begin with exactly one level-1 title" bash "$title_fixture/scripts/check_report.sh"

echo "PASS: all positive baselines and negative quality-gate tests"
