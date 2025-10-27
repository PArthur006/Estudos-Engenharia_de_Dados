-- SELECT: Consulta e retorna dados de uma ou mais tabelas.
-- Selecionando todas as colunas de todos os clientes.
SELECT * FROM Clientes;

-- Selecionando colunas específicas com um filtro (WHERE).
SELECT Nome, Email FROM Clientes WHERE DataCadastro > '2023-01-31';

-- JOIN: Combina registros de duas ou mais tabelas com base em uma coluna relacionada.
-- Juntando Clientes e Pedidos para ver quem fez qual pedido.
SELECT
    C.Nome,
    P.PedidoID,
    P.DataPedido,
    P.ValorTotal
FROM Clientes AS C
JOIN Pedidos AS P ON C.ClienteID = P.ClienteID;

-- GROUP BY e Funções de Agregação: Agrupa linhas que têm os mesmos valores em colunas
-- e aplica uma função (COUNT, SUM, AVG, etc.) a cada grupo.
-- Contando quantos pedidos cada cliente fez.
SELECT
    C.Nome,
    COUNT(P.PedidoID) AS NumeroDePedidos
FROM Clientes AS C
LEFT JOIN Pedidos AS P ON C.ClienteID = P.ClienteID
GROUP BY C.Nome
ORDER BY NumeroDePedidos DESC;

-- Calculando o valor total gasto por cada cliente.
SELECT
    C.Nome,
    SUM(P.ValorTotal) AS TotalGasto
FROM Clientes AS C
JOIN Pedidos AS P ON C.ClienteID = P.ClienteID
GROUP BY C.Nome;

-- SUBQUERY (Subconsulta): Uma consulta aninhada dentro de outra.
-- Encontrando clientes que fizeram pedidos com valor acima da média.
SELECT Nome
FROM Clientes
WHERE ClienteID IN (
    SELECT ClienteID
    FROM Pedidos
    WHERE ValorTotal > (SELECT AVG(ValorTotal) FROM Pedidos)
);

-- VIEW: Cria uma tabela virtual baseada no resultado de uma consulta SELECT.
-- Simplifica consultas complexas e reutilizáveis.
CREATE VIEW V_DetalhesPedidos AS
SELECT
    C.Nome AS NomeCliente,
    C.Email,
    P.PedidoID,
    P.DataPedido,
    P.ValorTotal
FROM Clientes AS C
JOIN Pedidos AS P ON C.ClienteID = P.ClienteID;

-- Agora, podemos consultar a VIEW como se fosse uma tabela normal.
SELECT * FROM V_DetalhesPedidos WHERE ValorTotal > 100;
