# Errors & Logging → CW structural model (2026-11-25)

**UNLOCKED.** This is a candidate interpretation under pinned **CW_CORE_v1.6.0** (CCF 2.6.0, NodeTypes 1.19.0, Dependency Rules 4.4.0); CW/AIGMos evolve in parallel. No official CW validation or runtime tests have been run.

## Deliverables
- [Typed CW/CCF model](../canonical/AIGMos_1.9_Errors_Logging_CW_Candidate_v0.1.0.json)
- [26 behavior/acceptance scenarios](../tests/AIGMos_1.9_Errors_Logging_Contract_Tests_v0.1.0.json)
- [Local structural preflight report](../audits/AIGMos_1.9_Errors_Logging_CW_Preflight_2026-11-25_v0.1.0.json)

## What can be generated directly
The model contains real CW Entity Nodes, typed RULESET_DATA Properties and relational RULESET_LINK Properties. For each **explicitly selected** Logging mode, use the dependency-forming RULESET_LINK_DEPENDENCY Link (parent_ref=dependency, child_ref=selected dependent):

- off: no *normal continuous CS Logger* dependency; mandatory failed-CS trace remains.
- cs: HC.CS.
- ac: HC.CS + optional AccessCore, which must be included in selected build.

These are **mode-selection variants**, not separate runtime logger implementations. Generic `uses_unified_error` Links only preserve a relationship; do not treat them as source dependencies. Actual mode selection/profile binding requires a validator and is a Gap.

## Confirmed system semantics
CS is input; CSo is plain OK, unwrapped command feedback, or shared ERROR. One Error protocol applies to BOOT/Hardcore/Core/System/User Modules; no separate Audit subsystem or sixth Hardcore mechanism. Failed CS always emits one command+parameters Log Buffer record, even when normal Logger off; cs/ac modes must not duplicate it. When AC is active, any Error carries available actor identity regardless of Logging mode. Error and Log buffers separately retain newest N when N>0, all when N=0. The exact config keys/default counts are not yet selected.

## Nine explicit remaining gaps
1. CSo status ambiguity for payload equal to OK or ERROR; exact error ABI.
2. Error ownership/availability before CS startup and legal component access.
3. Error Buffer config keys/default, MEM/FILE retention and 0=all capacity.
4. Log Buffer keys/default, durability, access control.
5. Build-time vs runtime logger selection; ac when AC not runtime-active.
6. Redaction and full command/parameter capture policy.
7. Per-invocation nested CS correlation and duplicate suppression.
8. CW mode-selection/profile binding and exactly-one enforcement.
9. Error sink failure and preserving original failure.

## Evidence and limitations
`new.zip` has `new/docs/contracts/shared_error_audit_log_schema.json` and `new/system/lib/contracts/errors.py` (candidate error shape and redaction). Actual CS reporter still writes `$SYSTEM.ERRORS` as text; BOOT and TER use different paths. No code is ported. The custom preflight is *not* the official CW/CCF validator. CW selected spec-set is pinned to Git blob `3b712798e8a21a15c4981119188f340a335334b7`, not a mutable “latest”.
