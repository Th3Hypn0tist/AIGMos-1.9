# AIGMos 1.9 — new.zip integration audit (2026-11-23)

**UNLOCKED.** Source: user-provided `new.zip` SHA-256 `9c4d1a0223549f501eca64e3cc35b01d9cb00cabee2710ee608504f5df5145f9`.

## Imported source scope

- Source self-identifies as an AIGMos 2.0 QA/release-candidate snapshot. Do not import its `locked` markers into 1.9.
- Static scan: **548** non-cache files, **319** Python sources (AST valid), **71** JSON sources (parse valid), **50** JSON contracts, **75** Python test files. **No runtime tests performed.**
- It contains **47** command files versus **35** in the previously reviewed 1.8 GitHub snapshot. Additional filenames: `bot`, `eval`, `export`, `import_table`, `math`, `osc`, `package`, `shopping`, `test`, `trig_reset`, `um`, `web`. The `bot` command is **excluded** from 1.9.

## User decision: exclude bot training — not bot-runtime capabilities

Do NOT port:

- `system/cs/commands/bot.py` and `system/lib/bot/role_training.py`
- `system/lib/contracts/bot_trainer.py` and `docs/contracts/core_features_bot_trainer.json`
- `bot.role.train`, `bot.role.validate`, reserved `bot.weights.*` and `#BOT` training candidate/report pipelines
- trainer-only help, examples, test gates and registry entries

**Important transitive coupling:** `system/lib/contracts/__init__.py` imports trainer symbols and `system/lib/contracts/compliance.py` references the trainer and links `symbols_MODE.json` compliance to trainer tests. Remove/redefine those exact edges; deleting `bot.py` alone is not sufficient.

**Keep where selected:** Q/QC, Q backend aliases, stateful chats, queue scheduling, streaming, thinking, runtime roles/prompts, runtime MODE, bounded tool scopes and `#T`/`#MCP` validation. These are not the training mechanism.

## 1.9 feature owners — disposition

| Owner | Features in scope |
|---|---|
| **HC.INPUT / STATE / TER / CS / EXPOSE** | Fundamental semantics and input gateway, CS dispatch, $/& state, TER expressions and runner, configurable transport boundaries |
| **SYSTEM / configuration** | Protected `/config` loaded by BOOT/internal RELOAD; no ordinary CS read/write; AC activation (`false → true`) only permitted write |
| **STATE / FILE** | Memory-volatile working data, component-owned explicit FILE save/restore, independent named KV lists |
| **Q (optional)** | q/qc, mandatory `q.default` when Q selected, alias/profile inheritance, Qcue, Qmon, streaming, sampler, bounded scoped tools |
| **EXP (optional System Lib)** | exact-definition lookup, validate, run through existing HC.CS with restricted effects, return CSo through `?`. No separate parser/dispatcher or mandatory `#`/spreadsheet engine. Extra export/reload support is NOT confirmed and remains OPEN. |
| **EXPOSE transports (optional)** | OSC IN/OUT, REST, static Web; no listener code in stripped target |
| **CS optional commands** | `math.*`, imports/exports (including `import.table`), map, `trig.reset` |
| **User Modules / Panels (optional)** | 5 kinds with `layout → panel` adaptation: command/input/output/adapter/panel; `um.*` install/update/validate/package; Layout View composition |
| **System tooling** | Package manager, test runner, docs/help sync, audit/redaction, deployment profiles |
| **User app (optional)** | Shopping/cart/inventory/price history; calendar only a documented/demo surface until implementation verified |
| **Optional integration** | Speech intent validation spec-only, no claim of implementation |
| **EXCLUDED** | Bot training commands/code/contracts/tests/candidate pipeline; entirely different future design |

## High-risk architecture differences

1. Archive `config.json` + `#SYSTEM:config` vs 1.9 protected `/config`; only privileged BOOT/RELOAD and narrow AC enable write.
2. Archive auto-SQLite persistence vs 1.9 MEM volatile + explicit FILE; durability parity requires an explicit design.
3. Archive relies on `#` for input/REST/tool registries; minimal MP build must not depend on `#`.
4. Archive code supports five user-module types but some help/docs say four; reconcile with 1.9 Panel/View.
5. Archive heavy EXP table processing, internal expression parser, export/reload bundle are **not** part of agreed minimal EXP. Exact named definitions are run via HC.CS, return data via CSo into `?`, and require restricted effect handling. Any preserved legacy features beyond that require separate optional ownership and parity tests.
6. REST source has 2.0 semantics; 1.9 has separate `$` GET-only and `#` GET/POST modes.
7. Cron helpers exist, while the newer `trig` command documents `onchange/at/after`; verify cron parity.
8. Generic file import/export may bypass `/config` protection absent a single canonical path guard.
9. Q has runtime/bounded tool features beyond older 1.8 snapshot; do not drop them under the label `bot training`.

## LOCKED gate

This is a **discovery and architectural crosswalk**, not CCF/CW-validated proof. Each imported feature must get a versioned 1.9 contract, owner, dependency closure, MP/CP target, protected config and acceptance tests. No implementation code has been changed.

Machine-readable inventory: `developer/audits/AIGMos_1.9_new_zip_feature_inclusion_v0.1.0.json`.

## Correction: EXP scope (user reconfirmation)

The 2026-11-22 decision baseline **A19-025..031 is authoritative** over any new.zip feature import suggestion. The minimal EXP is an optional **System Lib** on HC.CS: config-selected definition source, exact named lookup, validation, existing CS command execution, CSo data result presented as `?`. `?` is not a definition store. No private parser, second dispatcher, full `#` table engine, spreadsheet pipeline, or implicit ancestor/descendant fallback. Evaluation is normal read/compute/result work and requires a restricted execution/effect context. Exact config source, schemas, reload/export features remain **OPEN**, not automatically inherited from archive. Heavy legacy functionality may be separately inventoried for optional 1.8 parity; it may not expand slim EXP automatically.
