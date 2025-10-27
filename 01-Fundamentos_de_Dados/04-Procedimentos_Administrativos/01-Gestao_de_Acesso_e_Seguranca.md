# Gestão de Acesso: Logons e Usuários

No SQL Server, a segurança é gerenciada em dois níveis principais: o nível da instância (servidor) e o nível do banco de dados. Entender a diferença entre **Logons** e **Usuários** é fundamental para administrar o acesso corretamente.

---

### 1. Logons (Nível da Instância)

Um **Logon** é uma entidade de segurança no nível da instância do SQL Server. Ele concede a uma "principal" (uma pessoa, um grupo ou um serviço) a permissão para se **conectar** à instância do SQL Server.

- **Escopo**: Instância inteira.
- **Propósito**: Autenticar a identidade de quem está tentando acessar o servidor. Um logon, por si só, não concede acesso a nenhum banco de dados específico (exceto os bancos de dados do sistema, com permissões limitadas).
- **Armazenamento**: As informações sobre logons são armazenadas no banco de dados mestre (`master`).

**Exemplo de Criação de Logon:**
```sql
-- Cria um logon para um usuário com autenticação do SQL Server
CREATE LOGIN MeuLogin WITH PASSWORD = 'SenhaComplexa123';

-- Cria um logon para uma conta do Windows
CREATE LOGIN [DOMINIO\NomeUsuario] FROM WINDOWS;
```

---

### 2. Usuários (Nível do Banco de Dados)

Um **Usuário** (`User`) é uma entidade de segurança no nível do banco de dados. Ele concede a um logon a permissão para **acessar e interagir** com um banco de dados específico.

- **Escopo**: Um único banco de dados.
- **Propósito**: Autorizar o que um logon pode fazer dentro de um banco de dados (ler dados, escrever dados, executar procedures, etc.).
- **Armazenamento**: As informações sobre usuários são armazenadas dentro de cada banco de dados.

**Exemplo de Criação de Usuário:**
```sql
-- Acessa o contexto do banco de dados desejado
USE MeuBancoDeDados;

-- Cria um usuário no banco de dados e o mapeia para um logon existente
CREATE USER MeuUsuario FOR LOGIN MeuLogin;
```

---

### A Relação: Mapeamento entre Logon e Usuário

A conexão entre um logon e um usuário é chamada de **mapeamento**. O processo funciona da seguinte forma:

1.  **Autenticação (Logon)**: Um cliente tenta se conectar à instância do SQL Server. A instância verifica se as credenciais correspondem a um **Logon** válido. Se sim, a conexão é estabelecida.
2.  **Autorização (Usuário)**: Uma vez conectado, o cliente tenta acessar um banco de dados específico (ex: `USE MeuBancoDeDados`). O SQL Server verifica se o **Logon** está mapeado a um **Usuário** dentro daquele banco de dados.
    - Se houver um usuário correspondente, as permissões desse usuário são aplicadas.
    - Se não houver um usuário mapeado, o acesso ao banco de dados é negado.

![Logon -> User Mapping](httpsa://i.imgur.com/your-image-link.png)  *(Nota: Imagem ilustrativa, link não funcional)*

**Analogia:**
- **Logon**: É como o crachá que te dá acesso para entrar no prédio da empresa (a instância).
- **Usuário**: É como a chave que te dá acesso a uma sala específica dentro do prédio (o banco de dados), permitindo que você trabalhe lá dentro.

Essa separação permite um controle de segurança granular. Um DBA pode criar um logon para um desenvolvedor que permite a conexão ao servidor, mas só criar usuários nos bancos de dados de desenvolvimento, impedindo o acesso aos bancos de dados de produção.
