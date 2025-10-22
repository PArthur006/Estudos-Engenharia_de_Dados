## Aula 01: Conceitos Básicos de Bancos de Dados

### Definições Introdutórias Essenciais

- **Dado:** É a matéria-prima bruta; um fato registrado, sem contexto imediato. (Ex: "João", "25", "São Paulo").
- **Informação:** É o dado processado, organizado e contextualizado, que adquire significado e utilidade. (Ex: "João, 25 anos, mora em São Paulo" - Uma informação sobre uma pessoa).
- **Metadados:** São "dados sobre os dados". Descrevem as características, o formato, o tipo, a origem e o propósito dos dados. São cruciais para entender e gerenciar a informação. (Ex: Para o dado "25", o metadado pode ser "idade", "tipo numérico", "unidade em anos").

### Conceitos Fundamentais

- **Modelagem de Dados:** Uma metodologia para determinar as Regras de Negócio (RN) e a arquitetura de um Banco de Dados (BD). Ela descreve as estruturas lógicas e físicas do banco.
- **Minimundo:** A representação da realidade ou o escopo do projeto que será modelado. Mudanças no minimundo são replicadas no banco de dados.
- **Abstração:** Uma representação mental da realidade que foi mapeada a partir do minimundo. É o processo de omitir detalhes desnecessários para focar nos essenciais.

### Bancos de Dados e SGBDs

- **Bancos de Dados (BD):** Coleção organizada de dados inter-relacionados que representam um aspecto do mundo real. Permitem o armazenamento e a recuperação eficiente de informações.
- **Sistema Gerenciador de Banco de Dados (SGBD):** Software que permite a criação, manutenção, controle e acesso aos dados de um BD. Ele atua como uma interface entre os usuários/aplicações e o banco de dados. (Ex: MySQL, PostgreSQL, SQL Server, Oracle).
- **Sistema de Bancos de Dados:** É o conjunto completo composto pelo Banco de Dados, o SGBD, os usuários e as aplicações que interagem com ele.
- **Funções Principais:**
    - Armazenamento e recuperação de dados.
    - Segurança contra acessos não permitidos.
    - Proteção contra falhas de sistema ou hardware.
    - Gerenciamento do acesso concorrente de múltiplos usuários e aplicações.
- **Quatro Elementos Principais de um SGBD:**
    1. **Dados:** As informações armazenadas.
    2. **Software:** A camada de programas (o próprio SGBD) que fica entre os usuários e os dados físicos.
    3. **Hardware:** Os dispositivos de memória secundária (discos, etc.) onde os dados residem.
    4. **Usuários:**
        - **Programador:** Escreve as aplicações que consomem o banco de dados.
        - **Usuário Final:** Acessa o banco através das aplicações ou linguagens de consulta.
        - **DBA (Administrador de Banco de Dados):** Gerencia o banco de dados.

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

### Arquiteturas de Banco de Dados

Bancos de dados podem ser categorizados por sua arquitetura:

- **Centralizada:** Todos os dados em um único local.
- **Descentralizada:** Dados distribuídos em múltiplos locais, mas sem integração.
- **Distribuída:** Dados distribuídos em múltiplos locais, mas gerenciados como um todo lógico.
- **Replicada:** Cópias dos dados são mantidas em diferentes locais.

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

## Aula 07: Comparando Entidades e Relações

### O Paralelo: Entidade vs. Relação

Uma **Entidade** (Conceito) se torna uma **Relação** (estrutura de dados) quando passamos do modelo conceitual para o modelo lógico.

- **Entidade:** É um conceito do mundo real que queremos representar. É um objeto, pessoa, lugar ou evento sobre o qual armazenamos informações. Pertence ao **Modelo Conceitual**.
    - Exemplo: A ideia de um `CLIENTE` ou de um `PRODUTO`.
- **Relação:** É a implementação lógica de uma entidade são efetivamente guardados. Pertence ao **Modelo Lógico/Físico**.
    - Exemplo: A tabela `tb_clientes` ou `tb_produtos`.

### Anatomia e Características de uma Relação

