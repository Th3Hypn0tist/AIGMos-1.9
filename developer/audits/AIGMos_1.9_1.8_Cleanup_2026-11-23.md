# AIGMos 1.9 — 1.8 suursiivous / source audit (2026-11-23)

**State: UNLOCKED — source-inspection checkpoint, not a validated canonical spec.**

## Rule

The complete **union of selectable 1.9 builds** must preserve every supported 1.8 capability. An individual MP minimal build may omit Q, structured `#`, Layout, AI-specific dependencies and unused transports. Do not equate physical pruning with product-level loss of functionality.

## Source pin

- AIGMos 1.8: `20383e681dd49f3be33070dba41bbcdc4034ef63`
- AIGMos 1.9 initial baseline: `a7f912548bd0ee41c3e8073f4e8abb92c53387fe`
- Current 1.9 decision baseline: `developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json`
- New user-confirmed delta: `developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json`

## Observed 1.8 command files (35)

- STATE / CS: `mk set get ls cat add cp mv rm`
- TER / execution: `run loop cycle trig on emit`
- Layout: `new bind binds unbind`
- Q: `q qc`
- HTTP: `hget hpost`
- Import/export: `import.file import.json import.list import.code export.file export.json export.code`
- Mapping: `map.files map.structure`
- System / utility: `reload / echo`

Sources: `system/cs/commands/*.py`, `system/cs/command_registry.py`, `system/cs/parser.py`. These names were checked in actual command files; exact behavioral parity tests remain outstanding.

## Current 1.8 layout modules found (7)

`system/layout/modules/{cs,q,monitor,qmon,qcue,list,label}.py`

The old code-aligned v41 document also mentions `viewer/editor`; those particular modules were **not found** under the expected current paths. Their functionality is unverified, not silently discarded.

## Ownership and configuration cleanup

| 1.8 fact | 1.9 direction |
|---|---|
| `#SYSTEM:config:*` mirrors every root config leaf; SQLite is default | Private validated /config snapshots, no wholesale STATE mirror |
| `#SYSTEM:runtime:{triggers,events,runners,trigger_state}` | TER-owned definitions (explicit FILE) and runtime (MEM) |
| `#SYSTEM:Qcue` | Q-owned runtime queue/history; preserve alias/FIFO semantics |
| `#SYSTEM:keymap:alt:*` | Layout-owned keymap |
| `#SYSTEM:boot:init_cs_done` | SYSTEM-owned boot status if still required |
| `#OSC` implicit 1.8 ingress | Config-selected `$I` for MP; `#I` only when structured selected |
| 1.8 `config.json.q.default` unconditionally required | **Required exactly when Q is included**, Q-owned validation |
| Direct CS file path reads/writes | Global /config guard; BOOT and internal RELOAD may read; AC enable sole write exception |
| Q provider config read from `#SYSTEM:config:q` | Q privately receives validated config; preserve per-profile defaults, overrides and secrets |
| 1.8 SQLite automatic persistence | 1.9 MEM volatile + explicit FILE; define parity save/reload route |

### Specific code-evidenced problem paths

- `system/config.py` unconditionally validates `q.default`.
- `system/bootstrap.py` recursively mirrors all config leaves and boots on SQLite.
- `system/lib/reload_ops.py` recreates the whole `#SYSTEM:config` mirror.
- `system/lib/q/profile.py` reads config from state and runtime config.
- `system/lib/q/qcue.py` maintains per-alias FIFO, a global active slot and queue/history.
- `system/runtime/runner_store.py` uses `#SYSTEM:runtime:runners`.
- `system/layout/keymap.py` uses `#SYSTEM:keymap:alt:*`.
- `system/inputs/osc.py` defaults to a `#OSC` root.
- `system/cs/lib/file_import.py`, `system/cs/lib/file_export.py`, `system/cs/commands/import_list.py` and `system/cs/commands/export_json.py` access paths and need consistent protected-directory denial, including traversal/symlinks.

## Q feature group — preserve, do not merely relocate profiles

From `system/lib/q/`: profile defaults and aliases, runtime sampler overrides, authentication headers and secrets, `q`/ `qc` output differences, stateful history, async tasks, per-alias Qcue FIFO, live/queued state, JSONL/SSE streaming, nonstreaming mode, think/nonthink payload, thinking display controls, role/system prompt handling, prompt-symbol expansion, health check, timeout/error behavior, Qmon/Qcue rendering.

**Build gate:** Q selected => validated `q.default` mandatory; Q unselected => Q configuration and dependencies absent. `q.default` existence alone does not imply network success.

## Existing named source tests

- `tests/modules/test_phase23_final_cleanup.py` — 1
- `tests/modules/test_phase24_release_candidate_smoke.py` — 10
- `tests/modules/test_phase24_active_layout_runtime_fix.py` — 1
- `tests/modules/test_phase25_cleanup_and_q_regressions.py` — 3
- `tests/modules/test_phase26_layout_persistence_store.py` — 2
- `tests/test_textcells_stdlib.py` — 2

**19 test functions observed; NOT executed here.**

## Canonical LOCKED gate

1. Map all observed 1.8 functionality to 1.9 owners, modules, target profiles and runnable parity tests.
2. Reconcile `A19-016` root `config.json` and `A19-077` `#SYSTEM` config to protected `/config` explicitly. Do not silently overwrite old historical decision files.
3. Define the only AC write exception, its exact file path, authorization and atomic-failure handling.
4. Cover every generic CS/extension import/export path with a shared /config protection policy and negative tests.
5. Reconcile MEM/FILE explicit persistence with 1.8 durable Q/layout/runner behaviors via an accepted functional parity contract.
6. Validate source dependency closure and MP/CP build constraints.
7. Run real implementation tests and the CCF 2.4.2 / NodeTypes 1.15.1 / Rules v3.11.0 checks. **Only then** mark individually validated contracts LOCKED.

**No implementation code has been modified by this audit.**
