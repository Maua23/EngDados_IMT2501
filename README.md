O dbt utiliza os mesmos dados já carregados no projeto base como camada Bronze.

Para a camada Silver, há o agrupamento dos dados de cliente e pedidos feitos para análise do usuário, calculando dados como data da primeira e última compra, total de pedidos, valor total gasto e ticket médio, além da forma preferida de pagamento.

Na camada Gold é analisado o perfil do usuário na plataforma por classificação dos clientes através do gasto total (alto, médio e baixo) e análise RFM (recência, frequência e valor monetário) para identificar clientes VIPs, clientes em risco e possível análise de churn. É disponibilizado também o faturamento mensal.
