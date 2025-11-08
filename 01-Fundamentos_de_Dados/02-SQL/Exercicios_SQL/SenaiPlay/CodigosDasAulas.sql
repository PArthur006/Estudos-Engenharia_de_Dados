# Aula 2: Conceitos Básicos de SQL
# ---
# OBJETIVO:
# 1. Aprender a criar um "ambiente" (Banco de Dados).
# 2. Criar nossa primeira estrutura (Tabela).
# 3. Inserir dados (DML).
# ---

# DDL (Data Definition Language) - Comandos que DEFINEM a estrutura.

# 1. Criar o Banco de Dados (Schema)
# O "container" para nossas tabelas.
CREATE DATABASE IF NOT EXISTS empresa;

# 2. Selecionar o Banco de Dados
# Avisa o MySQL qual banco queremos usar para os próximos comandos.
USE empresa;

# 3. Criar a Tabela
# A "planta baixa" dos nossos dados de clientes.
CREATE TABLE clientes (
    id INT,
    nome VARCHAR(100),
    email VARCHAR(100)
);

# DML (Data Manipulation Language) - Comandos que MANIPULAM os dados.

# 1. Inserir um único registro
INSERT INTO clientes (id, nome, email)
VALUES (1, 'Arthur', 'arthur@exemplo.com');

# 2. Inserir múltiplos registros de uma vez
INSERT INTO clientes (id, nome, email)
VALUES
(2, 'Beatriz', 'beatriz@exemplo.com'),
(3, 'Carla', 'carla@exemplo.com');

# DQL (Data Query Language) - Comando que CONSULTA os dados.

# 1. Selecionar e ver todos os dados da tabela
SELECT * FROM clientes;

# Aula 5: Relacionamento entre Tabelas
# ---
# OBJETIVO:
# 1. Criar a segunda tabela (pedidos) do nosso modelo.
# 2. Preparar o terreno para a Aula 6, onde a conexão (Foreign Key) será feita.
# ---

USE empresa;

# 1. Revisar nossa tabela "pai" (lado "1" do relacionamento)
# (Assumindo que a Aula 4 já foi executada e a PK foi adicionada)
ALTER TABLE clientes MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;

SELECT * FROM clientes;

# 2. Criar a tabela "filha" (lado "N" do relacionamento)
#
# Vamos criar a tabela 'pedidos'.
# Note que a coluna 'ClienteID' é um 'INT' simples. Por enquanto,
# ela é apenas uma coluna comum que irá "apontar" para o 'id' da tabela 'clientes'.
#
# A conexão lógica (a Foreign Key) será criada na próxima aula.

CREATE TABLE pedidos (
    idPedidos INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    ClienteID INT, -- Esta coluna será a nossa futura Chave Estrangeira
    DataPedido DATE
);

# 3. Inserir dados de teste
#
# Note que, NESTE MOMENTO, o banco aceitaria um ClienteID que não existe (ex: 99).
# INSERT INTO pedidos (ClienteID, DataPedido) VALUES (99, '2025-11-01');
#
# Isso acontece porque a regra (Constraint) da Chave Estrangeira ainda não foi criada.
# Vamos inserir os dados corretos.

INSERT INTO pedidos (ClienteID, DataPedido) VALUES
(1, '2025-10-01'), -- Pedido do cliente ID 1 (Arthur)
(1, '2025-10-15'), -- Outro pedido do cliente ID 1
(2, '2025-10-05'); -- Pedido do cliente ID 2 (Beatriz)

# 4. Consultar a nova tabela
SELECT * FROM pedidos;

# O próximo passo (Aula 6) é aplicar a CONSTRAINT FOREIGN KEY
# na coluna 'ClienteID' para garantir que ela só possa
# receber valores que existem na coluna 'clientes.id'.


# Aula 6: Chaves Estrangeiras (Foreign Keys)
# ---
# OBJETIVO:
# 1. Criar a "coleira" (o link lógico) entre a tabela 'clientes' (pai)
#    e a tabela 'pedidos' (filha).
# 2. Definir regras automáticas (ON DELETE/ON UPDATE) para
#    manter a consistência dos dados.
# ---

USE empresa;

