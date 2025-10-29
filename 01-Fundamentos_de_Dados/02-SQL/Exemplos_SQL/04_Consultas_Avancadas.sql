-- ******************************************************
-- Exemplo de SQL Avançado 
-- Tópicos: Subconsultas (Subqueries) e CTEs (Common Table Expressions)
-- ******************************************************

-- 1. Criação do Ambiente de Teste
CREATE DATABASE IF NOT EXISTS DB_SprintAvaliacao;
USE DB_SprintAvaliacao;

-- Limpar tabelas na ordem correta (filhas primeiro)
DROP TABLE IF EXISTS ItensVenda;
DROP TABLE IF EXISTS Vendas;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Produtos;

-- Criar Tabelas
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    NomeCliente VARCHAR(100)
);

CREATE TABLE Produtos (
    ProdutoID INT PRIMARY KEY,
    NomeProduto VARCHAR(100),
    Preco DECIMAL(10, 2) 
);

CREATE TABLE Vendas (
    VendaID INT PRIMARY KEY,
    ClienteID INT,
    DataVenda DATE,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

CREATE TABLE ItensVenda (
    VendaID INT,
    ProdutoID INT,
    Quantidade INT,
    PRIMARY KEY (VendaID, ProdutoID), -- Chave composta
    FOREIGN KEY (VendaID) REFERENCES Vendas(VendaID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

-- Inserir Dados
INSERT INTO Clientes (ClienteID, NomeCliente) VALUES
(1, 'Arthur'), (2, 'Beatriz'), (3, 'Carla'), (4, 'Daniel (sem vendas)');

INSERT INTO Produtos (ProdutoID, NomeProduto, Preco) VALUES
(101, 'Notebook', 4500.00),
(102, 'Mouse', 150.00),
(103, 'Teclado', 300.00),
(104, 'Monitor', 1200.00),
(105, 'Cadeira (sem vendas)', 900.00);

INSERT INTO Vendas (VendaID, ClienteID, DataVenda) VALUES
(1, 1, '2025-10-01'),
(2, 2, '2025-10-02'),
(3, 1, '2025-10-03');

INSERT INTO ItensVenda (VendaID, ProdutoID, Quantidade) VALUES
(1, 101, 1), -- Arthur comprou Notebook
(1, 102, 1), -- Arthur comprou Mouse
(2, 104, 2), -- Beatriz comprou 2 Monitores
(3, 102, 1); -- Arthur comprou outro Mouse

-- ******************************************************
-- 2. EXEMPLOS DE SUBCONSULTAS
-- ******************************************************

-- Exemplo 1: Subconsulta Escalar (no WHERE)
-- (Produtos com preço acima da média)
SELECT '--- 1. Produtos com preço acima da média (Subq Escalar) ---' AS ' ';
SELECT *
FROM Produtos
WHERE Preco > (SELECT AVG(Preco) FROM Produtos);

-- Exemplo 2: Subconsulta Multi-Valor (no WHERE com IN)
-- (Clientes que já fizeram compras)
SELECT '--- 2. Clientes que fizeram compras (Subq Multi-Valor IN) ---' AS ' ';
SELECT *
FROM Clientes
WHERE ClienteID IN (SELECT DISTINCT ClienteID FROM Vendas);

-- Exemplo 3: Subconsulta Multi-Valor (no WHERE com NOT IN)
-- (Produtos que nunca foram vendidos)
SELECT '--- 3. Produtos que nunca foram vendidos (Subq Multi-Valor NOT IN) ---' AS ' ';
SELECT *
FROM Produtos
WHERE ProdutoID NOT IN (SELECT DISTINCT ProdutoID FROM ItensVenda);

-- Exemplo 4: Subconsulta Correlacionada (no SELECT)
-- (Contar quantas vendas cada cliente fez)
SELECT '--- 4. Contagem de vendas por cliente (Subq Correlacionada) ---' AS ' ';
SELECT
    C.NomeCliente,
    (SELECT COUNT(V.VendaID)
     FROM Vendas V
     WHERE V.ClienteID = C.ClienteID) AS TotalVendas
FROM Clientes C;
-- Nota: O exemplo acima (Correlacionada) é melhor resolvido com um JOIN:
/*
SELECT
    C.NomeCliente,
    COUNT(V.VendaID) AS TotalVendas
FROM Clientes C
LEFT JOIN Vendas V ON C.ClienteID = V.ClienteID
GROUP BY C.NomeCliente;
*/

-- Exemplo 5: Subconsulta de Tabela (no FROM)
-- (Calcular o valor total de cada venda)
SELECT '--- 5. Valor total por venda (Subq no FROM) ---' AS ' ';
SELECT
    V.VendaID,
    Totais.ValorTotalDaVenda
FROM Vendas V
JOIN (
    -- Esta é a Subconsulta no FROM (precisa do Alias "Totais")
    SELECT
        IV.VendaID,
        SUM(P.Preco * IV.Quantidade) AS ValorTotalDaVenda
    FROM ItensVenda IV
    JOIN Produtos P ON IV.ProdutoID = P.ProdutoID
    GROUP BY IV.VendaID
) AS Totais ON V.VendaID = Totais.VendaID;


-- ******************************************************
-- 3. EXEMPLOS DE CTE (Common Table Expressions)
-- ******************************************************
-- (CTEs são suportadas no MySQL versão 8.0 e mais recentes)

-- Exemplo 6: Reescrevendo o Exemplo 5 com CTE
-- (Muito mais fácil de ler)
SELECT '--- 6. Valor total por venda (reescrito com CTE) ---' AS ' ';
-- 1. Define a CTE (bloco lógico temporário)
WITH TotaisPorVenda AS (
    SELECT
        IV.VendaID,
        SUM(P.Preco * IV.Quantidade) AS ValorTotalDaVenda
    FROM ItensVenda IV
    JOIN Produtos P ON IV.ProdutoID = P.ProdutoID
    GROUP BY IV.VendaID
)
-- 2. Usa a CTE como se fosse uma tabela normal
SELECT
    V.VendaID,
    T.ValorTotalDaVenda
FROM Vendas V
JOIN TotaisPorVenda T ON V.VendaID = T.VendaID;


-- Exemplo 7: Múltiplas CTEs (Encadeamento)
-- (Passo 1: Calcular o total por venda. Passo 2: Calcular a média de gastos por cliente)
SELECT '--- 7. Média de gastos por cliente (Múltiplas CTEs) ---' AS ' ';

-- Passo 1: Calcular o total de cada venda
WITH TotaisPorVenda AS (
    SELECT
        V.ClienteID,
        IV.VendaID,
        SUM(P.Preco * IV.Quantidade) AS ValorTotalDaVenda
    FROM ItensVenda IV
    JOIN Produtos P ON IV.ProdutoID = P.ProdutoID
    JOIN Vendas V ON IV.VendaID = V.VendaID
    GROUP BY V.ClienteID, IV.VendaID
),
-- Passo 2: Calcular a média de gastos do cliente, usando a CTE anterior
GastosPorCliente AS (
    SELECT
        ClienteID,
        AVG(ValorTotalDaVenda) AS GastoMedioPorVenda,
        SUM(ValorTotalDaVenda) AS GastoTotal
    FROM TotaisPorVenda
    GROUP BY ClienteID
)
-- Resultado Final: Junta com o nome do cliente
SELECT
    C.NomeCliente,
    G.GastoMedioPorVenda,
    G.GastoTotal
FROM Clientes C
JOIN GastosPorCliente G ON C.ClienteID = G.ClienteID;