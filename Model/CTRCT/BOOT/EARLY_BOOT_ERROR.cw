{
  "id": "#CTRCT:AIGMOS19:BOOT:EARLY_BOOT_ERROR",
  "name": "BOOT / EARLY BOOT ERROR",
  "entity_type_ref": "contract",
  "status": "unlocked",
  "members": [
    "#LOGIC:AIGMOS19:BOOT"
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
              "id": "BOOT-01",
              "requirement": "BOOT can report canonical Errors before HC.CS or optional Logging capture modes initialize.",
              "source_file": "developer/canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json",
              "source_record_ref": "#CTRCT:AIGMOS19:BOOT",
              "provenance_class": "prior_derived_contract_requirements",
              "status": "unlocked"
            },
            {
              "id": "BOOT-03",
              "requirement": "BOOT errors without real CS execution must not cause a fabricated CS log or fake actor.",
              "source_file": "developer/canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json",
              "source_record_ref": "#CTRCT:AIGMOS19:BOOT",
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
          "category": "BOOT",
          "logical_role": "EARLY_BOOT_ERROR",
          "implementation_member_status": "candidate_CW_LOGIC_no_code_validation"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/canonical/AIGMos_1.9_Errors_Logging_CTRCT_First_v0.1.0.json",
    "source_requirement_ids": [
      "BOOT-01",
      "BOOT-03"
    ],
    "review_status": "UNLOCKED"
  }
}
