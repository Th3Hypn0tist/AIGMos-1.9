# AIGMos 1.9 — START HERE (2026-11-23)

**Development architecture remains UNLOCKED; no CCF/CW or runtime parity pass is claimed.**

**27 Nov ERROR always HARD FAIL:** [confirmed delta](contracts/AIGMos_1.9_Error_Always_Hard_Fail_Delta_v0.1.0.json), [Error record v0.1.2](contracts/AIGMos_1.9_Unified_Error_Record_CSo_Context_v0.1.2.json), [CW v0.1.5](canonical/AIGMos_1.9_Errors_Logging_CW_Candidate_v0.1.5.json), [65 test cases](tests/AIGMos_1.9_Errors_Logging_Contract_Tests_v0.1.4.json), [handover](memos/2026-11-27_error_always_hard_fail.md). Error can NEVER be soft/recoverable/warning/OK. Aborts originating execution; G11 tracks per-owner wider failure scope. UNLOCKED.

**27 Nov confirmed CSo internal status:** [decision](contracts/AIGMos_1.9_CSo_Internal_Outcome_Delta_v0.1.0.json), [record contract v0.1.1](contracts/AIGMos_1.9_Unified_Error_Record_CSo_Context_v0.1.1.json), [CW v0.1.4](canonical/AIGMos_1.9_Errors_Logging_CW_Candidate_v0.1.4.json), [57 tests](tests/AIGMos_1.9_Errors_Logging_Contract_Tests_v0.1.3.json), [handover](memos/2026-11-27_cso_internal_outcome.md). G01 internal status resolved, G10 external transport mapping remains open; UNLOCKED. No runtime code or CW ruleset changes.

**25 Nov confirmed Buffer owners & Error record:** [ownership](contracts/AIGMos_1.9_Error_Log_Buffer_Ownership_Delta_v0.1.0.json), [Error/CSo context](contracts/AIGMos_1.9_Unified_Error_Record_CSo_Context_v0.1.0.json), [CW v0.1.3](canonical/AIGMos_1.9_Errors_Logging_CW_Candidate_v0.1.3.json), [48 scenarios](tests/AIGMos_1.9_Errors_Logging_Contract_Tests_v0.1.2.json), [handover](memos/2026-11-25_error_record_cs_context.md). Ownership confirmed, exact Error fields remain candidate. UNLOCKED.

**25 Nov Error System Lib next pass:** [interface and Buffer candidate](contracts/AIGMos_1.9_Error_Library_And_Buffers_v0.1.0.json), [CW v0.1.2](canonical/AIGMos_1.9_Errors_Logging_CW_Candidate_v0.1.2.json), [36 scenarios](tests/AIGMos_1.9_Errors_Logging_Contract_Tests_v0.1.1.json) and [handover](memos/2026-11-25_errors_logging_library_buffers.md). Buffer ownership is **user confirmed**; Error->Logging physical source import remains an **unconfirmed proposal**. No runtime changes or official validator pass.

**25 Nov correction — Error is a LIBRARY:** [Error Library placement delta](contracts/AIGMos_1.9_Error_Library_Placement_Delta_v0.1.0.json) and [revised CW candidate v0.1.1](canonical/AIGMos_1.9_Errors_Logging_CW_Candidate_v0.1.1.json). Shared Error must work in BOOT before CS; HC.CS consumes the library and maps Error into CSo, not vice versa. Remaining G02 covers exact 1.9 file path and early buffer startup. UNLOCKED.

**25 Nov Errors/Logging CW formalization:** [canonical candidate](canonical/AIGMos_1.9_Errors_Logging_CW_Candidate_v0.1.0.json), [26-case acceptance matrix](tests/AIGMos_1.9_Errors_Logging_Contract_Tests_v0.1.0.json), [local preflight](audits/AIGMos_1.9_Errors_Logging_CW_Preflight_2026-11-25_v0.1.0.json), [handover](memos/2026-11-25_errors_logging_cw_formalization.md). Nine semantics remain explicit Gaps; NOT official CW validation.

**23 Nov Errors & Logging decisions:** [handover](memos/2026-11-23_errors_logging_handover.md), [Unified Errors / CSo](contracts/AIGMos_1.9_Unified_Errors_CSo_v0.1.0.json), [CS Logging](contracts/AIGMos_1.9_CS_Logging_v0.1.0.json). These user-confirmed rules supersede older speculative audit notes. CW Core v1.6.0 opt-in (CCF 2.6.0, NodeTypes 1.19.0, Rulesets 4.4.0) remains UNLOCKED while CW/AIGMos develop together.

**23 Nov Build Tool additions:** [Build Tool session handover](memos/2026-11-23_build_tool_session_handover.md) and three draft contracts: [Build Profile](contracts/AIGMos_1.9_Build_Profile_v0.1.0.json), [CodeMarkup integration](contracts/AIGMos_1.9_Build_CodeMarkup_Integration_v0.1.0.json), [Full Source Snapshot Build](contracts/AIGMos_1.9_Full_Source_Snapshot_Build_v0.1.0.json). Read these for later Build Tool discussions; they do not supersede unrelated 1.9 runtime decisions or modify CW Rulesets.

Read in this order:

1. `developer/START_HERE_2026-11-22.md` — preceding baseline and original navigation.
2. `developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json` — base 79 development decisions, historical 2026-11-22 status.
3. `developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json` — confirmed 2026-11-23 changes; use to reconcile superseded config assumptions.
4. `developer/audits/AIGMos_1.9_1.8_Cleanup_2026-11-23.md` — source-pinned feature inventory and structural cleanup.
5. `developer/memos/2026-11-22_session_handover_v0.3.0.md` and `developer/contracts/AIGMos_1.9_Source_Dependency_Header_v0.2.0.json` — prior runtime details and source dependency ABI.

**Structure derivability audit (2026-11-23):** [Structure-derived vs manually resolved pre-code requirements](audits/AIGMos_1.9_Structure_Derivability_Audit_2026-11-23_v0.1.0.json). CCF/CW can derive typed identities, links, closure and readiness from **explicitly modeled canonical data**, but existing 1.9 developer notes are not a complete CCF artifact and runtime behavior requires separate evidence.

**Source-header caution:** v0.2.0 still defines `target=MP` as compatible with both MP and CP. Proposed `target=BOTH` and distinct MP-only treatment require a versioned contract change; no silent migration. Basic pruning starts from one full-system source snapshot and does not solve dependency versions individually.

**Immediate next task:** Complete 1.8 source parity coverage and define component-owned /config, loader, Q default profile and AC activation exception. Never label this LOCKED until validation. Never modify runtime implementation without separate clear authorization.

**Highest-risk mistakes:** Carrying `#SYSTEM:config`/unconditional Q into MP, allowing CS filesystem access into /config, losing Q's queues or role/stream behavior, forgetting `q.default` in Q-enabled builds, and dropping 1.8 durable data functionality rather than giving it an explicit FILE path.
