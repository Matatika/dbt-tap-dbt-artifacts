{{ config(materialized='table') }}

with run_results as (
    select * from {{ source ('dbt_artifacts_source', 'run_results') }}
),
test_run_results as (
    {{ test_run_results() }}
)
select * from test_run_results