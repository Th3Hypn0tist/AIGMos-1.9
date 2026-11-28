# AIGMos 1.9 — CW session handoff
**Created:** 2026-11-28 (Europe/Helsinki)  
**Repository:** `Th3Hypn0tist/AIGMos-1.9` · branch `main`  
**Source HEAD BEFORE this handoff commit:** `30c04ac492224c5f0d727583bfefe054a56cf4f8`  
**State:** `UNLOCKED`, work in progress, not validator-approved and not runtime-tested.

> **New-session instruction:** Read **this handoff**, [Model README](../../Model/README.md), the [active canonical CW root](../../Model/model.cw), and the [source inventory preflight](../audits/AIGMos_1.9_CW_Model_Inventory_Preflight_2026-11-27_v0.1.0.json). Continue from **`Model/model.cw`**, **not** from the old `developer/canonical/*.json` drafts. Fetch the latest `main` when starting; the SHA above predates the handoff commit.

## 1. Why the current state matters

The user caught a fundamental mismatch: despite repeated descriptions of "CW", the repository contained **zero real `.cw` files**. On 2026-11-28, commit `30c04ac492224c5f0d727583bfefe054a56cf4f8` created the **first real, sharded, canonical CW project**. Previously created CCF-shaped JSON contracts are *development evidence*, not the active serialized CW model. The user also corrected the spelling to **`#CTRCT`** (not `#CRTCT`) and pointed out that there should be **more than four contracts**. That led to 63 Contract shards.

Do **not** claim the old JSON drafts were actual `.cw` files; do **not** substitute or recompose them with the active root. The semantic order is **`#CTRCT` contract requirements → `#LOGIC` implementation behavior**, with StructureTree derived from explicitly modeled canonical identities, properties and links.

## 2. Verified repository state

| Item | Actual observed state |
|---|---|
| Active CW root | `Model/model.cw` |
| Contract Nodes | **63** `#CTRCT` Entity shards in `Model/CTRCT/<category>/<name>.cw` |
| Logic Nodes | **4** `#LOGIC` Entity shards in `Model/LOGIC/`: ERROR, LOGGING, HC_CS, BOOT |
| Shards declared in root | **67**; plus root `model.cw` = **68 `.cw` files** |
| Requirements assigned | **110** source decision/rule IDs classified into Contracts |
| Explicit exclusions | **7** historical, superseded, out-of-scope or unresolved prior records |
| Unclassified among 117 source records | **0**, *classification coverage only* |
| Open root Gaps | **10** |
| Latest Error/Logging test matrix | **65 declared scenarios**, **not executed** |
| Local custom CW structure/preflight | `LOCAL_PREFLIGHT_PASS`, **0 findings** |
| Official CW spec lint / canonical validator | **NOT run** |
| Code/model parity, MP/CP runtime, device tests | **NOT run** |
| Runtime implementation files in AIGMos-1.9 | Not present in the inspected tree; repository currently contains Model and development materials |

The 63 Contracts are an **initial grouping of source decisions**. They have not yet been proven to be the correct atomic Contract decomposition. Most contain RULESET_DATA carrying a source decision and its ID; this makes the text traceable but does **not** prove the behavior is fully formalized or machine-executable. `members: []` means implementation identity has not been modeled and must not be fabricated.

Root `specification_ref` is pinned to `git-blob:Th3Hypn0tist/CW/spec_sets/CW_CORE_v1.6.0.json@3b712798e8a21a15c4981119188f340a335334b7`. Corresponding specifications: **CCF 2.6.0 / NodeTypes 1.19.0 / Dependency Rules 4.4.0**; bundle remains **opt-in and UNLOCKED**. Historical user-uploaded 2.4.2 / 1.15.1 / 3.11.0 snapshots must not silently override the explicitly pinned current working set.

## 3. Architecture principles — selected, not guessed

**AIGM vs AIGMos.** AIGM is platform-independent; AIGMos is an implementation/reference. AIGMos itself must have **zero external dependencies**. External adapters/integrations may require explicitly declared dependencies.

