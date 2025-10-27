# Monitoramento de Banco de Dados

Monitorar um banco de dados é crucial para garantir desempenho, disponibilidade e segurança. Um bom monitoramento permite identificar gargalos, prever problemas de capacidade, analisar a atividade dos usuários e diagnosticar erros.

---

### 1. Ferramentas e Técnicas de Monitoramento

#### a) Activity Monitor (SSMS)
O **Activity Monitor**, integrado ao SQL Server Management Studio (SSMS), oferece uma visão geral e em tempo real da atividade na instância do SQL Server.

- **Como acessar**: Clique com o botão direito na instância no Object Explorer e selecione `Activity Monitor`.
- **Seções Principais**:
  - **Overview**: Gráficos de `% Processor Time`, `Waiting Tasks`, `Database I/O` e `Batch Requests/sec`.
  - **Processes**: Lista de todas as conexões ativas, mostrando quem está conectado, de onde, e o que está executando. Útil para identificar sessões bloqueadoras (`blocking`).
  - **Resource Waits**: Mostra os principais tipos de "esperas" que as threads estão enfrentando (ex: `CXPACKET`, `PAGEIOLATCH_SH`), ajudando a diagnosticar gargalos de CPU, I/O ou contenção.
  - **Data File I/O**: Exibe a atividade de leitura e escrita por arquivo de banco de dados.
  - **Recent Expensive Queries**: Lista as consultas mais custosas executadas recentemente, com base no uso de CPU, I/O e duração.

#### b) Dynamic Management Views (DMVs) e Functions (DMFs)
DMVs e DMFs são views e funções de sistema que expõem o estado interno do SQL Server. Elas são a base para a maioria das ferramentas de monitoramento e permitem diagnósticos profundos via T-SQL.

- **Propósito**: Fornecem dados detalhados sobre sessões, transações, esperas, uso de memória, planos de execução e muito mais.
- **Exemplos de DMVs Populares**:
  - `sys.dm_exec_requests`: Mostra as requisições atualmente em execução.
  - `sys.dm_os_wait_stats`: Agrega estatísticas de esperas desde que a instância foi iniciada. Essencial para análise de desempenho.
  - `sys.dm_exec_query_stats`: Fornece estatísticas de desempenho agregadas para planos de consulta em cache (ex: qual consulta consumiu mais CPU no total).
  - `sys.dm_db_index_usage_stats`: Mostra como os índices estão sendo usados (leituras, escritas, buscas).

**Exemplo de Consulta com DMV:**
```sql
-- Top 5 tipos de esperas na instância
SELECT TOP 5 wait_type, waiting_tasks_count, wait_time_ms
FROM sys.dm_os_wait_stats
WHERE wait_type NOT LIKE 'SLEEP%' -- Filtra esperas "ociosas"
ORDER BY wait_time_ms DESC;
```

#### c) SQL Server Profiler e Extended Events

- **SQL Server Profiler**: Uma ferramenta gráfica que permite capturar um "trace" (rastreamento) de eventos que ocorrem na instância do SQL Server. É útil para depurar problemas específicos, mas **está obsoleto** e tem um alto custo de desempenho em ambientes de produção.
- **Extended Events (XEvents)**: É o sistema de rastreamento moderno, leve e altamente escalável que substitui o Profiler. É a ferramenta recomendada para monitoramento e auditoria de eventos. Permite capturar dados de eventos de forma muito mais eficiente e com menor impacto no desempenho.

---

### 2. Geração de Relatórios de Log

O **SQL Server Log**, também conhecido como Error Log, é um arquivo de texto que registra eventos importantes, erros e mensagens informativas sobre a instância.

- **Propósito**: É o primeiro lugar a se olhar para diagnosticar falhas na inicialização, problemas de hardware, erros de corrupção e outros eventos críticos.
- **Como acessar**:
  - **Via SSMS**: No Object Explorer, vá em `Management` > `SQL Server Logs`.
  - **Via T-SQL**: Use a stored procedure `sp_readerrorlog`.
    ```sql
    -- Lê o log de erro atual
    EXEC sp_readerrorlog;

    -- Lê o log de erro anterior (arquivo .1)
    EXEC sp_readerrorlog 1;
    ```

O monitoramento contínuo usando essas ferramentas permite que um DBA seja proativo, resolvendo problemas antes que eles afetem os usuários finais.
