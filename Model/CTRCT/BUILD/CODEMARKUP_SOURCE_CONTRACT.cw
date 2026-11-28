{
  "id": "#CTRCT:AIGMOS19:BUILD:CODEMARKUP_SOURCE_CONTRACT",
  "name": "BUILD / CODEMARKUP SOURCE CONTRACT",
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
              "id": "CMI-001",
              "requirement": "Single Python # comment prefix for metadata and markup, never a special ## prefix.",
              "source_file": "developer/contracts/AIGMos_1.9_Build_CodeMarkup_Integration_v0.1.0.json",
              "source_record_ref": "CMI-001",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "CMI-002",
              "requirement": "First three metadata lines retain exact order: # deps, # libs, # target; optional # prune JSON string array follows.",
              "source_file": "developer/contracts/AIGMos_1.9_Build_CodeMarkup_Integration_v0.1.0.json",
              "source_record_ref": "CMI-002",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "CMI-003",
              "requirement": "The Git checkout is CPython-first. In a file supporting both targets, CP body is executable Python and MP body is commented source activated by MP build.",
              "source_file": "developer/contracts/AIGMos_1.9_Build_CodeMarkup_Integration_v0.1.0.json",
              "source_record_ref": "CMI-003",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "CMI-004",
              "requirement": "Use # target: BOTH for files with shared MP/CP implementations and # <AC.CP>/# </AC.CP> and # <AC.MP>/# </AC.MP> for platform variations. AC is an example feature ID.",
              "source_file": "developer/contracts/AIGMos_1.9_Build_CodeMarkup_Integration_v0.1.0.json",
              "source_record_ref": "CMI-004",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "CMI-005",
              "requirement": "A root feature entry in # prune such as AC controls its AC.CP and AC.MP code variants; the target suffix is a variant selector, not a separately chosen feature.",
              "source_file": "developer/contracts/AIGMos_1.9_Build_CodeMarkup_Integration_v0.1.0.json",
              "source_record_ref": "CMI-005",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "CMI-006",
              "requirement": "Build Tool physically removes excluded branches, optional hooks and exclusive dependencies; raw code is not rewritten by executing it.",
              "source_file": "developer/contracts/AIGMos_1.9_Build_CodeMarkup_Integration_v0.1.0.json",
              "source_record_ref": "CMI-006",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            },
            {
              "id": "CMI-007",
              "requirement": "CodeMarkup already belongs on the CW roadmap; AIGMos only sends its new real use-case requirements to CW. Do not modify CW specs in this repo/session.",
              "source_file": "developer/contracts/AIGMos_1.9_Build_CodeMarkup_Integration_v0.1.0.json",
              "source_record_ref": "CMI-007",
              "provenance_class": "registered_development_decision",
              "status": "unlocked"
            }
          ]
        },
        "properties": {}
      },
      "metadata": {
        "source_trace": "developer/contracts/AIGMos_1.9_Build_CodeMarkup_Integration_v0.1.0.json",
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
          "logical_role": "CODEMARKUP_SOURCE_CONTRACT",
          "implementation_member_status": "unmapped_no_identity_invented"
        },
        "properties": {}
      }
    }
  ],
  "metadata": {
    "source_document": "developer/contracts/AIGMos_1.9_Build_CodeMarkup_Integration_v0.1.0.json",
    "source_requirement_ids": [
      "CMI-001",
      "CMI-002",
      "CMI-003",
      "CMI-004",
      "CMI-005",
      "CMI-006",
      "CMI-007"
    ],
    "review_status": "UNLOCKED"
  }
}
