{
  "id": "#CTRCT:AIGMOS19:SECURITY:AC_ACTIVATION_BOUNDARY",
  "name": "SECURITY / AC ACTIVATION BOUNDARY",
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
              "id": "A19-073",
              "requirement": "In an AC-capable build AC may be enabled directly in config.json before boot, OR activated while running through a CS command. CS activation persists enabled=true to config.json and activates runtime enforcement. Activated state survives reboot.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-073",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-074",
              "requirement": "AC cannot be deactivated via CS (nor through generic CS file/state operations). Disable requires direct file-level edit of config.json outside CS, effective after restart. An AC authorization error must not silently disable the AC gate.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-074",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-075",
              "requirement": "CS-triggered AC activation is the ONE exception allowing AIGMos runtime to change config.json, and it may change ONLY ac.enabled from false to true through a narrowly scoped internal operation. No general config file write permission is conferred.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-075",
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
          "category": "SECURITY",
          "logical_role": "AC_ACTIVATION_BOUNDARY",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-073",
      "A19-074",
      "A19-075"
    ],
    "review_status": "UNLOCKED"
  }
}
