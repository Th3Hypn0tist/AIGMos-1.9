{
  "id": "#CTRCT:AIGMOS19:TER:RUNNER_TARGET_MODES",
  "name": "TER / RUNNER TARGET MODES",
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
              "id": "A19-067",
              "requirement": "config.json runner.modes supports once or all. MicroPython-compatible profile supports once only; CP can support once, cycle and loop with extra capabilities and threading where needed. The same public CS interface is shared across MP and CP.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-067",
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
          "category": "TER",
          "logical_role": "RUNNER_TARGET_MODES",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-067"
    ],
    "review_status": "UNLOCKED"
  }
}
