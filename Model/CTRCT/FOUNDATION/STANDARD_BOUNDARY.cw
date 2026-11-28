{
  "id": "#CTRCT:AIGMOS19:FOUNDATION:STANDARD_BOUNDARY",
  "name": "FOUNDATION / STANDARD BOUNDARY",
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
              "id": "A19-001",
              "requirement": "AIGM is a platform-independent standard; AIGMos 1.9 is its technical implementation/reference. MicroPython support is an AIGMos implementation target, not a condition of AIGM standard conformance.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-001",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-024",
              "requirement": "Never silently modify locked AIGMos 2.0 canonical contracts. Adapt semantics through explicitly versioned 1.9 contracts and document differences.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-024",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-047",
              "requirement": "Status remains unlocked until a compatible complete contract is validated. No claim of immutable specification or automatic lock may be made based solely on documenting these decisions.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-047",
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
          "category": "FOUNDATION",
          "logical_role": "STANDARD_BOUNDARY",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-001",
      "A19-024",
      "A19-047"
    ],
    "review_status": "UNLOCKED"
  }
}
