{% macro test_run_results() %}
  {{ return(adapter.dispatch('test_run_results')()) }}
{% endmacro %}


{% macro default__test_run_results() %}

    SELECT
        id, 
        result_item->>'status' AS status,
        timing_item->>'name' AS timing_name,
        timing_item->>'started_at' AS timing_started_at,
        timing_item->>'completed_at' AS timing_completed_at,
        result_item->>'message' AS message,
        (result_item->>'failures')::int AS failures,
        result_item->>'thread_id' AS thread_id,
        result_item->>'unique_id' AS unique_id,
        round(cast(result_item->>'execution_time' as numeric), 3) AS execution_time,
        result_item->>'adapter_response' AS adapter_response
    FROM run_results,
        jsonb_array_elements(results) AS result_item,
        jsonb_array_elements(result_item->'timing') AS timing_item
    WHERE timing_item->>'name' = 'execute'
    AND args__rpc_method = 'test'
    
{% endmacro %}


{# postgres should use default #}
{% macro postgres__test_run_results() %}

    {{ return(default__test_run_results()) }}

{% endmacro %}



{% macro snowflake__test_run_results() %}

    SELECT
        rr.id,
        result_item.value:status AS status,
        timing_item.value:name::STRING AS timing_name,
        timing_item.value:started_at::STRING AS timing_started_at,
        timing_item.value:completed_at::STRING AS timing_completed_at,
        result_item.value:message AS message,
        result_item.value:failures::INTEGER AS failures,
        result_item.value:thread_id AS thread_id,
        result_item.value:unique_id AS unique_id,
        result_item.value:execution_time::FLOAT AS execution_time,
        result_item.value:adapter_response AS adapter_response
    FROM run_results as rr,
        LATERAL FLATTEN(input => parse_json(rr.results)) as result_item,
        LATERAL FLATTEN(input => result_item.value, path => 'timing') as timing_item
    WHERE timing_item.value:name::STRING = 'execute'
    AND args__rpc_method = 'test'

{% endmacro %}