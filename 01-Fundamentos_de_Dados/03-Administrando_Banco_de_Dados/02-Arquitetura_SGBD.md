# Arquitetura do SGBD

A arquitetura de um SGBD é classicamente definida em três níveis (ou esquemas). Esse modelo, conhecido como **Arquitetura ANSI-SPARC**, foi projetado para separar a visão que os usuários têm dos dados da maneira como os dados são fisicamente armazenados.

O objetivo principal é fornecer **independência de dados**.

---

### A Arquitetura de 3 Níveis

#### 1. Nível Externo (ou de Visão)
É o nível mais alto, mais próximo dos usuários. Ele define a **visão particular** que um usuário ou um grupo de usuários tem do banco de dados.

- **O que é**: Consiste em múltiplas "visões" (Views) do banco de dados. Cada `View` define um subconjunto dos dados que é relevante para uma aplicação ou usuário específico.
- **Exemplo**: Em um banco de dados acadêmico, o setor financeiro pode ter uma visão que mostra apenas os dados de mensalidades dos alunos, enquanto um professor tem uma visão que mostra apenas as notas e as turmas que ele leciona.
- **Propósito**:
  - **Simplificação**: Oculta a complexidade do banco de dados, mostrando apenas o que é necessário.
  - **Segurança**: Impede que usuários acessem dados que não lhes dizem respeito.

#### 2. Nível Conceitual (ou Lógico)
Este é o nível da comunidade, que representa o banco de dados completo em termos de sua estrutura lógica. É a visão do Administrador de Dados (AD) e do DBA.

- **O que é**: Descreve **quais** dados estão armazenados e **quais relacionamentos** existem entre eles. É a implementação do modelo de dados (ex: modelo relacional), mostrando todas as entidades, atributos, relacionamentos e restrições.
- **Exemplo**: O diagrama entidade-relacionamento (DER) completo, que depois é mapeado para tabelas, chaves primárias e estrangeiras.
- **Propósito**:
  - Fornecer uma visão unificada e estável da estrutura do banco de dados, independente de como os dados são armazenados fisicamente.

#### 3. Nível Interno (ou Físico)
É o nível mais baixo, que descreve **como** os dados são fisicamente armazenados no disco.

- **O que é**: Detalha as estruturas de armazenamento, como os arquivos de dados (`.mdf`, `.ldf`), os índices (B-Trees), a organização dos registros nas páginas de dados e os caminhos de acesso.
- **Propósito**:
  - Descrever a implementação física para otimizar o desempenho e o uso do espaço.

---

### Independência de Dados

A separação em três níveis permite dois tipos de independência:

- **Independência Lógica de Dados**: A capacidade de modificar o esquema conceitual **sem ter que alterar** os esquemas externos (as aplicações dos usuários). Por exemplo, adicionar uma nova tabela ou um novo atributo a uma tabela existente não deve quebrar as aplicações que não usam essa nova estrutura.

- **Independência Física de Dados**: A capacidade de modificar o esquema interno **sem ter que alterar** o esquema conceitual. Por exemplo, o DBA pode decidir criar um novo índice, alterar a forma como um arquivo é particionado no disco ou mover os dados para um SSD mais rápido. Nenhuma dessas mudanças deve impactar a estrutura lógica do banco (as tabelas e seus relacionamentos) nem as aplicações.
