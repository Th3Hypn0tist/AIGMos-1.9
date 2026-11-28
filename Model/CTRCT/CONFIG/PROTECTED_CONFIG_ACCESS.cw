{
  "id": "#CTRCT:AIGMOS19:CONFIG:PROTECTED_CONFIG_ACCESS",
  "name": "CONFIG / PROTECTED CONFIG ACCESS",
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
              "id": "CLEAN-005",
              "requirement": "Component-owned configuration is placed under protected /config. BOOT loads it; CS reload command can request a privileged loader to read/validate/reload it. Ordinary CS cannot read raw /config or write raw /config, including through generic FILE/import/export operations. Do not mirror private configuration wholesale to STATE.",
              "source_file": "developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json",
              "source_record_ref": "CLEAN-005",
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
          "category": "CONFIG",
          "logical_role": "PROTECTED_CONFIG_ACCESS",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json",
    "source_requirement_ids": [
      "CLEAN-005"
    ],
    "review_status": "UNLOCKED"
  }
}
