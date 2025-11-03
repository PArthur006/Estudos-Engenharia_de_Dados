-- a) Descubra o total de custo da tabela de pedidos.
SELECT SUM(Custo_Venda) AS "Custo Total" FROM pedidos;
-- b) Descubra a quantidade total de lojas.
SELECT COUNT(Loja) FROM lojas;
-- c) Descubra o custo médio dos produtos (de acordo com a tabela de produtos).
SELECT AVG(Custo_Unit) AS "Custo Médio dos Produtos" FROM produtos;
-- d) Descubra a quantidade mínima e máxima de funcionários das lojas (faça isso em um único SELECT).
SELECT MIN(`Num_Funcionarios`) AS "Qtd. Mínima de Funcionários", MAX(`Num_Funcionarios`) AS "Qtd. Máxima de Funcionários" FROM lojas;