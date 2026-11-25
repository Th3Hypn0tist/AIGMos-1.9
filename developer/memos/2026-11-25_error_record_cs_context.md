# AIGMos 1.9 — Error ownership & record model (2026-11-25)

**UNLOCKED. No runtime or CW Ruleset modifications; no official validator pass.**

## Confirmed

Error is a shared System Lib, and **Error owns Error Buffer**. **Logging owns Log Buffer**. Both buffer counts are independent config.json values, where positive N retains last N and zero retains all. CS is input; CSo returns OK / actual command response / ERROR. A CS Error produces one command+parameter log, even in normal logging mode off. An active AccessCore adds available actor context to every Error regardless of Logging mode. There is no separate Audit system.

## New machine-readable artifacts
- [Confirmed ownership delta](../contracts/AIGMos_1.9_Error_Log_Buffer_Ownership_Delta_v0.1.0.json)
- [Error record and CS context candidate](../contracts/AIGMos_1.9_Unified_Error_Record_CSo_Context_v0.1.0.json)
- [CW candidate v0.1.3](../canonical/AIGMos_1.9_Errors_Logging_CW_Candidate_v0.1.3.json)
- [48 scenario matrix](../tests/AIGMos_1.9_Errors_Logging_Contract_Tests_v0.1.2.json)
- [Local structural preflight](../audits/AIGMos_1.9_Errors_Logging_CW_Preflight_2026-11-25_v0.1.3.json)

## Proposed, not approved

Minimal Error record candidate: required code/message/source; optional operation/details/correlation_id/cs/ac. Single Error.report entrypoint records once, optionally receives explicit CS invocation context, actor supplied from the execution boundary. Do not introduce direct Error imports of HC.CS or AccessCore. Dedupe by invocation, not command string. Internal OK/ERROR tagging may be needed when a successful command returns the text ERROR, but public CSo success payload stays unwrapped. Source-level ERROR->LOGGING import versus sink injection remains an open choice.

## Remaining design gates

Exact Error record shape and return ABI, sensitive CS argument masking, early BOOT buffer before config, config.json buffer keys/defaults, 0=all MP resource handling, optional FILE persistence, and AC-runtime-disabled case in logging mode ac.

Local checks: 17 nodes, 45 properties, 6 dependency links, 2 ownership links, 9 gaps, 48 defined tests; 0 structural findings. **Not formal CW validation and not executed runtime tests.**
