{
  "id": "#CTRCT:AIGMOS19:BUILD:SOURCE_DEPENDENCY_AUTHORITY",
  "name": "BUILD / SOURCE DEPENDENCY AUTHORITY",
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
              "id": "A19-020",
              "requirement": "Zero hidden dependencies. Every code file INCLUDING Hardcore declares direct deps/libs and target MP/CP. Validate actual imports, direct/derived dependency closure, code/CS references, target compatibility and permissions independently.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-020",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-049",
              "requirement": "'deps' declares only directly used modules and Hardcore interfaces; 'libs' declares only directly used libraries (including System Lib). Do not conflate the two categories.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-049",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-050",
              "requirement": "Declare only immediate dependencies; REST declaring EXP in libs does not declare EXP's HC.CS dependency unless REST directly uses CS itself.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-050",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-051",
              "requirement": "Source headers are the source of truth for code dependency declarations. Module manifests may contain generated/validated projections but not a competing manually-maintained requires list.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-051",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "A19-052",
              "requirement": "A scanner can extract every source header in one pass, then compute and validate dependency closure in memory for Build Tool and later CW code import, preserving declared edge provenance versus derived edges.",
              "source_file": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
              "source_record_ref": "A19-052",
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
          "logical_role": "SOURCE_DEPENDENCY_AUTHORITY",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Decision_Baseline_v0.3.0.json",
    "source_requirement_ids": [
      "A19-020",
      "A19-049",
      "A19-050",
      "A19-051",
      "A19-052"
    ],
    "review_status": "UNLOCKED"
  }
}
