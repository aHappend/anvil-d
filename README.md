# Anvil-D Series — Autonomous DeepSeek-R1 / V3 / V2 MLA & Sparse MoE FPGA Accelerators

[**中文主页 (`README.zh-CN.md`)**](README.zh-CN.md) · [**Anvil-Q Series**](https://github.com/aHappend/anvil-q) · [**Anvil-D Series**](https://github.com/aHappend/anvil-d) · [**Anvil-QN Series**](https://github.com/aHappend/anvil-qn) · [**Anvil-E Series**](https://github.com/aHappend/anvil-e) · [**Anvil-EN Series**](https://github.com/aHappend/anvil-en) · [**Furnace-X SoCs**](https://github.com/aHappend/furnace-x) · [**Hammer-V RISC-V SoCs**](https://github.com/aHappend/hammer-v)

Peer flagship series alongside **Anvil-Q**, **Anvil-QN**, **Anvil-E**, and **Anvil-EN**. Evolved from parent **Anvil-Q2** (`134.81 MHz` GQA) into matrix-absorbed Multi-Head Latent Attention (`d_c = 256` KV latent + `d_r = 64` decoupled RoPE) and Top-K Shared+Routed Sparse MoE, verified across **6 model scales** (`DeepSeek-R1-Distill-1.5B/7B`, `DeepSeek-V2-Lite-16B`, `DeepSeek-V3-Lite-8B`, plus backward-compatible `Qwen2.5-0.5B/1.5B/3B`) and **8 physical on-board M20K HIL profiles** on Intel Arria 10 GX1150.

## Top-Level Chip Generations (Promoted to Repository Root)

| Chip Generation (Top-Level Dir) | Microarchitecture & Target Model Scope | Silicon Status | Top-Conference Whitepapers & RTL |
| :--- | :--- | :---: | :--- |
| **[`Anvil-D1` (`/anvil_d1/`)](anvil_d1/)** | DeepSeek-R1/V3 Latent MLA + Shared/Routed MoE Engine (25 SV, 113.02 MHz) | **SIGNED OFF (27 SV, 113.02 MHz, 8-Profile HIL)** | [`SHOWCASE_REPORT.pdf`](anvil_d1/SHOWCASE_REPORT.pdf) · [`中文白皮书`](anvil_d1/SHOWCASE_REPORT.zh-CN.pdf) · [`REPORT.pdf`](anvil_d1/REPORT.pdf) |
| **[`Anvil-D2` (`/anvil_d2/`)](anvil_d2/)** | DeepSeek-V3 Multi-Token Speculative MTP & Dual-Pipe Overlap Engine (28 SV, 113.02 MHz) | **Active Evolution (18 SV)** | [`SHOWCASE_REPORT.pdf`](anvil_d2/SHOWCASE_REPORT.pdf) · [`中文白皮书`](anvil_d2/SHOWCASE_REPORT.zh-CN.pdf) · [`REPORT.pdf`](anvil_d2/REPORT.pdf) |
| **[`Anvil-D3` (`/anvil_d3/`)](anvil_d3/)** | DeepSeek-V3.2 Fine-Grained Block-FP8/W4 Hybrid Quantization Engine | **Active Evolution (0 SV)** | [`anvil_d3/rtl/`](anvil_d3/rtl/) |
| **[`Anvil-D4` (`/anvil_d4/`)](anvil_d4/)** | DeepSeek-R2 Flagship 32K Long-Context Sparse-Attention MLA Engine | **Active Evolution (0 SV)** | [`anvil_d4/rtl/`](anvil_d4/rtl/) |

## Multi-Scale Model Matrix, Generational (`N-1`) Evolution & 8-Profile Arria 10 HIL

- **6 Evaluated Model Scales per Chip**: 4 native parameter scales + 2 backward-compatible parent-architecture model families, benchmarked against dual-socket Intel Xeon CPU (FP32) and NVIDIA Tesla V100 32GB GPU (FP16) across context lengths `128..4096`.
- **8-Profile Physical FPGA Board HIL**: 8 distinct on-board M20K weight/activation/token stimulus profiles executed on physical Intel Arria 10 GX1150 (`10AX115N2F45E1SG`, Chip ID `23645547322997765`) with 0 bit errors, plus heterogeneous multi-IP SoC board co-execution (`evidence/soc-board-coexecution.json`).
