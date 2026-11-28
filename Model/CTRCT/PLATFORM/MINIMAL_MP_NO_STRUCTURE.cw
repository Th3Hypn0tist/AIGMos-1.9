{
  "id": "#CTRCT:AIGMOS19:PLATFORM:MINIMAL_MP_NO_STRUCTURE",
  "name": "PLATFORM / MINIMAL MP NO STRUCTURE",
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
              "id": "CLEAN-004",
              "requirement": "The standard minimal MP build contains no # structured facility. A selected structured Core Module may provide # in compatible other builds. No Hardcore/SYSTEM dependency may implicitly require #.",
              "source_file": "developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json",
              "source_record_ref": "CLEAN-004",
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
          "category": "PLATFORM",
          "logical_role": "MINIMAL_MP_NO_STRUCTURE",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json",
    "source_requirement_ids": [
      "CLEAN-004"
    ],
    "review_status": "UNLOCKED"
  }
}
