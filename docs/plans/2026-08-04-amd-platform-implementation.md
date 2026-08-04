# AMD Platform Deep Research Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 建立并公开发布一套截至 2026-08-04、可复核且不少于 50,000 汉字的 AMD 消费端与完整平台中文深度研究。

**Architecture:** 使用专题 Markdown、共享编号来源账本和 CSV 产品矩阵作为单一事实源；根目录长报告由 shell 脚本确定性装配。质量脚本分别检查篇幅、引用闭包、重复段落和失效链接。

**Tech Stack:** Markdown、CSV、POSIX shell、Perl、Git、GitHub CLI。

---

### Task 1: 初始化设计基线

**Files:**
- Create: `docs/plans/2026-08-04-amd-platform-design.md`
- Create: `docs/plans/2026-08-04-amd-platform-implementation.md`

**Steps:**
1. 初始化 `main` 分支。
2. 写入设计与本计划。
3. 运行 `git diff --check`，预期无输出。
4. 提交 `docs: design AMD platform research repository`。

### Task 2: 建立证据账本和编辑规范

**Files:**
- Create: `research/editorial.md`
- Create: `research/sources-amd.md`
- Create: `research/references.md`

**Steps:**
1. 定向检索 AMD 官方产品页、架构文档、ROCm 文档和 SEC/IR 材料。
2. 为每一来源分配稳定的 `A001` 样式 ID，并记录标题、URL、机构、访问日期和用途。
3. 写明事实、推断、测试和路线图口径。
4. 暂运行引用审计，预期在正文未完成前报告未使用来源。

### Task 3: 撰写技术与产品章节

**Files:**
- Create: `research/architecture-evolution.md`
- Create: `research/consumer-products.md`
- Create: `research/product-portfolio.md`
- Create: `research/memory-interconnect.md`
- Create: `research/software-ai-ecosystem.md`
- Create: `research/market-competition.md`
- Create: `research/roadmap-risks.md`
- Create: `data/product-matrix.csv`

**Steps:**
1. 按架构、die、package、family、SKU、OEM 六层口径写作。
2. 覆盖用户要求的消费端、数据中心、嵌入式、DPU、软件和竞争维度。
3. 每一正文事实块加入来源 ID；每一个来源 ID 至少使用一次。
4. 检查 CSV 列数一致、关键家族均有代表条目。

### Task 4: 创建装配和质量脚本

**Files:**
- Create: `scripts/assemble_report.sh`
- Create: `scripts/check_report.sh`
- Create: `scripts/audit_citations.sh`
- Create: `scripts/check_duplicates.pl`
- Create: `scripts/check_links.sh`
- Create: `README.md`
- Generate: `AMD_CONSUMER_PLATFORM_DEEP_RESEARCH.md`

**Steps:**
1. 装配报告并统计 Unicode 字符与汉字。
2. 运行 `bash scripts/check_report.sh`，预期汉字数不少于 50,000。
3. 运行 `bash scripts/audit_citations.sh`，预期无未定义、无未使用。
4. 运行 `perl scripts/check_duplicates.pl`，预期重复长段落为 0。
5. 运行 `bash scripts/check_links.sh`，预期 404/410 硬失败为 0。
6. 运行 `git diff --check` 和敏感信息扫描，预期均通过。

### Task 5: 提交、发布与远端验收

**Files:**
- Stage: all required repository files

**Steps:**
1. 提交 `docs: publish AMD consumer platform deep research`。
2. 若远端不存在，运行 `gh repo create enduringstack/amd-consumer-platform-deep-research-cn --public --source=. --remote=origin --push`。
3. 若远端存在，先检查历史；仅在安全一致时接入并普通推送。
4. 用 GitHub API 检查 `isPrivate=false`、默认分支为 `main`、远端 SHA 等于本地 HEAD。
5. 用 Contents API 逐项验证根文件、全部 `research/` 文档、CSV、脚本与计划可见。
