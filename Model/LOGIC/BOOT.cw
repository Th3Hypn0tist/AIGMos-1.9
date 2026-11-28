{
  "id": "#LOGIC:AIGMOS19:BOOT",
  "name": "BOOT bootstrap and Error reporting",
  "entity_type_ref": "code",
  "status": "unlocked",
  "properties": [
    {
      "id": "DATA_BOOT_STATUS",
      "property_type_ref": "data",
      "ruleset_ref": "RULESET_DATA",
      "status": "unlocked",
      "value": {
        "data_type_ref": "a19:boot_status",
        "value": null,
        "properties": {
          "semantic_role": "Boot initialization result, fatal when canonical ERROR"
        }
      },
      "metadata": {
        "authority": "confirmed_behavior"
      }
    },
    {
      "id": "FUNCTION_BOOT_FAILURE_REPORT",
      "property_type_ref": "function",
      "ruleset_ref": "RULESET_FUNCTION",
      "status": "unlocked",
      "value": {
        "function_type_ref": "a19:report_boot_failure",
        "input_refs": [],
        "output_refs": [
          "DATA_BOOT_STATUS"
        ],
        "properties": {
          "must_work_before_CS": true,
          "uses_shared_ERROR": true,
          "error_aborts_BOOT": true,
          "bootstrap_storage": "OPEN",
          "normalized_logic_body": "UNRESOLVED",
          "runtime_symbol": "UNRESOLVED"
        }
      },
      "metadata": {
        "authority": "functional_role_derived_not_exact_API"
      }
    },
    {
      "id": "LINK_BOOT_USES_ERROR",
      "property_type_ref": "link",
      "ruleset_ref": "RULESET_LINK_DEPENDENCY",
      "status": "unlocked",
      "value": {
        "link_type_ref": "dependency",
        "parent_ref": "#LOGIC:AIGMOS19:ERROR",
        "child_ref": "#LOGIC:AIGMOS19:BOOT",
        "properties": {}
      },
      "metadata": {
        "authority": "confirmed_dependency"
      }
    }
  ],
  "required_links": []
}
