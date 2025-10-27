# O Administrador de Banco de Dados (DBA)

## O Papel do DBA (Database Administrator)

É o profissional responsável por **armazenar, organizar e proteger** os dados de uma empresa, utilizando um SGBD (Sistema Gerenciador do Banco de Dados).

## Tarefas Essenciais do DBA

- **Instalação e Configuração:** Instalar o SGBD (Oracle, SQL Server, etc.) e configurar a infraestrutura e os parâmetros do sistema.
- **Do Lógico para o Físico:** Receber o modelo lógico (a "planta baixa") e implementá-lo, criando fisicamente as tabelas e estruturas no banco.
- **Backup e Restore:** Criar e gerenciar a política de cópias de segurança (backups) e ser capaz de restaurar o banco em caso de faha ou desastre.
- **Gestão de Espaço:** Monitorar o crescimento dos arquivos de dados (`.mdf`, `.ldf` no SQL Server; `datafiles` no Oracle) para garantir que há espaço em disco.
- **Gestão de Acesso (Segurança):**
    - Cadastrar usuários (Autenticação).
    - Conceder e revogar privilégios (Autorização). (É aqui que se usa DCL: `GRANT` e `REVOKE`).
- **Gestão de Performance (Tuning):** A tarefa mais nobre. Monitorar o banco para encontrar gargalos e otimizar consultas lentas, ajustar índices, etc.
- **Manutenção:** Reestrutura o banco, aplicar patches de segurança e atualizações.

## DBA vs. Administrador de Dados (AD)

### DBA (Administrador de Banco de Dados)

**Foco: TÉCNICO / FÍSICO**

- **Função:** Cuida da **tecnologia** (o SGBD). Garante performance, backup, segurança, instalação.
- É o "engenheiro" que cuida do motor.

### AD (Administrador de Dados)

**Foco: ESTRATÉGICO / LÓGICO / NEGÓCIO**

- **Função:** Cuida do **dado** como um ativo da empresa. Define modelos conceituais, garante a qualidade da informação, interpreta os dados.
- É o "estrategista" que define *para onde* o carro vai.

## Tipos de Bancos de Dados (Revisão e Expansão)

### Relacionais (SQL / OLTP)

Baseados em tabelas, colunas e linhas. Foco em consistência e transações do dia-a-dia. (Ex: Oracle, SQL Server, MySQL).

### Data Warehouse (OLAP)

Um tipo especial de banco relacional, otimizado para **análise** e relatórios. (Vemos isso na Normalização: eles são desnormalizadospara performance de leitura).

### NoSQL (Não-Relacionais)

Foco em flexibilidade e escala horizontal

- **Documentos (JSON):** Ex: MongoDB.
- **Chave-Valor:** Ex: Redis.
- **Grafos:** Ex: Neo4j.

### DBaaS (Database as a Service)

O banco de dados é um serviço na nuvem (Cloud). O provedor (Oracle, AWS, etc.) cuida da instalação e infraestrutura.

### Autônomos

Usam IA/Machine Learning para se autogerenciar (tuning, segurança, backups).

---

## Componentes (Stack do Microsoft SQL Server)

- **Database Engine:** O "cérebro" do SGBD. É o que processa e armazena os dados.
- **SSIS (Integration Services):** Ferramenta de **ETL** (Extração, Transformação, Carga).
- **SSAS (Analysis Services):** Ferramenta de **OLAP** (Cria cubos de dados pra Business Intelligence).
- **SSRS (Reporting Services):** Ferramenta de **Relatórios** (Visualização de dados).
