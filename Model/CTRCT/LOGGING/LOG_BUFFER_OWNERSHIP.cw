{
  "id": "#CTRCT:AIGMOS19:LOGGING:LOG_BUFFER_OWNERSHIP",
  "name": "LOGGING / LOG BUFFER OWNERSHIP",
  "entity_type_ref": "contract",
  "status": "unlocked",
  "members": [
    "#LOGIC:AIGMOS19:LOGGING"
  ],
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
              "id": "LOG-01",
              "requirement": "Logging owns Log Buffer; Error owns its separate Error Buffer. The owner identities are not #SYSTEM.",
              "source_file": "developer/canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json",
              "source_record_ref": "#CTRCT:AIGMOS19:LOGGING",
              "provenance_class": "prior_derived_contract_requirements",
              "status": "unlocked"
            }
          ]
        },
        "properties": {}
      },
      "metadata": {
        "source_trace": "developer/canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json",
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
          "category": "LOGGING",
          "logical_role": "LOG_BUFFER_OWNERSHIP",
          "implementation_member_status": "candidate_CW_LOGIC_no_code_validation"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json",
    "source_requirement_ids": [
      "LOG-01"
    ],
    "review_status": "UNLOCKED"
  }
}
