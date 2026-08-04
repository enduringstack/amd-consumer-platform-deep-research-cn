# AMD 产品名称、规格字段与对比口径速查

## 1. 名称只能用于导航

AMD 名称先帮助定位市场，不能代替规格。Ryzen表示客户端 CPU/APU，Threadripper表示 HEDT/工作站，EPYC表示服务器，Radeon RX表示消费显卡，Radeon PRO表示专业显卡，Instinct表示数据中心加速器，Ryzen Embedded/EPYC Embedded强调生命周期，Versal/FPGA属于自适应计算，Pensando属于网络基础设施。最终均回到精确料号与产品页。[A003]

系列数字可能表达产品世代、市场层级或组合，不能假设每位都固定。移动系列历史上可能在同一大系列混入不同 CPU架构；Ryzen AI新命名又按 AI PC重组。零售商标题常省略后缀，采购单必须写全名、OPN和 OEM型号。

## 2. Ryzen 3/5/7/9 与代际

Ryzen 3/5/7/9是市场层级，核心数随代际和桌面/移动变化。Ryzen 9通常更多核，Ryzen 7不保证永远8核，移动异构核心还需查 Zen 5/Zen 5c组合。数字9000/8000/7000不保证所有子系列同裸片或相同 PCIe。

桌面 Ryzen 9000的 X后缀常表示较高功耗/频率，非 X可为65W，F表示具体 SKU需独显，G通常强调较强集显，X3D表示 3D V-Cache。实际规则以规格页，不能给后缀赋未公布含义。[A002][A003]

`PRO`表示商用安全、管理和生命周期组合，性能基础可能接近非 PRO，OEM是否启用企业功能另查。`GE`等低功耗嵌入/桌面后缀也要查具体 TDP。盒装/Tray/MPK有不同产品 ID与保修渠道。

## 3. Ryzen AI 名称

Ryzen AI是 CPU、Radeon GPU和专用 XDNA NPU组合的品牌定义，不是只有 NPU。[A004] `AI 300`、`AI 400`、`AI Max`是家族；`Max+ 395`、`AI 9 HX 370`等尾部数字/层级定位具体 SKU。Max强调更大 iGPU和宽共享内存，普通 AI不应由名称推断同等位宽。

`HX`在 Ryzen AI名称中表示高性能定位，但 OEM仍可在可配置功耗内设计；不能把桌面 HX传统经验机械套入。`PRO`增加商用合同。处理器页面的“最多50 TOPS”通常指 NPU，整颗平台的 CPU/GPU计算不能混成相同口径。

AI 400在快照日正式扩展桌面与工作站，但仍须通过 OEM设备获得。[A081] 网页出现“laptops, desktops”不证明每个 SKU以插槽零售，更不证明任何 AM5主板可安装。

## 4. Threadripper 名称

Threadripper 9000面向高端桌面，`PRO 9000 WX`面向工作站。最高64核与96核是系列上限，具体9955WX/9975WX/9995WX核心数不同。所有9000均350W级定位也要查具体表。[A010]

平台名 TRX50/WRX90不是 CPU。TRX50四通道、较少 PCIe与 HEDT/部分 PRO兼容；WRX90八通道、更多 PCIe与 PRO管理。CPU可插不等于获得另一平台的通道。

## 5. Radeon RX 名称

RX 9000表示 RDNA 4消费家族，RX 9070 XT高于9070，9060级面向更主流。`XT`一般表示同级更高配置，`GRE`是特定市场/配置标签，不能按字母推核心。显存容量可能同一 GPU有多个版本。[A014]

板卡还带 AIB厂商后缀如 OC、Gaming、Nitro等，不是 AMD SKU。它们改变散热、频率、尺寸和保修。AMD“Game Clock”和“Boost Clock”定义不同：前者是典型游戏期望，后者是满足条件的最高，均非保证持续。

显卡规格中的 `Compute Units`跨 RDNA代际不能等性能；AI Accelerator、Ray Accelerator数量也需配架构。Stream Processor计数与 NVIDIA CUDA core不可一对一。TBP是整卡功耗口径，不是 GPU裸片 TDP。

## 6. Radeon PRO 名称

W7900/W7800等 W表示工作站，数字分层；`Dual Slot`描述板卡形态，可能影响功耗/频率。Radeon AI PRO R9700强调 AI/专业定位和 RDNA 4，仍要查显存、ECC、认证与 ROCm矩阵。[A016]

专业卡与消费卡即使同 gfx target，驱动、认证、显示和支持合同不同。ROCm表中的 Runtime/HIP SDK勾选是软件状态，不能由 PRO 名称推断。[A039]

## 7. Instinct 名称

MI300A的 A表示 CPU+GPU APU形态，MI300X是 GPU加速器；MI325X扩大 HBM，MI350X/MI355X属于 CDNA 4不同功耗/平台定位，MI350P为 PCIe卡。它们不能按数字大小当单一速度序列。[A034][A035]

`OAM`、`PCIe card`、平台/UBB是封装与系统形态。OAM峰值和功耗不能套给 PCIe；八 GPU平台互连也不是单卡规格。采购写 GPU型号、模组、HBM、TDP、主机和互连。

峰值表要附 FP64/FP32/TF32/FP16/BF16/FP8/FP6/FP4、matrix/vector、dense/sparse。把最小精度稀疏 PFLOPS与双精度 TFLOPS并列排名是口径错误。

## 8. EPYC 名称

