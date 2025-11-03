# Modelagem Dimensional: Fatos e Dimensões

> Modelagem Dimensional é o padrão de design usado para construir um **Data Warehouse (DW)** ou um sistema **OLAP**.
> Seu principal objetivo é otimizar o banco de dados para **alta performance em consultas (`SELECT`)** e **fácil entendimento** pelo usuário final.

>Ela é intencionalmente **Desnormalizada**. A redundância (repetição de dados) é aceita para evitar `JOINs` complexos e caros.

## A Estrutura Central

A modelagem dimensional separa os dados em dois (e apenas dois) tipos de tabelas:

#### A. Tabela Fato (FATOS)

- É a tabela central. Ela armazena os **Eventos de Negócio** ou "o que aconteceu".
- Pense nela como a "planilha de Vendas" ou o "extrato bancário".
- **O que ela contém:**
    1. **Métricas (ou medidas):** São os números que você pode analisar, os valores que podem ser agregados (somados, contados, etc.).
        - Exemplos: `Valor_Venda`, `Qtd_Itens`, `Custo_Produto`.
    2. **Chaves Estrangeiras (FKs):** "Ponteiros" que conectam o evento às tabelas de Dimensão.
        - Exemplos: `ID_Cliente`, `ID_Produto`, `ID_Tempo`.
- É a tabela **"gigante"** (com milhões ou bilhões de linhas) e **"estreita"** (com poucas colunas, a maioria são números: métricas ou chaves).

#### B. Tabela Dimensão (DIMENSÕES)

- São as tabelas que **dão contexto** ao Fato. Elas respondem as perguntas: "Quem?", "O que?", "Onde?", "Quando?".
- Pense nelas como os "filtros" que você usará nos seus relatórios.
- **O que ela contém:**
    1. **Chave Primária (PK):** O identificador único da dimensão (ex: `ID_Cliente`).
    2. **Atributos Descritivos:** Todo o texto e as categorias que descrevem o evento.
        - Exemplo (`Dim.Cliente`): `Nome_Cliente`, `Cidade`, `Estado`, `Regiao`.
- São as tabelas **"pequenas"** (milhares de linhas, ex: uma linha para cada cliente ou produto) e **"largas"** (muitas colunas de texto, usadas para filtrar e agrupar).
- **Desnormalizadas:** Em uma Dimensão, você *repete* dados. Por exemplo, na `Dim_Cliente`, a coluna `Regiao` (ex: "Sudeste") vai se repetir para todos os clientes de SP e RJ. Isso é proposital para evitar um `JOIN` com uma tabela `Regiao`.

## A Diferença na Prática

- **Consulta OLTP (Normalizado):** "Qual o faturamento por região?"
    ```sql
    SELECT ... FROM Vendas
    JOIN ItensVenda ...
    JOIN Produtos ...
    JOIN Clientes ...
    JOIN Cidades ...
    JOIN Estados ...
    JOIN Regioes ...
    ```
    - Consulta lenta, com 7 `JOINs`.
- **Consulta OLAP (Dimensional):** "Qual o faturamento por região?"
    ```sql
    SELECT SUM(F.Valor_Venda), D_Cliente.Regiao
    FROM Fato_Vendas F
    JOIN Dim_Cliente D_Cliente ON F.ID_Cliente = D_Cliente.ID_Cliente
    GROUP BY D_Cliente.Regiao
    ```
    - Consulta rápida, com um único `JOIN`.
