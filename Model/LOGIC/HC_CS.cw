{
  "id": "#LOGIC:AIGMOS19:HC.CS",
  "name": "HC.CS execution and CSo projection",
  "entity_type_ref": "code",
  "status": "unlocked",
  "properties": [
    {
      "id": "DATA_CS_INPUT",
      "property_type_ref": "data",
      "ruleset_ref": "RULESET_DATA",
      "status": "unlocked",
      "value": {
        "data_type_ref": "a19:cs_input",
        "value": null,
        "properties": {
          "semantic_role": "Command input CSi"
        }
      },
      "metadata": {
        "authority": "confirmed_behavior"
      }
    },
    {
      "id": "DATA_EXECUTION_OUTCOME",
      "property_type_ref": "data",
      "ruleset_ref": "RULESET_DATA",
      "status": "unlocked",
      "value": {
        "data_type_ref": "a19:cs_internal_outcome",
        "value": null,
        "properties": {
          "semantic_role": "Internal status OK/ERROR, separate payload_present and payload"
        }
      },
      "metadata": {
        "authority": "confirmed_behavior"
      }
    },
    {
      "id": "DATA_CSO_OUTPUT",
      "property_type_ref": "data",
      "ruleset_ref": "RULESET_DATA",
      "status": "unlocked",
      "value": {
        "data_type_ref": "a19:cso_output",
        "value": null,
        "properties": {
          "semantic_role": "Public CSo: OK / original command feedback / unified ERROR"
        }
      },
      "metadata": {
        "authority": "confirmed_behavior"
      }
    },
    {
      "id": "DATA_CS_CONTEXT",
      "property_type_ref": "data",
      "ruleset_ref": "RULESET_DATA",
      "status": "unlocked",
      "value": {
        "data_type_ref": "a19:cs_invocation_context",
        "value": null,
        "properties": {
          "semantic_role": "Command and parameters plus available invocation/AC actor context"
        }
      },
      "metadata": {
        "authority": "confirmed_behavior"
      }
    },
    {
      "id": "FUNCTION_EXECUTE_CS",
      "property_type_ref": "function",
      "ruleset_ref": "RULESET_FUNCTION",
      "status": "unlocked",
      "value": {
        "function_type_ref": "a19:execute_cs",
        "input_refs": [
          "DATA_CS_INPUT",
          "DATA_CS_CONTEXT"
        ],
        "output_refs": [
          "DATA_EXECUTION_OUTCOME"
        ],
        "properties": {
          "status_values": [
            "OK",
            "ERROR"
          ],
          "ERROR_means": "hard_fail",
          "success_payload_not_status": true,
          "normalized_logic_body": "UNRESOLVED",
          "runtime_symbol": "UNRESOLVED"
        }
      },
      "metadata": {
        "authority": "semantics_confirmed_runtime_symbol_open"
      }
    },
    {
      "id": "FUNCTION_PROJECT_CSO",
      "property_type_ref": "function",
      "ruleset_ref": "RULESET_FUNCTION",
      "status": "unlocked",
      "value": {
        "function_type_ref": "a19:project_cso",
        "input_refs": [
          "DATA_EXECUTION_OUTCOME"
        ],
        "output_refs": [
          "DATA_CSO_OUTPUT"
        ],
        "properties": {
          "status_discriminator": "internal",
          "unwrapped_success": true,
          "raw_string_ERROR_is_valid_success_data": true,
          "external_transport_status": "OPEN",
          "normalized_logic_body": "UNRESOLVED",
          "runtime_symbol": "UNRESOLVED"
        }
      },
      "metadata": {
        "authority": "functional_role_derived_not_exact_API"
      }
    },
    {
      "id": "LINK_CS_USES_ERROR",
      "property_type_ref": "link",
      "ruleset_ref": "RULESET_LINK_DEPENDENCY",
      "status": "unlocked",
      "value": {
        "link_type_ref": "dependency",
        "parent_ref": "#LOGIC:AIGMOS19:ERROR",
        "child_ref": "#LOGIC:AIGMOS19:HC.CS",
        "properties": {}
      },
      "metadata": {
        "authority": "confirmed_dependency"
      }
    }
  ],
  "required_links": []
}
