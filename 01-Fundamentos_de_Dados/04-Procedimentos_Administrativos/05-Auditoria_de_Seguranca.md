# Auditoria de Segurança no SQL Server

Auditoria de segurança é o processo de rastrear e registrar eventos que ocorrem em uma instância do SQL Server ou em um banco de dados específico. O objetivo é responder à pergunta "quem fez o quê, quando e onde?". A auditoria é fundamental para conformidade com regulamentações (como LGPD, SOX, HIPAA), detecção de atividades suspeitas e análise forense.

---

### 1. SQL Server Audit

**SQL Server Audit** é a solução principal e mais robusta para auditoria no SQL Server. É uma ferramenta flexível, de alto desempenho e permite a criação de políticas de auditoria granulares.

- **Componentes**:
  1.  **Audit Object (Auditoria)**: Define o destino onde os logs de auditoria serão gravados (arquivo, log de eventos do Windows ou log de segurança).
  2.  **Server Audit Specification (Especificação de Auditoria do Servidor)**: Define quais eventos no nível da instância serão auditados (ex: logins falhos, alterações de permissão no servidor). Só pode haver uma por auditoria.
  3.  **Database Audit Specification (Especificação de Auditoria do Banco de Dados)**: Define quais eventos no nível do banco de dados serão auditados (ex: `SELECT` em uma tabela de salários, `DELETE` em uma tabela de clientes). Pode haver várias por banco de dados.

- **Vantagens**:
  - **Desempenho**: Projetado para ter um impacto mínimo no desempenho.
  - **Flexibilidade**: Permite auditar ações específicas em objetos específicos (ex: auditar apenas `UPDATE` na tabela `Funcionarios` pelo usuário `Admin`).
  - **Segurança**: O log de auditoria pode ser gravado em um local seguro e separado.
  - **Centralização**: Facilita o gerenciamento da auditoria em toda a instância.

**Exemplo de Configuração:**
```sql
-- 1. Criar a Auditoria (destino)
CREATE SERVER AUDIT AuditoriaGeral
TO FILE (FILEPATH = 'C:\SQLAudits\');

-- 2. Criar a Especificação de Auditoria do Servidor
CREATE SERVER AUDIT SPECIFICATION AuditoriaLogins
FOR SERVER AUDIT AuditoriaGeral
ADD (FAILED_LOGIN_GROUP),
ADD (SUCCESSFUL_LOGIN_GROUP);

-- 3. Criar a Especificação de Auditoria do Banco de Dados
USE MeuBancoDeDados;
CREATE DATABASE AUDIT SPECIFICATION AuditoriaTabelaSalarios
FOR SERVER AUDIT AuditoriaGeral
ADD (SELECT, UPDATE ON dbo.Salarios BY public)
WITH (STATE = ON);

-- 4. Ativar a auditoria
ALTER SERVER AUDIT AuditoriaGeral WITH (STATE = ON);
```

---

### 2. Extended Events (XEvents)

Embora seu foco principal seja o monitoramento de desempenho, os **Extended Events** são leves e eficientes o suficiente para serem usados em cenários de auditoria, especialmente para capturar eventos muito específicos com baixo overhead.

---

### 3. DDL Triggers

Triggers de DDL (Data Definition Language) podem ser usados para capturar e registrar alterações na estrutura do banco de dados ou do servidor (eventos `CREATE`, `ALTER`, `DROP`).

- **Propósito**: Criar um log personalizado de quem está modificando a estrutura dos objetos.
- **Exemplo**:
  ```sql
  CREATE TRIGGER AuditSchemaChanges
  ON DATABASE
  FOR DDL_DATABASE_LEVEL_EVENTS
  AS
  BEGIN
      DECLARE @data XML = EVENTDATA();
      INSERT INTO dbo.LogDeAuditoriaDDL (EventType, ObjectName, LoginName, EventData)
      VALUES (
          @data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)'),
          @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(100)'),
          @data.value('(/EVENT_INSTANCE/LoginName)[1]', 'nvarchar(100)'),
          CAST(@data AS nvarchar(MAX))
      );
  END;
  ```

---

### 4. SQL Server Profiler (Obsoleto)

O **SQL Server Profiler** é uma interface gráfica que permite capturar eventos do servidor em um "trace". Embora seja intuitivo para investigações rápidas, ele foi **substituído** pelo SQL Server Audit e Extended Events.

- **Desvantagens**:
  - **Alto Overhead**: Pode degradar significativamente o desempenho de servidores de produção.
  - **Obsoleto**: A Microsoft não recomenda mais seu uso para auditoria contínua e pode remover a ferramenta em versões futuras.
  - **Menos Flexível**: Mais difícil de gerenciar e automatizar em comparação com o SQL Server Audit.

Para qualquer necessidade de auditoria moderna, o **SQL Server Audit** deve ser a primeira escolha.
