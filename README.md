# Anvil-D — MLA and sparse-MoE accelerator RTL

[English](README.md) · [简体中文](README.zh-CN.md) · [Repository guide / 文件导航](REPOSITORY_GUIDE.md)

Documentation updated: 2026-11-17. This page describes a repository snapshot, not a live job dashboard.

## Overview

**Anvil-D** publishes chip RTL, technical reports and verification artifacts. DeepSeek-oriented matrix-absorbed latent attention, decoupled RoPE, shared/routed experts and multi-token prediction research.

The chip project is public; Vulcan itself remains private and closed-source. Future public releases must be limited to chip technology and public reproducibility materials, excluding Vulcan internal architecture and operating materials. This refresh organizes documentation only; it is not a comprehensive disclosure audit of historical material and does not claim that the existing repository tree has undergone such clearance.

## Scope and evidence

Use the [exact-directory result index](REPOSITORY_GUIDE.md). Functional simulation, synthesis, standalone/virtual-pin timing, board-bridge probing, workload readback and system-software execution are different evidence scopes. A pass at one scope does not establish another. Existing historical results are retained; this documentation refresh neither upgrades nor invalidates them.

Read timing, utilization and performance values from their specific records and applicability conditions; results from differently located copies are not merged. This page makes no fleet-wide claim of physical-board completion, full-model inference, physical Linux boot or measured power/energy efficiency.

## Repository guide

The [repository guide](REPOSITORY_GUIDE.md) lists existing source, constraints, tests, reports and result paths. Hyphenated, underscored and `chips/` directories can be different publication copies; none is silently designated authoritative, moved or deleted.

Start reproduction from the selected chip’s public specification, test instructions and scripts. Tool, input and board requirements belong to that directory. Chip experiments were not rerun as part of this documentation update.

## Existing chip directories

| Chip / variant | Existing root paths | Public artifacts |
| --- | --- | --- |
| ANVIL-D1 | [`anvil-d1/`](anvil-d1/) · [`anvil_d1/`](anvil_d1/) | [REPORT.md](anvil-d1/REPORT.md) · [REPORT.pdf](anvil-d1/REPORT.pdf) · [SHOWCASE_REPORT.pdf](anvil-d1/SHOWCASE_REPORT.pdf) · [SHOWCASE_REPORT.zh-CN.pdf](anvil-d1/SHOWCASE_REPORT.zh-CN.pdf) |
| ANVIL-D2 | [`anvil-d2/`](anvil-d2/) · [`anvil_d2/`](anvil_d2/) | [REPORT.md](anvil-d2/REPORT.md) · [REPORT.pdf](anvil-d2/REPORT.pdf) · [SHOWCASE_REPORT.pdf](anvil-d2/SHOWCASE_REPORT.pdf) · [SHOWCASE_REPORT.zh-CN.pdf](anvil-d2/SHOWCASE_REPORT.zh-CN.pdf) |

## Architecture and publication scope / 架构与发表范围

- D1: latent-attention matrix absorption, decoupled RoPE and shared/routed sparse-expert datapaths.
- D2: multi-token prediction and overlapped compute/data-transfer research.
- D3/D4 appeared in earlier roadmap text but have no corresponding published directories in this snapshot. They are not delivered implementations.

Model names describe target architectures and configurations, not proof that all parameters, context lengths or complete models executed on the FPGA. Consult the specific test and result bindings. / 模型名称表示目标架构与配置，不代表所有参数量、上下文或完整模型已在 FPGA 执行。

## Related projects

- AI / embeddings: [Anvil-Q](https://github.com/aHappend/anvil-q), [Anvil-E](https://github.com/aHappend/anvil-e), [Anvil-QN](https://github.com/aHappend/anvil-qn), [Anvil-EN](https://github.com/aHappend/anvil-en), [Anvil-D](https://github.com/aHappend/anvil-d).
- Systems: [Hammer-V](https://github.com/aHappend/hammer-v), [Furnace-X](https://github.com/aHappend/furnace-x).
- DSP / vision: [Billet-F](https://github.com/aHappend/billet-f), [Billet-T](https://github.com/aHappend/billet-t), [Swage-S](https://github.com/aHappend/swage-s).
- Data / security / graphics: [Bellows-L](https://github.com/aHappend/bellows-l), [Bellows-N](https://github.com/aHappend/bellows-n), [Rivet-A](https://github.com/aHappend/rivet-a), [Rivet-H](https://github.com/aHappend/rivet-h), [Crucible-G](https://github.com/aHappend/crucible-g), [SABLE](https://github.com/aHappend/sable).
- [Public fleet catalog](https://github.com/aHappend/vulcan-showcase). Related independent research: [ACE-2](https://github.com/aHappend/ace-2), [ACE-3](https://github.com/aHappend/ace-3); these retain their own provenance and acceptance boundaries.
- DSpark is a research direction, not a published chip delivery in this repository; no implementation or repository link is asserted here.
