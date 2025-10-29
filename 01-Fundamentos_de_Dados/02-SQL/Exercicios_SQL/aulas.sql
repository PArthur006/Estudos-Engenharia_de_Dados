USE DB_MiniCurso_HashTag;

-- Exemplo 1: SELECT *

SELECT * FROM clientes;

SELECT * FROM pedidos;

-- Exemplo 2: SELECT FROM

SELECT Nome, Sobrenome, Email FROM clientes;

-- Exemplo 3: SELECT AS

SELECT Data_Venda AS "Data da Venda", Id_Produto AS "ID do Produto", Qtd_Vendida AS "Quantidade Vendida" FROM pedidos;

-- Exemplo 4: SELECT LIMIT

SELECT * FROM pedidos LIMIT 5;

-- -------------------------------------------

-- ORDER BY

-- Exemplo 1: Faça uma consulta na tabela de clientes e faã uma ordenação de acordo com o nome do cliente, em ordem alfabética.

SELECT *
FROM clientes
ORDER BY Nome, Sobrenome;

-- Exemplo 2: Faça uma consulta na tabela de clientes e faça uma ordenação de acordo com a renda anual, da maior para a menor.

SELECT Renda_Anual, Nome, Sobrenome
FROM clientes
ORDER BY Renda_Anual DESC;

-- Exemplo 3: Faça uma consulta na tabela de clientes e faça uma ordenação de acordo com a data de nascimento, em ordem do mais novo para o mais velho.

SELECT Nome, Sobrenome, Data_Nascimento
FROM clientes
ORDER BY Data_Nascimento DESC;

-- -------------------------------------------

-- WHERE

-- Exemplo 1: Selecione na tabela de clientes apenas os clientes do sexo feminino.

SELECT * FROM clientes
WHERE Sexo = 'F'
ORDER BY Nome, Sobrenome;

-- Exemplo 2: Selecione na tabela de produtos apenas os produtos com preço acima de R$2.000

SELECT Preco_Unit, Nome_Produto FROM produtos
WHERE Preco_Unit > 2000
ORDER BY Preco_Unit;

-- Exemplo 3: Selecione os pedidos realizados no dia 10/03/2019.

SELECT * FROM pedidos
WHERE Data_Venda = '2019-03-10'
ORDER BY Data_Venda;

-- -------------------------------------------

-- SUM, COUNT, AVG, MIN E MAX.

-- SUM

SELECT * FROM pedidos;

SELECT SUM(Receita_Venda) AS "Receita Total" FROM pedidos;

-- COUNT 

SELECT COUNT(Sexo='M') as 'Clientes do Sexo Masculino' FROM clientes;
-- OU
SELECT COUNT(Nome) FROM clientes
WHERE Sexo = 'M';

-- AVG

SELECT AVG (Renda_Anual) AS 'Média Salarial' FROM clientes;

-- MIN

SELECT MIN (Preco_Unit) AS 'Preço Unitário Mínimo'
FROM produtos;

-- MAX

SELECT MAX (Preco_Unit) AS 'Preço Unitário Máximo'
FROM produtos;

-- -------------------------------------------

-- GROUP BY

-- Exemplo 1: Crie um agrupamento que mostre a quantidade de produtos por marcas.

SELECT * FROM produtos;

SELECT Marca_Produto, COUNT(Marca_Produto) AS 'Qtd. Produtos'
FROM produtos
GROUP BY Marca_Produto
ORDER BY COUNT(Marca_Produto) DESC;

-- Exemplo 2: Crie um agrupamento que mostre a quantidade de clientes por escolaridade.

SELECT * from clientes;

SELECT Escolaridade, COUNT (Escolaridade) AS 'Qtd. Escolaridade'
FROM clientes
GROUP BY Escolaridade
ORDER BY COUNT (Escolaridade) DESC;

-- Exemplo 3: Crie um agrupamento que mostre o total de receita (tabela pedidos) por id da loja.

SELECT * FROM pedidos;
SELECT * from lojas;

SELECT ID_Loja, SUM (Receita_Venda) AS 'Receita Total'
FROM pedidos
GROUP BY ID_Loja
ORDER BY SUM (Receita_Venda) DESC;

-- -------------------------------------------

-- JOIN

-- Exemplo 1: Faça uma consulta à tabela de pedidos que retorne as colunas de Loja, Data_Venda e Receita_Venda.

SELECT Loja, Data_Venda, Receita_Venda
FROM pedidos
INNER JOIN lojas ON pedidos.ID_Loja = lojas.ID_Loja;

-- Exemplo 2: Crie um agrupamento que mostre o total de receita (tabela pedidos) por lojas.

SELECT Loja, SUM (Receita_Venda) AS 'Receita Total'
FROM pedidos
INNER JOIN lojas ON pedidos.ID_Loja = lojas.ID_Loja
GROUP BY Loja;