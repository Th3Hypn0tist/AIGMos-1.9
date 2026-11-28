{
  "id": "#CTRCT:AIGMOS19:CS:UNWRAPPED_CSO",
  "name": "CS / UNWRAPPED CSO",
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
              "id": "CSO-02",
              "requirement": "When OK and payload absent, CSo returns plain OK; when OK with payload, CSo returns original command feedback unwrapped.",
              "source_file": "developer/canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json",
              "source_record_ref": "#CTRCT:AIGMOS19:CSO",
              "provenance_class": "prior_derived_contract_requirements",
              "status": "unlocked"
            },
            {
              "id": "CSO-03",
              "requirement": "Payload presence is separate from value; literal ERROR, literal OK, null, false, zero and empty string may be successful returned data.",
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
          "logical_role": "UNWRAPPED_CSO",
          "implementation_member_status": "candidate_CW_LOGIC_no_code_validation"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json",
    "source_requirement_ids": [
      "CSO-02",
      "CSO-03"
    ],
    "review_status": "UNLOCKED"
  }
}
