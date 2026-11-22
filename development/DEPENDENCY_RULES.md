# AIGMos 1.9 — Explicit Dependency Contract

**Status:** architectural invariant accepted for AIGMos 1.9; enforcement and migration **not yet implemented**.  
**Scope:** Core, SYSTEM modules, USER modules, USE modules, Panel, View, View Engine, Expose and build compositions.  
**Principle:** **NO HIDDEN DEPENDENCIES.** A dependency may exist, but it must be declared, resolvable, authorized where relevant, target-compatible, and verifiable.

## 1. Non-negotiable invariants

**DEP-001 — Every dependency must be explicit.** Each executable component declares its complete **direct** dependencies in its owning manifest/contract. Transitive dependencies are generated as a closure from the direct dependency graph. Neither source location nor runtime import behavior counts as a valid declaration.

**DEP-002 — No implicit loading.** Importing a module must not silently register, activate, bind, start a listener, connect to external services, or allocate an optional runtime subsystem. Activation follows an explicit selected composition and lifecycle operation.

**DEP-003 — No hidden transitive dependency.** Selecting A cannot bring in B indirectly except through an auditable declared chain A → ... → B. Every included component has a known owner, purpose and reason for inclusion. Cycles are rejected unless the involved contract defines an explicitly supported cycle resolution with test evidence; default is reject.

**DEP-004 — Optional means actually removable.** A component marked optional is not imported, started, required for boot, or shipped in a target artifact when unselected. The Core bootstrap must run without any UI/Panel/View, Build Engine, optional network service, or optional state adapter.

**DEP-005 — Missing dependency is a hard failure of the affected composition.** Missing or incompatible provider, version, capability, manifest, asset, or target feature → **explicit validation failure**. No silent fallback, substitute provider, skip, guessed path, or auto-install. An explicitly declared optional feature may be disabled if its contract defines that behavior and reports the resulting capability set.

**DEP-006 — Names are not authority.** A module does not acquire SYSTEM rights because it resides under `system/library/`, matches a SYSTEM module name, or is loaded by Core. Identity, requested capabilities, and granted runtime permissions are separate facts. Name conflicts are detected, not overwritten.

**DEP-007 — Dependency direction is enforced.** Minimal Core has no dependencies on optional USE/USER/SYSTEM module implementations. Modules depend on stable Core contracts; components cannot reach into another module's implementation or state except through a declared interface/binding. View composes declared Panels; Panel cannot silently import another Panel or access CS authority by being part of a View.

**DEP-008 — Runtime and build use the same resolved facts.** Resolution yields an immutable *per-build dependency snapshot* (not a newly locked architectural specification) with selected targets, component identifiers/versions, source revisions where available, resolved interfaces and dependencies, resources, platform constraints, and checks. The runtime must not discover extra dependencies outside that snapshot.

**DEP-009 — Target compatibility is a declared dependency.** Python implementation, MicroPython variant, stdlib availability, native modules, drivers, OS services, hardware peripherals and resource assumptions must be explicit where required. A CPython import working does not prove ESP32-C6 compatibility.

**DEP-010 — No undeclared external resources.** Files, configuration keys, templates, View/Panel references, network endpoints, environmental features, secrets/providers and native assets needed for operation must be declared and validated. Secret *values* must not be stored in module manifests or build reports.

## 2. Required manifest/contract content

Existing USER contracts remain the source baseline; these requirements specify **1.9's dependency information**, which must be versioned without silently changing locked source contracts.

| Field / fact | Required meaning |
|---|---|
| `identity` | stable module id, class/type, origin (SYSTEM/USER/USE/Core), version |
| `provides` | explicit public interfaces, capabilities or service bindings exposed to consumers |
| `requires` | direct dependencies by stable identity or a specific declared interface; version constraints and why required |
| `optional_requires` | explicit condition, feature and behavior when unavailable; cannot import unconditionally |
| `runtime_requirements` | runtime/API/platform/library/driver availability and target profile |
| `resources` | required templates, assets, config schema and external bindings |
| `entrypoints` / `lifecycle` | concrete start/stop/load interfaces; no import-time activation |
| `capabilities` / `policies` | requested permissions and applicable restrictions; grant is separate |
| `tests` | tests covering dependency presence, absence, target, interface and denied access |

Names above express **required information**, not a prematurely locked literal JSON schema. The specific manifest fields will be mapped to the pre-existing USER `module.json` contract in a versioned change.

### Explicit dependency classes

