# AIGMos 1.9 — Build Tool session handover (2026-11-23)

**STATUS: UNLOCKED development notes and contracts. No CCF/CW validator pass. No runtime implementation modified. CW formats/rulesets were deliberately NOT edited in this session.**

## Priority reading

1. [Build Tool design v0.1.0](../contracts/AIGMos_1.9_Build_Tool_Design_v0.1.0.json) — consolidated existing design and newest refinements.
2. [Build Profile v0.1.0](../contracts/AIGMos_1.9_Build_Profile_v0.1.0.json) — persisted/exportable selections (draft schema).
3. [Build CodeMarkup integration v0.1.0](../contracts/AIGMos_1.9_Build_CodeMarkup_Integration_v0.1.0.json) — accepted source example and target branch semantics; CW grammar is external and pending.
4. [Full Source Snapshot Build v0.1.0](../contracts/AIGMos_1.9_Full_Source_Snapshot_Build_v0.1.0.json) — one coherent full source as prune input, no per-dependency version solving.
5. [Source Dependency Header v0.2.0](../contracts/AIGMos_1.9_Source_Dependency_Header_v0.2.0.json) — historical active baseline, target MP=MP+CP **until explicit versioned migration**.
6. [Decision Baseline v0.3.0](../contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json) — earlier 79 decisions; the four documents above add subsequent details without silently rewriting historic baseline.

## Architecture — confirmed

- Build Tool is an optional AIGMos System **View definition `BUILD`** composed from Panels and CS-exposed functions/commands; a runtime instance may be `|BUILD`. Definition vs instance already existed in AIGMos 1.8.
- One AIGMos instance with Builder composes a new target runtime using the complete full-system source snapshot available to it. Module registry and graph are projected from canonical structure, manifests and source metadata; no parallel manually maintained dependency SSOT.
- Build Profiles **must be saveable and exportable**, and are intended to be importable/loaded. They record user composition/target/feature selection, not the authoritative dependency closure or target secrets. Save via builder-owned FILE storage, not protected `/config`.
- Build input is **one coherent loaded full-system source checkout**, not independent component versions. Therefore **no per-dependency version management/solver** belongs to basic prune. Whole-source snapshot ID / Git commit / checksum belongs in artifact provenance.
- The first three source header lines remain `# deps: []`, `# libs: []`, `# target: …`; direct-only dependencies remain code-level SSOT. The optional line `# prune: ["AC", "IAM"]` names features with in-file conditional regions.
- Single-`#` CodeMarkup: `# <AC.CP>` and `# </AC.CP>`; `# <AC.MP>` and `# </AC.MP>`. With `# target: BOTH`, raw Git checkout runs on **CPython**; CP bodies are executable, MP bodies stay commented. Build for MP removes CP branch and activates commented MP branch. An excluded feature prunes both target variants and exclusive imports/dependencies.
- Hardcore is the initial **candidate** scope for line/block-level trimming, with Core Modules and above selected via whole module/file closure. The exact markup scope policy requires explicit validation; do not elevate this proposal into a universal CW restriction.
- Build sequence: select source snapshot/profile → inventory source headers + markup → compute closure → prune physically → validate emitted source/imports/CS and TER references → package → target-profile PC tests → provision safely → optionally strip temporary Expose and revalidate → deploy.

## Accepted CodeMarkup example

```python
# deps: ["HC.STATE"]
# libs: []
# target: BOTH
# prune: ["AC"]

def execute(command):

    # <AC.CP>
    authorize_cp(command)
    # </AC.CP>

    # <AC.MP>
    # authorize_mp(command)
    # </AC.MP>

    return dispatch(command)
```

This demonstrates **markup shape**, not a complete standalone runnable example: `authorize_cp`, `authorize_mp` and `dispatch` need implementations and dependency verification.

## Critical historical semantic difference

The existing `AIGMos_1.9_Source_Dependency_Header_v0.2.0.json` defines `# target: MP` as **compatible with both MP and CP**, while `# target: CP` is **CP-only**. This session accepted the proposed `BOTH` spelling and distinct MP-only vs CP-only selection. **A new explicitly versioned header contract is required**. Do not silently reinterpret prior `MP` source. Target profile's MP/CP selection is separate from a source file's `BOTH` capability declaration.

## Still open / do not infer answers

1. CW CodeMarkup grammar, comment escaping, nesting, target markers, indentation, multiline Python, source-to-output mapping. A handover JSON `CW_CodeMarkup_Prune_Requirements_Handover_v0.1.0.json` has been produced for separate CW development; it is not a committed change to any CW ruleset here.
2. Conditional `deps/libs` declaration protocol for imports inside feature/target regions, without conflicting SSOT.
3. Exact source-header next version and version-aware migration / validation.
4. Build Profile final schema and precise CS commands/UI/portable export and import mechanics.
5. Exact output artifact folder/manifest and snapshot digest/provenance rules.
6. Real target compiler/resource/hardware tests, especially ESP32-C6-N16 without PSRAM.
7. Reconcile stale `development/` guidance (e.g. old `boot.config`, separate Build Engine, and manifest-as-code-deps-SSOT) against newer decision contracts rather than treating all versions as equal authority.

## Scope / implementation status

This repository change creates development contracts and updates Build Tool design/START HERE navigation. **No runtime code, Core files, CCF, NodeTypes or CW Dependency Rules were touched.** None of the new development contracts is `LOCKED`.
