# AIGMos 1.9 — Shared Error System Lib, interface and buffers (2026-11-25)

**UNLOCKED / CANDIDATE. No runtime code modified, official CW validation NOT run.**

## Confirmed
Error is a shared System Lib, independent of HC.CS, usable by BOOT and User Modules. One Error protocol. CSo = OK / actual command feedback / ERROR. Error Buffer and Log Buffer are independent; N>=1 retains newest N, 0 retains all. Logging off (default) suppresses routine successful CS logging only, not failed-CS command+parameter trace. Error includes available AC actor whenever AC active, regardless of logging mode.

## Proposed next step; not user-confirmed
- One public semantic Error.report operation constructs and records a single Error, returning record/reference. Exact name, parameters and API remain open.
- Error Library owns Error Buffer, Logging Library owns Log Buffer; proposed CW ownership Links explicitly tagged as candidate.
- Minimal LOGGING library/sink active even mode off. Proposed one-way ERROR -> LOGGING dependency, with NO Logger source import of HC.CS; modes cs/ac affect feature capability/CS-side hooks, not a reverse Python import. Alternative callback injection is open.
- BOOT passes validated protected config to both libraries; early BOOT Error needs a minimal pre-config receiver. No /config access via general CS.
- General MEM-volatility is default. No automatic FILE persistence; buffer-specific export/save/retention is unresolved. On MP, 0=all means no count eviction and may exhaust RAM: do not silently cap.
- Context holds optional invocation and AC identity; no fabricated CS command, no global mutable actor. Error propagation should not duplicate records. Raw secret values require redaction while retaining safe command context.

## Deliverables
- [Development contract](../contracts/AIGMos_1.9_Error_Library_And_Buffers_v0.1.0.json)
- [Typed CW candidate v0.1.2](../canonical/AIGMos_1.9_Errors_Logging_CW_Candidate_v0.1.2.json)
- [36-scenario matrix](../tests/AIGMos_1.9_Errors_Logging_Contract_Tests_v0.1.1.json)
- [Local preflight v0.1.2](../audits/AIGMos_1.9_Errors_Logging_CW_Preflight_2026-11-25_v0.1.2.json)

There are still nine tracked semantic Gaps. Next resolution: whether the proposed Error->Logging sink arrangement and buffer ownership is accepted, then exact Error record/CS outcome ABI. Source-level dependency classification must be checked independently from mode's feature dependency.
