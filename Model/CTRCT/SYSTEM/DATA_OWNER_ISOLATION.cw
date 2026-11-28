{
  "id": "#CTRCT:AIGMOS19:SYSTEM:DATA_OWNER_ISOLATION",
  "name": "SYSTEM / DATA OWNER ISOLATION",
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
              "id": "CLEAN-002",
              "requirement": "SYSTEM owns only SYSTEM's own data. TER owns trigger, event and runner definitions/runtime and queues. Q owns its profiles, queues, tasks and history. Layout owns keymap and instances. STATE is a storage service, not a semantic owner.",
              "source_file": "developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json",
              "source_record_ref": "CLEAN-002",
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
          "category": "SYSTEM",
          "logical_role": "DATA_OWNER_ISOLATION",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json",
    "source_requirement_ids": [
      "CLEAN-002"
    ],
    "review_status": "UNLOCKED"
  }
}
