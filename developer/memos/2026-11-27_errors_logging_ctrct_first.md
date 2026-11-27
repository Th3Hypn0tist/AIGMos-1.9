# AIGMos 1.9 — #CTRCT first, then #LOGIC (2026-11-27)

User correction: canonical identity family is **#CTRCT** (not #CRTCT). A contract-oriented stage is necessary ahead of detailed #LOGIC implementation modeling. Contracts establish normative requirements; #LOGIC declares code/function implementation semantics and must be reconciled against contracts, not treated as an authoritative substitute.

## Artifacts

- [Combined canonical #CTRCT + #LOGIC working package](../canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json)
- [Local structural preflight](../audits/AIGMos_1.9_Errors_Logging_CTRCT_Preflight_2026-11-27_v0.1.0.json)

The package contains four **contract** Nodes (`#CTRCT:AIGMOS19:ERROR`, `LOGGING`, `CSO`, `BOOT`) and the four existing **code** Nodes (`#LOGIC:AIGMOS19:ERROR`, `LOGGING`, `HC.CS`, `BOOT`). Each Contract's explicit `members` lists the corresponding LOGIC identity; requirements are typed RULESET_DATA Properties with stable rule IDs. The normative rules are in contracts, the implementation role/function skeletons under LOGIC. This is one coherent active candidate artifact: **do not compose with the older isolated #LOGIC v0.1.0**, as that would duplicate Entity identities.

## What is settled

ERROR always HARD FAIL of originating operation; Error System Lib independent of HC.CS; Error owns Error Buffer; Logging owns Log Buffer; log modes off(default)/cs/ac; one failed-CS trace in all modes; AC actor included when active/available; CSo internally tagged OK/ERROR and externally unwrapped success feedback. BOOT shared Error usable before CS. No standalone Audit.

## What is not settled

Exact Error record required fields, code taxonomy and redaction; buffer default sizes/keys and early BOOT retention; source import ERROR->LOGGING vs injection; external CSo transport framing; normalized Function.logic abort expression. The last item is a CW primitive gap independent of declaring the hard-fail **contract**. No fake `fail` op was inserted.

## CW semantics

CW NodeTypes v1.19.0 declares `contract` with `members` and `code` with Function/Data sections. Rulesets v4.4.0 contract.members declares normative scope; `contract_affiliation` is for an implementation file declaring it conforms to a whole Contract, and is not inferred solely because a Contract lists a LOGIC member. No implementation-file affiliation was invented.

## Validation

4 contract Nodes, 4 code Nodes, 22 explicitly coded normative rules, 28 Properties, 10 open Gaps. Local preflight: 0 structural findings. Official CW validator and runtime tests have not been executed. Status UNLOCKED.
