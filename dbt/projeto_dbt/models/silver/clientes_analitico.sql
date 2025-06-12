WITH pedidos_clientes AS (
    SELECT
        c.id_cliente,
        MIN(p.data_pedido) AS primeira_compra,
        MAX(p.data_pedido) AS ultima_compra,
        COUNT(DISTINCT p.id_pedido) AS total_pedidos,
        COUNT(DISTINCT p.data_pedido) - 1 AS intervalo_compras,
        SUM(pg.valor_pagamento) AS total_pago,
        AVG(pg.valor_pagamento) AS ticket_medio,
        COUNT(*) FILTER (WHERE pg.metodo_pagamento IS NOT NULL) AS total_pagamentos,
        MODE() WITHIN GROUP (ORDER BY pg.metodo_pagamento) AS forma_pagamento_preferida
    FROM {{ ref('clientes') }} c
    LEFT JOIN {{ ref('pedidos') }} p
        ON c.id_cliente = p.id_cliente
    LEFT JOIN {{ ref('exemplo_incremental_pagamentos') }} pg
        ON p.id_pedido = pg.id_pedido
    GROUP BY c.id_cliente
)

SELECT * FROM pedidos_clientes