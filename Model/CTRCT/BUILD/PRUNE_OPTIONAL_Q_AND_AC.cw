{
  "id": "#CTRCT:AIGMOS19:BUILD:PRUNE_OPTIONAL_Q_AND_AC",
  "name": "BUILD / PRUNE OPTIONAL Q AND AC",
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
              "id": "CLEAN-008",
              "requirement": "Build Tool physically prunes unselected modules, conditional hooks, associated validators/config requirements and exclusive dependencies; external AI interoperability via generic INPUT/EXPOSE does not make AI/Q code part of that build.",
              "source_file": "developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json",
              "source_record_ref": "CLEAN-008",
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
          "category": "BUILD",
          "logical_role": "PRUNE_OPTIONAL_Q_AND_AC",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Config_Ownership_Parity_Delta_v0.1.0.json",
    "source_requirement_ids": [
      "CLEAN-008"
    ],
    "review_status": "UNLOCKED"
  }
}
