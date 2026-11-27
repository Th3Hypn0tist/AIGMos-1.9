# AIGMos 1.9 — Error is ALWAYS Hard Fail (2026-11-27)

**CONFIRMED DECISION — architecture still UNLOCKED; no official CW validator or runtime execution.**

## Normative meaning

Any actual ERROR is a **HARD FAIL of the current operation or execution path**. It cannot be a soft error, recoverable warning, ignored exception, no-op, fallback success or OK. The internal status tag, never the display text, decides whether a failure happened. Successful command data may literally contain `ERROR` without failing.

`BOOT` Error aborts initialization per the prior BOOT rules. A CS ERROR aborts the current CS command and returns ERROR to its caller. For TER/Event/Runner and asynchronous module lifecycles, a hard fail of the current execution does not by itself establish whole-instance shutdown, rollback or reboot; that propagation scope remains an explicit Gap `G11`. Do not invent global shutdown behavior.

Legacy `new.zip` Error schema contains `recoverable` and variable `severity`; 1.9 cannot accept `recoverable=true` or warning severity as a valid canonical ERROR. A final exact Error record schema remains open.

## Updated artifacts

- [Confirmed hard fail delta](../contracts/AIGMos_1.9_Error_Always_Hard_Fail_Delta_v0.1.0.json)
- [Unified Error Record contract v0.1.2](../contracts/AIGMos_1.9_Unified_Error_Record_CSo_Context_v0.1.2.json)
- [CW model v0.1.5](../canonical/AIGMos_1.9_Errors_Logging_CW_Candidate_v0.1.5.json)
- [Acceptance matrix v0.1.4](../tests/AIGMos_1.9_Errors_Logging_Contract_Tests_v0.1.4.json)
- [Local preflight](../audits/AIGMos_1.9_Errors_Logging_Hard_Fail_Preflight_2026-11-27_v0.1.5.json)

Error System Lib owns Error Buffer; Logging library owns Log Buffer. Normal logging off/cs/ac remains unchanged; failed CS always has one matched log record. No separate Audit is included.

**Next:** Decide whether the Error record needs an explicit `hard_fail` field (redundant if status=ERROR implies it), and finalize the minimum code/message/source fields without leaking credentials. Record transport and ownership remain open.
