{
  "format": {
    "contract_format": "CANONICAL_CONTRACT",
    "format_version": "2.1"
  },
  "identity": {
    "id": "AIGMOS19_CW_MODEL",
    "name": "AIGMos 1.9 canonical CW model — #CTRCT first",
    "type": "system_architecture",
    "version": "0.1.0"
  },
  "specification_ref": "git-blob:Th3Hypn0tist/CW/spec_sets/CW_CORE_v1.6.0.json@3b712798e8a21a15c4981119188f340a335334b7",
  "status": "unlocked",
  "purpose": "Real sharded CW canonical model, with each #CTRCT responsibility in its own .cw Entity shard, four earlier #LOGIC code-node skeletons and explicitly traceable source decisions. These replace the previous non-sharded developer/canonical JSON drafts as the working CW surface.",
  "scope": {
    "owns": [
      "AIGMos 1.9 #CTRCT contract identity, scope and source-traced normative requirement inventory",
      "Explicit CW #LOGIC skeleton identities for Error/Logging/HC.CS/BOOT",
      "Canonical shard closure for the first active AIGMos 1.9 CW package"
    ],
    "does_not_own": [
      "Unapproved behavioral decisions",
      "Unmodeled implementation identities or code",
      "Immutable/validator-approved contract status",
      "Runtime source implementation of functions",
      "Whole-instance shutdown from any ERROR",
      "Separate Bot-training Audit"
    ]
  },
  "entities": [],
  "shards": [
    {
      "entity_ref": "#CTRCT:AIGMOS19:FOUNDATION:STANDARD_BOUNDARY",
      "artifact_ref": "CTRCT/FOUNDATION/STANDARD_BOUNDARY.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:FOUNDATION:MIGRATION_PARITY",
      "artifact_ref": "CTRCT/FOUNDATION/MIGRATION_PARITY.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:PLATFORM:TARGET_MP_CP",
      "artifact_ref": "CTRCT/PLATFORM/TARGET_MP_CP.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:HARDCORE:HARDCORE_SET",
      "artifact_ref": "CTRCT/HARDCORE/HARDCORE_SET.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:HARDCORE:INPUT_STATE_GATE",
      "artifact_ref": "CTRCT/HARDCORE/INPUT_STATE_GATE.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:HARDCORE:STATE_ACCESS",
      "artifact_ref": "CTRCT/HARDCORE/STATE_ACCESS.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:HARDCORE:TER_EXECUTION",
      "artifact_ref": "CTRCT/HARDCORE/TER_EXECUTION.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:HARDCORE:CS_EXECUTION",
      "artifact_ref": "CTRCT/HARDCORE/CS_EXECUTION.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:SECURITY:AC_CS_CHOKEPOINT",
      "artifact_ref": "CTRCT/SECURITY/AC_CS_CHOKEPOINT.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:HARDCORE:EXPOSE_BOUNDARY",
      "artifact_ref": "CTRCT/HARDCORE/EXPOSE_BOUNDARY.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:CONFIG:ROOT_CONFIG",
      "artifact_ref": "CTRCT/CONFIG/ROOT_CONFIG.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:MODULES:MODULE_DEPENDENCY_CLASSES",
      "artifact_ref": "CTRCT/MODULES/MODULE_DEPENDENCY_CLASSES.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:MODULES:OPTIONAL_STRUCTURE",
      "artifact_ref": "CTRCT/MODULES/OPTIONAL_STRUCTURE.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:MODULES:MODULE_PRIMITIVES",
      "artifact_ref": "CTRCT/MODULES/MODULE_PRIMITIVES.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:EXP:EXP_CLASSIFICATION",
      "artifact_ref": "CTRCT/EXP/EXP_CLASSIFICATION.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:EXP:EXP_DEFINITION_SOURCE",
      "artifact_ref": "CTRCT/EXP/EXP_DEFINITION_SOURCE.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:EXP:EXP_EVALUATION",
      "artifact_ref": "CTRCT/EXP/EXP_EVALUATION.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:EXP:EXP_EFFECT_BOUNDARY",
      "artifact_ref": "CTRCT/EXP/EXP_EFFECT_BOUNDARY.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:REST:REST_GET",
      "artifact_ref": "CTRCT/REST/REST_GET.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:REST:REST_MODES",
      "artifact_ref": "CTRCT/REST/REST_MODES.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:REST:REST_SECURITY_AND_SELECTION",
      "artifact_ref": "CTRCT/REST/REST_SECURITY_AND_SELECTION.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:BUILD:BUILDER_ROLE",
      "artifact_ref": "CTRCT/BUILD/BUILDER_ROLE.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:BUILD:BUILD_TARGET_PROVISIONING",
      "artifact_ref": "CTRCT/BUILD/BUILD_TARGET_PROVISIONING.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:TER:TER_PERSISTENCE_CLOSURE",
      "artifact_ref": "CTRCT/TER/TER_PERSISTENCE_CLOSURE.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:BUILD:SOURCE_DEPENDENCY_AUTHORITY",
      "artifact_ref": "CTRCT/BUILD/SOURCE_DEPENDENCY_AUTHORITY.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:STORAGE:MEM_FILE_DEFINITIONS",
      "artifact_ref": "CTRCT/STORAGE/MEM_FILE_DEFINITIONS.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:STORAGE:MOUNT_BINDINGS",
      "artifact_ref": "CTRCT/STORAGE/MOUNT_BINDINGS.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:TER:RELOAD_ATOMICITY",
      "artifact_ref": "CTRCT/TER/RELOAD_ATOMICITY.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:TER:EVENT_QUEUE",
      "artifact_ref": "CTRCT/TER/EVENT_QUEUE.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:TER:RUNNER_QUEUE",
      "artifact_ref": "CTRCT/TER/RUNNER_QUEUE.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:TER:RUNNER_CONTROL",
      "artifact_ref": "CTRCT/TER/RUNNER_CONTROL.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:BOOT:BOOT_CS_SCRIPT",
      "artifact_ref": "CTRCT/BOOT/BOOT_CS_SCRIPT.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:TER:RUNNER_TARGET_MODES",
      "artifact_ref": "CTRCT/TER/RUNNER_TARGET_MODES.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:PLATFORM:COOPERATIVE_SCHEDULER",
      "artifact_ref": "CTRCT/PLATFORM/COOPERATIVE_SCHEDULER.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:BUILD:TARGET_PRUNING",
      "artifact_ref": "CTRCT/BUILD/TARGET_PRUNING.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:SECURITY:AC_ACTIVATION_BOUNDARY",
      "artifact_ref": "CTRCT/SECURITY/AC_ACTIVATION_BOUNDARY.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:SYSTEM:SYSTEM_OWNERSHIP",
      "artifact_ref": "CTRCT/SYSTEM/SYSTEM_OWNERSHIP.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:BUILD:CODEMARKUP_SOURCE_CONTRACT",
      "artifact_ref": "CTRCT/BUILD/CODEMARKUP_SOURCE_CONTRACT.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:MODULES:ONE_EIGHT_PARITY",
      "artifact_ref": "CTRCT/MODULES/ONE_EIGHT_PARITY.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:SYSTEM:DATA_OWNER_ISOLATION",
      "artifact_ref": "CTRCT/SYSTEM/DATA_OWNER_ISOLATION.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:STATE:KV_SYMBOL_ROOT",
      "artifact_ref": "CTRCT/STATE/KV_SYMBOL_ROOT.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:PLATFORM:MINIMAL_MP_NO_STRUCTURE",
      "artifact_ref": "CTRCT/PLATFORM/MINIMAL_MP_NO_STRUCTURE.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:CONFIG:PROTECTED_CONFIG_ACCESS",
      "artifact_ref": "CTRCT/CONFIG/PROTECTED_CONFIG_ACCESS.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:Q:OPTIONAL_Q_BOOT",
      "artifact_ref": "CTRCT/Q/OPTIONAL_Q_BOOT.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:SECURITY:AC_CONFIG_EXCEPTION",
      "artifact_ref": "CTRCT/SECURITY/AC_CONFIG_EXCEPTION.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:BUILD:PRUNE_OPTIONAL_Q_AND_AC",
      "artifact_ref": "CTRCT/BUILD/PRUNE_OPTIONAL_Q_AND_AC.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:ERROR:HARD_FAIL",
      "artifact_ref": "CTRCT/ERROR/HARD_FAIL.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:ERROR:SHARED_ERROR_LIBRARY",
      "artifact_ref": "CTRCT/ERROR/SHARED_ERROR_LIBRARY.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:ERROR:ERROR_BUFFER_OWNERSHIP",
      "artifact_ref": "CTRCT/ERROR/ERROR_BUFFER_OWNERSHIP.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:ERROR:ERROR_CS_CONTEXT",
      "artifact_ref": "CTRCT/ERROR/ERROR_CS_CONTEXT.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:ERROR:ERROR_AC_ACTOR",
      "artifact_ref": "CTRCT/ERROR/ERROR_AC_ACTOR.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:LOGGING:LOG_BUFFER_OWNERSHIP",
      "artifact_ref": "CTRCT/LOGGING/LOG_BUFFER_OWNERSHIP.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:LOGGING:LOGGING_MODE",
      "artifact_ref": "CTRCT/LOGGING/LOGGING_MODE.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:LOGGING:FAILED_CS_LOG",
      "artifact_ref": "CTRCT/LOGGING/FAILED_CS_LOG.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:LOGGING:MODE_DEPENDENCIES",
      "artifact_ref": "CTRCT/LOGGING/MODE_DEPENDENCIES.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:LOGGING:BUFFER_CAPACITY",
      "artifact_ref": "CTRCT/LOGGING/BUFFER_CAPACITY.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:LOGGING:AUDIT_EXCLUSION",
      "artifact_ref": "CTRCT/LOGGING/AUDIT_EXCLUSION.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:CS:INTERNAL_RESULT",
      "artifact_ref": "CTRCT/CS/INTERNAL_RESULT.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:CS:UNWRAPPED_CSO",
      "artifact_ref": "CTRCT/CS/UNWRAPPED_CSO.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:CS:CS_HARD_FAIL",
      "artifact_ref": "CTRCT/CS/CS_HARD_FAIL.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:CS:CSO_TRANSPORT",
      "artifact_ref": "CTRCT/CS/CSO_TRANSPORT.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:BOOT:EARLY_BOOT_ERROR",
      "artifact_ref": "CTRCT/BOOT/EARLY_BOOT_ERROR.cw"
    },
    {
      "entity_ref": "#CTRCT:AIGMOS19:BOOT:BOOT_HARD_FAIL",
      "artifact_ref": "CTRCT/BOOT/BOOT_HARD_FAIL.cw"
    },
    {
      "entity_ref": "#LOGIC:AIGMOS19:ERROR",
      "artifact_ref": "LOGIC/ERROR.cw"
    },
    {
      "entity_ref": "#LOGIC:AIGMOS19:LOGGING",
      "artifact_ref": "LOGIC/LOGGING.cw"
    },
    {
      "entity_ref": "#LOGIC:AIGMOS19:HC.CS",
      "artifact_ref": "LOGIC/HC_CS.cw"
    },
    {
      "entity_ref": "#LOGIC:AIGMOS19:BOOT",
      "artifact_ref": "LOGIC/BOOT.cw"
    }
  ],
  "constraints": {
    "invariants": [
      {
        "id": "CW-001",
        "rule": "This sharded .cw root lists exactly one shard for each included canonical Entity; historical developer/canonical JSON drafts are NOT composed into this Model."
      },
      {
        "id": "CW-002",
        "rule": "Every Contract owns a distinct semantic responsibility and its source decision IDs; unmodeled #LOGIC identities are NOT invented."
      },
      {
        "id": "CW-003",
        "rule": "Sources marked superseded, reconciliation-pending, or historical are classified outside active Contracts; a new decision is needed before promoting unresolved semantics."
      },
      {
        "id": "CW-004",
        "rule": "Contract.members defines normative CW Entity scope, not proof of code or runtime compliance."
      },
      {
        "id": "CW-005",
        "rule": "Real Error means hard fail; the exact machine-level abort representation remains a formalization Gap."
      }
    ]
  },
  "references": [],
  "gaps": [
    {
      "gap_id": "G-001",
      "type": "unresolved_semantics",
      "status": "open",
      "entity_ref": "#CTRCT:AIGMOS19:BUILD:CODEMARKUP_SOURCE_CONTRACT",
      "description": "Pinned CodeMarkup target/header migration from earlier MP/CP headers to MP/CP/BOTH must remain versioned and validated before execution."
    },
    {
      "gap_id": "G-002",
      "type": "unresolved_semantics",
      "status": "open",
      "entity_ref": "#CTRCT:AIGMOS19:CONFIG:PROTECTED_CONFIG_ACCESS",
      "description": "Protected config paths, actual config schema, #SYSTEM projection and pre-config Error buffer still require reconciliation."
    },
    {
      "gap_id": "G-003",
      "type": "unresolved_semantics",
      "status": "open",
      "entity_ref": "#CTRCT:AIGMOS19:ERROR:HARD_FAIL",
      "description": "CW_LOGIC_PRIMITIVES 1.0 under Rulesets 4.4.0 lacks an explicit hard-fail/abort/raise primitive; no Function.logic body is fabricated."
    },
    {
      "gap_id": "G-004",
      "type": "unresolved_semantics",
      "status": "open",
      "entity_ref": "#CTRCT:AIGMOS19:CS:UNWRAPPED_CSO",
      "description": "CSo transport status must distinguish the success payload literal ERROR from actual hard fail, without wrapping success."
    },
    {
      "gap_id": "G-005",
      "type": "unresolved_semantics",
      "status": "open",
      "entity_ref": "#CTRCT:AIGMOS19:TER:RUNNER_CONTROL",
      "description": "Source-backed Runner once/cycle/loop stop/start/flush parity and propagation semantics remain open."
    },
    {
      "gap_id": "G-006",
      "type": "unresolved_semantics",
      "status": "open",
      "entity_ref": "#CTRCT:AIGMOS19:MODULES:ONE_EIGHT_PARITY",
      "description": "The union of valid 1.9 feature-selected builds must retain 1.8 parity; source audit and executable tests are not completed."
    },
    {
      "gap_id": "G-007",
      "type": "unresolved_semantics",
      "status": "open",
      "entity_ref": "#CTRCT:AIGMOS19:BOOT:EARLY_BOOT_ERROR",
      "description": "Early BOOT Error storage/loading before config/CS initialization unresolved."
    },
    {
      "gap_id": "G-008",
      "type": "unresolved_semantics",
      "status": "open",
      "entity_ref": "#CTRCT:AIGMOS19:ERROR:SHARED_ERROR_LIBRARY",
      "description": "Exact Error record schema, Error library APIs, actor/secret handling and failure propagation paths not yet approved."
    },
    {
      "gap_id": "G-009",
      "type": "unresolved_semantics",
      "status": "open",
      "entity_ref": "#CTRCT:AIGMOS19:LOGGING:BUFFER_CAPACITY",
      "description": "Exact config.json keys and buffer defaults, resource policy for N=0, persistence and access remain open."
    },
    {
      "gap_id": "G-010",
      "type": "unresolved_semantics",
      "status": "open",
      "entity_ref": "#CTRCT:AIGMOS19:MODULES:MODULE_DEPENDENCY_CLASSES",
      "description": "System→System imports/dependency authorization, lifecycle and module registry not yet final."
    }
  ],
  "prose": {
    "summary": "63 actual #CTRCT .cw Entity shards and 4 #LOGIC .cw Entity shards; 110 traced candidate requirements and 7 explicit exclusions. This is the first AIGMos 1.9 filesystem CW model, distinct from older developer JSON drafts.",
    "notes": "UNLOCKED development evidence; canonical CW representation is real but no formal CW validator or runtime acceptance has been run. The same JSON syntax is used within .cw because CW is a canonical data model, not a different textual encoding."
  },
  "metadata": {
    "created_date": "2026-11-27",
    "source_documents": [
      "developer/canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json",
      "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
      "developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json",
      "developer/contracts/AIGMos_1.9_Build_CodeMarkup_Integration_v0.1.0.json"
    ],
    "source_requirements": 110,
    "excluded_source_decisions": [
      {
        "id": "A19-046",
        "status": "historical_reference",
        "reason": "AIGMos 2.0 REST reference semantics; v1.9 divergence is modeled elsewhere."
      },
      {
        "id": "A19-048",
        "status": "superseded",
        "reason": "Earlier source-header wording; revised header/markup are versioned separately."
      },
      {
        "id": "A19-069",
        "status": "versioned_prior_header",
        "reason": "Prior MP/CP header model, later target migration to MP/CP/BOTH is UNLOCKED and must not rewrite previous interpretation."
      },
      {
        "id": "A19-076",
        "status": "recommended_not_confirmed",
        "reason": "Activation rollback on atomic-write failure not explicitly adopted."
      },
      {
        "id": "A19-077",
        "status": "reconciliation_pending",
        "reason": "Historical config projection to #SYSTEM conflicts with more recent protected config policy; need precise visibility model."
      },
      {
        "id": "A19-079",
        "status": "legacy_observation",
        "reason": "Observation about 1.8 implementation, not a 1.9 normative requirement."
      },
      {
        "id": "CLEAN-009",
        "status": "future_out_of_scope",
        "reason": "Encrypted direct instance link is a future concern outside current 1.9 implementation."
      }
    ],
    "prior_draft": "developer/canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json",
    "source_classification_status": "COMPLETE",
    "selected_specification_set": "CW_CORE_v1.6.0 (UNLOCKED opt-in)"
  }
}
