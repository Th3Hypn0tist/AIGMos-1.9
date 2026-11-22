# AIGMos 1.9 — session handover 2026-11-22 (v0.3.0)

**STATUS: UNLOCKED development handover. No implementation code was changed.** The canonical contract / CW validator has NOT passed this document; do not label it immutable or locked.

## START HERE — authority, in order

1. [Decision baseline v0.3.0](../contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json) — machine-readable consolidated decisions; **79 recorded entries**, including source observations clearly marked as such and explicit open issues.
2. [Three-line source header v0.2.0](../contracts/AIGMos_1.9_Source_Dependency_Header_v0.2.0.json) — new syntax, supersedes **two-line v0.1.0**.
3. This handover — precise context, observed legacy behavior, questions and first next action.
4. Previous historical [baseline v0.2.0](../contracts/AIGMos_1.9_Decision_Baseline_v0.2.0.json) and [prior architecture memo](2026-11-22_architecture_handover.md) remain available, but contain **superseded** assumptions (notably Hardcore exemption/two-line headers, unresolved queue and FILE details). Do not use them as latest authority.

## 1. System identity and architecture

- **AIGM** is platform-independent standard. **AIGMos** is a technical implementation/reference, not itself the whole standard. **TER** is internal to AIGMos and NOT an AIGM conformance mandate.
- 1.9 continues, modularizes and optimizes the existing 1.8 rather than rewriting features unconditionally. Planned build sequence: **Hardcore → Core Modules → System Modules → Build Tool → ESP32-C6 deployment**.
- Hardcore has **INPUT, STATE, TER, CS, EXPOSE**, exactly five. EXPOSE owns optional transport bindings, and a headless/Expose-less deployment is valid.
- Trigger ! → Event @ → Runner %; routines & contain CS command sequences. TER talks to CS/CSi. CS owns command execution, CSo and general STATE access. INPUT is the restricted, optional, *write-only* exception to STATE under config-selected $I or #I; INPUT cannot read STATE nor call CS.
- The optional # structured facility is not mandatory Hardcore. EXP is optional System Lib, **not** TER trigger expressions and not Hardcore. REST is an optional EXPOSE HTTP transport with previously decided $ GET-only / # GET+POST modes, ?REST response mapping. Preserve differences from immutable 2.0 references rather than silently rewriting 2.0 contracts.
- Module primitives: command/input/output/adapter/panel; View is a composition of Panels. Build Tool is a System View and functions/commands, not a sixth Hardcore item.

## 2. Persistence / boot / reload — latest choices

- MEM is default and **volatile**. FILE persistence is deliberate; MEM state mutations do **not** automatically update files.
- FILE stores independent component definitions in plain JSON, e.g. `triggers.json`, `events.json`, `runners.json`. No mandatory version wrapper; component validates content. Atomic temporary/validate/replace save. Failed save retains prior disk file and leaves current MEM edits. Missing file means empty definitions; malformed present file on boot is **fatal**.
- Standard mount-point identities are fixed, config selects adapter binding. Custom mounts permitted. Unbound optional component inactive; active missing required dependency fails boot. Binding change requires restart.
- Reload through explicit CS command only; no file-watch. No hot reload of static mount/dependency/binding. TER reload swaps definitions atomically, preserves inflight work and queued event snapshot definition; re-prime triggers without firing. Invalid reload keeps old live definitions and returns FAIL.
- Event queue: volatile FIFO, one event dispatch at a time, no priorities; bounded config capacity, overload returns FAIL and preserves admitted items; no reboot replay.
- Runner: own FIFO per named runner, no concurrent runs of same runner, globally configured capacity, FAIL on overflow, a failed job does not hold queue, no timeouts; cooperative stop vs flush, queued work preserved by stop and cleared by flush. Stopped runner rejects new work; run.start resumes queued work.
- Boot: runners start stopped. Optional `boot.cs` can start them. Missing script valid; boot command FAIL aborts boot without rollback/retry.
- **Important unresolved reconciliation:** older question whether `run.start` itself should enqueue/run an invocation was asked before inspecting 1.8; legacy `run`, `cycle`, `loop` semantics differ from the tentative READY-only wording. Do not silently lock this.
- Different 1.8 persistence design: 1.8 StateEngine uses SQLite as default, automatically queues State mutations to persistence, and 1.8 Runner uses threads; **this is not the new MEM/FILE 1.9 contract**.

