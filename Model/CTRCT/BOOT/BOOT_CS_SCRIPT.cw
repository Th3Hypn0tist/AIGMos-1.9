{
  "id": "#CTRCT:AIGMOS19:BOOT:BOOT_CS_SCRIPT",
  "name": "BOOT / BOOT CS SCRIPT",
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
              "id": "A19-066",
              "requirement": "Optional boot.cs is the designated mechanism for explicit Runner startup. Missing boot.cs is not an error; boot.cs command FAIL aborts boot with no rollback and no automatic retry. Effects already committed remain.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-066",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            }
          ]
        },
        "properties": {}
      },
      "metadata": {
        "source_trace": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
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
          "logical_role": "BOOT_CS_SCRIPT",
          "implementation_member_status": "candidate_CW_LOGIC_no_code_validation"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-066"
    ],
    "review_status": "UNLOCKED"
  }
}
