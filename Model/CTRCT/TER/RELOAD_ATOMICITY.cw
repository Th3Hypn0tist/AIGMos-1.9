{
  "id": "#CTRCT:AIGMOS19:TER:RELOAD_ATOMICITY",
  "name": "TER / RELOAD ATOMICITY",
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
              "id": "A19-059",
              "requirement": "Explicit CS reload for reloadable definitions only, no file watching; static mount/adapter/dependency changes not hot-reloadable. TER definition reload uses atomic swap: inflight operations finish under their acquired definitions, newly accepted work uses new definitions.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-059",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-060",
              "requirement": "Invalid TER reload FAILs without replacing live definitions. Re-prime triggers from current STATE on successful reload without emitting Events.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-060",
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
          "logical_role": "RELOAD_ATOMICITY",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-059",
      "A19-060"
    ],
    "review_status": "UNLOCKED"
  }
}
