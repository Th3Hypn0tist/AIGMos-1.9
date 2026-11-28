{
  "id": "#CTRCT:AIGMOS19:SECURITY:AC_CS_CHOKEPOINT",
  "name": "SECURITY / AC CS CHOKEPOINT",
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
              "id": "A19-012",
              "requirement": "CS may have an optional AccessCore authorization hook; no mandatory IAM/AccessCore dependency in Hardcore. Independent structural/module write restrictions remain mandatory.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-012",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-072",
              "requirement": "AccessCore is an OPTIONAL compile-time feature at the CS execution chokepoint. A NON-AC build contains no AC code or hook. An AC-enabled build includes AC code and hook but may boot with AC runtime disabled. Both use the SAME CS source-of-truth implementation.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-072",
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
          "logical_role": "AC_CS_CHOKEPOINT",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-012",
      "A19-072"
    ],
    "review_status": "UNLOCKED"
  }
}
