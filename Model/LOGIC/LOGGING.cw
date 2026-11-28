{
  "id": "#LOGIC:AIGMOS19:LOGGING",
  "name": "Logging shared library",
  "entity_type_ref": "code",
  "status": "unlocked",
  "properties": [
    {
      "id": "DATA_CS_LOG_INPUT",
      "property_type_ref": "data",
      "ruleset_ref": "RULESET_DATA",
      "status": "unlocked",
      "value": {
        "data_type_ref": "a19:cs_log_input",
        "value": null,
        "properties": {
          "semantic_role": "Real CS invocation command/parameters, or available AC identity in selected ac mode"
        }
      },
      "metadata": {
        "authority": "confirmed_behavior"
      }
    },
    {
      "id": "DATA_LOG_BUFFER",
      "property_type_ref": "data",
      "ruleset_ref": "RULESET_DATA",
      "status": "unlocked",
      "value": {
        "data_type_ref": "a19:log_buffer",
        "value": null,
        "properties": {
          "semantic_role": "Buffer owned by Logging library; N>0 newest N, N=0 all"
        }
      },
      "metadata": {
        "authority": "confirmed_behavior"
      }
    },
    {
      "id": "DATA_LOG_MODE",
      "property_type_ref": "data",
      "ruleset_ref": "RULESET_DATA",
      "status": "unlocked",
      "value": {
        "data_type_ref": "a19:log_mode",
        "value": null,
        "properties": {
          "semantic_role": "off / cs / ac; mode off still traces failed CS"
        }
      },
      "metadata": {
        "authority": "confirmed_behavior"
      }
    },
    {
      "id": "FUNCTION_RECORD_CS",
      "property_type_ref": "function",
      "ruleset_ref": "RULESET_FUNCTION",
      "status": "unlocked",
      "value": {
        "function_type_ref": "a19:record_cs_invocation",
        "input_refs": [
          "DATA_CS_LOG_INPUT",
          "DATA_LOG_MODE"
        ],
        "output_refs": [
          "DATA_LOG_BUFFER"
        ],
        "properties": {
          "one_trace_per_failed_invocation": true,
          "mode_off_failed_cs_trace": true,
          "no_separate_audit": true,
          "parameter_redaction": "OPEN",
          "normalized_logic_body": "UNRESOLVED",
          "runtime_symbol": "UNRESOLVED"
        }
      },
      "metadata": {
        "authority": "semantics_confirmed_runtime_symbol_open"
      }
    }
  ],
  "required_links": []
}
