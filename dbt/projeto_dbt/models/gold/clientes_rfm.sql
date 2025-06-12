WITH base AS (
    SELECT
        id_cliente,
        ultima_compra,
        total_pedidos AS frequencia,
        total_pago AS monetario
    FROM {{ ref('clientes_analitico') }}
)

SELECT
    *,
    CURRENT_DATE - ultima_compra AS recencia
FROM base