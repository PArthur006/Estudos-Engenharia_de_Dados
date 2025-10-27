# Linguagem de Consulta de Dados

> **DQL (Data Query Language)** é usada para **recuperar** e **visualizar** os dados. O principal comando é o `SELECT`.

## `SELECT`

Sua função é consultar e retornar dados de uma ou mais tabelas.

- **Sintaxe para colunas específicas:** `SELECT Coluna1, Coluna2 FROM Nome_Da_Tabela;`
- **Sintaxe para todas as colunas:** `SELECT * FROM Nome_Da_Tabela;`

## `WHERE`

Tem por função ser a cláusula de **filtragem** fundamental. Limita as linhas que o `SELECT`, `UPDATE` ou `DELETE` irão afetar.

- **Sintaxe:** `SELECT Coluna FROM NomeDaTabela WHERE Condicao;`

### Operadores Comuns do `WHERE`

- `BETWEEN...AND...`
    - **Função:** Define um intervalo de valores (inclusivo, ou seja, inclui os limites).
    - Ex: `WHERE Preco BETWEEN 10 AND 20;`
- `IN (...)`
    - **Função:** Define uma lista de valores possíveis. (É um **"OU"** simplificado).
    - Ex: `WHERE Pais IN ('Brasil', 'Alemanha', 'EUA');`
- `NOT IN (...)`
    - **Função:** Define uma lista de valores a serem **excluídos** da consulta.
- `LIKE`
    - **Função:** Usado para busca de padrões em texto (strings).
    - **Curingas (Wildcards):**
        - **`%` (Porcentagem):** Substitui *zero, um ou múltiplos caracteres*.
            - `LIKE 'A%'` (Começa com 'A')
            - `LIKE '%A'` (Termina com 'A')
            - `LIKE '%A%'` (Contém 'A' em qualquer lugar)
        - **`_` (Underline):** Substitui *exatamente um caractere*.
            - `LIKE 'Jo_o'` (Retorna 'João', 'Joao', etc.)

---