**Hardcore (exactly five):** `INPUT`, `STATE`, `TER`, `CS`, `EXPOSE`. Libraries (Error, Logging, EXP) and optional AccessCore, structured `#` facility, REST, Q, etc. must **not** be added as sixth Hardcore mechanisms.

**INPUT/STATE/CS:** INPUT has a restricted write-only path to `$I` or `#I` (config selected); INPUT does not read STATE or invoke CS. STATE is a storage service, not a public API: general state access is CS-mediated. CS owns command parsing, registry, dispatch and CSi/CSo.

**TER:** Trigger `!` → Event `@` → Runner `%` are one Hardcore control mechanism. Routine `&` is an ordered CS command sequence, not a fourth TER submechanism. Event and Runner queues, stop/start/flush and reload/persistence are explicitly specified in the 79-decision baseline; avoid inventing scheduler, retry, replay or termination semantics.

**EXPOSE:** optional transports (Serial, Telnet, HTTP/REST, OSC) and headless deployments; stripping optional transports must physically remove exclusive dependencies. OSC belongs under EXPOSE.

**Protected config and storage:** `config.json` under protected `/config`; privileged BOOT loader, not generic CS raw file access. **Only exception:** narrow authorized AccessCore `ac.enabled: false → true` persistence, not general config write access. MEM volatile default; FILE persistence is **explicit** (no implicit per-write mirroring). Component-owned data must not be dumped into `#SYSTEM`; `#SYSTEM` owns only its own system data. Exact public config projection is still unsettled.

**AccessCore:** optional, integrated at the common CS chokepoint; a non-AC build excludes AC code. AC-enabled build may have AC disabled at runtime. Must not accidentally bypass constraints or silently deactivate AC on authorization error.

**Q/EXP/REST:** Q is build-optional; a Q-containing build requires valid `q.default`. EXP is optional **System Lib**, not Hardcore or Core Module; `?` exposes its computed result. REST GET maps `/rest/<path>` to `?REST:<path>` (not `$REST`); REST `$` mode GET-only, `#` mode adds POST with validated `#REST:<path>` write. No arbitrary command proxy from HTTP bodies.

**Targets and builds:** mandatory Hardcore must run on MicroPython-constrained ESP32-C6-N16 without PSRAM. Shared MP/CP functional SSOT; CP enhancements are opt-in, not compulsory. Build Tool is a System View `|BUILD`, with source/feature dependency closure and pruning. Source header contract history and newer CodeMarkup target proposal must remain **versioned**: former `# target: MP` meant MP+CP; proposed `BOTH` semantics **must not retroactively rewrite** earlier headers. No assumptions about completed code generation.

## 4. Last confirmed Error / Logging / CSo decisions

- **ERROR always HARD FAIL** of the originating operation. No warning/soft/recoverable ERROR; does not universally imply reboot or global shutdown. BOOT Error aborts BOOT per existing boot contract.
- ERROR is one **shared System Lib** usable before CS initialization and from User Modules; it is **not** HC.CS-owned. It must not acquire an HC.CS or AccessCore dependency.
- **Error library owns Error Buffer; Logging library owns Log Buffer.** Independent sizes configured via config.json: `N>0` keeps newest N; `N=0` retains all. Exact config keys/default capacities and MEM/FILE behavior are open.
- Logger modes **`off` (default), `cs`, `ac`**. Normal successful-command logging off; every actual **failed CS** invocation still yields **exactly one** command+parameter entry in Log Buffer even in off. Do not duplicate in cs/ac. Error enters Error Buffer separately.
- When AccessCore is runtime-active, Error includes available actor identity **regardless** of Logger mode.
- **CS input → internal tagged outcome `OK` / `ERROR` → CSo**. An OK without payload returns plain `OK`; an OK with payload returns **exact command response unwrapped**. Explicit payload presence distinguishes no return from `0`, `false`, `null` or empty string. Successful payload text `ERROR` is **still success**; actual ERROR always hard-fails. Exact external text/OSC/HTTP status framing is open.
- No extra Audit subsystem for 1.9, but preserve accepted Q/runtime feature parity.
- The exact Error record fields (`code/message/source` were *proposed*, not accepted), callable signature `Error.report` (*proposed*), Error→Logging source import versus sink injection, pre-config Error buffer, deduplication correlation and parameter redaction remain **OPEN**. Do not promote proposals into decisions.