# 1. (Re)Definir a tabela "filha" (pedidos)
# (Este passo pode ser pulado se a tabela já foi criada na Aula 5)
DROP TABLE IF EXISTS pedidos;
CREATE TABLE pedidos(
    idPedidos INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    ClienteID INT,
    DataPedido DATE
);

# 2. Criar um ÍNDICE (INDEX) na coluna da Chave Estrangeira
#
# MUITO IMPORTANTE: Isso otimiza a performance. Sempre que
# você cria uma Foreign Key, você deve indexar a coluna.
# Isso torna os JOINs e as verificações de integridade (como esta)
# milhares de vezes mais rápidos em tabelas grandes.
ALTER TABLE `empresa`.`pedidos`
ADD INDEX `fk_cliente_idx`(`ClienteID`);

# 3. Adicionar a "Regra" (CONSTRAINT) da Chave Estrangeira
# Este é o comando principal da aula.
ALTER TABLE `empresa`.`pedidos`
ADD CONSTRAINT `fk_clienteid`
    # -> A coluna 'ClienteID' da tabela 'pedidos'...
    FOREIGN KEY (`ClienteID`)
    # -> ...deve obrigatoriamente existir na coluna 'id' da tabela 'clientes'.
    REFERENCES `empresa`.`clientes` (`id`)
    
    # --- Regras Automáticas ---
    
    # REGRA 1: Se um cliente (pai) for DELETADO...
    # ...todos os seus pedidos (filhos) são DELETADOS juntos.
    ON DELETE CASCADE
    
    # REGRA 2: Se o 'id' de um cliente (pai) for ATUALIZADO...
    # ...o 'ClienteID' nos seus pedidos (filhos) também é ATUALIZADO.
    ON UPDATE CASCADE;

# --- Testando a Regra (Integridade Referencial) ---

# Na Aula 5, este comando FUNCIONARIA.
# Agora, ele vai FALHAR (o que é BOM!).
# Erro: "Cannot add or update a child row: a foreign key constraint fails"
# Motivo: Não existe nenhum cliente com 'id' = 99 na tabela 'clientes'.
INSERT INTO pedidos (ClienteID, DataPedido) VALUES (99, '2025-11-01');

# Este INSERT vai FUNCIONAR, pois o cliente ID 3 (Carla) existe.
INSERT INTO pedidos (ClienteID, DataPedido) VALUES (3, '2025-11-02');

# --- Testando o ON DELETE CASCADE ---

# Vamos deletar a cliente 'Carla' (ID 3) da tabela PAI
DELETE FROM clientes WHERE id = 3;

# Agora, verifique a tabela FILHA
# O pedido da Carla (criado acima) foi DELETADO automaticamente.
SELECT * FROM pedidos WHERE ClienteID = 3; -- (Retornará 0 linhas)


# 4. (Opcional) Como remover a Constraint
# Este comando apaga a "regra" da Foreign Key.
ALTER TABLE `empresa`.`pedidos`
DROP FOREIGN KEY `fk_clienteid`;

# Este comando apaga o índice que criamos para performance.
ALTER TABLE `empresa`.`pedidos`
DROP INDEX `fk_cliente_idx`;

# Aula 7: Consultas SQL Básicas
# ---
# OBJETIVO:
# 1. Popular nossas tabelas com dados para que as consultas façam sentido.
# 2. Praticar os comandos básicos de leitura: SELECT, WHERE, ORDER BY, LIKE.
# ---

USE empresa;

# --- 1. FUNDAÇÃO DE DADOS (CRÍTICO PARA AS PRÓXIMAS AULAS) ---

# Limpando dados antigos para começar do zero
DELETE FROM pedidos;
DELETE FROM clientes;
DROP TABLE IF EXISTS pedidos_itens;
DROP TABLE IF EXISTS produtos;

# (Re)criando a tabela clientes (como na Aula 4, mas com AUTO_INCREMENT)
DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100),
    sobrenome VARCHAR(100),
    email VARCHAR(100)
);

