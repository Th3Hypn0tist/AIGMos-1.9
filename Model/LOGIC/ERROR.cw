{
  "id": "#LOGIC:AIGMOS19:ERROR",
  "name": "Error shared System Lib",
  "entity_type_ref": "code",
  "status": "unlocked",
  "properties": [
    {
      "id": "DATA_FAILURE_INPUT",
      "property_type_ref": "data",
      "ruleset_ref": "RULESET_DATA",
      "status": "unlocked",
      "value": {
        "data_type_ref": "a19:error_input",
        "value": null,
        "properties": {
          "semantic_role": "Real source failure, with context if available"
        }
      },
      "metadata": {
        "authority": "confirmed_behavior"
      }
    },
    {
      "id": "DATA_ERROR_RECORD",
      "property_type_ref": "data",
      "ruleset_ref": "RULESET_DATA",
      "status": "unlocked",
      "value": {
        "data_type_ref": "a19:error_record",
        "value": null,
        "properties": {
          "semantic_role": "Shared Error record; exact field schema open"
        }
      },
      "metadata": {
        "authority": "confirmed_behavior"
      }
    },
    {
      "id": "DATA_ERROR_BUFFER",
      "property_type_ref": "data",
      "ruleset_ref": "RULESET_DATA",
      "status": "unlocked",
      "value": {
        "data_type_ref": "a19:error_buffer",
        "value": null,
        "properties": {
          "semantic_role": "Buffer owned by Error System Lib; N>0 newest N, N=0 all"
        }
      },
      "metadata": {
        "authority": "confirmed_behavior"
      }
    },
    {
      "id": "DATA_HARD_FAIL_POLICY",
      "property_type_ref": "data",
      "ruleset_ref": "RULESET_DATA",
      "status": "unlocked",
      "value": {
        "data_type_ref": "a19:hard_fail_policy",
        "value": null,
        "properties": {
          "semantic_role": "ERROR denotes hard fail of current execution, never warning/recoverable"
        }
      },
      "metadata": {
        "authority": "confirmed_behavior"
      }
    },
    {
      "id": "FUNCTION_REPORT_ERROR",
      "property_type_ref": "function",
      "ruleset_ref": "RULESET_FUNCTION",
      "status": "unlocked",
      "value": {
        "function_type_ref": "a19:report_unified_error",
        "input_refs": [
          "DATA_FAILURE_INPUT",
          "DATA_HARD_FAIL_POLICY"
        ],
        "output_refs": [
          "DATA_ERROR_RECORD",
          "DATA_ERROR_BUFFER"
        ],
        "properties": {
          "failure_disposition": "HARD_FAIL",
          "no_cs_import": true,
          "no_ac_import": true,
          "boot_safe": true,
          "record_once": true,
          "normalized_logic_body": "UNRESOLVED",
          "runtime_symbol": "UNRESOLVED"
        }
      },
      "metadata": {
        "authority": "semantics_confirmed_runtime_symbol_open"
      }
    },
    {
      "id": "LINK_ERROR_TRACE_SINK",
      "property_type_ref": "link",
      "ruleset_ref": "RULESET_LINK",
      "status": "unlocked",
      "value": {
        "link_type_ref": "failed_cs_trace_sink",
        "parent_ref": "#LOGIC:AIGMOS19:LOGGING",
        "child_ref": "#LOGIC:AIGMOS19:ERROR",
        "properties": {}
      },
      "metadata": {
        "authority": "confirmed_semantic_flow_NOT_source_dependency"
      }
    }
  ],
  "required_links": []
}
