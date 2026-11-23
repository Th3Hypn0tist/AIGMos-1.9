# AIGMos 1.9 — Errors & Logging handover (2026-11-23)

**UNLOCKED.** CW and AIGMos 1.9 develop together. No validator pass, immutable lock or runtime implementation is claimed.

## Current contracts
- [Unified Errors and CSo](../contracts/AIGMos_1.9_Unified_Errors_CSo_v0.1.0.json)
- [CS Logging](../contracts/AIGMos_1.9_CS_Logging_v0.1.0.json)
- [Earlier legacy source audit](../audits/AIGMos_1.9_Errors_Logging_Source_Audit_2026-11-23_v0.1.0.json) — historical findings, not latest decisions.

## User-confirmed semantics
- CS is input; output is plain OK, actual command result, or common ERROR. Successful results are not forcibly wrapped.
- One Error mechanism in every component, including BOOT before CS, and User Modules.
- Error Buffer is separate: config.json length 1..N is newest N, 0 = all.
- Logger: off (default, no continuous success logging), cs (CS commands+params), ac (CS+params+AC actor).
- Logging-mode dependencies: off avoids continuous logger cost; cs needs CS; ac needs CS+AC.
- Every Error related to a CS execution causes ONE corresponding CS command+params record in Log Buffer, including when logging off. Already logged in cs/ac means no duplicate.
- Errors include available actor whenever AC is active irrespective of logging mode; never fabricate actor or command for pre-CS BOOT errors.
- Log Buffer has independent config length 1..N or 0=all. Logging cannot be completely off while Errors exist.
- Separate Audit/bot-training mechanism is not part of 1.9, but no removal of accepted Q/runtime features is authorized.

## Source mapping
- new.zip: new/docs/contracts/shared_error_audit_log_schema.json contains structured AIGMOS_ERROR_V1 and separate Audit clauses; retain only useful error/redaction ideas subject to new 1.9 contract.
- new/system/lib/contracts/errors.py provides build_contract_error/redact_for_contract; implementation is not wired into all runtime errors.
- new/system/cs/parser.py + reporter.py use HandlerResponse.error and $SYSTEM.ERRORS text, while BOOT/TER use boot_log. Requires consolidation.
- new/config.json contains no new Errors/Logging buffer or mode settings.

## Explicitly unresolved
Exact Error/CSo wire shape and collision when user data equals OK/ERROR; buffer ownership and early BOOT, precise config keys/defaults, MEM-vs-FILE persistence, secret-safe parameter capture, access rights, nested invocation correlation/dedupe, switching mode vs build closure, ac mode while AC runtime-disabled.

Reference: CW_CORE_v1.6.0 (CCF 2.6.0 / NodeTypes 1.19.0 / Rulesets 4.4.0), UNLOCKED opt-in. Source archive SHA-256 9c4d1a0223549f501eca64e3cc35b01d9cb00cabee2710ee608504f5df5145f9.
