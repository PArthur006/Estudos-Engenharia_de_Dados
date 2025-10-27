# Funções de Agregação e Agrupamentos

Funções de agregação operam em um conjunto de valores para retornar um único valor escalar. Elas são frequentemente usadas com a cláusula `GROUP BY` para resumir dados.

---

### 1. Funções de Agregação Comuns

- **`COUNT()`**: Conta o número de linhas.
  - `COUNT(*)`: Conta todas as linhas.
  - `COUNT(nome_coluna)`: Conta todas as linhas onde `nome_coluna` não é NULA.
  - `COUNT(DISTINCT nome_coluna)`: Conta o número de valores distintos (únicos).

- **`SUM()`**: Soma todos os valores de uma coluna numérica. Ignora valores nulos.

- **`AVG()`**: Calcula a média dos valores de uma coluna numérica. Ignora valores nulos.

- **`MIN()`**: Retorna o menor valor em uma coluna.

- **`MAX()`**: Retorna o maior valor em uma coluna.

**Exemplo:**
```sql
SELECT
    COUNT(*) AS TotalPedidos,
    SUM(ValorTotal) AS FaturamentoTotal,
    AVG(ValorTotal) AS TicketMedio,
    MIN(DataPedido) AS PrimeiroPedido,
    MAX(DataPedido) AS UltimoPedido
FROM Pedidos;
```

---

### 2. Agrupamento de Dados com `GROUP BY`

A cláusula `GROUP BY` é usada com funções de agregação para agrupar linhas que têm os mesmos valores em colunas especificadas, gerando um resumo para cada grupo.

- **Regra**: Qualquer coluna no `SELECT` que não seja uma função de agregação **deve** estar na cláusula `GROUP BY`.

**Exemplo**: Calcular o total de vendas por cliente.
```sql
SELECT
    ID_Cliente,
    COUNT(*) AS NumeroDePedidos,
    SUM(ValorTotal) AS TotalGasto
FROM Pedidos
GROUP BY ID_Cliente;
```
Neste caso, todas as linhas com o mesmo `ID_Cliente` são agrupadas, e as funções `COUNT()` e `SUM()` são aplicadas a cada um desses grupos.

---

### 3. Filtrando Grupos com `HAVING`

Enquanto a cláusula `WHERE` filtra **linhas** antes do agrupamento, a cláusula `HAVING` filtra **grupos** depois que as funções de agregação foram calculadas.

- **`WHERE`**: Filtra dados brutos. Não pode ser usada com funções de agregação.
- **`HAVING`**: Filtra os resultados do `GROUP BY`. É usada exclusivamente com funções de agregação.

**Exemplo**: Listar apenas os clientes que gastaram mais de R$ 1.000,00 no total.
```sql
SELECT
    ID_Cliente,
    SUM(ValorTotal) AS TotalGasto
FROM Pedidos
WHERE StatusPedido = 'Entregue' -- Filtra linhas ANTES do agrupamento
GROUP BY ID_Cliente
HAVING SUM(ValorTotal) > 1000; -- Filtra grupos DEPOIS do agrupamento
```

**Ordem de Execução Lógica:**
1.  `FROM`
2.  `WHERE`
3.  `GROUP BY`
4.  `HAVING`
5.  `SELECT`
6.  `ORDER BY`

---

### 4. Funções Escalares (Exemplos)

Diferente das funções de agregação, as funções escalares operam em um único valor de entrada e retornam um único valor de saída por linha.

- **Funções de String**:
  - `UPPER(texto)`, `LOWER(texto)`: Converte para maiúsculas/minúsculas.
  - `SUBSTRING(texto, inicio, tamanho)`: Extrai parte de uma string.
  - `CONCAT(texto1, texto2, ...)`: Concatena strings.

- **Funções Numéricas**:
  - `ROUND(numero, casas_decimais)`: Arredonda um número.
  - `CEILING(numero)`: Arredonda para cima.
  - `FLOOR(numero)`: Arredonda para baixo.

- **Funções de Data**:
  - `GETDATE()` ou `NOW()`: Retorna a data e hora atuais.
  - `YEAR(data)`, `MONTH(data)`, `DAY(data)`: Extraem partes de uma data.
  - `DATEDIFF(intervalo, data1, data2)`: Calcula a diferença entre duas datas.
