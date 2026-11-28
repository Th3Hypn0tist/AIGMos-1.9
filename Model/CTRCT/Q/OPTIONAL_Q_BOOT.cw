{
  "id": "#CTRCT:AIGMOS19:Q:OPTIONAL_Q_BOOT",
  "name": "Q / OPTIONAL Q BOOT",
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
              "id": "CLEAN-006",
              "requirement": "Q is optional at build time. EVERY Q-containing build must include a valid q.default profile; boot must fail if absent or invalid. A Q-free build must not require Q configuration, Q code, Q validators or Q-exclusive dependencies. Q-specific config/validation is Q-owned.",
              "source_file": "developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json",
              "source_record_ref": "CLEAN-006",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            }
          ]
        },
        "properties": {}
      },
      "metadata": {
        "source_trace": "developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json",
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
          "category": "Q",
          "logical_role": "OPTIONAL_Q_BOOT",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json",
    "source_requirement_ids": [
      "CLEAN-006"
    ],
    "review_status": "UNLOCKED"
  }
}
