# AMD 消费端与完整产品体系深度研究（中文）

一套截至 **2026-08-04**、证据可追溯、可机械装配与审计的 AMD 平台研究。主线覆盖 Ryzen 桌面/移动/APU、Ryzen AI/AI Max、Threadripper、Radeon、掌机、mini PC 和半定制；完整体系覆盖 EPYC、Instinct、Embedded、Xilinx 自适应计算/FPGA、Pensando DPU 与数据中心网络。

## 核心原则

- 区分 architecture、die、package、product family、具体 SKU 和 OEM 整机。
- 动态事实冻结在快照日；路线图只使用 AMD 正式披露。
- 技术事实优先 AMD 产品规格、白皮书、开发文档、SEC/IR 与官方源码。
- 峰值 TOPS/TFLOPS、厂商倍数和第三方测试必须保留精度、功耗与环境边界。
- 67 项可访问的一手/官方来源全部由正文实际引用，引用 ID 可机械审计。
- 自动门禁只验证 ID、URL、正文使用和 CSV 链接等结构，不验证一句话是否被来源语义支持；发布前必须人工逐句抽审。

## 文档导航

- [合并版报告](AMD_CONSUMER_PLATFORM_DEEP_RESEARCH.md)
- [编辑口径与结论](research/editorial.md)
- [架构演进：K8/Bulldozer/Zen/RDNA/CDNA/XDNA](research/architecture-evolution.md)
- [消费端产品体系](research/consumer-products.md)
- [产品名称与规格字段速查](research/sku-decoding-guide.md)
- [从芯片到 OEM 整机审计](research/system-design-audit.md)
- [OEM、内存与软件兼容案例簿](research/oem-compatibility-casebook.md)
- [十二类部署蓝图](research/deployment-blueprints.md)
- [持续性能与 AI 实验手册](research/benchmark-fieldbook.md)
- [完整产品组合：EPYC/Instinct/Xilinx/Pensando](research/product-portfolio.md)
- [内存、缓存与互连](research/memory-interconnect.md)
- [ROCm、HIP 与端侧 AI 软件](research/software-ai-ecosystem.md)
- [市场与竞争](research/market-competition.md)
- [正式路线图与风险](research/roadmap-risks.md)
- [来源账本](research/sources-amd.md)
- [引用复核指南](research/references.md)
- [代表产品矩阵 CSV](data/product-matrix.csv)

## 质量门禁

```bash
bash scripts/assemble_report.sh
bash scripts/check_report.sh
bash scripts/audit_citations.sh
perl scripts/check_duplicates.pl
bash scripts/check_links.sh
bash scripts/test_quality_gates.sh
```

`AMD_CONSUMER_PLATFORM_DEEP_RESEARCH.md` 是生成文件。修改源章节后先重新装配，再提交源文件与合并版。

## 适用与限制

本仓库适合产品规划、采购、技术选型、开发迁移和研究；不构成投资建议。OEM 功耗、内存、散热和固件会使同一移动 SKU 表现不同。ROCm、Ryzen AI Software、驱动和应用支持会持续变化，部署前必须复核当前官方矩阵。
