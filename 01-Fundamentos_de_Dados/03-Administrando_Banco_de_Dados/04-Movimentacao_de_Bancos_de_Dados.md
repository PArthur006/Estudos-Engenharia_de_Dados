# Movimentação de Bancos de Dados: Attach e Detach

"Attach" (Anexar) e "Detach" (Desanexar) são operações administrativas que permitem mover um banco de dados de uma instância do SQL Server para outra. Esse processo envolve desconectar os arquivos de dados (`.mdf`) e de log (`.ldf`) de uma instância e, em seguida, conectá-los a outra.

---

### 1. Detach (Desanexar um Banco de Dados)

O processo de "detach" remove o banco de dados da instância do SQL Server, mas mantém seus arquivos de dados e de log intactos no sistema de arquivos.

- **Propósito**: Preparar um banco de dados para ser movido para outro servidor ou para arquivamento.
- **Pré-requisitos**:
  - O banco de dados não pode estar em uso (sem conexões ativas).
  - É recomendável fazer um backup antes de iniciar o processo.

#### Como Fazer o Detach:

**Via SQL (T-SQL):**
A forma mais comum e controlada é usando a stored procedure `sp_detach_db`.

```sql
-- Garante que não há conexões ativas, revertendo transações pendentes
ALTER DATABASE NomeDoBanco SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

-- Desanexa o banco de dados
EXEC sp_detach_db 'NomeDoBanco';
```

**Via SSMS (SQL Server Management Studio):**
1.  Clique com o botão direito no banco de dados.
2.  Vá em `Tasks` > `Detach...`.
3.  Na janela que se abre, marque a opção `Drop Connections` para forçar o fechamento de conexões ativas.
4.  Clique em `OK`.

Após o detach, os arquivos `.mdf` e `.ldf` estão livres para serem movidos, copiados ou arquivados.

---

### 2. Attach (Anexar um Banco de Dados)

O processo de "attach" registra um banco de dados em uma instância do SQL Server usando seus arquivos de dados e de log existentes.

- **Propósito**: Adicionar um banco de dados (que foi previamente desanexado ou copiado) a uma nova instância do SQL Server.
- **Pré-requisitos**:
  - Os arquivos `.mdf` e `.ldf` devem estar acessíveis no sistema de arquivos do novo servidor.
  - As permissões de acesso aos arquivos devem ser concedidas à conta de serviço do SQL Server.

#### Como Fazer o Attach:

**Via SQL (T-SQL):**
É a forma mais explícita, permitindo especificar os caminhos dos arquivos.

```sql
-- Anexa um banco de dados especificando os arquivos de dados e de log
CREATE DATABASE NomeDoBanco
ON (FILENAME = 'C:\Caminho\Para\SeuBanco.mdf'),
   (FILENAME = 'C:\Caminho\Para\SeuBanco_log.ldf')
FOR ATTACH;
```

**Via SSMS (SQL Server Management Studio):**
1.  Clique com o botão direito na pasta `Databases` no Object Explorer.
2.  Selecione `Attach...`.
3.  Na janela `Attach Databases`, clique em `Add...`.
4.  Navegue até o local do arquivo `.mdf` e selecione-o. O SSMS geralmente localiza o arquivo `.ldf` correspondente automaticamente.
5.  Verifique se os detalhes do banco de dados na grade estão corretos.
6.  Clique em `OK`.

A movimentação via Attach/Detach é ideal para migrações de servidores, atualizações de versão do SQL Server ou para entregar uma cópia de um banco de dados a terceiros.
