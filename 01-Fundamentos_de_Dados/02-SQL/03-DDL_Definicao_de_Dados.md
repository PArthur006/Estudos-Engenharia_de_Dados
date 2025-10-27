# DDL - Linguagem de Definição de Dados

> **DDL (Data Definition Language)** é o conjunto de comandos SQL usados para **definir** e **gerenciar a estrutura** do banco (Tabelas, Views, etc.).

## `Create Table`

O comando `CREATE TABLE` é usado para construir uma nova tabela no banco de dados.

### Sintaxe Base

```sql
CREATE TABLE NomeDaTabela
(
    NomeDaColuna1 TipoDeDados [Restrições],
    NomeDaColuna2 TipoDeDados [Restrições],
    ...
    [Restrições da Tabela (ex: Chaves)]
);
```

---

## Restrições (Constraints)

Restrições são regras aplicadas às colunas para garantir a integridade e a validade dos dados.

### Primary Key (PK)

A **Chave Primária** identifica de forma **única** cada linha da tabela.

- **Regra:** Não pode ser nula (NULL) e não pode se repetir.

### Foreign Key (FK)

A **Chave Estrangeira** é o campo que estabelece o **RELACIONAMENTO** entre duas tabelas. É uma coluna que "aponta" para a `PRIMARY KEY` de outra tabela.

- **O que garante:** A **Integridade Referencial**
    - Ex: Não deixa criar um *Pedido* para um *Cliente* que não existe.

> `NOT NULL`: É uma função que obriga que a coluna seja preenchida; Ela não pode ter valores nulos.

---

