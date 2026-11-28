{
  "id": "#CTRCT:AIGMOS19:MODULES:MODULE_PRIMITIVES",
  "name": "MODULES / MODULE PRIMITIVES",
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
              "id": "A19-022",
              "requirement": "The five AIGMos 1.9 functional module primitives are command, input, output, adapter and panel. This is a versioned 1.9 adaptation of relevant 2.0 module contracts.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-022",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-023",
              "requirement": "View is declarative composition of Panels, not a sixth primitive. Panel replaces the former small UI View primitive; legacy .tmpl is conceptually a View composition.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-023",
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
          "category": "MODULES",
          "logical_role": "MODULE_PRIMITIVES",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-022",
      "A19-023"
    ],
    "review_status": "UNLOCKED"
  }
}
