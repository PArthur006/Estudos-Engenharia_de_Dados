# DML - Linguagem de Manipulação de Dados

> **DML (Data Manipulation Language)** é o conjunto de comandos usados para **interagir com os dados** (inserir, modificar ou remover).

## `INSERT INTO`

Tem como função adicionar novas linhas (registros) a uma tabela.

- **Sintaxe:** `INSERT INTO Nome_da_Tabela (Coluna_1, Coluna_2) VALUES ('Valor 1', 'Valor 2');`

## `UPDATE`

Sua função é modificar dados em linhas que **já existem**.

**ALERTA:** Use **SEMPRE** a cláusula `WHERE`! Sem ela, você atualizará TODAS as linhas da tabela.

- **Sintaxe:** `UPDATE Nome_da_Tabela SET Nome_Coluna = Novo_Valor WHERE Condicao_Especifica;`

## `DELETE FROM`

É usado para remover linhas inteiras da tabela.

**ALERTA:** Use **SEMPRE** a cláusula `WHERE`! Sem ela, você apagará TODOS os dados da tabela.

- **Sintaxe:** `DELETE FROM Nome_Da_Tabela WHERE Condicao_Especifica;`

---

