{
  "id": "#CTRCT:AIGMOS19:LOGGING:MODE_DEPENDENCIES",
  "name": "LOGGING / MODE DEPENDENCIES",
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
              "id": "LOG-04",
              "requirement": "Mode cs requires HC.CS capability; mode ac requires HC.CS plus AccessCore; these capability requirements do not imply Python import direction.",
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
          "logical_role": "MODE_DEPENDENCIES",
          "implementation_member_status": "candidate_CW_LOGIC_no_code_validation"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json",
    "source_requirement_ids": [
      "LOG-04"
    ],
    "review_status": "UNLOCKED"
  }
}
