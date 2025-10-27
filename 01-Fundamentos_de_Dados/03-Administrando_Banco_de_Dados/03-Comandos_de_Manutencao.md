# Comandos de Manutenção em Banco de Dados

Comandos de manutenção são essenciais para garantir a integridade, o desempenho e a saúde geral de um banco de dados. Eles permitem que DBAs (Administradores de Banco de Dados) verifiquem e corrijam problemas, gerenciem o espaço em disco e otimizem a performance.

---

### 1. `CHECKPOINT`

O comando `CHECKPOINT` força a gravação de todas as páginas de dados "sujas" (modificadas em memória, mas ainda não salvas em disco) do buffer cache para os arquivos de dados físicos.

- **Propósito**: Garante que as modificações sejam persistidas em disco, minimizando o tempo de recuperação em caso de uma falha.
- **Uso**: Embora o SQL Server execute checkpoints automaticamente, um DBA pode forçar um checkpoint manual para controlar o impacto no I/O (Entrada/Saída) do disco.

```sql
CHECKPOINT;
```

---

### 2. `DBCC` (Database Console Commands)

`DBCC` é um conjunto de comandos usados para tarefas de manutenção, validação e verificação de status do banco de dados.

#### `DBCC CHECKDB`
Verifica a integridade lógica e física de todos os objetos no banco de dados especificado.

- **Propósito**: Detectar corrupção de dados. É uma das ferramentas de manutenção mais importantes.
- **Uso**:
  ```sql
  -- Verifica o banco de dados atual
  DBCC CHECKDB;

  -- Verifica um banco de dados específico e tenta reparar problemas encontrados
  DBCC CHECKDB ('NomeDoBanco') WITH REPAIR_REBUILD;
  ```

#### `DBCC SHRINKFILE` e `DBCC SHRINKDATABASE`
Reduzem o tamanho dos arquivos de dados ou de log.

- **Propósito**: Liberar espaço em disco não utilizado dentro dos arquivos do banco de dados.
- **Atenção**: O uso excessivo de `SHRINK` pode causar fragmentação de índices, prejudicando o desempenho. Deve ser usado com cautela.
- **Uso**:
  ```sql
  -- Reduz o tamanho de um arquivo de dados específico para 1024 MB (1 GB)
  DBCC SHRINKFILE (NomeArquivoLogico, 1024);

  -- Tenta reduzir o tamanho de todo o banco de dados
  DBCC SHRINKDATABASE (NomeDoBanco);
  ```

---

### 3. `sp_spaceused`

É uma stored procedure de sistema que exibe o espaço em disco reservado e utilizado por uma tabela, índice ou por todo o banco de dados.

- **Propósito**: Analisar o consumo de espaço, permitindo identificar tabelas grandes ou espaço não utilizado.
- **Uso**:
  ```sql
  -- Exibe o espaço usado pelo banco de dados atual
  EXEC sp_spaceused;

  -- Exibe o espaço usado por uma tabela específica
  EXEC sp_spaceused 'NomeDaTabela';
  ```

- **Colunas de Saída Principais**:
  - `database_size`: Tamanho total do banco de dados.
  - `unallocated space`: Espaço no banco de dados que não está reservado para objetos.
  - `reserved`: Espaço total alocado para objetos.
  - `data`: Espaço usado pelos dados.
  - `index_size`: Espaço usado pelos índices.
  - `unused`: Espaço reservado para objetos, mas ainda não utilizado.
