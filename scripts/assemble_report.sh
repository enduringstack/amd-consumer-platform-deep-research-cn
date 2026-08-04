#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
output="$repo_dir/AMD_CONSUMER_PLATFORM_DEEP_RESEARCH.md"

parts=(
  research/editorial.md
  research/architecture-evolution.md
  research/consumer-products.md
  research/sku-decoding-guide.md
  research/system-design-audit.md
  research/oem-compatibility-casebook.md
  research/deployment-blueprints.md
  research/benchmark-fieldbook.md
  research/product-portfolio.md
  research/memory-interconnect.md
  research/software-ai-ecosystem.md
  research/market-competition.md
  research/roadmap-risks.md
  research/references.md
  research/sources-amd.md
)

{
  printf '# AMD 消费端与完整产品体系深度研究\n\n'
  printf '> 研究快照：2026-08-04。本文件由 `scripts/assemble_report.sh` 从 `research/` 源章节确定性生成，请勿直接编辑。\n\n'
  printf '本报告覆盖 Ryzen 桌面/移动/APU、Ryzen AI/AI Max、Threadripper、Radeon、掌机、mini PC、半定制，以及 EPYC、Instinct、Embedded、Xilinx 自适应计算、Pensando DPU 和端到端软件体系。\n\n'
  for part in "${parts[@]}"; do
    printf '\n---\n\n'
    sed -E 's/^(#{1,5})([[:space:]])/#\1\2/' "$repo_dir/$part"
  done
} > "$output"

printf 'assembled %s from %d source files\n' "$output" "${#parts[@]}"
