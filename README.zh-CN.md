# Anvil-D 系列 — 自主演进 DeepSeek-R1 / V3 / V2 潜变量注意力 (MLA) 与稀疏 MoE FPGA 加速器家族

[**English README (`README.md`)**](README.md) · [**Anvil-Q 系列**](https://github.com/aHappend/anvil-q) · [**Anvil-D 系列**](https://github.com/aHappend/anvil-d) · [**Anvil-QN 系列**](https://github.com/aHappend/anvil-qn) · [**Anvil-E 系列**](https://github.com/aHappend/anvil-e) · [**Anvil-EN 系列**](https://github.com/aHappend/anvil-en) · [**Furnace-X 异构 SoC**](https://github.com/aHappend/furnace-x) · [**Hammer-V RISC-V SoC**](https://github.com/aHappend/hammer-v)

与 **Anvil-Q**、**Anvil-QN**、**Anvil-E**、**Anvil-EN** 完全平级的独立旗舰大模型芯片仓库。由父本 **Anvil-Q2**（`134.81 MHz` GQA）跨代演进为矩阵吸收式多头潜变量注意力（MLA，`d_c = 256` 潜变量 KV + `d_r = 64` 解耦 RoPE）与共享+路由稀疏 MoE 架构，完成 **6 款本命与向后兼容模型** 及 **物理 Arria 10 板卡 8-Profile 流式 HIL + 异构 SoC 连用实测**。

## 顶层芯片代际目录一览（已直接提升至仓库根目录）

| 芯片代际（顶层目录） | 微架构与目标大模型范围 | 硅签核状态 | 顶会级中英文白皮书 PDF 与 RTL |
| :--- | :--- | :---: | :--- |
| **[`Anvil-D1` (`/anvil_d1/`)](anvil_d1/)** | DeepSeek-R1/V3 Latent MLA + Shared/Routed MoE Engine (25 SV, 113.02 MHz) | **SIGNED OFF (27 SV, 113.02 MHz, 8-Profile HIL)** | [`SHOWCASE_REPORT.pdf`](anvil_d1/SHOWCASE_REPORT.pdf) · [`中文白皮书`](anvil_d1/SHOWCASE_REPORT.zh-CN.pdf) · [`REPORT.pdf`](anvil_d1/REPORT.pdf) |
| **[`Anvil-D2` (`/anvil_d2/`)](anvil_d2/)** | DeepSeek-V3 Multi-Token Speculative MTP & Dual-Pipe Overlap Engine (28 SV, 113.02 MHz) | **Active Evolution (18 SV)** | [`SHOWCASE_REPORT.pdf`](anvil_d2/SHOWCASE_REPORT.pdf) · [`中文白皮书`](anvil_d2/SHOWCASE_REPORT.zh-CN.pdf) · [`REPORT.pdf`](anvil_d2/REPORT.pdf) |
| **[`Anvil-D3` (`/anvil_d3/`)](anvil_d3/)** | DeepSeek-V3.2 Fine-Grained Block-FP8/W4 Hybrid Quantization Engine | **Active Evolution (0 SV)** | [`anvil_d3/rtl/`](anvil_d3/rtl/) |
| **[`Anvil-D4` (`/anvil_d4/`)](anvil_d4/)** | DeepSeek-R2 Flagship 32K Long-Context Sparse-Attention MLA Engine | **Active Evolution (0 SV)** | [`anvil_d4/rtl/`](anvil_d4/rtl/) |

## 多规模本命/兼容模型评测、父代（`N-1`）演进对比与 8-Profile 物理板卡 HIL

- **单芯片覆盖 6 款本命与向后兼容模型**：包含 4 个本命参数量级与 2 个向后兼容父代模型家族，在 `ctx = 128..4096` 全长序列下与同机双路 Xeon CPU (FP32) 及 Tesla V100 GPU (FP16) 进行吞吐、延迟、能效及抖动全面对比。
- **物理 Arria 10 板卡 8-Profile 流式 HIL 与异构 SoC 上板连用**：在 Intel Arria 10 GX1150 实机板卡（Chip ID `23645547322997765`）上跑通 8 组不同模型权重/激活/Token 激励配置及跨家族异构 SoC 连用流水线（详见 `evidence/soc-board-coexecution.json`）。
