# AIGMos 1.9 Canonical Wireframe

**2026-11-28 CURRENT SESSION HANDOFF:** [read the complete CW handoff](../developer/handovers/AIGMos_1.9_CW_Handoff_2026-11-28_v0.1.0.md) or [machine-readable JSON](../developer/handovers/AIGMos_1.9_CW_Handoff_2026-11-28_v0.1.0.json). The sharded Model is UNLOCKED; official CW validation not run.

This is the first **actual sharded CW project** in the AIGMos-1.9 repository. Before this commit the repository had **zero .cw files**: only development JSON documents, candidate CCF-shaped drafts, architecture notes and audits. Those are historical evidence, not the active CW composition.

## Canonical entry point

`Model/model.cw` (the sharded CW root) + its explicit `shards` closure: `63` `#CTRCT` Nodes in `Model/CTRCT/<category>/` and `4` `#LOGIC` skeleton Nodes in `Model/LOGIC/`.

- Contract Ruleset semantics live in CCF/Core: `contract.members` lists canonical scope; it is not source-code implementation correspondence.
- A Contract without established #LOGIC member has `members: []` rather than a guessed implementation.
- Every normative source decision is preserved as an ID + exact development decision text in one Contract's RULESET_DATA Property. This **does not mean** that the generic RULESET_DATA validator proves the behavior; direct behavioral Ruleset/Function formalization is a follow-up.
- Earlier `developer/canonical/*.json` snapshots remain for audit/history, but **do not import or compose them alongside Model/model.cw**.
- `Model/model.cw` is the source for StructureTree and validator projections once supported tooling validates the model; no parallel hand-maintained Node inventory is authoritative.

## Source coverage

Sources: `developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json` (79 entries), `developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json` (9), `developer/contracts/AIGMos_1.9_Build_CodeMarkup_Integration_v0.1.0.json` (7), `developer/canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json` (22 earlier rules). The inventory covers **110 candidate requirements**, with **7 classifications as historical, superseded or deferred**. Details and source/exclusion ledger in `developer/audits/AIGMos_1.9_CW_Model_Inventory_Preflight_2026-11-27_v0.1.0.json`.

## Selected CW specification

Explicit opt-in: `CW_CORE_v1.6.0` (CCF 2.6.0 / NodeTypes 1.19.0 / Dependency Rules 4.4.0), pinned by content hash in the `Model/model.cw` specification_ref. It remains UNLOCKED.

Run the official validator from an adjacent CW repo checkout:

```bash
cd ../CW
python3 linter/cw_spec_lint.py --spec-set spec_sets/CW_CORE_v1.6.0.json --coverage
python3 linter/cw_validate.py ../AIGMos-1.9/Model --spec-set spec_sets/CW_CORE_v1.6.0.json --json
```

**This commit does not claim that command has been executed or that the package is READY.** A structural preflight and source coverage audit are included. Next: run validator, reconcile gaps, derive missing #LOGIC Nodes from contracts, and implement code mapping / runtime tests.
