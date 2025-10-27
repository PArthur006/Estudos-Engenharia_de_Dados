-- INSERT: Adiciona novos registros (linhas) a uma tabela.
INSERT INTO Clientes (ClienteID, Nome, Email, DataCadastro, Telefone)
VALUES
(1, 'João Silva', 'joao.silva@email.com', '2023-01-15', '11987654321'),
(2, 'Maria Santos', 'maria.santos@email.com', '2023-02-20', '21912345678');

INSERT INTO Pedidos (PedidoID, ClienteID, DataPedido, ValorTotal)
VALUES
(101, 1, '2023-03-10', 150.50),
(102, 2, '2023-03-12', 200.00),
(103, 1, '2023-04-05', 75.25);

-- UPDATE: Modifica registros existentes em uma tabela.
-- Atualizando o email de um cliente específico.
UPDATE Clientes
SET Email = 'joao.silva.novo@email.com'
WHERE ClienteID = 1;

-- Aumentando o valor de um pedido em 10%.
UPDATE Pedidos
SET ValorTotal = ValorTotal * 1.10
WHERE PedidoID = 101;

-- DELETE: Remove registros de uma tabela.
-- Removendo um pedido específico.
DELETE FROM Pedidos
WHERE PedidoID = 103;

-- CUIDADO: Um DELETE sem a cláusula WHERE removerá TODOS os registros da tabela.
-- DELETE FROM Pedidos;
