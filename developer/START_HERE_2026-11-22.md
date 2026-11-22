# AIGMos 1.9 — START HERE (2026-11-22)

**Current status: UNLOCKED architecture decisions. Do not interpret these documents as CCF/CW-validated or immutable.**

Read in this order when beginning a fresh conversation:

1. [Latest 1.9 decision baseline v0.3.0](contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json) — machine-readable, 79 entries, including explicit open issues.
2. [Latest session handover v0.3.0](memos/2026-11-22_session_handover_v0.3.0.md) — complete boot/FILE/TER/Runner, MP/CP, AC and 1.8 #SYSTEM audit context.
3. [Three-line source header contract v0.2.0](contracts/AIGMos_1.9_Source_Dependency_Header_v0.2.0.json) — mandatory `deps`, `libs`, `target` on ALL source files including Hardcore.
4. Historical original architecture memo [2026-11-22_architecture_handover.md](memos/2026-11-22_architecture_handover.md) and older decision/header versions are **superseded wherever they conflict** with the files above.

## Nonnegotiable distinctions

- **AIGM** = platform-agnostic standard; **AIGMos** = implementation/reference; TER is AIGMos-internal.
- `# target: MP` works on MicroPython **and** CPython; `# target: CP` only CPython. No duplicate competing implementation.
- Build Tool prunes unselected features and transitive-exclusive dependencies. The NON-AC build must have no AC hook code; AC build includes dormant/active AC selectable at runtime.
- AC can be activated via CS, which uniquely persists `ac.enabled=true` into `config.json`; no CS deactivation. Direct file edit + restart needed to disable.
- MEM is volatile, FILE saves explicitly; no automatic MEM→FILE persistence.
- 1.8 `#SYSTEM` has other modules' Q/TER/Layout data: 1.9 ownership cleanup is the **immediate open design task**, not a finalized new path layout.

## Starter prompt for next session

> Continue AIGMos 1.9 architecture. Read `developer/START_HERE_2026-11-22.md`, then the linked v0.3.0 JSON baseline, v0.3.0 handover and v0.2.0 source header. Prioritize the current unresolved `#SYSTEM` ownership cleanup based on the verified 1.8 implementation. Ask one specific architectural question at a time. Never treat old two-line headers or automatic SQLite persistence as 1.9 decisions. Do not modify implementation files without explicit permission.

**Note:** No code changes or CCF/CW validator run are claimed by this documentation checkpoint.
