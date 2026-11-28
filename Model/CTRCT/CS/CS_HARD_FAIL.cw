{
  "id": "#CTRCT:AIGMOS19:CS:CS_HARD_FAIL",
  "name": "CS / CS HARD FAIL",
  "entity_type_ref": "contract",
  "status": "unlocked",
  "members": [
    "#LOGIC:AIGMOS19:HC.CS"
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
              "id": "CSO-04",
              "requirement": "Internal status ERROR always hard-fails the current CS execution and is represented through shared Error System Lib.",
              "source_file": "developer/canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json",
              "source_record_ref": "#CTRCT:AIGMOS19:CSO",
              "provenance_class": "prior_derived_contract_requirements",
              "status": "unlocked"
            },
            {
              "id": "CSO-05",
              "requirement": "If actual CS execution fails, the Error Buffer records the failure and the Log Buffer records one invocation trace.",
              "source_file": "developer/canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json",
              "source_record_ref": "#CTRCT:AIGMOS19:CSO",
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
          "category": "CS",
          "logical_role": "CS_HARD_FAIL",
          "implementation_member_status": "candidate_CW_LOGIC_no_code_validation"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json",
    "source_requirement_ids": [
      "CSO-04",
      "CSO-05"
    ],
    "review_status": "UNLOCKED"
  }
}
