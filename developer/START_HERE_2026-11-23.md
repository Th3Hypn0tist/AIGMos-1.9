# AIGMos 1.9 — START HERE (2026-11-23)

**Development architecture remains UNLOCKED; no CCF/CW or runtime parity pass is claimed.**

Read in this order:

1. `developer/START_HERE_2026-11-22.md` — preceding baseline and original navigation.
2. `developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json` — base 79 development decisions, historical 2026-11-22 status.
3. `developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json` — confirmed 2026-11-23 changes; use to reconcile superseded config assumptions.
4. `developer/audits/AIGMos_1.9_1.8_Cleanup_2026-11-23.md` — source-pinned feature inventory and structural cleanup.
5. `developer/memos/2026-11-22_session_handover_v0.3.0.md` and `developer/contracts/AIGMos_1.9_Source_Dependency_Header_v0.2.0.json` — prior runtime details and source dependency ABI.

**Immediate next task:** Complete 1.8 source parity coverage and define component-owned /config, loader, Q default profile and AC activation exception. Never label this LOCKED until validation. Never modify runtime implementation without separate clear authorization.

**Highest-risk mistakes:** Carrying `#SYSTEM:config`/unconditional Q into MP, allowing CS filesystem access into /config, losing Q's queues or role/stream behavior, forgetting `q.default` in Q-enabled builds, and dropping 1.8 durable data functionality rather than giving it an explicit FILE path.
