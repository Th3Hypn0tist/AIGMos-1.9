{
  "id": "#CTRCT:AIGMOS19:BUILD:BUILD_TARGET_PROVISIONING",
  "name": "BUILD / BUILD TARGET PROVISIONING",
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
              "id": "A19-041",
              "requirement": "Build the C6-target source composition first; run that composition on PC; configure the TARGET instance through temporary Expose; write target config.json and FILE-backed TER definitions; optionally strip Expose and validate; deploy to C6.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-041",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-042",
              "requirement": "The C6-target source composition must be runnable on a PC with explicit host shims for hardware-bound modules. This does not mean running a C6 MicroPython firmware binary under CPython.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-042",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-043",
              "requirement": "Stripping Expose removes transport code and exclusive dependencies, not merely config.enabled. Rerun closure/command-reference checks after stripping; preserve target behavior unrelated to interfaces.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-043",
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
          "category": "BUILD",
          "logical_role": "BUILD_TARGET_PROVISIONING",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-041",
      "A19-042",
      "A19-043"
    ],
    "review_status": "UNLOCKED"
  }
}
