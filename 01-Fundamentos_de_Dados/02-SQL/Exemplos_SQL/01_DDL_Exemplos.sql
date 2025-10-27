-- Exemplos de Comandos DDL (Data Definition Language)

-- CREATE TABLE: Cria uma nova tabela no banco de dados.
-- Aqui, criamos uma tabela 'Clientes' e uma 'Pedidos'.
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DataCadastro DATE
);

CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY,
    ClienteID INT,
    DataPedido DATE,
    ValorTotal DECIMAL(10, 2),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- ALTER TABLE: Modifica a estrutura de uma tabela existente.
-- Adicionando uma coluna 'Telefone' à tabela 'Clientes'.
ALTER TABLE Clientes
ADD Telefone VARCHAR(20);

-- Modificando o tipo de dado de uma coluna.
-- (A sintaxe pode variar um pouco entre SGBDs)
ALTER TABLE Clientes
MODIFY Nome VARCHAR(150);

-- DROP TABLE: Remove uma tabela do banco de dados.
-- CUIDADO: Esta ação é irreversível e apaga todos os dados da tabela.
-- DROP TABLE Pedidos;
-- DROP TABLE Clientes;