EPYC 9005是 SP5 5th Gen家族，包含 Zen 5高性能与 Zen 5c密度 SKU。末尾字母可能区分单路、高频、缓存或电信等优化，规则随代际，必须查规格数据库。[A032][A033]

核心数不是全部：基础/boost、L3、TDP、内存速度、插槽数和 CXL同样重要。单路专用 SKU不能双路，双路能力也不表示必须双路。云虚拟机暴露 vCPU不等于物理 EPYC型号。

## 9. Embedded 与自适应计算

Embedded系列名后同数字可能与消费产品共享架构，却增加供货、宽温、RAS或封装。生命周期承诺以正式产品文档和合同，不能从网页长期存在推断。[A019][A059]

Versal AI Edge/AI Core/Premium/Prime/HBM各自偏 AI、通用、网络收发或内存。Adaptive SoC不是 CPU+GPU APU同义，它含可编程逻辑/AI Engine和 NoC。FPGA系列还按逻辑容量、DSP、收发器和封装选。[A057][A057][A058]

Pensando Pollara是 AI NIC，Salina是 DPU。端口 Gb/s不代表包处理、RDMA或集群吞吐，软件/交换生态必需。[A063][A063]

## 10. CPU 规格字段

`Cores/Threads`是可见核心/SMT线程；`Base Clock`不是典型全核固定频率；`Max Boost`是单核突发条件；`Default TDP`是平台热设计；`cTDP`给 OEM范围。实际 PPT/功耗需测。

`L2/L3 Cache`是总量还是每核需读表；X3D把堆叠计入 L3。`Processor Technology`节点是制造标签，不用于跨代面积比较。`Unlocked`允许调校但超出规格可能影响保修。

`PCIe version`是控制器能力，通道数和主板布线另查。`System Memory Specification`是官方速率条件，DIMM数量/rank可能降低。ECC support需要 CPU、主板、BIOS和 DIMM闭环。

## 11. GPU 规格字段

`CU`包含 SIMDs和纹理/相关资源，跨架构吞吐不同。`Game/Boost clock`随功耗温度，AIB可改。`Peak fill-rate/TFLOPS`理论且不含利用。`Infinity Cache`减少外部访问，不添加显存容量。

`Memory size/type/interface/speed`共同决定理论带宽；压缩与缓存影响有效。显示端口版本与最大组合要看脚注。媒体编码格式还看色深、profile和应用。

`Recommended PSU`是典型系统建议，不替代整机功耗计算；连接器和瞬态也查。卡长、高、槽厚决定安装。散热设计不是 GPU芯片规格。

## 12. NPU 与 AI 规格字段

TOPS=每秒万亿操作，必须有数据类型和计数规则。不同厂商是否把 MAC算一或两操作、是否用稀疏会不同。Copilot+门槛是平台资格，不是模型速度线性预测。

NPU支持精度、片上存储、带宽和编译覆盖决定有效。GPU AI TOPS与 NPU TOPS不能相加成应用值。CPU也可 AI，但向量指令和库口径不同。正确比较同模型、同质量、端到端能量。[A041]

## 13. 内存字段

DDR5双通道、Threadripper四/八通道、EPYC更多通道；LPDDR的256-bit是封装接口；Radeon GDDR6是独显；Instinct HBM3E在封装。它们的“GB”都表示容量，却具有完全不同的可升级、一致性与带宽。[A034]

共享内存 APU没有固定“显存”物理池，BIOS预留和动态借用；报告必须写总量与 GPU可用。独显显存物理固定，系统内存不能无损替代。CXL内存是远端层，不等同 DIMM本地。

## 14. 互连字段

PCIe `Gen x lanes`说明链路；物理插槽可能电气更少。USB4端口可能隧穿 PCIe/DP但 OEM实现。Infinity Fabric是内部架构族，不给所有产品同带宽。CXL需协议/设备/固件/OS。[A030][A052][A053]

Resizable BAR/SAM是地址窗口，不是带宽翻倍。[A054] GPU P2P、RDMA和多卡互连按平台。数据中心 GPU的 Infinity Fabric Link与桌面 CCD Fabric不应合并。

## 15. 功耗字段

CPU TDP、GPU TBP、APU cTDP、墙上功率和任务能量分开。移动 OEM可调整长期/短期，桌面 BIOS可启 PBO，显卡 AIB可提高 power limit。比较时恢复默认或明确。

每瓦性能=完成同任务的性能/功耗，任务能量=平均功耗×时间；两者回答不同。空闲/待机对移动和服务器 TCO重要。散热器标称瓦数无统一标准。

## 16. 上市和可用字段

Announcement date、launch date、shipping、OEM availability、channel stock和 software enablement是不同日期。路线图“预计”是未来条件。AMD Newsroom提供公告索引，但网页更新需存档。[A080]

产品规格出现日期可证明料号信息，不证明当地可买；OEM设备发布不证明所有配置；驱动列出设备不证明每个应用。报告的快照日期必须与动态事实并列。

## 17. 最小公平比较表

CPU：核心/线程、架构、缓存、内存、平台、默认功耗、持续频率、任务。GPU：架构、显存、TBP、驱动、游戏/API、画质/分辨率、帧时间。NPU：模型、精度、覆盖、端到端时延/能量。工作站：内存通道、PCIe、认证、服务。AI GPU：模组、HBM、精度/稀疏、互连、软件和集群。

所有表再加价格日期、地区和整机。缺字段留空，不用家族平均补。这样名称只作为索引，架构、die、package、family、SKU和 OEM终于不会混在同一列。
