{
  "id": "#CTRCT:AIGMOS19:REST:REST_MODES",
  "name": "REST / REST MODES",
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
              "id": "A19-034",
              "requirement": "REST has a $ mode: GET-only; POST is not offered. This mode must be buildable without the optional # structured facility.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-034",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-035",
              "requirement": "REST has a # mode: GET plus POST. POST writes validated JSON request data to the route-derived #REST:<path> state, then may evaluate/return ?REST:<path> if a response is configured.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-035",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-036",
              "requirement": "For AIGMos 1.9 the response after # mode POST is optional. This intentionally differs from the original 2.0 WEB_REST missing-response rule, which specifies REST_RESPONSE_NOT_FOUND or configurable rejection; document as a 1.9 versioned contract divergence.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-036",
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
          "category": "REST",
          "logical_role": "REST_MODES",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-034",
      "A19-035",
      "A19-036"
    ],
    "review_status": "UNLOCKED"
  }
}
