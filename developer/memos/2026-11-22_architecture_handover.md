# AIGMos 1.9 — architecture handover (2026-11-22)

**Status:** development memo, UNLOCKED. **Source of decisions:** architecture discussion, checked against AIGMos 1.8 implementation and selected AIGMos 2.0 contracts. **This memo is not a new immutable specification.**
**Machine-readable decision baseline:** `developer/contracts/AIGMos_1.9_Decision_Baseline_v0.1.0.json`.

## 1. What we are building

AIGMos 1.9 is a modularized, optimized continuation of AIGMos 1.8. The implementation reference target is **ESP32-C6-N16 without PSRAM**. AIGM remains a platform-independent standard; AIGMos is one implementation. MicroPython compatibility is an AIGMos Hardcore implementation requirement, not an AIGM conformance condition.

Development phases: **Hardcore → Core Modules → System Modules → Build Tool → ESP32-C6 Build**. The phase named “Build Tool” creates a use-case composition from existing System View/Panels and functions; **it is not a new architectural layer or mandatory independent Build Engine**.

### Five Hardcore mechanisms

| Mechanism | Responsibility | Important exclusion |
| --- | --- | --- |
| INPUT | Accept bounded values, write STATE through MEM | Never read STATE or invoke CS |
| STATE | Read/write/delete/list + route to MEM/FILE adapters | No implicit FILE write for every MEM change |
| TER | Trigger `!` → Event `@` → Runner `%`, with ordered `&` routines sent to CSi | TER reads STATE but does not write STATE |
| CS | CSi/CSo, parser, registry, dispatch, STATE access; optional AC enforcement point | No mandatory UI/AI/AC or network dependency |
| EXPOSE | Own external surface bindings; optional transport implementations | No mandatory HTTP/OSC/Telnet/Serial stack |

An Expose-less final target package is valid. All other mechanisms must run independently from EXPOSE. Trigger **condition expressions** are part of TER and **are not EXP**.

## 2. Modular runtime

- Reuse the AIGMos 2.0 user-module contract family as source material with a **versioned 1.9 adaptation**, without silently editing the locked source.
- Five 1.9 functional module primitives: **command / input / output / adapter / panel**.
- A **View** is a declarative **Panel composition**, not a sixth module primitive. `Panel` replaces the former UI small-module meaning of `View`; legacy `.tmpl` corresponds conceptually to View.
- Dependency classes: Core Module (Hardcore public APIs only; no other Core Modules), System Module (Core + permitted Core Modules), AIGM User Module (Core/System; no external deps), User Module (declared deps incl. external permitted subject to other policies).
- **Zero hidden dependencies.** Manifest, dependency closure, import/resources/target compatibility, and actual runtime authority must be validated. Dependency declarations do not grant authorization.
- The first implementation takes **only minimal CS commands** necessary for symbols, STATE, TER definition/execution, command dispatch and CSo; no wholesale 1.8 command-port.
- Actual System→System direct module dependency policy is **unresolved**. Compose through public Core/CS APIs without assuming that same-class direct imports are permitted.

## 3. Configuration and Expose

**Reuse root `config.json`, not a new `boot.config`.** Remove `role`, `layout`, and the existing AI/Q configuration from the common startup configuration. OSC moves **inside `config.json → expose`**, never as a mandatory standalone `osc` boot configuration. Serial, Telnet, Web/REST and OSC are optional Expose-associated transports/bindings as selected by profile and target. Serial must not require network. Exact `config.json` JSON schema/binding names are **not locked**.

`#` structured tree/table semantics are **not mandatory Hardcore**; `structured` is a candidate Core Module, distinct from the separate Structure tool.

## 4. EXP — separate from trigger expressions

EXP **is not Hardcore**. It is a **small functionality using CS**, not an independent parser/dispatcher or spreadsheet execution engine.

- `?` is the **result/evaluation surface**, not the home of the definition itself.
- EXP definitions used to be represented at `#EXP`. Because `#` is being removed from the mandatory base, the definitions' location **must be selectable from `config.json`**, rather than hard-coded to `#EXP`. Exact backend/path/schema is open.
- Resolve a named definition from the configured source, give its command text to the existing CS path, expose the resulting data through `?`.
- The supplied 1.8 `expressions.py` implementation is a small `execute_exact_expression(parser,target)` wrapper: validates a `?` symbol, reads the corresponding command text, calls `parser.parse(...)`, and returns a success bool. That bool is **not itself** the data result. The 1.9 CS/CSo output binding must provide the returned data.
- EXP's **whole-`#`-table / “Excel killer”** functionality, mass table operations and heavy table pipelines are **excluded from the 1.9 minimal scope**.
- The 2.0 EXP source contract specifies pure/side-effect-bounded evaluation. Current 1.8 direct `parser.parse` has no obvious enforcement in that wrapper: the 1.9 EXP→CS boundary must enforce the permitted effect scope. This is an implementation requirement, not a claim already satisfied.

## 5. REST — checked against 2.0; 1.9 decisions separate

Checked original 2.0 sources:

- `canonical/json/interfaces/01_WEB_REST.json`: fixed `/rest/<path>` mapping; GET → `?REST:<path>`; POST payload → `#REST:<path>`, then evaluate `?REST:<path>`.
- `canonical/json/runtime/io/00_Native_IO_Contracts.json`: same GET/POST split.
- `canonical/json/runtime/symbols/03_EXP.json`: `?` evaluation contract.

