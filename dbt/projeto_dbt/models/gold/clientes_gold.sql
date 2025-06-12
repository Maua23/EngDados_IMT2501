WITH base AS (
    SELECT *
    FROM {{ ref('clientes_analitico') }}
)

SELECT
    *,
    CASE
        WHEN total_pago < 500 THEN 'baixo'
        WHEN total_pago BETWEEN 500 AND 10000 THEN 'médio'
        ELSE 'alto'
    END AS categoria_cliente
FROM base