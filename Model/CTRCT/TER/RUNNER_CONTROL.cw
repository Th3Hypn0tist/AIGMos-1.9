{
  "id": "#CTRCT:AIGMOS19:TER:RUNNER_CONTROL",
  "name": "TER / RUNNER CONTROL",
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
              "id": "A19-064",
              "requirement": "Runner executions run to completion without timeouts. run.stop requests cooperative stop, retaining queued work; run.flush requests stop and clears queued work. No forced termination of currently executing CS command; honor safe boundary.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-064",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-065",
              "requirement": "Stopped Runner rejects new execution requests. run.start resumes its retained FIFO. At boot Runners start stopped unless explicitly started via boot.cs.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-065",
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
          "logical_role": "RUNNER_CONTROL",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-064",
      "A19-065"
    ],
    "review_status": "UNLOCKED"
  }
}