## 3. Build Tool / target policy

Every **source file including Hardcore** starts with three mandatory lines, for Python:

```python
# deps: ["HC.CS"]
# libs: []
# target: MP
```

- deps: directly used modules/interfaces; libs: directly used libraries including System Lib. Do not duplicate transitive deps. Both JSON arrays can be empty.
- target `MP` **means both MicroPython AND CPython**. target `CP` means CPython-only; never use `MP/CP` as a target tag.
- MP-compatible code is the one shared implementation/SSOT. CP extensions add capabilities without parallel competing copies. CS public interface is shared by both targets.
- Build Tool selects MP or CP; validates all reachable deps/references and resource suitability; includes **only** selected functionality plus dependency closure. Even on CP, do not include all CP extras. Unselected extensions, transport, AC etc. and their exclusive deps must be pruned.
- MP Runner supports `once`; CP can provide `once`, `cycle`, `loop`. `config.json runner.modes` is `once` or `all`. MP scheduler cooperative and round-robin with equal priority for INPUT (if present), TER and Runner; long-running CS must internally yield; CP may use threading. Detailed scheduler API is open.
- For optional source-level AC inclusion, the discussion explicitly identified **code-level conditional pruning** as necessary. Exact syntax and whether arbitrary function/body AST pruning is required are **NOT locked**.

## 4. AccessCore (AC) — exceptional config write

- AC is optional and enforced at the CS chokepoint, with **one CS source of truth**.
- **NON-AC build:** compile/prune AC and its hook out. **AC build:** AC code/hook included but runtime state can be disabled.
- AC may be enabled by setting `ac.enabled=true` in `config.json` before boot. It may ALSO be enabled by a CS command during runtime; that command sets `ac.enabled: false → true` **in config.json** persistently and turns on enforcement. Restart retains active status.
- **No CS command can disable AC.** For AC deactivation, an operator must edit `config.json` directly at file level, then restart. Generic CS state/file operations must not provide an indirect bypass.
- This is the **only exception in the entire AIGMos design** where runtime/CS-triggered behavior can write `config.json`. It is a narrowly scoped internal operation, **not general config write access**.
- Recommend atomic file commit BEFORE reporting successful activation; failure semantics were explicitly posed as A/B but not answered in isolation — do not mislabel as user-locked. CS enable command name and enable authorization are likewise open.
- Activation must not leak general filesystem write capability to CS; no fail-open on AC errors.

## 5. #SYSTEM ownership audit — 1.8 was inspected on GitHub

Inspected `Th3Hypn0tist/AIGMos` (1.8 repo, default branch), particularly:

`system/bootstrap.py`, `system/config.py`, `system/adapters/registry.py`, `system/state/request.py`, `system/state/engine.py`, `system/state/api.py`, `system/lib/reload_ops.py`, `system/runtime/runner_store.py`, `system/lib/trigger/store.py`, `system/lib/q/qcue.py`, `system/layout/keymap.py`, `system/extensions.py`, `system/cs/commands/set.py`, `system/cs/symbol_handler.py`, `system/cs/reporter.py`, `docs/contracts/runtime_ownership_rules_v1.md`, `system/library/help/layouts.md`.

**Verified 1.8 behaviors:**

