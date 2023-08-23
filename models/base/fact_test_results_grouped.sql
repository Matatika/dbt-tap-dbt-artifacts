{{ config(materialized='table') }}

with test_run_results as (
    select * from {{ ref('fact_test_results') }}
),
test_results_grouped as (
    select 
        unique_id 
        , count(*) "total_runs"
        , sum(case when status = 'pass' then 1 else 0 end) "total_passes"
        , sum(case when status = 'fail' then 1 else 0 end)  "total_failures"
        , avg(execution_time) "avg execution time"
        , min(cast(timing_started_at as timestamp)) "last run time"
    from test_run_results
    group by unique_id
)
select * from test_results_grouped