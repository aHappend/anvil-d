# Anvil-D — Repository guide / 文件导航

[English](README.md) · [简体中文](README.zh-CN.md)

Documentation inventory checked on 2026-11-17, against repository base `993a1815b939cbbd77786240719fa84124e491c1`.

## Reading the inventory / 阅读方法

This is a path-level index, not a new experiment or a recertification. Each measurement belongs to the exact linked record and directory. Different copies of a chip can contain different source revisions and results. A recorded pass does not imply that another copy, model size, software stack or board image passed.

本页按实际路径列出交付物，不代表新实验或重新签核。同名芯片的多份目录可能有不同源码和结果；一份记录的通过不外推到其他副本、模型规模、软件栈或板卡镜像。

## Source, tests and reports / 源码、测试与报告

| Existing directory | Source / constraints | Public tests / technical documents | Reports |
| --- | --- | --- | --- |
| [`anvil-d1/`](anvil-d1/) | [`anvil-d1/rtl/`](anvil-d1/rtl/) | [`anvil-d1/tests/`](anvil-d1/tests/) · [`anvil-d1/design/`](anvil-d1/design/) | [`anvil-d1/REPORT.md`](anvil-d1/REPORT.md) · [`anvil-d1/REPORT.pdf`](anvil-d1/REPORT.pdf) · [`anvil-d1/SHOWCASE_REPORT.pdf`](anvil-d1/SHOWCASE_REPORT.pdf) · [`anvil-d1/SHOWCASE_REPORT.zh-CN.pdf`](anvil-d1/SHOWCASE_REPORT.zh-CN.pdf) |
| [`anvil-d2/`](anvil-d2/) | [`anvil-d2/rtl/`](anvil-d2/rtl/) | [`anvil-d2/tests/`](anvil-d2/tests/) · [`anvil-d2/design/`](anvil-d2/design/) | [`anvil-d2/REPORT.md`](anvil-d2/REPORT.md) · [`anvil-d2/REPORT.pdf`](anvil-d2/REPORT.pdf) · [`anvil-d2/SHOWCASE_REPORT.pdf`](anvil-d2/SHOWCASE_REPORT.pdf) · [`anvil-d2/SHOWCASE_REPORT.zh-CN.pdf`](anvil-d2/SHOWCASE_REPORT.zh-CN.pdf) |
| [`anvil_d1/`](anvil_d1/) | [`anvil_d1/rtl/`](anvil_d1/rtl/) | [`anvil_d1/tests/`](anvil_d1/tests/) · [`anvil_d1/design/`](anvil_d1/design/) | [`anvil_d1/REPORT.md`](anvil_d1/REPORT.md) · [`anvil_d1/REPORT.pdf`](anvil_d1/REPORT.pdf) · [`anvil_d1/SHOWCASE_REPORT.pdf`](anvil_d1/SHOWCASE_REPORT.pdf) · [`anvil_d1/SHOWCASE_REPORT.zh-CN.pdf`](anvil_d1/SHOWCASE_REPORT.zh-CN.pdf) |
| [`anvil_d2/`](anvil_d2/) | [`anvil_d2/rtl/`](anvil_d2/rtl/) | [`anvil_d2/tests/`](anvil_d2/tests/) · [`anvil_d2/design/`](anvil_d2/design/) | [`anvil_d2/REPORT.md`](anvil_d2/REPORT.md) · [`anvil_d2/REPORT.pdf`](anvil_d2/REPORT.pdf) · [`anvil_d2/SHOWCASE_REPORT.pdf`](anvil_d2/SHOWCASE_REPORT.pdf) · [`anvil_d2/SHOWCASE_REPORT.zh-CN.pdf`](anvil_d2/SHOWCASE_REPORT.zh-CN.pdf) |
| [`chips/anvil_d1/`](chips/anvil_d1/) | [`chips/anvil_d1/rtl/`](chips/anvil_d1/rtl/) | [`chips/anvil_d1/tests/`](chips/anvil_d1/tests/) · [`chips/anvil_d1/design/`](chips/anvil_d1/design/) | [`chips/anvil_d1/REPORT.md`](chips/anvil_d1/REPORT.md) · [`chips/anvil_d1/REPORT.pdf`](chips/anvil_d1/REPORT.pdf) · [`chips/anvil_d1/SHOWCASE_REPORT.pdf`](chips/anvil_d1/SHOWCASE_REPORT.pdf) · [`chips/anvil_d1/SHOWCASE_REPORT.zh-CN.pdf`](chips/anvil_d1/SHOWCASE_REPORT.zh-CN.pdf) |
| [`chips/anvil_d2/`](chips/anvil_d2/) | [`chips/anvil_d2/rtl/`](chips/anvil_d2/rtl/) | [`chips/anvil_d2/tests/`](chips/anvil_d2/tests/) · [`chips/anvil_d2/design/`](chips/anvil_d2/design/) | [`chips/anvil_d2/REPORT.md`](chips/anvil_d2/REPORT.md) · [`chips/anvil_d2/REPORT.pdf`](chips/anvil_d2/REPORT.pdf) · [`chips/anvil_d2/SHOWCASE_REPORT.pdf`](chips/anvil_d2/SHOWCASE_REPORT.pdf) · [`chips/anvil_d2/SHOWCASE_REPORT.zh-CN.pdf`](chips/anvil_d2/SHOWCASE_REPORT.zh-CN.pdf) |

## Public result records / 公开结果记录

Status and numbers below are transcribed only from the linked record. Functional simulation, generic synthesis, standalone/virtual-pin timing, bridge connectivity, workload readback and system-software execution are separate scopes. Missing entries mean that this index found no matching public record at that path, not that an experiment failed or never occurred.

