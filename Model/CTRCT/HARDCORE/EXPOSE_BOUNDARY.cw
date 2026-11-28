{
  "id": "#CTRCT:AIGMOS19:HARDCORE:EXPOSE_BOUNDARY",
  "name": "HARDCORE / EXPOSE BOUNDARY",
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
              "id": "A19-013",
              "requirement": "EXPOSE owns interface bindings. Serial, Telnet, HTTP/REST and OSC are optional transports/implementations selected by build and configuration; no mandatory external listener stack in Hardcore.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-013",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-014",
              "requirement": "OSC input/output belongs under EXPOSE, configured in config.json.expose; it is not a top-level mandatory osc setting. OSC is an Expose interface even for incoming OSC.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-014",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-015",
              "requirement": "After PC-based configuration it must be possible to remove EXPOSE transports and all dependencies exclusive to them; a valid deployed target may run with no externally exposed interfaces.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-015",
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
          "category": "HARDCORE",
          "logical_role": "EXPOSE_BOUNDARY",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-013",
      "A19-014",
      "A19-015"
    ],
    "review_status": "UNLOCKED"
  }
}
