SELECT
    metodo_pagamento,
    COUNT(*) AS total_transacoes,
    SUM(valor_pagamento) AS valor_total
FROM {{ ref('exemplo_incremental_pagamentos') }}
GROUP BY metodo_pagamento