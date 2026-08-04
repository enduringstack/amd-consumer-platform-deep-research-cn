#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

grep -Eho 'https://[^][() <>]+' "$repo_dir"/research/*.md "$repo_dir"/README.md \
  | sed -E 's/[.,;:，。；：]+$//' | sort -u > "$tmp_dir/urls"

total="$(wc -l < "$tmp_dir/urls" | tr -d ' ')"

xargs -P 8 -n 1 bash -c '
  url="$1"
  code="$(curl -L -A "Mozilla/5.0 research-link-checker" --connect-timeout 8 --max-time 20 -sS -o /dev/null -w "%{http_code}" "$url" 2>/dev/null || true)"
  printf "%s\t%s\n" "${code:-000}" "$url"
' _ < "$tmp_dir/urls" > "$tmp_dir/results"

hard_fail=0
soft_fail=0
checked=0
while IFS=$'\t' read -r code url; do
  checked=$((checked + 1))
  case "$code" in
    404|410)
      echo "HARD $code $url"
      hard_fail=$((hard_fail + 1))
      ;;
    000|"")
      echo "WARN network $url"
      soft_fail=$((soft_fail + 1))
      ;;
    *)
      ;;
  esac
done < "$tmp_dir/results"

echo "unique links: $total"
echo "links checked: $checked"
echo "network warnings: $soft_fail"
echo "404/410 hard failures: $hard_fail"
(( hard_fail == 0 )) || exit 1
echo "PASS: no 404/410 links"
