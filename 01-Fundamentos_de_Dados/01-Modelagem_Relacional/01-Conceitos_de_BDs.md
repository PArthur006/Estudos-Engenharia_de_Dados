# Curso de Modelagem de Dados

#### Fonte: Youtube: Bóson Treinamentos

---

## Aula 01: Conceitos Básicos de Bancos de Dados

### Definições Introdutórias Essenciais

- **Dado:** É a matéria-prima bruta; um fato registrado, sem contexto imediato. (Ex: "João", "25", "São Paulo").
- **Informação:** É o dado processado, organizado e contextualizado, que adquire significado e utilidade. (Ex: "João, 25 anos, mora em São Paulo" - Uma informação sobre uma pessoa).
- **Metadados:** São "dados sobre os dados". Descrevem as características, o formato, o tipo, a origem e o propósito dos dados. São cruciais para entender e gerenciar a informação. (Ex: Para o dado "25", o metadado pode ser "idade", "tipo numérico", "unidade em anos").

### Bancos de Dados e SGBDs

- **Bancos de Dados (BD):** Coleção organizada de dados inter-relacionados que representam um aspecto do mundo real. Permitem o armazenamento e a recuperação eficiente de informações.
- **Sistema Gerenciador de Banco de Dados (SGBD):** Software que permite a criação, manutenção, controle e acesso aos dados de um BD. Ele atua como uma interface entre os usuários/aplicações e o banco de dados. (Ex: MySQL, PostgreSQL, SQL Server, Oracle).
- **Sistema de Bancos de Dados:** É o conjunto completo composto pelo Banco de Dados, o SGBD, os usuários e as aplicações que interagem com ele.

### Aplicações, Usuários e Características

- **Aplicação dos BDs:** Presentes em quase todos os sistemas modernos (comércio eletrônico, sistemas bancários, redes sociais, gestão empresarial, etc), sendo fundamentais para o armazenamento e acesso rápido à informação.
- **Usuários de BDs:** Diversos, incluindo: 
    - **Administradores de Bancos de Dados (DBAs):** Gerenciam e mantém o BD e o SGBD.
    - **Designers de BD:** Criam a estrutura (esquema) do banco.
    - **Programadores/Desenvolvedores:** Criam as aplicações que interagem com o BD.
    - **Usuários Finais:** Interagem com as aplicações para acessar ou inserir dados.
- **Características e Funcionalidades:**
    - **Persistência:** Os dados permanecem armazenados mesmo após o desligamento do sistema.
    - **Segurança:** Controle de acesso e proteção dos dados.
    - **Integridade:** Regras para garantir a correção e consistência dos dados.
    - **Concorrência:** Permite que múltiplos usuários acessem e modifiquem os dados simultaneamente de forma controlada.
    - **Recuperação:** Capacidade de restaurar os dados após falhas.

### Modelos de Bancos de Dados

Os modelos de banco de dados definem como os dados são estruturados e como os relacionamentos entre eles são estabelecidos.

- **a) Modelo Hierárquico:**
    - Estrutura em forma de árvore, com um nó "pai" podendo ter vários nós "filhos", mas cada "filho" tem apenas um "pai".
    - Dados organizados em registros e links.
    - Exemplo: IBM IMS (antigo).
- **b) Modelo de Rede:**
    - Uma evolução do modelo hierárquico. Permite que um nó "filho" tenha múltiplos "pais", formando uma estrutura mais complexa de grafo.
    - Mais flexível que o hierárquico, mas ainda complexo de gerenciar.
- **c) Modelo Relacional (O Mais Utilizado Atualmente):**
    - **Base:** Organiza os dados em tabelas (ou "relações"), que são formadas por linhas (registros/tuplas) e colunas (atributos/campos).
    - **Simplicidade:** Facilidade de compreensão e implementação.
    - **Relacionamentos:** As conexões entre as tabelas são feitas através de valores comuns em colunas (chaves primárias e estrangeiras), o que permite consultas poderosas.
    - **Linguagem Padrão:** Utiliza **SQL (Structured Query Language)** para a manipulação e consulta dos dados, sendo o foco do seu aprendizado.

---
---

## Aula 02: Introdução ao Modelo Relacional

### Modelos e Modelagem de Dados

- **Modelos:** São representações simplificadas de um objeto ou sistema do mundo real. Servem para facilitar a compreensão, a análise e o design.
- **Modelagem de Dados:** É o processo de criar um modelo de dados para um sistema de informação, definindo e analisando os requisitos de dados para suportar os processos de negócio. Essencialmente, é a "planta baixa" do banco de dados.

### O Modelo Relacional em Detalhe

É o modelo mais popular, baseado na organização de dados em tabelas. Sua força está na simplicidade conceitual e no poder da manipulação de dados através de SQL.

- **Componentes de um Banco de Dados Relacional:**
    - **Tabelas (ou Relações):** A estrutura principal. Armazena dados sobre um assunto específico (ex: uma tabela `CLIENTES`, uma tabela `PRODUTOS`).
    - **Tuplas (Linhas ou Registros):** Cada linha em uma tabela, representando uma ocorrência única daquele assunto. (Ex: `nome`, `email`, `idade` na tabela `CLIENTES`).
    - **Relacionamentos:** As conexões lógicas entre as tabelas, estabelecidas através de chaves.
- **Chaves (Keys) - A base dos relacionamentos:**
    - **Chave Primária (Primary Key - PK):** Uma ou mais colunas que identificam de forma **única** cada linha em uma tabela. Não pode ser nula e não pode ter valores repetidos.
    - **Chaves Estrangeiras (Foreign Key - FK):** Uma coluna (ou conjunto de colunas) em uma tabela que estabelece um link para a chave primária de outra tabela. É o que cria o relacionamento.
- **Outros Componentes:**
    - **Índices:** Estruturas que melhoram a velocidade das operações de busca de dados.
    - **Stored Procedures (SP):** Blocos de código SQL pré-compilados que podem ser executados.
    - **Triggers:** Procedimentos que são executados automaticamente em resposta a certos eventos (INSERT, UPDATE, DELETE).

### Modelo Entidade-Relacionamento (MER)

O MER é uma abordagem conceitual e de alto nível para modelagem de dados. É usado na fase inicial de design para representar visualmente a estrutura do banco de dados através de um **Diagrama Entidade-Relacionamento (DER)**.

- **Componentes do MER:**
    - **Entidade:** Representa um objeto ou conceito do mundo real sobre o qual queremos armazenar dados. Geralmente se torna uma tabela no modelo relacional.
        - **Convenção no Diagrama:** Retângulo.
    - **Atributo:** Uma propriedade ou característica de uma entidade. Geralmente se torna uma coluna na tabela.
        - **Convenção no Diagrama:** Elipse.
    - **Relacionamento:** Representa a associação entre duas ou mais entidades.
        - **Convenção no Diagrama:** Losango.
- **Conceitos Adicionais do MER:**
    - **Cardinalidade:** Define a quantidade de ocorrências de uma entidade que podem se relacionar com as ocorrências de outra. Descreve o "número" do relacionamento.
    - **Identificador Único (UID):** É um ou mais atributos que identificam unicamente uma instância da entidade. No modelo relacional, o UID geralmente se torna a Chave Primária (PK).

---
---

