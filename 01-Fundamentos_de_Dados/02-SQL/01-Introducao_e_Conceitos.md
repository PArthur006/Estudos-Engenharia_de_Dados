# Introdução e Conceitos de Implementação

## Da Modelagem para a Implemetação

**Modelagem:** é o projeto, a "planta baixa" do banco de dados (Ex: Modelo Entidade-Relacionamento, MER). Ela define *o que* vamos armazenar e *como* as entidades se relacionam (conceitual, lógico).

**Implementação:** é a "construção". É o ato de pegar o modelo lógico e transformá-lo em um banco de dados real e físico, usando código SQL (físico).

## SGBD (Sistema de Gerenciamento de Banco de Dados)

É o **software** que nos permite criar, gerenciar e interagir com os bancos de dados. Ele cuida da segurança, performance e armazenamento.

- **Exemplos:**
    - Microsoft SQL Server
    - Oracle Database
    - MySQL
    - PostgreSQL

## SQL (Structured Query Language)

É a **Linguagem padrão universal** que usamos para "conversar" com um SGBD. Usamos ela para pedir ao SGBD para criar uma tabela, inserir um dado ou fazer uma consulta.

- **Padrão vs. Dialetos:**
    - Existe um padrão (ANSI) que define os comandos básicos (`SELECT`, `INSERT`, etc.).
    - Cada SGBD tem seu próprio **dialeto**, que adiciona funcionalidades extras.
        - **T-SQL (Transact-SQL):** É o dialeto usado pelo **Microsoft SQL Server**.
        - **PL/SQL (Procedural Language/SQL):** É o dialeto usado pelo **Oracle Database**.
    - **Nota:** Os comandos básicos são 99% idênticos. As diferenças aparecem nos tópicos avançados, como Stored Procedures, Triggers e funções específicas.

## As Subdivisões (Categorias) do SQL

A linguagem SQL é dividida em grupos, de acordo com a função de cada comando. Saber isso é fundamental:

- **DQL (Data Query Language - Linguagem de Consulta de Dados)**
    - **Função:** Ler, consultar, buscar dados.
    - **Comando Principal:**
        - `SELECT`
- **DML (Data Manipulation Language)**
    - **Função:** Manipular os dados que *já existem* dentro das tabelas.
    - **Comandos:**
        - `INSERT` (Adicionar);
        - `UPDATE` (Modificar);
        - `DELETE` (Apagar);
- **DDL (Data Definition Language)**
    - **Função:** Definir a **estrutura** do banco (objetos do banco).
    - **Comandos:**
        - `CREATE` (Criar tabela, view, etc.);
        - `ALTER` (Modificar a estrutura);
        - `DROP` (Excluir a estrutura).
- **DCL (Data Control Language)**
    - **Função:** Gerenciar permissões e acesso ao banco (segurança).
    - **Comandos:**
        - `GRANT` (Conceder permissão);
        - `REVOKE` (Remover permissão);
- **TCL (Transaction Control Language)**
    - **Função:** Gerenciar transações para garantir a consistência dos dados (Conceito de ACID).
    - **Comandos:**
        - `COMMIT` (Confirmar/Salvar a transação);
        - `ROLLBACK` (Desfazer a transação).

---

# Fases do Projeto de BD e Análise de Requisitos

## O que é "Projetar" um Banco de Dados?

É o processo de criar a "planta baixa" (o design) do banco de dados antes de escrever qualquer código SQL.

Um bom projeto economiza tempo, recursos e evita retrabalho.

## As 4 Fases do Projeto de BD

1. **Fase:** Análise de Requisitos (O que o cliente precisa?)
2. **Fase:** Estruturação dos Dados (Quais tabelas e colunas?)
3. **Fase:** Criação de Relacionamentos (Como as tabelas se conectam?)
4. **Fase:** Normalização (Como otimizar a estrutura?)

---
