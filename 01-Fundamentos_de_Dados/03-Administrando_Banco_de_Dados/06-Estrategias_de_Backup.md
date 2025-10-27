# Estratégias de Backup e Restore

Uma estratégia de backup e restauração bem definida é o pilar da recuperação de desastres (Disaster Recovery) de qualquer banco de dados. Ela garante que os dados possam ser recuperados em caso de falha de hardware, corrupção de dados ou erro humano.

---

### 1. Tipos de Backup

#### a) Backup Completo (Full Backup)
Cria uma cópia completa do banco de dados. Inclui todos os objetos, dados e uma porção do log de transações para garantir a consistência.

- **Características**:
  - **Base para outros backups**: É o ponto de partida para backups diferenciais e de log.
  - **Restauração simples**: Requer apenas um arquivo (o backup completo mais recente) para restaurar o banco de dados.
  - **Consumo**: Demora mais tempo para ser criado e ocupa mais espaço em disco.
- **Quando usar**: Geralmente agendado para períodos de baixa atividade (ex: semanalmente ou diariamente à noite).

**Comando T-SQL:**
```sql
BACKUP DATABASE NomeDoBanco
TO DISK = 'C:\Caminho\Backup\NomeDoBanco_Full.bak';
```

#### b) Backup Diferencial (Differential Backup)
Copia apenas as extensões de dados que foram modificadas desde o último backup **completo**.

- **Características**:
  - **Mais rápido que o Full**: Copia menos dados.
  - **Economiza espaço**: O arquivo gerado é menor que um backup completo.
  - **Restauração em duas etapas**: Para restaurar, você precisa do **último backup completo** e do **último backup diferencial**.
- **Quando usar**: Frequentemente entre backups completos (ex: a cada poucas horas) para reduzir a perda de dados potencial.

**Comando T-SQL:**
```sql
BACKUP DATABASE NomeDoBanco
TO DISK = 'C:\Caminho\Backup\NomeDoBanco_Diff.bak'
WITH DIFFERENTIAL;
```

#### c) Backup de Log de Transações (Transaction Log Backup)
Copia os registros do log de transações que foram gerados desde o último backup de log. Este tipo de backup só é possível em modelos de recuperação `FULL` ou `BULK_LOGGED`.

- **Características**:
  - **Recuperação Point-in-Time**: Permite restaurar o banco de dados para um ponto específico no tempo (ex: até um minuto antes do erro).
  - **Pequeno e rápido**: Geralmente são muito rápidos de criar e geram arquivos pequenos.
- **Quando usar**: Realizado com alta frequência (ex: a cada 5, 10 ou 15 minutos) para minimizar a perda de dados.

**Comando T-SQL:**
```sql
BACKUP LOG NomeDoBanco
TO DISK = 'C:\Caminho\Backup\NomeDoBanco_Log.trn';
```

---

### 2. Processo de Restauração (Restore)

Restaurar um banco de dados envolve aplicar os backups para trazê-lo de volta a um estado consistente.

#### Cenário de Restauração (usando Full + Differential):

1.  **Restaure o último Backup Completo**: Este é o primeiro passo. Use a opção `WITH NORECOVERY` para indicar que mais backups serão aplicados.
    ```sql
    RESTORE DATABASE NomeDoBanco
    FROM DISK = 'C:\Caminho\Backup\NomeDoBanco_Full.bak'
    WITH NORECOVERY;
    ```

2.  **Restaure o último Backup Diferencial**: Aplique o backup diferencial mais recente criado após o backup completo. Use `WITH NORECOVERY` se ainda for aplicar logs de transação.
    ```sql
    RESTORE DATABASE NomeDoBanco
    FROM DISK = 'C:\Caminho\Backup\NomeDoBanco_Diff.bak'
    WITH NORECOVERY;
    ```

3.  **(Opcional) Aplique Backups de Log**: Se houver backups de log, aplique-os em sequência, do mais antigo para o mais novo.

4.  **Recupere o Banco de Dados**: Após aplicar o último backup, recupere o banco de dados para torná-lo online e acessível.
    ```sql
    RESTORE DATABASE NomeDoBanco WITH RECOVERY;
    ```

A opção `WITH RECOVERY` finaliza o processo de restauração, realiza o "roll forward" e "roll back" de transações e torna o banco de dados operacional.
