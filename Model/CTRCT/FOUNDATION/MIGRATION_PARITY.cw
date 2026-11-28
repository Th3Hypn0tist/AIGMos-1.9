{
  "id": "#CTRCT:AIGMOS19:FOUNDATION:MIGRATION_PARITY",
  "name": "FOUNDATION / MIGRATION PARITY",
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
              "id": "A19-002",
              "requirement": "Build AIGMos 1.9 by modularizing and optimizing the existing AIGMos 1.8. Preserve working semantics where applicable; avoid unconditional rewrites.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-002",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-003",
              "requirement": "Hardcore → Core Modules → System Modules → Build Tool → ESP32-C6 Build.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-003",
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
          "category": "FOUNDATION",
          "logical_role": "MIGRATION_PARITY",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-002",
      "A19-003"
    ],
    "review_status": "UNLOCKED"
  }
}
