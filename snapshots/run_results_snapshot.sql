{% snapshot run_results_snapshot %}

{{
    config(
      target_schema=var('schema'),
      unique_key='id',
      strategy='timestamp',
      updated_at='updated_at',
    )
}}

with run_results as (
    select * from {{ source ('dbt_artifacts_source', 'run_results') }}
),

run_results_snapshot as (
    select
        *
    from run_results
)

select * from run_results_snapshot
{% endsnapshot %}