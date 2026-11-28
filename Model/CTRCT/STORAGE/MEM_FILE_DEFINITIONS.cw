{
  "id": "#CTRCT:AIGMOS19:STORAGE:MEM_FILE_DEFINITIONS",
  "name": "STORAGE / MEM FILE DEFINITIONS",
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
              "id": "A19-055",
              "requirement": "MEM is volatile and the default runtime working store. FILE persistence is EXPLICIT (save/reload/boot restoration), not an implicit mirror of each MEM mutation.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-055",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-056",
              "requirement": "Triggers, Events and Runners are stored as distinct FILE JSON documents (e.g. triggers.json, events.json, runners.json). One JSON document per component, plain JSON without mandatory version wrapper; each component validates its own content.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-056",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-057",
              "requirement": "Save JSON atomically (temporary write, validate, replace); preserve prior file on failed save; retained MEM changes are not rolled back. Missing definition file is normal/empty; invalid existing JSON during boot fails closed.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-057",
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
          "category": "STORAGE",
          "logical_role": "MEM_FILE_DEFINITIONS",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-055",
      "A19-056",
      "A19-057"
    ],
    "review_status": "UNLOCKED"
  }
}
