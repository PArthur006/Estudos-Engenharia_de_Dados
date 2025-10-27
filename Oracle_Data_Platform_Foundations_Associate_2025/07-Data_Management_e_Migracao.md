# 07 - Gerenciamento e Migração de Dados

## Ciclo de Vida do Gerenciamento de Dados

Gerenciar dados na OCI envolve um ciclo de vida completo, desde a ingestão até a proteção e o descarte.

- **Ingestão:** Mover dados de fontes externas para a OCI.
- **Armazenamento:** Escolher o serviço de armazenamento correto (Object Storage, Autonomous Database, etc.).
- **Processamento:** Transformar e enriquecer os dados.
- **Análise:** Extrair insights usando ferramentas como Analytics Cloud e OML.
- **Proteção:** Garantir a segurança, backup e alta disponibilidade.

## Segurança de Dados

A OCI oferece uma abordagem de segurança em camadas:

- **Oracle Data Safe:** Um centro de controle unificado para a segurança dos seus bancos de dados Oracle. Suas funções incluem:
    - **Avaliação de Segurança:** Analisa configurações de segurança e identifica riscos.
    - **Auditoria de Usuários:** Rastreia atividades no banco de dados.
    - **Descoberta de Dados Sensíveis (Data Discovery):** Encontra dados sensíveis (como CPFs, cartões de crédito) no seu esquema.
    - **Mascaramento de Dados (Data Masking):** Cria cópias ofuscadas do banco de dados para uso em ambientes de não produção.
- **Criptografia:** TDE (Transparent Data Encryption) e TLS por padrão no ADB.
- **IAM (Identity and Access Management):** Controle de acesso granular a todos os recursos da OCI.

## Ferramentas de Migração para a Nuvem

A Oracle oferece várias ferramentas para migrar bancos de dados on-premise para a OCI.

1.  **Zero Downtime Migration (ZDM):**
    - A principal ferramenta da Oracle para automatizar a migração de bancos de dados para a OCI com tempo de inatividade mínimo ou zero.
    - Orquestra o uso de outras ferramentas como Data Guard e GoldenGate.

2.  **Oracle Data Pump:**
    - Utilitário para exportar/importar dados e metadados em alta velocidade. Ideal para migrações lógicas onde a estrutura do banco pode mudar.

3.  **GoldenGate:**
    - Solução de replicação de dados em tempo real. Usado para migrações com zero downtime e para manter sistemas on-premise e na nuvem sincronizados.

4.  **Database Migration Service (DMS):**
    - Um serviço gerenciado na OCI que simplifica a migração de bancos de dados, utilizando o ZDM por baixo dos panos.
