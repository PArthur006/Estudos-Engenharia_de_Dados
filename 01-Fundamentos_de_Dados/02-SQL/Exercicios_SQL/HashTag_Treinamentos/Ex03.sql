-- a) Faça um filtro na tabela de produtos e retorne apenas os produtos com custo maior ou igual a 200.
SELECT * FROM produtos
WHERE Custo_Unit >= 200
ORDER BY Custo_Unit;

-- b) Faça um filtro na tabela de produtos e retorne apenas os produtos da marca "DELL"
SELECT * FROM produtos
WHERE Marca_Produto = 'DELL';