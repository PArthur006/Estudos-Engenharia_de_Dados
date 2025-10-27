# Proteção de Dados: Criptografia no SQL Server

A criptografia é o processo de codificar dados para que apenas partes autorizadas possam lê-los. No SQL Server, a criptografia é uma defesa em profundidade essencial para proteger dados sensíveis contra acesso não autorizado, tanto em trânsito (na rede) quanto em repouso (nos arquivos de dados).

---

### 1. Hierarquia de Criptografia

O SQL Server usa uma hierarquia de chaves para implementar a criptografia. Cada camada criptografa a camada abaixo dela, criando uma "cadeia" de proteção.

1.  **Service Master Key (SMK)**: A raiz da hierarquia. É gerada automaticamente quando a instância do SQL Server é instalada. Ela é protegida pela API de Proteção de Dados do Windows (DPAPI) e está ligada à conta de serviço do SQL Server.
2.  **Database Master Key (DMK)**: Uma chave simétrica criada em um banco de dados específico e protegida (criptografada) pela SMK. Ela serve como base para a criação de certificados e outras chaves dentro daquele banco de dados.
3.  **Certificados ou Chaves Assimétricas**: São pares de chaves (pública e privada) protegidos pela DMK. Eles são usados para proteger outras chaves ou dados.
4.  **Chaves Simétricas**: Chaves de uso final, protegidas por certificados ou chaves assimétricas. Elas são usadas para criptografar e descriptografar os dados diretamente, pois são mais rápidas para operações em massa.

---

### 2. Conceitos Fundamentais

#### a) Chave Simétrica
Utiliza a **mesma chave** tanto para criptografar quanto para descriptografar os dados.
- **Vantagem**: Muito rápida e eficiente, ideal para criptografar grandes volumes de dados.
- **Desvantagem**: A distribuição segura da chave é um desafio. Se a chave for comprometida, a segurança dos dados é perdida.

#### b) Chave Assimétrica
Utiliza um par de chaves matematicamente relacionadas: uma **chave pública** e uma **chave privada**.
- A chave pública é usada para criptografar os dados e pode ser distribuída livremente.
- A chave privada é mantida em segredo e é a única que pode descriptografar os dados.
- **Vantagem**: Resolve o problema da distribuição de chaves.
- **Desvantagem**: É computacionalmente mais lenta que a criptografia simétrica.

#### c) Certificado
Um certificado digital é um contêiner que agrupa uma chave pública com informações de identidade (como nome, data de validade, etc.), assinado por uma autoridade de certificação (ou autoassinado). No SQL Server, um certificado é essencialmente um wrapper para uma chave assimétrica.

---

### 3. TDE (Transparent Data Encryption)

A **Transparent Data Encryption (TDE)** é uma tecnologia que criptografa os arquivos de dados (`.mdf`), de log (`.ldf`) e de backup (`.bak`) do SQL Server em repouso.

- **"Transparente"**: A criptografia e a descriptografia ocorrem em tempo real, de forma transparente para a aplicação. A aplicação continua a enviar e receber dados como se não estivessem criptografados. O SQL Server gerencia todo o processo.

- **Como funciona**:
  1.  Um certificado ou uma chave assimétrica é criado no banco de dados `master`.
  2.  Uma chave de criptografia de banco de dados (**Database Encryption Key - DEK**) é criada no banco de dados do usuário e protegida pelo certificado no `master`.
  3.  A TDE é ativada para o banco de dados. A DEK é então usada para criptografar todo o conteúdo do banco de dados no disco.

- **Propósito**: Proteger os dados contra acesso não autorizado aos arquivos físicos. Se um invasor roubar os discos rígidos ou os arquivos de backup, os dados estarão ilegíveis sem as chaves de criptografia.

- **Importante**:
  - A TDE **não** protege dados em trânsito (na rede). Para isso, é necessário usar SSL/TLS.
  - A TDE **não** protege contra um DBA ou usuário com altas permissões que acessa os dados através de uma conexão SQL normal, pois a descriptografia é transparente para eles.
  - É **crucial** fazer backup do certificado e da chave mestra que protegem a DEK. Sem eles, a restauração do banco de dados em outro servidor será impossível.

**Comandos básicos para ativar a TDE:**
```sql
-- No banco de dados master
USE master;
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'SenhaForteParaMasterKey!';
CREATE CERTIFICATE MeuCertificadoTDE WITH SUBJECT = 'Certificado para TDE';

-- No banco de dados do usuário
USE MeuBancoDeDados;
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE MeuCertificadoTDE;

-- Ativa a TDE
ALTER DATABASE MeuBancoDeDados SET ENCRYPTION ON;
```