- **Required runtime:** execution cannot work without the declared provider.
- **Conditional optional:** an identified feature may work with a provider, with explicit alternative/disabled behavior and no undeclared imports.
- **Build-only:** tooling used to construct/validate an artifact, not present in the shipped runtime unless separately selected.
- **Test-only:** fixture and validation dependency; cannot leak into runtime packages.
- **Target/platform:** required host services, language APIs, firmware/native modules, devices and resource constraints.
- **Resource/data:** required files, View declarations, Panel identities, schemas, protocol bindings and configuration.

A module may list multiple classes, but every direct edge has one clear execution/scope meaning and a declared condition.

## 3. Resolver/validator behavior

For requested target T and selected components S:

1. Read the selected modules' contracts and **all direct edges**, without executing their implementation code.
2. Validate identities, versions, declared interfaces, capabilities, target/platform constraints and required resources.
3. Compute deterministic dependency closure `C = closure(S, requires)`; include each transitive edge with its chain of justification.
4. Reject missing providers, ambiguous providers, incompatible versions, unsupported target features, unexpected cycles, undeclared imports/resources and violations of allowed dependency direction.
5. Emit a machine-readable dependency report and per-build lock/snapshot. Include **why each component is in the output**.
6. Build only C plus the explicitly defined Core baseline. No registry scanning at target boot to pull in additional modules.
7. Validate the actual packaged files/import graph against that resolved closure. Packaging must not add undeclared code implicitly.

A general-purpose developer-host discovery tool may inventory candidates, but **discovery is not permission, activation or inclusion**.

## 4. Static and runtime validation gates

| Check | Must demonstrate |
|---|---|
| Import edge scan | `import`, `from ... import`, relative imports and resolvable lazy imports map to owned/declarable dependencies; non-statically resolvable imports require an explicitly bounded declaration and corresponding test. |
| Runtime smoke with absent modules | Minimal Core starts with View Engine, Panel registry, optional adapters/network and Build Engine physically absent. |
| Import-time effects | No optional service starts or mutates shared state merely because a module was imported. |
| Negative dependency tests | Required dependency missing, wrong version, missing capability, ambiguous provider and wrong target all **fail visibly**. |
| Conditional feature tests | Optional providers absent → declared feature disabled/handled with explicit status, never an unnoticed fallback. |
| Asset and View/Panel binding validation | Every View Panel reference, template/resource path and cross-module binding resolves to a declared provider. |
| Permission boundary tests | SYSTEM/USER same-name conflict is explicit; no implied privilege escalation or undeclared state mutation. |
| Artifact inspection | Produced target contains exactly declared Core baseline + resolved modules/assets, not unselected modules or build/test helpers. |
| Target checks | CPython tests and MicroPython/ESP32-C6 compatibility are separate measured evidence; no false equivalence. |

**Pass rule:** any unresolved/undeclared dependency is a **hard gate (FAIL)**, never a warning for release or a target composition. Reporting an unresolved dependency is not permission to continue using it. A failure may be fixed by declaring and implementing the relation, changing architecture, or removing the dependency — not by disabling the check.

## 5. P0 migration order

- [ ] Scan the entire 1.8 source tree and build an evidence-backed actual import/call/resource/startup graph.
- [ ] Classify each node as Core infrastructure, SYSTEM module, USER module, USE module, Panel, View, engine or other declared resource.
- [ ] Identify and remove implicit Core → optional component edges, starting at `system/bootstrap.py`.
- [ ] Identify cross-module imports and shared helpers; create explicit interface contracts or relocate truly shared mechanisms.
- [ ] Map existing USER manifest to 1.9 dependency declarations; version the change without modifying the locked source silently.
- [ ] Build dependency resolver and independent validator for direct and transitive dependency closure.
- [ ] Add fail-closed validation for undeclared import, undeclared asset, duplicate identity, incompatible target, non-selected module loaded.
- [ ] Create Minimal Core no-optional-dependencies smoke and test a single Panel + View composition.
- [ ] Integrate validation as a mandatory gate before migration completion and before every build/release.
- [ ] Verify resource savings and behavior preservation on real target hardware.

## 6. Boundary reminder

**Declared dependency ≠ automatically selected module.** A valid declaration permits the resolver to explain the required composition; it does not give the module extra authority, require the whole SYSTEM tree, or override the selected target's limits.

**Goal:** at any time, it must be mechanically answerable:
- **What** does this component depend on?
- **Why** is that dependency necessary?
- **Who** provides it?
- **Where** is it used and activated?
- **Can** the target run without it?
- **What** fails if it is absent?

This contract is **not yet enforced in code**. The 1.9 implementation may not be certified as modular or hidden-dependency-free before the tests and reports pass.