下表状态与数值只来自对应文件。功能仿真、通用综合、独立 IP／虚拟引脚时序、桥接连通性、工作负载读回和系统软件执行分别解释；未列出不等于判定失败或从未做过。

| Exact directory | Record | Recorded result and scope |
| --- | --- | --- |
| `anvil-d1` | [`anvil-d1/evidence/verification-receipts.json`](anvil-d1/evidence/verification-receipts.json) | Recorded artifact; inspect its applicability, source binding and scope. |
| `anvil-d1` | [`anvil-d1/evidence/rtl-timing-lint.json`](anvil-d1/evidence/rtl-timing-lint.json) | recorded status: `passed` |
| `anvil-d1` | [`anvil-d1/evidence/quartus-sta.json`](anvil-d1/evidence/quartus-sta.json) | recorded status: `passed`; Fmax MHz: `102.46`; setup slack ns: `0.24`; hold slack ns: `0.037` |
| `anvil-d1` | [`anvil-d1/evidence/ppa-resource-summary.json`](anvil-d1/evidence/ppa-resource-summary.json) | Recorded artifact; inspect its applicability, source binding and scope. |
| `anvil-d1` | [`anvil-d1/evidence/board-hil.json`](anvil-d1/evidence/board-hil.json) | recorded status: `passed`; scope: BAR0/reg57 bridge-connectivity probe only; not per-chip workload execution |
| `anvil-d2` | [`anvil-d2/evidence/verification-receipts.json`](anvil-d2/evidence/verification-receipts.json) | Recorded artifact; inspect its applicability, source binding and scope. |
| `anvil-d2` | [`anvil-d2/evidence/rtl-timing-lint.json`](anvil-d2/evidence/rtl-timing-lint.json) | recorded status: `passed` |
| `anvil_d1` | [`anvil_d1/evidence/verification-receipts.json`](anvil_d1/evidence/verification-receipts.json) | Recorded artifact; inspect its applicability, source binding and scope. |
| `anvil_d1` | [`anvil_d1/evidence/rtl-timing-lint.json`](anvil_d1/evidence/rtl-timing-lint.json) | recorded status: `passed` |
| `anvil_d1` | [`anvil_d1/evidence/quartus-sta.json`](anvil_d1/evidence/quartus-sta.json) | recorded status: `passed`; Fmax MHz: `102.46`; setup slack ns: `0.24`; hold slack ns: `0.037` |
| `anvil_d1` | [`anvil_d1/evidence/ppa-resource-summary.json`](anvil_d1/evidence/ppa-resource-summary.json) | Recorded artifact; inspect its applicability, source binding and scope. |
| `anvil_d1` | [`anvil_d1/evidence/board-hil.json`](anvil_d1/evidence/board-hil.json) | recorded status: `passed`; scope: BAR0/reg57 bridge-connectivity probe only; not per-chip workload execution |
| `anvil_d2` | [`anvil_d2/evidence/verification-receipts.json`](anvil_d2/evidence/verification-receipts.json) | Recorded artifact; inspect its applicability, source binding and scope. |
| `anvil_d2` | [`anvil_d2/evidence/rtl-timing-lint.json`](anvil_d2/evidence/rtl-timing-lint.json) | recorded status: `passed` |
| `chips/anvil_d1` | [`chips/anvil_d1/evidence/verification-receipts.json`](chips/anvil_d1/evidence/verification-receipts.json) | Recorded artifact; inspect its applicability, source binding and scope. |
| `chips/anvil_d1` | [`chips/anvil_d1/evidence/rtl-timing-lint.json`](chips/anvil_d1/evidence/rtl-timing-lint.json) | recorded status: `passed` |
| `chips/anvil_d1` | [`chips/anvil_d1/evidence/quartus-sta.json`](chips/anvil_d1/evidence/quartus-sta.json) | recorded status: `passed`; Fmax MHz: `102.46`; setup slack ns: `0.24`; hold slack ns: `0.037` |
| `chips/anvil_d1` | [`chips/anvil_d1/evidence/ppa-resource-summary.json`](chips/anvil_d1/evidence/ppa-resource-summary.json) | Recorded artifact; inspect its applicability, source binding and scope. |
| `chips/anvil_d1` | [`chips/anvil_d1/evidence/board-hil.json`](chips/anvil_d1/evidence/board-hil.json) | recorded status: `passed`; scope: BAR0/reg57 bridge-connectivity probe only; not per-chip workload execution |
| `chips/anvil_d2` | [`chips/anvil_d2/evidence/verification-receipts.json`](chips/anvil_d2/evidence/verification-receipts.json) | Recorded artifact; inspect its applicability, source binding and scope. |
| `chips/anvil_d2` | [`chips/anvil_d2/evidence/rtl-timing-lint.json`](chips/anvil_d2/evidence/rtl-timing-lint.json) | recorded status: `passed` |

## File-management policy / 文件管理约定

- Keep RTL, constraints, tests and result originals in their existing locations. This documentation refresh does not move or delete them.
- Hyphenated, underscored and `chips/` directories are separate existing trees, not interchangeable aliases. The index lists all of them without declaring one authoritative.
- Preserve dated reports as publications. Update the README and this guide when the public source/evidence changes; do not silently rewrite an old result.
- Keep chip artifacts separate from the private Vulcan implementation. Public reproducibility instructions must not require private framework code or internal operation traces.

保留现有源码、约束、测试和原始证据路径；连字符、下划线和 `chips/` 多份目录不自动视为等价。历史报告保留其发表时范围，公开复现不得依赖私有框架实现。
