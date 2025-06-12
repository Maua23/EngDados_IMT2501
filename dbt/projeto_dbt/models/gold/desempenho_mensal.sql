SELECT
    DATE_TRUNC('month', ultima_compra) AS mes,
    COUNT(*) AS total_pedidos,
    SUM(total_pago) AS valor_total,
    AVG(ticket_medio) AS ticket_medio
FROM {{ ref('clientes_analitico') }}
GROUP BY DATE_TRUNC('month', ultima_compra)
ORDER BY mes