# Métodos de Autenticação no SQL Server

A autenticação é o processo de verificar a identidade de um principal (usuário, serviço ou computador) que tenta se conectar a uma instância do SQL Server. O SQL Server oferece dois modos principais de autenticação, que podem ser configurados durante a instalação ou posteriormente.

---

### Modo de Autenticação Misto (Mixed Mode)

Quando o SQL Server é configurado em "Mixed Mode", ele aceita ambos os métodos de autenticação: Autenticação do Windows e Autenticação do SQL Server.

---

### 1. Autenticação do Windows (Windows Authentication)

Neste modo, o SQL Server confia na autenticação realizada pelo sistema operacional Windows. A identidade do usuário é validada pelo Active Directory (AD) ou pela conta local do Windows.

- **Como funciona**:
  1.  O usuário faz login no Windows com suas credenciais (usuário e senha).
  2.  Ao tentar se conectar ao SQL Server, o driver do cliente passa um "token" de segurança do Windows para a instância.
  3.  O SQL Server valida esse token para confirmar a identidade do usuário. Não há troca de senhas pela rede para o SQL Server.

- **Vantagens**:
  - **Segurança Aprimorada**: As senhas não são transmitidas pela rede nem armazenadas no SQL Server. A política de senhas (complexidade, expiração) é centralizada e gerenciada pelo Windows/Active Directory.
  - **Single Sign-On (SSO)**: O usuário não precisa digitar credenciais novamente para acessar o banco de dados, proporcionando uma experiência mais fluida.
  - **Gerenciamento Simplificado**: A administração de usuários e grupos é feita no Active Directory, facilitando o controle de acesso em ambientes corporativos.

- **Quando usar**: É o método **recomendado** e considerado a melhor prática para a maioria dos ambientes, especialmente em redes corporativas com domínio Windows.

**Criação de Logon (Windows Authentication):**
```sql
-- Concede acesso à instância para um usuário ou grupo do Windows
CREATE LOGIN [DOMINIO\NomeUsuario] FROM WINDOWS;
CREATE LOGIN [DOMINIO\GrupoDeUsuarios] FROM WINDOWS;
```

---

### 2. Autenticação do SQL Server (SQL Server Authentication)

Neste modo, o SQL Server gerencia seu próprio conjunto de nomes de usuário e senhas. As credenciais são armazenadas dentro do próprio banco de dados mestre.

- **Como funciona**:
  1.  O usuário fornece um nome de usuário (`login name`) e uma senha (`password`) ao se conectar.
  2.  O SQL Server verifica se essas credenciais correspondem a um logon do SQL Server armazenado em seus metadados.

- **Vantagens**:
  - **Portabilidade**: Permite que usuários de sistemas operacionais não-Windows (como Linux ou macOS) ou aplicações legadas se conectem ao banco de dados.
  - **Simplicidade para Ambientes Heterogêneos**: Útil quando não há um domínio do Active Directory ou quando a aplicação não pode se integrar com a autenticação do Windows.

- **Desvantagens**:
  - **Menos Seguro**: As credenciais (embora hasheadas) são armazenadas no SQL Server e precisam ser transmitidas pela rede (a criptografia da conexão é vital).
  - **Gerenciamento de Senhas**: Requer que o DBA gerencie políticas de senha (expiração, complexidade) dentro do SQL Server.
  - **Risco de Conexões Hard-coded**: Desenvolvedores podem ser tentados a embutir senhas diretamente no código da aplicação, o que é uma péssima prática de segurança.

- **Quando usar**:
  - Aplicações web onde os usuários finais não possuem contas no domínio.
  - Ambientes de TI mistos ou sem um domínio centralizado.
  - Necessidade de um login específico para um serviço ou aplicação.

**Criação de Logon (SQL Server Authentication):**
```sql
-- Cria um logon com usuário e senha gerenciados pelo SQL Server
CREATE LOGIN MeuLoginSQL WITH PASSWORD = 'SenhaForte&123';
```
