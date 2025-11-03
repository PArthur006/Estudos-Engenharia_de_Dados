-- a) Faça um agrupamento para descobrir o total de clientes por Sexo.
SELECT Sexo, COUNT(Sexo) FROM clientes
GROUP BY Sexo;
-- b) Faça um agrupamento para descobrir quantos produtos existem por categoria.
SELECT `ID_Categoria`, COUNT(`ID_Categoria`) FROM produtos
GROUP BY `ID_Categoria`;
-- c) Faça um agrupamento para descobrir a soma total de receita por Loja.
SELECT `ID_Loja`, SUM(`Receita_Venda`) AS 'Soma Total' FROM pedidos
GROUP BY `ID_Loja`
ORDER BY `ID_Loja`;