**Confirmed 1.9 semantics:**

1. **`?REST` contains/addresses the EXP-style GET response definitions/results**. **`$REST` was a mistaken name and must not be used for the response surface.**
2. A REST GET resolves `?REST:<path>` and returns the produced response; GET does not write STATE.
3. REST supports a **`$` mode** (GET-only, no POST) that works without `#`.
4. REST also supports a **`#` mode** (GET plus POST), with POST data written under `#REST:<path>` and an **optional** EXP-style response if configured; this mode requires optional structured `#` capability.
5. REST runs through optional Expose/HTTP; it does **not** allow raw parser command selection from HTTP input. EXP-style definitions are handled through the common CS evaluation mechanism.
6. Binding/mode selection belongs to the configuration; **exact field names, per-service vs per-route mode granularity, JSON payload mapping and response-on-missing HTTP semantics remain open**.

**Version difference to preserve:** the original 2.0 REST spec treats absent POST response as `REST_RESPONSE_NOT_FOUND` / configurable rejection, whereas the 1.9 discussion explicitly permits a POST with **no EXP response**. This requires an explicit versioned 1.9 contract change; **do not silently claim 2.0 conformance** for the new behavior.

A REST `#`-mode cannot be accidentally pulled into a `$`-only / no-`#` target.

## 6. Build Tool = self-composition within AIGMos

The **Build Tool is a System View + Panels + System functions/commands**, not a separate mandatory platform layer; it can use CS to invoke its functions. Only minimal Build Tool commands/actions belong in the first iteration, exact names open.

**Correct order:**

```text
Source AIGMos instance (contains Builder)
   → select C6 target + modules
   → resolve declared dependencies
   → BUILD a C6-target source composition FIRST
   → RUN that C6-profile composition on PC
   → CONFIGURE via selected Expose → update config.json and FILE/TER definitions
   → optionally STRIP Expose, regenerate package and validate closure
   → DEPLOY to ESP32-C6
   → RUN autonomously (headless if chosen)
```

The PC-hosted build must behave according to the target profile; hardware-specific modules need explicit host adapters or simulations. The C6 MicroPython firmware image itself is not directly executable in CPython.

When stripping Expose, **actually remove its code and exclusive dependencies**, not merely disable the configuration. Final validation must include **TER/CS command references from persisted definitions**, declared adapters, capabilities and target fit, not just module manifest dependencies. Builder does not automatically ship with built targets, but a build can optionally include it when compatible.

## 7. Persistence and boot

STATE includes MEM and an explicit FILE adapter. TER definitions written during PC configuration must persist to the C6 instance. Define deterministic boot restoration **before** allowing trigger firing; ensure restoration itself causes no unintended trigger events. The exact FILE data format, transactional/atomic write strategy, runtime-state resume policy, event queue semantics and flash wear handling remain unresolved. No assertion that `config.json` and FILE are a single store.

## 8. Open engineering decisions (do not guess)

1. STATE public API signatures, values, error contract, symbol grammar, adapter routes and persistence mapping.
2. TER loop/queue, backpressure, timing, edge detection, reentry, restart/resume, cycle detection.
3. Minimal CS command ABI, parser 1.8 backward-compatibility subset, CSo result channel, safe/pure EXP execution mode.
4. Exact `config.json` schema, Expose bindings and REST `$`/`#` mode configuration/granularity.
5. EXP definition-source mapping in config; relationship of file-backed `?` definitions and runtime representation; whether `?` is installed only when selected.
6. Exact 1.9 module manifest adaptation, entrypoint/lifecycle conventions, System→System dependency rule.
7. PC hardware adapter/simulation API; final deploy form (MicroPython files vs firmware bundle); target resource testing.
8. Exact minimum initial CS commands, Build View panels/operations, and acceptance tests.

## 9. Conflicts in existing repository docs to reconcile later

Current `development/ROADMAP.md` still says `boot.config`. Current `development/DECISIONS.md`, `CORE_SPLIT.md`, `GOALS.md` and `TODO.md` retain earlier Core/Trigger/Core Module splits, older phase plans or old Expose assumptions. They are **not silently rewritten by this handover**. The machine-readable decisions in `developer/contracts/` record newer discussion choices; harmonizing old docs is a separate explicit code/documentation task.

## Source provenance

- AIGMos 1.8: `system/cs/parser.py`, `system/state/api.py`, `system/runtime/triggers.py`, `system/runtime/runner.py`, `system/lib/trigger/expr_parse.py`, `system/lib/trigger/expr_eval.py`; provided `expressions.py` wrapper.
- AIGMos 2.0 (source snapshot `535c1dacfc4ee72f1fbc00dedea3f3672178dbe2`): `canonical/json/interfaces/01_WEB_REST.json`; `canonical/json/runtime/io/00_Native_IO_Contracts.json`; `canonical/json/runtime/symbols/03_EXP.json`; canonical module manifest and user-module files in `canonical/json/runtime/modules/`.
- AIGMos 1.9: existing `development/ROADMAP.md`, `DECISIONS.md`, `DEPENDENCY_RULES.md`, `REUSED_SPECS.md`.

**No 1.9 runtime code has been changed by this note.**
