# JOINs e UNIONs

`JOIN` e `UNION` são duas operações fundamentais em SQL para combinar dados de múltiplas fontes, mas elas funcionam de maneiras completamente diferentes.

- **`JOIN`**: Combina **colunas** de tabelas diferentes com base em uma condição de relacionamento.
- **`UNION`**: Combina (anexa) **linhas** de duas ou mais consultas.

---

### 1. JOINs

A cláusula `JOIN` é usada para buscar dados de duas ou mais tabelas com base em uma coluna relacionada entre elas.

#### `INNER JOIN`
Retorna apenas as linhas que têm valores correspondentes em **ambas** as tabelas. É o tipo de join mais comum.

**Exemplo**: Listar os clientes e os pedidos que eles fizeram.
```sql
SELECT
    Cliente.Nome,
    Pedido.ID_Pedido,
    Pedido.DataPedido
FROM Clientes
INNER JOIN Pedidos ON Clientes.ID_Cliente = Pedidos.ID_Cliente;
```
*Apenas clientes que fizeram pedidos aparecerão no resultado.*

#### `LEFT JOIN` (ou `LEFT OUTER JOIN`)
Retorna **todas as linhas** da tabela da esquerda (`FROM`) e as linhas correspondentes da tabela da direita (`JOIN`). Se não houver correspondência na tabela da direita, as colunas dessa tabela virão com valor `NULL`.

**Exemplo**: Listar **todos** os clientes e, se tiverem feito pedidos, mostrar esses pedidos.
```sql
SELECT
    Cliente.Nome,
    Pedido.ID_Pedido
FROM Clientes
LEFT JOIN Pedidos ON Clientes.ID_Cliente = Pedidos.ID_Cliente;
```
*Clientes que nunca fizeram um pedido aparecerão na lista, com `ID_Pedido` igual a `NULL`.*

#### `RIGHT JOIN` (ou `RIGHT OUTER JOIN`)
É o inverso do `LEFT JOIN`. Retorna **todas as linhas** da tabela da direita (`JOIN`) e as linhas correspondentes da tabela da esquerda. Se não houver correspondência, as colunas da tabela da esquerda virão como `NULL`.

**Exemplo**: Listar todos os pedidos e o nome do cliente que os fez.
```sql
SELECT
    Cliente.Nome,
    Pedido.ID_Pedido
FROM Clientes
RIGHT JOIN Pedidos ON Clientes.ID_Cliente = Pedidos.ID_Cliente;
```
*Se um pedido, por algum erro, não tiver um cliente associado, ele ainda aparecerá na lista com `Nome` igual a `NULL`.*

#### `FULL OUTER JOIN`
Retorna todas as linhas quando há uma correspondência em **qualquer uma** das tabelas. Combina a funcionalidade do `LEFT JOIN` e do `RIGHT JOIN`.

- Se não há correspondência na tabela da direita, suas colunas são `NULL`.
- Se não há correspondência na tabela da esquerda, suas colunas são `NULL`.

**Exemplo**: Listar todos os clientes e todos os pedidos, combinando-os onde for possível.
```sql
SELECT
    Cliente.Nome,
    Pedido.ID_Pedido
FROM Clientes
FULL OUTER JOIN Pedidos ON Clientes.ID_Cliente = Pedidos.ID_Cliente;
```
*O resultado incluirá: clientes com pedidos, clientes sem pedidos e pedidos sem clientes.*

---

### 2. UNION e UNION ALL

O operador `UNION` é usado para combinar o conjunto de resultados de duas ou mais `SELECT`.

**Regras para usar `UNION`**:
1.  Cada `SELECT` dentro do `UNION` deve ter o **mesmo número de colunas**.
2.  As colunas devem ter **tipos de dados compatíveis** (ou que possam ser implicitamente convertidos).
3.  Os nomes das colunas no resultado final são determinados pela **primeira consulta `SELECT`**.

#### `UNION`
Combina os resultados e **remove as linhas duplicadas**.

**Exemplo**: Listar em um único resultado os nomes de todos os clientes e de todos os fornecedores.
```sql
SELECT Nome FROM Clientes
UNION
SELECT Nome FROM Fornecedores;
```
*Se um nome existe em ambas as tabelas (ex: "Empresa X"), ele aparecerá apenas uma vez.*

#### `UNION ALL`
Combina os resultados e **inclui todas as linhas**, mesmo as duplicadas. É mais rápido que o `UNION` porque não precisa verificar a existência de duplicatas.

**Exemplo**:
```sql
SELECT Nome FROM Clientes
UNION ALL
SELECT Nome FROM Fornecedores;
```
*Se "Empresa X" for um cliente e também um fornecedor, seu nome aparecerá duas vezes na lista.*

Use `UNION ALL` sempre que tiver certeza de que não há duplicatas ou quando as duplicatas são desejadas, pois ele oferece melhor desempenho.
