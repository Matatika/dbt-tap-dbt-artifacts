{{ config(materialized='table') }}

with run_results as (
    select * from {{ source ('dbt_artifacts_source', 'run_results') }}
),
test_run_results as (
    select
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
    and result_item->>'status' != 'success'
)
select * from test_run_results