## 5. CW modeling rules to preserve

1. `#CTRCT` = NodeType `contract`, normative responsibility and `members` scope; `#LOGIC` = NodeType `code`, Function/Data/Link implementation model. Both use JSON serialization **inside** `.cw` files. JSON is a serialization format, not a different truth model.
2. `Model/model.cw` is the sharded composition **single root**. Its `shards[]` is the declared closure; each shard contains exactly one Entity. Do not also inline or reimport the old JSON entities (duplicate IDs).
3. `contract.members` declares normative membership; `contract_affiliation` is a **different** Link used for implementation-file affiliation. Do not conflate them.
4. Function `input_refs/output_refs` resolve only inside their owner Entity. A Function `logic.body` can only claim semantics available under the pinned `CW_LOGIC_PRIMITIVES`.
5. **Known CW gap:** pinned primitive set lacks an explicit `fail`, `abort` or `raise` primitive for `ERROR = HARD FAIL`. Do **not** invent one, claim normal `return` is a hard-fail primitive, or modify CW standard silently. Formal decision/versioned CW update needed.
6. Links and dependency closure must be explicit; a generic Error→Logging semantic sink does **not** prove source-level import direction. No fake source-code correspondence.
7. All Specs/Contracts remain **`UNLOCKED` until real validation**. Passing ad-hoc structural preflight is not validator acceptance. All implementation and parity tests are still unexecuted.

## 6. Current root Gaps — preserve exactly

| Gap | Open issue |
|---|---|
| `G-001` | Pinned CodeMarkup target/header migration from earlier MP/CP headers to MP/CP/BOTH must remain versioned and validated before execution. |
| `G-002` | Protected config paths, actual config schema, #SYSTEM projection and pre-config Error buffer still require reconciliation. |
| `G-003` | CW_LOGIC_PRIMITIVES 1.0 under Rulesets 4.4.0 lacks an explicit hard-fail/abort/raise primitive; no Function.logic body is fabricated. |
| `G-004` | CSo transport status must distinguish the success payload literal ERROR from actual hard fail, without wrapping success. |
| `G-005` | Source-backed Runner once/cycle/loop stop/start/flush parity and propagation semantics remain open. |
| `G-006` | The union of valid 1.9 feature-selected builds must retain 1.8 parity; source audit and executable tests are not completed. |
| `G-007` | Early BOOT Error storage/loading before config/CS initialization unresolved. |
| `G-008` | Exact Error record schema, Error library APIs, actor/secret handling and failure propagation paths not yet approved. |
| `G-009` | Exact config.json keys and buffer defaults, resource policy for N=0, persistence and access remain open. |
| `G-010` | System→System imports/dependency authorization, lifecycle and module registry not yet final. |

These ten are *root-level* gaps, not proof that all remaining semantic work is exhausted. New findings get new or reconciled Gap IDs; do not erase gaps to make a validator pass.

## 7. Explicitly excluded / not-promoted records

| Source decision ID | Classification | Reason |
|---|---|---|
| `A19-046` | `historical_reference` | AIGMos 2.0 REST reference semantics; v1.9 divergence is modeled elsewhere. |
| `A19-048` | `superseded` | Earlier source-header wording; revised header/markup are versioned separately. |
| `A19-069` | `versioned_prior_header` | Prior MP/CP header model, later target migration to MP/CP/BOTH is UNLOCKED and must not rewrite previous interpretation. |
| `A19-076` | `recommended_not_confirmed` | Activation rollback on atomic-write failure not explicitly adopted. |
| `A19-077` | `reconciliation_pending` | Historical config projection to #SYSTEM conflicts with more recent protected config policy; need precise visibility model. |
| `A19-079` | `legacy_observation` | Observation about 1.8 implementation, not a 1.9 normative requirement. |
| `CLEAN-009` | `future_out_of_scope` | Encrypted direct instance link is a future concern outside current 1.9 implementation. |