# (Re)criando a tabela pedidos (como na Aula 6)
DROP TABLE IF EXISTS pedidos;
CREATE TABLE pedidos(
    idPedidos INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    ClienteID INT,
    DataPedido DATE,
    CONSTRAINT fk_clienteid FOREIGN KEY (ClienteID)
        REFERENCES clientes (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

# INSERINDO NOVOS CLIENTES
INSERT INTO clientes (nome, sobrenome, email) VALUES
('Arthur', 'Silva', 'arthur.silva@exemplo.com'),
('Beatriz', 'Santos', 'bia.santos@exemplo.com'),
('Carla', 'Oliveira', 'carla_o@exemplo.com'),
('Daniel', 'Moraes', 'daniel.moraes@exemplo.com');

# INSERINDO PEDIDOS PARA ELES
INSERT INTO pedidos (ClienteID, DataPedido) VALUES
(1, '2025-10-01'), -- Pedido do Arthur
(1, '2025-10-15'), -- Outro pedido do Arthur
(2, '2025-10-05'), -- Pedido da Beatriz
(3, '2025-10-20'); -- Pedido da Carla
-- Note: O Cliente 'Daniel' (ID 4) não tem pedidos.

# --- NOVAS TABELAS PARA AULAS FUTURAS (PRODUTOS E ITENS) ---

CREATE TABLE produtos (
    idProduto INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    NomeProduto VARCHAR(100),
    Preco DECIMAL(10, 2)
);

CREATE TABLE pedidos_itens (
    idItem INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idPedido INT,
    idProduto INT,
    Quantidade INT,
    CONSTRAINT fk_item_pedido FOREIGN KEY (idPedido)
        REFERENCES pedidos (idPedidos),
    CONSTRAINT fk_item_produto FOREIGN KEY (idProduto)
        REFERENCES produtos (idProduto)
);

# INSERINDO PRODUTOS
INSERT INTO produtos (NomeProduto, Preco) VALUES
('Notebook', 4500.00),
('Mouse', 150.00),
('Teclado', 300.00),
('Monitor', 1200.00);

# INSERINDO ITENS NOS PEDIDOS
INSERT INTO pedidos_itens (idPedido, idProduto, Quantidade) VALUES
(1, 1, 1), -- Pedido 1 (Arthur): 1 Notebook
(1, 2, 1), -- Pedido 1 (Arthur): 1 Mouse
(2, 3, 2), -- Pedido 2 (Arthur): 2 Teclados
(3, 4, 1), -- Pedido 3 (Beatriz): 1 Monitor
(4, 2, 5); -- Pedido 4 (Carla): 5 Mouses

# --- 2. PRÁTICA DE CONSULTAS BÁSICAS ---

# Selecionar todas as colunas de clientes
SELECT * FROM clientes;

# Selecionar colunas específicas
SELECT nome, email FROM clientes;

# Filtrar por ID (WHERE)
SELECT * FROM clientes WHERE id = 1;

# Filtrar por nome (LIKE)
SELECT * FROM clientes WHERE nome LIKE 'C%'; -- Nomes que começam com 'C'

# Ordenar (ORDER BY)
SELECT * FROM clientes ORDER BY nome ASC; -- Ordem Alfabética (A-Z)
SELECT * FROM produtos ORDER BY Preco DESC; -- Do mais caro para o mais barato

# Aula 8: Funções de Agregação e Agrupamento
# ---
# OBJETIVO: Resumir dados. Usar COUNT, SUM, AVG, GROUP BY e HAVING.
# ---

USE empresa;

# COUNT: Quantos clientes temos?
SELECT COUNT(id) AS TotalClientes FROM clientes;

# COUNT: Quantos produtos *distintos* foram vendidos?
SELECT COUNT(DISTINCT idProduto) AS ProdutosDistintosVendidos FROM pedidos_itens;

# SUM: Qual o valor total de todos os produtos em estoque?
SELECT SUM(Preco) AS ValorTotalEstoque FROM produtos;

# AVG: Qual o preço médio dos nossos produtos?
SELECT AVG(Preco) AS PrecoMedio FROM produtos;

# MIN / MAX: Qual o produto mais barato e o mais caro?
SELECT
    MIN(Preco) AS MaisBarato,
    MAX(Preco) AS MaisCaro
FROM produtos;

# GROUP BY: Quantos pedidos cada cliente fez?
SELECT
    ClienteID,
    COUNT(idPedidos) AS NumeroDePedidos
FROM
    pedidos
GROUP BY
    ClienteID;

# GROUP BY com HAVING: Quais clientes fizeram MAIS de 1 pedido?
SELECT
    ClienteID,
    COUNT(idPedidos) AS NumeroDePedidos
FROM
    pedidos
GROUP BY
    ClienteID
HAVING
    NumeroDePedidos > 1;

# Aula 9: Joins (Junções)
# ---
# OBJETIVO: Combinar dados de tabelas diferentes.
# ---

USE empresa;

# INNER JOIN: Mostrar apenas clientes QUE FIZERAM pedidos
SELECT
    c.nome,
    p.DataPedido
FROM
    clientes c
INNER JOIN
    pedidos p ON c.id = p.ClienteID;

# LEFT JOIN: Mostrar TODOS os clientes, e os pedidos deles (se tiverem)
# (O 'Daniel' (ID 4) aparecerá aqui com 'DataPedido' como NULL)
SELECT
    c.nome,
    p.DataPedido
FROM
    clientes c
LEFT JOIN
    pedidos p ON c.id = p.ClienteID;

# RIGHT JOIN: Mostrar TODOS os pedidos, e os clientes deles
# (Funciona como o INNER JOIN neste caso, pois não há pedidos "órfãos")
SELECT
    c.nome,
    p.DataPedido
FROM
    clientes c
RIGHT JOIN
    pedidos p ON c.id = p.ClienteID;

# JOIN MÚLTIPLO (O Relatório Completo)
# Objetivo: Ver o nome do cliente, o produto que ele comprou e o valor total (Preço * Qtd)
SELECT
    c.nome AS Cliente,
    pr.NomeProduto AS Produto,
    pi.Quantidade,
    pr.Preco,
    (pi.Quantidade * pr.Preco) AS ValorTotalItem
FROM
    clientes c
JOIN
    pedidos p ON c.id = p.ClienteID
JOIN
    pedidos_itens pi ON p.idPedidos = pi.idPedido
JOIN
    produtos pr ON pi.idProduto = pr.idProduto
ORDER BY
    c.nome;

# Aula 10: Subconsultas (Subqueries)
# ---
# OBJETIVO: Usar um SELECT dentro de outro SELECT.
# ---

USE empresa;

# Subconsulta no WHERE (com IN):
# Encontrar clientes que compraram o produto 'Mouse' (ID 2)
SELECT * FROM clientes
WHERE id IN (
    -- Subconsulta: Pega IDs de clientes que compraram o produto 2
    SELECT p.ClienteID
    FROM pedidos p
    JOIN pedidos_itens pi ON p.idPedidos = pi.idPedido
    WHERE pi.idProduto = 2
);

# Subconsulta Escalar no WHERE:
# Encontrar produtos mais caros que a média
SELECT * FROM produtos
WHERE Preco > (
    -- Subconsulta: Calcula o preço médio
    SELECT AVG(Preco) FROM produtos
);

# Subconsulta Correlacionada no SELECT:
# Mostrar clientes e a contagem de pedidos de cada um
SELECT
    c.nome,
    (
        -- Subconsulta: Conta pedidos para CADA cliente da consulta externa
        SELECT COUNT(*)
        FROM pedidos p
        WHERE p.ClienteID = c.id
    ) AS TotalPedidos
FROM
    clientes c;

# Aula 11: Procedures e Functions
# ---
# OBJETIVO: Salvar blocos de código no banco para reutilização.
# ---

USE empresa;

# --- 1. PROCEDURE (Procedimento Armazenado) ---
# (Um "bloco de código" que você CHAMA)

# DELIMITER é necessário para o MySQL entender onde o código da procedure termina
DELIMITER //

CREATE PROCEDURE sp_novo_cliente (
    IN p_nome VARCHAR(100),
    IN p_sobrenome VARCHAR(100),
    IN p_email VARCHAR(100)
)
BEGIN
    INSERT INTO clientes (nome, sobrenome, email)
    VALUES (p_nome, p_sobrenome, p_email);
END //

DELIMITER ;

# Testando a Procedure
CALL sp_novo_cliente('Fabio', 'Costa', 'fabio.costa@exemplo.com');
SELECT * FROM clientes WHERE nome = 'Fabio';


# --- 2. FUNCTION (Função) ---
# (Uma "fórmula" que você usa no SELECT e SEMPRE retorna um valor)

DELIMITER //

CREATE FUNCTION fn_calcular_total_item (
    p_preco DECIMAL(10, 2),
    p_quantidade INT
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC -- (Necessário se a função não ler dados de tabelas)
BEGIN
    RETURN p_preco * p_quantidade;
END //

DELIMITER ;

# Testando a Function
SELECT
    NomeProduto,
    Preco,
    fn_calcular_total_item(Preco, 3) AS PrecoPara3Unidades
FROM
    produtos;

# Aula 12: Triggers (Gatilhos)
# ---
# OBJETIVO: Disparar um código automaticamente após um evento (INSERT, UPDATE, DELETE).
# ---

USE empresa;

# 1. Criar uma tabela de LOG (Auditoria)
CREATE TABLE log_clientes (
    idLog INT PRIMARY KEY AUTO_INCREMENT,
    Acao VARCHAR(50),
    ClienteID_Antigo INT,
    Nome_Antigo VARCHAR(100),
    Nome_Novo VARCHAR(100),
    DataMudanca TIMESTAMP DEFAULT NOW()
);

# 2. Criar o Trigger
DELIMITER //

CREATE TRIGGER trg_log_update_cliente
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
    -- 'OLD' refere-se ao dado antes do UPDATE
    -- 'NEW' refere-se ao dado depois do UPDATE
    IF OLD.nome <> NEW.nome THEN
        INSERT INTO log_clientes (Acao, ClienteID_Antigo, Nome_Antigo, Nome_Novo)
        VALUES ('UPDATE de Nome', OLD.id, OLD.nome, NEW.nome);
    END IF;
END //

DELIMITER ;

# 3. Testar o Trigger (Disparar o evento)
UPDATE clientes SET nome = 'Arthur S.' WHERE id = 1;

# 4. Verificar se o LOG foi criado
SELECT * FROM log_clientes;
-- (Deve aparecer um registro do 'UPDATE de Nome' que fizemos)

# Aula 13: Views (Vistas)
# ---
# OBJETIVO: Criar "tabelas virtuais" (atalhos) para consultas complexas.
# ---

USE empresa;

# 1. Criar a View (O "Relatório Completo" da Aula 9)
CREATE VIEW vw_relatorio_completo AS
    SELECT
        c.nome AS Cliente,
        c.email,
        p.DataPedido,
        pr.NomeProduto AS Produto,
        pi.Quantidade,
        (pi.Quantidade * pr.Preco) AS ValorTotalItem
    FROM
        clientes c
    JOIN
        pedidos p ON c.id = p.ClienteID
    JOIN
        pedidos_itens pi ON p.idPedidos = pi.idPedido
    JOIN
        produtos pr ON pi.idProduto = pr.idProduto;

# 2. Usar a View como se fosse uma tabela
SELECT * FROM vw_relatorio_completo;

# 3. Usar a View com filtros
SELECT Cliente, Produto, ValorTotalItem
FROM vw_relatorio_completo
WHERE Cliente = 'Arthur';

# Aula 14: Importação e Exportação
# ---
# OBJETIVO: Mover dados para dentro e fora do banco (ex: CSV).
# NOTA: Estes comandos SQL dependem de permissões de arquivo no servidor!
# ---

USE empresa;

# --- 1. Exportação (SELECT INTO OUTFILE) ---
# Exporta o resultado do SELECT para um arquivo CSV
#
# IMPORTANTE: Por segurança, o MySQL só permite isso em um
# diretório específico. Verifique sua variável 'secure_file_priv'
# com o comando: SHOW VARIABLES LIKE 'secure_file_priv';
# O arquivo SÓ pode ser salvo nesse local (ex: '/var/lib/mysql-files/')

SELECT * FROM clientes
INTO OUTFILE '/var/lib/mysql-files/backup_clientes.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

# --- 2. Importação (LOAD DATA INFILE) ---
# (Primeiro, criamos uma tabela para receber os dados)
CREATE TABLE clientes_importados (
    id INT,
    nome VARCHAR(100),
    sobrenome VARCHAR(100),
    email VARCHAR(100)
);

# Importa os dados do CSV que acabamos de criar
LOAD DATA INFILE '/var/lib/mysql-files/backup_clientes.csv'
INTO TABLE clientes_importados
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT * FROM clientes_importados;

# Aula 15: Backup e Recuperação
# ---
# OBJETIVO: Criar uma cópia de segurança (dump) do banco.
# ---
#
# NOTA: Backup e Recuperação não são comandos SQL.
# Eles são executados no TERMINAL (cmd, bash, etc.),
# NÃO dentro do MySQL Workbench.

# --- 1. COMANDO DE BACKUP (Para rodar no Terminal) ---
#
# mysqldump -u [seu_usuario] -p [nome_do_banco] > [nome_do_arquivo_backup.sql]
#
# Exemplo:
# mysqldump -u root -p empresa > C:\Backups\backup_empresa_2025-11-07.sql
#
# (Ele pedirá sua senha e criará um arquivo .sql com TODOS os comandos
# CREATE TABLE e INSERT necessários para recriar o banco 'empresa')

# --- 2. COMANDO DE RECUPERAÇÃO (Para rodar no Terminal) ---
#
# (Primeiro, crie um banco de dados vazio no qual restaurar, ex: 'nova_empresa')
# mysql -u [seu_usuario] -p [nome_do_banco_vazio] < [nome_do_arquivo_backup.sql]
#
# Exemplo:
# mysql -u root -p nova_empresa < C:\Backups\backup_empresa_2025-11-07.sql
#
# (Ele executará o script .sql e recriará todas as tabelas e dados
# dentro do banco 'nova_empresa')

# Aula 16: Otimização de Consultas
# ---
# OBJETIVO: Entender como o MySQL lê uma consulta e como melhorá-la.
# ---

USE empresa;

# 1. O Problema: "Full Table Scan"
# O EXPLAIN mostra o "Plano de Execução" (como o MySQL vai buscar os dados)
EXPLAIN SELECT * FROM clientes WHERE email = 'carla_o@exemplo.com';
#
# No resultado, em 'type', você verá 'ALL' (Full Table Scan).
# Isso significa que o MySQL leu a tabela INTEIRA para achar o email.
# Em uma tabela de 10 milhões de clientes, isso é um desastre.

# 2. A Solução: INDEX (Índice)
# Criamos um "índice de livro" para a coluna 'email',
# permitindo que o MySQL encontre o valor instantaneamente.
CREATE INDEX idx_email_cliente ON clientes(email);

# 3. Verificando a Otimização
# Rode o EXPLAIN de novo
EXPLAIN SELECT * FROM clientes WHERE email = 'carla_o@exemplo.com';
#
# Agora, em 'type', você verá 'ref' ou 'const'.
# Isso mostra que o MySQL usou o 'idx_email_cliente' e
# foi direto na linha, sem ler a tabela inteira.


# Aula 17: Segurança e Gerenciamento de Usuários
# ---
# OBJETIVO: Criar usuários e dar permissões (DCL - Data Control Language).
# ---

# (Estes comandos geralmente são rodados pelo usuário 'root')

# 1. Criar um novo usuário
# (Este usuário só pode conectar da máquina local 'localhost')
CREATE USER 'analista_bi'@'localhost'
IDENTIFIED BY 'senha_super_segura123';

# 2. Conceder permissões (GRANT)
# Dar permissão de APENAS LEITURA (SELECT) na nossa View de relatório
GRANT SELECT ON empresa.vw_relatorio_completo TO 'analista_bi'@'localhost';

# Dar permissão para rodar a procedure de cadastrar cliente
GRANT EXECUTE ON PROCEDURE empresa.sp_novo_cliente TO 'analista_bi'@'localhost';

# 3. Verificar permissões
SHOW GRANTS FOR 'analista_bi'@'localhost';

# 4. Revogar permissões (REVOKE)
REVOKE EXECUTE ON PROCEDURE empresa.sp_novo_cliente FROM 'analista_bi'@'localhost';
SHOW GRANTS FOR 'analista_bi'@'localhost';

# 5. Apagar o usuário (DROP USER)
DROP USER 'analista_bi'@'localhost';