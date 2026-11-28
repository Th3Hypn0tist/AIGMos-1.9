{
  "id": "#CTRCT:AIGMOS19:MODULES:MODULE_DEPENDENCY_CLASSES",
  "name": "MODULES / MODULE DEPENDENCY CLASSES",
  "entity_type_ref": "contract",
  "status": "unlocked",
  "members": [],
  "properties": [
    {
      "id": "REQUIREMENTS",
      "property_type_ref": "data",
      "ruleset_ref": "RULESET_DATA",
      "status": "unlocked",
      "value": {
        "data_type_ref": "A19_DECLARED_REQUIREMENTS",
        "value": {
          "requirements": [
            {
              "id": "A19-017",
              "requirement": "Core Modules may depend on allowed Hardcore interfaces (e.g. HC.CS), not direct private STATE access; Core Module → Core Module remains forbidden.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-017",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-018",
              "requirement": "System Modules may depend on Hardcore and permitted Core Modules; direct System→System imports/dependencies are NOT yet authorized by a final decision.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-018",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-019",
              "requirement": "AIGM User Modules use Core/System facilities without external dependencies. Other User Modules may have external dependencies if explicitly declared and policy-compliant.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-019",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-053",
              "requirement": "Core Modules and System Lib are separate architectural categories; EXP belongs to System Lib and REST is an Expose module requiring EXP.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-053",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            }
          ]
        },
        "properties": {}
      },
      "metadata": {
        "source_trace": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
        "authority": "development_evidence_not_cw_locked"
      }
    },
    {
      "id": "CONTRACT_ROLE",
      "property_type_ref": "data",
      "ruleset_ref": "RULESET_DATA",
      "status": "unlocked",
      "value": {
        "data_type_ref": "A19_CONTRACT_ROLE",
        "value": {
          "category": "MODULES",
          "logical_role": "MODULE_DEPENDENCY_CLASSES",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-017",
      "A19-018",
      "A19-019",
      "A19-053"
    ],
    "review_status": "UNLOCKED"
  }
}
