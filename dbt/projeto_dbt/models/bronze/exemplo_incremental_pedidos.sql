{{ config(
    schema='staging',
    alias='exemplo_incremental_pedidos',
    materialized='incremental'
) }}

with max_data as (

    {% if is_incremental() %}
    select max(data_atualizacao) as ultima_data from {{ this }}
    {% else %}
    select null::timestamp as ultima_data
    {% endif %}

),

source as (
    select 
        id as id_pedido,
        user_id as id_cliente,
        order_date as data_pedido,
        status,
        order_date as data_atualizacao
    from {{ ref('raw_pedidos') }}
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