Source inventory: 79 architecture decisions + 9 clean-up/ownership decisions + 7 CodeMarkup decisions + 22 earlier Error/Logging draft rules = **117 records**. The active model maps **110** and separately classifies **7**. Classification is not equivalent to feature coverage or runtime parity.

## 8. Immediate next work (for the next session)

**Priority 1 — validate the real filesystem CW package.** Start from `Model/model.cw`, inspect shards and run the official spec linter/validator against the exact pinned version. The command lines in [Model/README.md](../../Model/README.md) have **not been run** in this project; troubleshoot tooling and avoid fictional validator success.

```bash
# From sibling CW checkout:
cd ../CW
python3 linter/cw_spec_lint.py --spec-set spec_sets/CW_CORE_v1.6.0.json --coverage
python3 linter/cw_validate.py ../AIGMos-1.9/Model --spec-set spec_sets/CW_CORE_v1.6.0.json --json
```

**Priority 2 — convert grouped source declarations to meaningful atomic #CTRCT contracts.** Review 63 existing Contracts for accidental grouping, overlapping authority, missing primitives/features, and contracts that need separate identities. Compare against `development/`, baseline, clean-up, Build Tool contracts and the 1.8 source/parity audits. Preserve IDs/provenance; do not blindly inflate the contract count or treat one heading as a complete contract.

**Priority 3 — build #CTRCT→#LOGIC traceability.** Currently four #LOGIC skeletons exist. Derive additional real code-node identities and per-function inputs/outputs only when supported by Contracts and source evidence. No invented implementation body or independent Error variants.

**Priority 4 — resolve missing normalized HARD FAIL semantics.** Document the CW primitive deficiency as a CW standard request/decision, without changing the pinned spec in this AIGMos repository. Only then model Function.logic.body that actually aborts.

**Priority 5 — implementation/parity gates.** After contracts and structure validate, map actual source metadata/CodeMarkup/imports to Node/Property IDs and run MP/CP, C6 resource and 1.8 functional parity tests. `AIGMos-1.9` has no runtime implementation in the inspected tree yet.

## 9. Reading and update policy

Read sources in this order: (1) this file, (2) [active root](../../Model/model.cw) and [Model README](../../Model/README.md), (3) [CW inventory](../audits/AIGMos_1.9_CW_Model_Inventory_Preflight_2026-11-27_v0.1.0.json), (4) [decision baseline](../contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json), (5) [protected config/ownership corrections](../contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json), (6) [CodeMarkup proposal](../contracts/AIGMos_1.9_Build_CodeMarkup_Integration_v0.1.0.json), (7) exact recent [Error decision](../contracts/AIGMos_1.9_Error_Always_Hard_Fail_Delta_v0.1.0.json) / [CSo decision](../contracts/AIGMos_1.9_CSo_Internal_Outcome_Delta_v0.1.0.json) / [buffers](../contracts/AIGMos_1.9_Error_Log_Buffer_Ownership_Delta_v0.1.0.json).

Prefer **one canonical Model root**, versioned deltas and clear test evidence; don't silently rewrite historical contracts or pin to a moving "latest" ruleset. Documentation and CW modeling work are authorized by the current task; no permission has been given to introduce new runtime implementation decisions or declare LOCKED.

**Next-session kickoff:** "Continue AIGMos 1.9 CW from `developer/handovers/AIGMos_1.9_CW_Handoff_2026-11-28_v0.1.0.md`. First run the official CW validator on `Model/model.cw`, preserve UNLOCKED and report specific gaps, then continue #CTRCT decomposition and #LOGIC traceability."