Uma relação é a estrutura fundamental ao Modelo Relacional e possui regras e componentes bem definidos:

- **Linhas (Tuplas ou Registros):**
    - Representam uma **ocorrência/instância única** de uma entidade.
    - Exemplo: Em uma Relação `CLIENTES`, cada linha representa um cliente específico.
- **Colunas (Atributos ou Campos):**
    - Representam uma **propriedade ou característica** da entidade.
    - Exemplo: Na relação `CLIENTES`, as colunas seriam `ID_Cliente`, `Nome`, `Email`, `Data_Nascimento`.
- **Características Fundamentais de uma Relação:**
    1. **Nome Único:** Cada Relação em um banco de dados deve ter um nome que a identifique unicamente.
    2. **Valores Atômicos:** A intersecção de uma linha com uma coluna (uma célula) deve conter um **único valor**, não podendo ser uma lista ou um conjunto de valores.
    3. **Colunas com Nomes Únicos:** Dentro de uma mesma Relação, todas as colunas devem ter nomes diferentes.
    4. **Ordem das Colunas Irrelevante:** A ordem em que as colunas são definidas não afeta os dados ou o significado da Relação.
    5. **Ordem das Linhas Irrelevante:** A ordem em que as linhas são armazenadas não tem significado. Consultas podem retornar os dados em qualquer ordem, a menos que uma ordenação seja especificada (`ORDER BY`).
    6. **Não há Linhas Duplicadas:** Cada linha em uma Relação deve ser única, o que é garantido pela existência de uma **Chave Primária**.

---
---


---
---

## Aula 11: Restrições de Integridade

Restrições de Integridade são um conjunto de regras e validações aplicadas ao banco de dados para garantir a **qualidade, consistência, precisão e validade** dos dados armazenados. Elas evitam que dados incorretos ou inconsistentes sejam inseridos, atualizados ou excluídos.

### Tipos de Restrições

1. **Integridade de Domínio:** Garante que todos os valores em uma determinada coluna sejam válidos, pertencendo ao seu domínio pré-definido.
    - **Fatores do Domínio:**
        - Tipo de dado, tamanho, formato, restrições.
2. **Integridade Referencial:** Garante a validade dos **relacionamentos** entre as tabelas. É a regra que governa as chaves estrangeiras.
    - **Regra Fundamental:** O valor de uma chave estrangeira em uma tabela deve corresponder a um valor de chave primária existente na tabela referenciada, ou ser nulo (se permitido).
    - **Ações em Atualização e Exclusão:** Define o que acontece com os registros "filhos" quando o registro "pai" é alterado ou removido.
        - **RESTRICT / NO ACTION:** Impede a alteração/exclusão do registor pai se existirem registros filhos associados. É a opção mais segura e comum.
        - **CASCADE:** A alteração/exclusão do registro pai é propagada para todos os registros filhos associados (se o pai for excluído, os filhos também são).
        - **SET NULL:** Se o registro pai for alterado/excluído, o valor da FK nos registros filhos é definido como `NULL`.
3. **Integridade de Vazio (`NOT NULL`):** Determina se uma coluna específica pode ou não aceitar valores nulos.
    - **Valor Nulo (NULL):** Representa um valor ausente, desconhecido ou não aplicável. Não é a mesma coisa que zero(`0`) ou um texto vazio (`' '`).
    - **Aplicação:** Colunas que são essenciais para identificar ou descrever um registro, como uma chave primária ou um CPF, geralmente são definidas como `NOT NULL`.
4. **Integridade de Chave:** Garante que cada linha em uma tabela possa ser identificada de forma única.
    - **Regra Fundamental:** A chave primária de uma tabela deve ser única e não nula. O SGBD impõe essa regra automaticamente.
5. **Integridade Definida Pelo Usuário:** São regras específicas do negócio que não se encaixam nas categorias anteriores.
    - Geralmente são implementadas através de `CHECK constraints`, `Triggers` ou `Sotred Procedures`.
    - Exemplo: O salário de um funcionário não pode ser negativo.

---
---
