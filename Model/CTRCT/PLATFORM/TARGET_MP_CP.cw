{
  "id": "#CTRCT:AIGMOS19:PLATFORM:TARGET_MP_CP",
  "name": "PLATFORM / TARGET MP CP",
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
              "id": "A19-004",
              "requirement": "Reference constrained target: ESP32-C6-N16 without PSRAM; all mandatory Hardcore source must be compatible with MicroPython. Run constrained target-profile composition on PC with explicit hardware adapters.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-004",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-070",
              "requirement": "One common MP-compatible implementation is the functional SSOT. CP implementations extend MP capabilities; do not keep duplicate competing versions of the same core behavior.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-070",
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
          "category": "PLATFORM",
          "logical_role": "TARGET_MP_CP",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-004",
      "A19-070"
    ],
    "review_status": "UNLOCKED"
  }
}