| Legacy storage | Observed owner/content | 1.9 audit action (proposed, not locked placement) |
| --- | --- | --- |
| `#SYSTEM:config:*` | Full `config.json` recursively mirrored at boot and during reload | Keep system config *projection* separate from authoritative file; decide read-only/sensitive-field policy |
| `#SYSTEM:runtime:triggers` | Trigger definitions | Move to TER-owned definition semantics / FILE |
| `#SYSTEM:runtime:events` | Event definitions | TER-owned definition semantics / FILE |
| `#SYSTEM:runtime:runners` | Runner definitions | TER/Runner-owned definition semantics / FILE |
| `#SYSTEM:runtime:trigger_state` | Trigger runtime state | TER-owned volatile state; avoid duplicated `!name:state` and `!name:pulse` truth |
| `#SYSTEM:Qcue` | Q-specific execution queue/history | Q-owned state |
| `#SYSTEM:keymap:alt:*` | Layout key bindings | Layout-owned state |
| `#SYSTEM:boot:init_cs_done` | Initialization completion marker | Belongs to boot/system, if still needed |
| `$SYSTEM.ERRORS` | CS error log | Audit CS/system ownership and retention |
| `#SYSTEM:runtime:layouts` | Explicitly rejected as target in 1.8 layout help | Keep `|` as owner surface |

**Critical 1.8 mismatch:** `_mirror_config_leafs` writes **every config leaf** to `#SYSTEM:config:*`; default StateRequest adapter is SQLite (special routes for $MEM and #OSC); StateEngine enqueues mutations for automatic disk persistence. Configuration can thus be copied into both STATE and SQLite, *not necessarily kept consistently in sync with config.json*. The config contains Q API keys/headers, so do not expose whole mirror unquestioningly. The normal `set` and assignment paths use state writes, and 1.8 doesn't give `#SYSTEM:config` a universal immutable boundary; extensions do have a partial `#SYSTEM` access restriction, which must not be mistaken for global protection.

**User's current correction:** config.json is not ordinarily opened/read from CS. It is loaded at boot and represented under `#SYSTEM`. However, **NOT all other module data belongs under `#SYSTEM`**. Suggested ownership invariant, **pending explicit user lock**: *`#SYSTEM` only owns System data; modules own their own runtime data, definitions and queues*. Avoid solving this by creating one new generic shared bucket. Distinguish **owner**, **persistence**, **CS visibility/access**.

## 6. Outstanding decisions — do not invent answers

1. Define exact `#SYSTEM` ownership criterion and classify existing legacy keys. Which configuration fields must be projected, masked or hidden, and how exactly should read-only behavior work? Exact addresses **not decided**.
2. Reconcile Runner `run.start`/invocation semantics with inspected 1.8 (different once/cycle/loop vs 1.9 FIFO/stop model).
3. Define source-level conditional AC-hook annotation and Build Tool pruning implementation (file-level-only is insufficient to eliminate CS hook without duplicate CS source).
4. Define explicit AC activation command spelling, ability/authorization to enable, and atomic failure semantics (A vs B formerly asked; user instead clarified exception).
5. Define scheduler yield/checkpoint ABI and static/dynamic blocking checks for MP.
6. Finalize FILE schema, commands, adapter target, mount semantics, boot.cs error behavior edge cases.
7. Reconcile old `development/` documentation, which still contains superseded assumptions. New contracts/memos are **development** records, not CCF/CW validated.

**Recommended immediate next question for clean session:** Start with `#SYSTEM` audit/ownership. Ask whether the proposed rule “`#SYSTEM` exclusively owns System metadata and a controlled configuration projection, while TER/Q/Layout own their own data” is accepted, then classify legacy keys one by one. Do not prematurely lock destination paths.

## 7. Source/format and work status

- Latest baseline: `developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json`.
- Latest header contract: `developer/contracts/AIGMos_1.9_Source_Dependency_Header_v0.2.0.json`.
- CCF 2.4.2 / NodeTypes 1.15.1 / Dependency Rules 3.11.0 are reference formats; **no validator pass**.
- The 1.8 references are evidence for implementation history, not source of truth superseding user-confirmed 1.9 decisions.
- **This operation wrote documentation only, not runtime code.**
