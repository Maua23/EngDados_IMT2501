{{ config(
    schema='staging',
    alias='exemplo_incremental_pagamentos',
    materialized='incremental'
) }}

with source as (
    select 
        id AS id_pagamento,
        order_id AS id_pedido,
        payment_method AS metodo_pagamento,
        amount / 100 AS valor_pagamento,
        current_timestamp AS data_atualizacao
    from {{ ref('raw_pagamentos') }}
),

renamed as (
    select 
        id_pagamento,
        id_pedido,
        metodo_pagamento,
        valor_pagamento,
        data_atualizacao
    from source
)

select * from renamed

{% if is_incremental() %}
where data_atualizacao > (select max(data_atualizacao) from {{ this }})
{% endif %}


-- Este modelo é responsável por criar uma fonte incremental de dados para pagamentos.
-- Ele renomeia as colunas da tabela de pagamentos e adiciona uma coluna de data de atualização.
-- A lógica de incremento garante que apenas os novos registros sejam adicionados à tabela de destino.
-- A coluna `valor_pagamento` é convertida de centavos para reais.