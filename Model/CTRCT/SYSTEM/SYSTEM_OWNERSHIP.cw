{
  "id": "#CTRCT:AIGMOS19:SYSTEM:SYSTEM_OWNERSHIP",
  "name": "SYSTEM / SYSTEM OWNERSHIP",
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
              "id": "A19-078",
              "requirement": "1.8 #SYSTEM currently accumulates other components' durable definitions, runtime trigger state, Q queue and Layout keymap. User requires rationalization: #SYSTEM must not become arbitrary component storage; proposed rule: #SYSTEM owns only SYSTEM information, component owners own their runtime/definition data. Exact relocation/namespaces NOT YET LOCKED.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-078",
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
          "category": "SYSTEM",
          "logical_role": "SYSTEM_OWNERSHIP",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-078"
    ],
    "review_status": "UNLOCKED"
  }
}
