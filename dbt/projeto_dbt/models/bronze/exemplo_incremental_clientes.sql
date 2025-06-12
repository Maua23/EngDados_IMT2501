{{ config(
    schema='staging',
    alias='exemplo_incremental_clientes',
    materialized='incremental'
) }}

{% set existing_cols = adapter.get_columns_in_relation(this) %}
{% set has_col = existing_cols | map(attribute='name') | map('lower') | select('equalto', 'data_atualizacao') | list | length > 0 %}

with max_data as (
    {% if is_incremental() and has_col %}
        select max(data_atualizacao) as ultima_data from {{ this }}
    {% else %}
        select null::timestamp as ultima_data
    {% endif %}
),

source as (
    select 
        id AS id_cliente,
        concat(first_name, ' ', last_name) AS nome_completo,
        current_timestamp AS data_atualizacao
    from {{ ref('raw_clientes') }}
),

filtrado as (
    select * from source
    where (
        select ultima_data from max_data
    ) is null 
    or data_atualizacao > (
        select ultima_data from max_data
    )
)

select * from filtrado