# Subconsultas e Views

Subconsultas e Views são recursos do SQL que ajudam a estruturar e simplificar consultas complexas, além de promover a reutilização de código e a segurança.

---

## 1. Subconsultas (Subqueries)

Uma subconsulta é uma instrução `SELECT` aninhada dentro de outra instrução (`SELECT`, `INSERT`, `UPDATE` ou `DELETE`) ou dentro de outra subconsulta.

### a) Subconsulta Escalar
Retorna uma única linha com uma única coluna. Pode ser usada em qualquer lugar onde um valor único é esperado, como em uma cláusula `WHERE` ou na lista de `SELECT`.

**Exemplo**: Encontrar todos os produtos que têm um preço acima da média.
```sql
SELECT
    NomeProduto,
    Preco
FROM Produtos
WHERE Preco > (SELECT AVG(Preco) FROM Produtos);
```
A subconsulta `(SELECT AVG(Preco) FROM Produtos)` é executada primeiro e retorna um único valor (a média de preços), que é então usado pela consulta principal.

### b) Subconsulta de Múltiplas Linhas
Retorna múltiplas linhas. É comumente usada com operadores como `IN`, `NOT IN`, `ANY` e `ALL`.

**Exemplo**: Encontrar todos os clientes que já compraram o "Produto A".
```sql
SELECT Nome
FROM Clientes
WHERE ID_Cliente IN (SELECT ID_Cliente
                     FROM Pedidos
                     WHERE ID_Produto = (SELECT ID_Produto FROM Produtos WHERE NomeProduto = 'Produto A'));
```
A subconsulta interna retorna uma lista de `ID_Cliente`, e o operador `IN` verifica se o cliente da consulta principal está nessa lista.

### c) Subconsulta Correlacionada
É uma subconsulta que depende da consulta externa para obter seus valores. A subconsulta é executada repetidamente, uma vez para cada linha avaliada pela consulta externa.

**Elas podem ser lentas e devem ser usadas com cuidado.** Muitas vezes, um `JOIN` é uma alternativa mais performática.

**Exemplo**: Encontrar todos os produtos cujo preço é o mais alto em sua respectiva categoria.
```sql
SELECT
    NomeProduto,
    Preco,
    ID_Categoria
FROM Produtos p1
WHERE Preco = (SELECT MAX(Preco)
               FROM Produtos p2
               WHERE p2.ID_Categoria = p1.ID_Categoria); -- A subconsulta depende de p1
```
Para cada produto `p1` da consulta externa, a subconsulta `p2` é executada para encontrar o preço máximo naquela categoria específica.

---

## 2. Views

Uma **View** (Visão) é uma consulta `SELECT` armazenada no banco de dados como um objeto, que pode ser usado como uma tabela virtual.

- **Não armazena dados**: A View é apenas a definição da consulta. Os dados são buscados das tabelas subjacentes toda vez que a View é acessada.

### Por que usar Views?

1.  **Simplificação**: Ocultar a complexidade de consultas com múltiplos `JOINs`. Em vez de escrever um `JOIN` complexo toda vez, você pode simplesmente fazer `SELECT * FROM MinhaViewComplexa`.

2.  **Segurança**: Restringir o acesso a dados. Você pode criar uma View que expõe apenas colunas não sensíveis ou linhas específicas de uma tabela, e conceder permissão à View em vez da tabela original.

3.  **Consistência**: Manter a lógica de negócio consistente. Se um cálculo complexo é usado em vários relatórios, você pode defini-lo uma vez em uma View para garantir que todos usem a mesma lógica.

### Criando e Usando uma View

**Sintaxe de Criação:**
```sql
CREATE VIEW Vw_PedidosClientes AS
SELECT
    c.Nome AS NomeCliente,
    c.Cidade,
    p.ID_Pedido,
    p.DataPedido,
    p.ValorTotal
FROM Clientes c
INNER JOIN Pedidos p ON c.ID_Cliente = p.ID_Cliente
WHERE c.Estado = 'SP';
```

**Usando a View:**
Agora, em vez de reescrever toda a consulta, você pode simplesmente usar:
```sql
-- Buscar todos os pedidos de clientes de São Paulo
SELECT * FROM Vw_PedidosClientes;

-- Buscar o total de vendas para clientes de Campinas
SELECT SUM(ValorTotal)
FROM Vw_PedidosClientes
WHERE Cidade = 'Campinas';
```

**Modificando e Removendo Views:**
- `ALTER VIEW ...`: Modifica a definição de uma View existente.
- `DROP VIEW ...`: Remove uma View do banco de dados.

---

## WITH CTEs (Commom Table Expressions)

Uma CTE (Expressão de Tabela Comum) é um **conjunto de resultados temporários e nomeado**.

### Sintaxe

Ela é definida *antes* do `SELECT` principal, usando a palavra-chave `WITH`

```sql
WITH MeuNomeTemporario AS (... aqui vai o SELECT ...)
SELECT * FROM MeuNomeTemporario;
```

### Por que usar CTEs?

1. **Legibilidade:** CTEs são o **oposto** de subconsultas aninhadas. Em vez de criar um "código espaguete", você cria blocos lógicos, um após o outro.
2. **Reutilização:** Você pode definir uma CTE uma vez e referenciá-la várias vezes no `SELECT` principal.
3. **Recursividade:** CTEs são a **única forma** de fazer consultas recursivas em SQL (ex: encontrar todos os subordinados de um gerente em uma hierarquia, navegar em uma árvore, etc.).

### Comparação: Subconsulta no `FROM` vs. CTE

#### Subconsulta no `FROM`

```sql
SELECT T1.Cliente, T2.Media FROM 
(SELECT ... FROM Clientes) 
AS T1 JOIN (SELECT ... FROM Pedidos) 
AS T2 ON T1.ID = T2.ID;
```

#### CTE

```sql
WITH TabelaClientes AS (
SELECT ... FROM Clientes
),
TabelaPedidos AS (
SELECT ... FROM Pedidos
)
SELECT T1.Cliente, T2.Media
FROM TabelaClientes AS T1
JOIN TabelaPedidos AS T2 ON T1.ID = T2.ID;
```

Em resumo, use **Subconsultas** para filtros simples e, sempre que sua consulta começar a ficar complexa, opte pelos **CTEs**, ou quando precisar dividir o problema em "etapas" lógicas. Na engenharia de dados, CTEs são usadas o tempo todo para construir pipelines de transformação.