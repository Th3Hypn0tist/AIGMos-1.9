# AIGMos 1.9 — CSo internal outcome decision (2026-11-27)

**Decision confirmed by user. STATUS: UNLOCKED; no implementation or formal CW validation.**

## Deterministic execution result

CS accepts a command input. Its INTERNAL execution result has authoritative `status: OK | ERROR`. A successful result distinguishes `payload_present` from the payload's actual value. Failure carries a shared Error System Lib error record/ref.

```text
CS INPUT → EXECUTE → INTERNAL OUTCOME
                       ├─ status=OK, payload_present=false → CSo: OK
                       ├─ status=OK, payload_present=true  → CSo: exact command feedback
                       └─ status=ERROR, error=shared Error → CSo: unified ERROR
```

The command's returned string `ERROR` (or `OK`) cannot by itself determine success or failure. A returned 0, false, null or empty string is also real data when `payload_present=true`. **Do not wrap successful CSo data in a mandatory success envelope.** Error recording and failure-triggered CS logging use internal `status=ERROR`, never text comparison.

## Open distinction

The internal ambiguity is resolved (**G01 resolved**). However, a plain-text external CSo projection of literal `ERROR` remains visually ambiguous. A separate **G10** tracks transport-specific machine-readable status conveyance without changing the bare successful payload. No specific HTTP/OSC/terminal encoding has been selected.

## Artifacts
- [Confirmed decision delta](../contracts/AIGMos_1.9_CSo_Internal_Outcome_Delta_v0.1.0.json)
- [Unified Error record and CS context v0.1.1](../contracts/AIGMos_1.9_Unified_Error_Record_CSo_Context_v0.1.1.json)
- [CW model v0.1.4](../canonical/AIGMos_1.9_Errors_Logging_CW_Candidate_v0.1.4.json)
- [57 acceptance cases](../tests/AIGMos_1.9_Errors_Logging_Contract_Tests_v0.1.3.json)
- [Local preflight v0.1.4](../audits/AIGMos_1.9_Errors_Logging_CW_Preflight_2026-11-27_v0.1.4.json)

Previous Error and Log Buffer ownership, Logging off/cs/ac, Error Library placement and Error-with-AC semantics are unchanged.
