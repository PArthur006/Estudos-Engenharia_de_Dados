# Anotações: Exadata e Base Database Service

> Fonte: Módulo 3: Exadata e Base Database Service

## Oracle Base Database Service (Serviço Co-Gerenciado em VMs)

Este serviço permite implantar bancos de dados Oracle completos em Máquinas Virtuais (VMs) na nuvem pública da Oracle (OCI).

- **Controle vs. Automação:** É um serviço **co-gerenciado**: a Oracle gerencia a infraestrutura subjacente, enquanto o cliente gerencia o conteúdo da VM do banco de dados (incluindo o S.O. e o software do BD). O cliente tem acesso root à VM.
- **Recursos:**
    - **Edições Suportadas:** Standard Edition e Enterprise Edition.
    - **Versões Suportadas:** 12c, 19c, 21c, 23ai.
    - **Flexibilidade:** Permite rodar workloads em VMs flexíveis (formas - shapes) com processadores Ampere, AMD ou Intel.
    - **Configurações:** Disponível como instância única (single-instance) ou RAC de 2 nós (2-node RAC).
    - **Segurança:** Modelo de segurança multinível com recursos como criptografia sempre ativa (Transparent Data Encryption - TDE).
- **Automação:** Fornece um conjunto robusto de funções de automação na nuvem para simplificar tarefas gerenciadas pelo usuário, como provisionamento, escalonamento de recursos, patching, backup/recovery e configuração de alta disponibilidade (HA) e recuperação de desastres (DR) com Data Guard, tudo sob o controle do cronograma do cliente.

### Licenciamento

- **License Included (LI):** Inclui a licença do Oracle Database e opções. Ideal para novas aplicações ou para usar recursos não licenciados on-premise. Possui 4 tiers:
    1. **Standard Edition 2 (SE2):** Inclui Multitenant (até 3 PDBs), Machine Learning, Spatial e Graph. Não suportado em shapes Ampere A1.
    2. **Enterprise Edition (EE):** Adiciona Data Guard, Packs de Diagnóstico, Tuning, Data Masking & Subsetting.
    3. **Enterprise Edition High Performance (EE-HP):** Adiciona Packs de Ciclo de Vida e Gerenciamento de Nuvem, Partitioning, Advanced Compression, Advanced Security. Necessário para Multitenant com mais de 3 PDBs.
    4. **Enterprise Edition Extreme Performance (EE-EP):** Adiciona Active Data Guard, RAC, Database In-Memory. Obrigatório para RAC de 2 nós.
    - TDE: Incluído em todos os tiers.
- **Bring Your Own License (BYOL):** Permite usar licenças Oracle Database on-premise existentes na nuvem. Ideal para migração.
    - **Benefícios BYOL:** Ao trazer uma licença EE, o cliente ganha direito de uso de TDE, Diagnostic Pack, Tuning Pack, Data Masking & Subsetting Pack e Real Application Testing (RAT) na nuvem.
    - **Oracle Support Rewards:** Clientes BYOL podem receber créditos (25%-33% do gasto em OCI) aplicáveis à fatura de suporte on-premise.

### Compute Shapes (Formas de VM)

- **Flexíveis:** Ampere A1 (mais econômico, só single-node LVM, sem SE2), Intel X9, AMD E4/E5. Permitem escalar OCPUs (1 a 57/32/64) e memória (8GB ou 16GB por OCPU) de forma granular. Aumentam a banda de rede conforme OCPUs aumentam.
- **Standard (Fixas):** Shapes mais antigos com tamanhos fixos de OCPU (1 a 24) e memória (15GB por OCPU). Escalar exige mudar para outro shape.
- **Escalonamento:** Não é possível mudar de single-node para 2-node RAC após a criação. Escalonamento de OCPU em RAC 2 nós é feito de forma rolling (um nó por vez).

### Armazenamento

- Utiliza Block Volumes da OCI, que são anexados à VM.
- **Opções de Gerenciamento:**
    1. **Logical Volume Manager (LVM):** Disponível para single-node, oferece provisionamento rápido.
    2. **Automatic Storage Management (ASM):** Padrão. Usa disk groups DATA (80%) e RECO (20%). Obrigatório para RAC 2 nós.
- **Escalonamento:** O armazenamento pode ser escalado online (até 80TB para DATA, 20TB para RECO). A performance de I/O aumenta com o tamanho do armazenamento.
- **Clones:** Suportados tanto para LVM quanto para ASM.

### Backup

- **Destinos:** Object Storage ou Recovery Service (padrão, mesmo preço, melhores RTO/RPO).

### Alta Disponibilidade (HA) e Recuperação de Desastres (DR)

- **RAC 2 Nós:** Os nós são colocados em Fault Domains separados dentro da mesma Availability Domain para proteção contra falhas de hardware ou manutenção na infraestrutura física.
- **Data Guard:** Pode ser configurado com standby em outra Availability Domain (para HA contra falha de AD) ou em outra Região (para DR).
- **MAA (Maximum Availability Architecture):** O serviço suporta todas as tecnologias MAA (Flashback, Backup/Recovery, Multitenant, RAC, Data Guard, Application Continuity), dependendo do tier de licenciamento EE-EP para RAC e Active Data Guard/Application Continuity.

### Segurança (Defense in Depth)

- **Banco de Dados:** TDE, Data Redaction/Masking/Subsetting, Key Vault, Database Vault, Database Firewall, Data Safe.
- **Sistema Operacional:** Imagem hardened baseada em Oracle Linux 7.
- **Rede:** Isolamento com Virtual Cloud Networks (VCNs), Oracle Native Network Encryption para conexões cliente-servidor.
- **Conformidade:** Sujeito a auditorias externas (PCI, HIPAA, ISO 27001).

---

## Oracle Exadata Database Service (Serviço Co-Gerenciado em Hardware Exadata)

Este serviço permite rodar o Oracle Database na plataforma Exadata Database Machine, seja na nuvem pública (OCI) ou no data center do cliente (Cloud@Customer).

- **Plataforma Exadata:** Hardware otimizado para Oracle Database, com servidores de BD e storage inteligentes (scale-out), interconectados por rede RoCE de alta performance e baixa latência. Oferece recursos exclusivos como SQL Offload, Smart Flash Cache, Storage Indexes, Hybrid Columnar Compression.
- **Modelo Co-Gerenciado:** Oracle gerencia a infraestrutura Exadata (hardware, firmware, software de storage, hipervisor), enquanto o cliente gerencia as VMs de banco de dados e seu conteúdo (Grid Infrastructure, software do BD, dados, schemas, chaves de criptografia) usando a automação da nuvem. O cliente tem acesso root às VMs.
- **Benefícios:** Combina o poder do Exadata (performance, disponibilidade, escalabilidade) com a simplicidade e economia da nuvem (automação, pay-per-use).
- **Compatibilidade:** 100% compatível com Oracle Database on-premise, facilitando a migração.
- **Automação:** Ferramentas de automação via UI ou API para provisionamento, patching (controlado pelo cliente), backup, escalonamento, configuração de HA/DR (Data Guard).
- **Isolamento:** Infraestrutura dedicada, sem superprovisionamento (overprovisioning), garantindo performance previsível.
- **Escalonamento:** Permite escalar OCPUs (cores de CPU nos servidores de BD) online, para cima ou para baixo, para alinhar com a demanda e otimizar custos.

### Licenciamento

- **License Included (LI):** Inclui licença EE e todas as opções e management packs (RAC, In-Memory, Multitenant, Active Data Guard, Partitioning, etc.). Requer o tier EE-Extreme Performance.
- **Bring Your Own License (BYOL):** Permite usar licenças EE on-premise. Inclui software Exadata Storage Server. Ganha direito a TDE, Data Safe, Diagnostic/Tuning Packs, Masking/Subsetting Pack e RAT na nuvem. Standard Edition não é suportado no Exadata.

### Deployment Flexível

- **Exadata Database Service on Dedicated Infrastructure (OCI Public Cloud):** Roda na infraestrutura Exadata dentro das regiões públicas da OCI. Oracle gerencia a infraestrutura. O cliente gerencia as VMs.
- **Exadata Cloud@Customer (ExaCC):** O hardware Exadata é instalado no data center do cliente, mas gerenciado remotamente pela Oracle como um serviço de nuvem. Os dados permanecem no data center do cliente. Ideal para requisitos de soberania de dados, baixa latência com aplicações on-premise ou transição gradual para a nuvem. Conecta-se à OCI via túnel seguro para gerenciamento (Control Plane).
- **Oracle Database@Azure:** Oferta nativa que permite rodar o Exadata Database Service diretamente dentro dos data centers do Microsoft Azure, com conexão de baixa latência via OCI FastConnect e Azure ExpressRoute.

### Arquitetura (Public Cloud / Cloud@Customer)

- Servidores de BD físicos hospedam VMs de BD.
- Servidores de Storage inteligentes.
- Rede interna RoCE segura e de alta performance.
- Redes de Cliente e Backup conectadas à VCN do cliente.
- Rede de Gerenciamento isolada para a Oracle (Cloud Ops).

### Segurança (Defense in Depth + Controle de Acesso)

- Aplica os mesmos princípios de segurança do Base Database Service (TDE, DB Vault, etc.).
- **Operator Access Control (OpCtl - para Cloud@Customer):** Recurso que exige que a equipe de operações da Oracle solicite acesso explícito ao cliente para intervir na infraestrutura no data center do cliente. O cliente pode aprovar/negar, definir limites de tempo/privilégios, monitorar em tempo real e revogar o acesso. Essencial para indústrias reguladas.

---

## Visão Geral do Gerenciamento do Ciclo de Vida
O Exadata Database Service oferece funcionalidades para gerenciar o ciclo de vida do banco de dados, incluindo:

- Criação de imagens de software customizadas (GI e DB).
- Criação de Database Homes.
- Criação de Databases.
- Gerenciamento de Pluggable Databases (PDBs).
- Habilitação de Data Guard.
- Manutenção gerenciada pelo usuário (updates e upgrades).

As operações podem ser realizadas via Console OCI, API, CLI ou SDKs.

---

## Imagens de Software Customizadas (Grid Infrastructure & Database)
Permitem criar padrões de software Oracle para facilitar implantações e patches.

- **Propósito:** Criar uma "imagem de ouro" aprovada pela organização, garantindo padronização.
- **Conteúdo:** Incluem versões específicas de GI ou DB, Release Updates (RUs), patches pontuais (one-offs) e/ou o inventário de patches de um Oracle Home existente.
- **Criação:**
    - Realizada via Console OCI ou API antes de provisionar/patch.
    - Seleciona-se o tipo (GI ou DB), o tipo de serviço (Exadata), um nome de exibição, o compartimento onde será armazenada.
    - Escolhe-se a versão do software Oracle, o RU/patch desejado, ou faz-se upload de um inventário de patches (opatch lsinventory).
- **Suporte:** Suporta qualquer versão/update Oracle suportado na nuvem.
- **Armazenamento:** Salvas automaticamente no Object Storage gerenciado pela Oracle e listadas na Console OCI.

---

## Criação de Database Homes
É o diretório onde os binários do Oracle Database são instalados.

- **Processo:**
    - Navegar até o VM Cluster desejado na Console OCI.
    - Clicar em "Create Database Home".
    - Informar um nome de exibição.
    - Selecionar uma imagem de software de banco de dados (padrão Oracle ou customizada).
    - Clicar em "Create".

---

## Criação de Databases (Container Database - CDB)
Processo para criar uma nova instância de banco de dados dentro de um Database Home.

- **Processo:**
    - Na página do VM Cluster, clicar em "Create Database".
    - Informar nome do banco de dados e versão desejada.
    - Opcionalmente, fornecer um nome para o primeiro Pluggable Database (PDB).
    - Selecionar um Database Home existente (com versão compatível) ou criar um novo.
    - Definir a senha para o usuário SYS (administrador).
    - Configurar o destino e o agendamento dos backups.
- **Opções Avançadas:** Escolher entre chaves de criptografia TDE gerenciadas pela Oracle ou pelo cliente (via OCI Vault ou Oracle Key Vault - OKV on-premise no caso de ExaCC).
- Clicar em "Create Database".

---

## Gerenciamento de Pluggable Databases (PDBs)
Operações de ciclo de vida para os bancos de dados "conectáveis" dentro de um CDB.

- **Criação:** Via Console ou API, dentro de um CDB existente, informando nome do PDB e senha do admin.
- **Conexão:** Cada PDB possui suas próprias strings de conexão (Easy Connect ou Long Connect).
- **Monitoramento:** Acesso ao Performance Hub para análise de performance específica do PDB.
- **Clonagem:**
    - **Clone Local:** Cria cópia do PDB dentro do mesmo CDB.
    - **Clone Remoto:** Cria cópia do PDB em um CDB diferente (pode ser em outro VM Cluster, na mesma AD).
    - **Clone Refrescável (Refreshable):** Cria um clone remoto que pode ser sincronizado (refresh) com a origem.
- **Outras Operações (Menu "More Actions"):**
    - **Start/Stop:** Iniciar ou parar um PDB individualmente.
    - **Relocate:** Mover um PDB de um CDB para outro CDB (pode renomear no processo).
    - **Restore:** Restaurar um PDB a partir de um backup (para o último backup ou ponto no tempo específico).
    - **Delete:** Remover um PDB.

---

## Habilitação e Gerenciamento de Oracle Data Guard
Configuração de um banco de dados standby para HA/DR.

- **Propósito:** Proteção contra desastres e downtime mínimo para manutenções planejadas. Componente chave da arquitetura MAA.
- **Habilitação (via Cloud Automation):**
    - Selecionar o VM Cluster "par" (em outra AD ou Região).
    - Escolher o tipo: Data Guard (standby físico normal) ou Active Data Guard (standby ativo para leitura, offload de backup, etc.; incluído na licença LI do Exadata Service).
    - Selecionar o Database Home no standby (existente ou novo).
    - Fornecer um nome único para o banco standby (DB_UNIQUE_NAME) e a senha do admin (deve ser a mesma do primário).
- **Operações de Transição de Papel:**
    - **Switchover:** Troca planejada de papéis primário <-> standby. Usado para manutenções.
    - **Failover:** Transição de emergência para o standby após falha do primário. Primário original é removido da configuração. Fast-Start Failover (FSFO) pode ser configurado manualmente para failover automático.
    - **Reinstate:** Reintegra um primário antigo (após falha e correção) como um novo standby.
- **Pré-requisitos:** DB systems no mesmo compartimento; mesma VCN (mesma região) ou VCNs pareadas (regiões diferentes); mesma versão de BD; DB_UNIQUE_NAME diferentes; regras de segurança de rede (ingress/egress) habilitadas para tráfego TCP na porta do listener (padrão 1521) entre os sistemas.

---

## Manutenção Gerenciada pelo Usuário (Patching & Upgrades)
Responsabilidades do cliente para manter o software atualizado nas VMs.

- **Divisão de Responsabilidades:**
    - **Oracle:** Patch trimestral da infraestrutura (servidores físicos, storage, switches, firmware, hipervisor). Manutenção agendável pelo cliente.
    - **Cliente:** Patch trimestral (ou no máximo 180 dias) do S.O. da VM convidada, Grid Infrastructure (GI) e Oracle Database Home. Requer permissões IAM apropriadas.
- **Melhores Práticas:**
    - Backup do banco antes de qualquer patch.
    - Preferir mover o banco para um novo DB Home atualizado em vez de aplicar patch no DB Home existente.
    - Atualizar GI antes de atualizar DB Homes para versões mais recentes.
    - Executar Precheck antes da janela de manutenção.
    - Verificar espaço livre em /u01 (GI) e /u02 (DB Home) - min 15GB.
    - Usar interfaces OCI (Console/API) para as operações.
- **Visualização de Patches e Histórico:**
    - Console OCI mostra versão atual de OS (Exadata Image), GI e DB Homes.
    - Página "Updates" lista patches disponíveis para cada componente (OS, GI, DB Home), incluindo imagens customizadas para DB Home. Mostra descrição, versão, data de release e status do último precheck.
    - Página "Update History" exibe operações de patch anteriores (tentativas, sucesso/falha, timestamp). Não mostra patches aplicados via linha de comando.
- **Aplicando Patches:**
    - **OS (Exadata Image Update):** Atualiza a VM convidada. Processo automatizado via Console/API, substitui o Patch Manager manual. Oferece precheck e opção de rollback. Apenas as 4 últimas versões menores ficam disponíveis. Selecionar patch -> Run Precheck -> Apply.
    - **Grid Infrastructure (GI):** Atualiza o software GI. Selecionar patch -> Run Precheck -> Apply. Aplicado em rolling fashion (um nó por vez). Instâncias DB no nó sendo atualizado ficam indisponíveis temporariamente.
    - **Database Home (DB Home):** Pode usar imagem padrão Oracle ou customizada.
        - **Opção 1 (Patch in-place):** Selecionar patch -> Run Precheck -> Apply. Atualiza o DB Home existente e todos os bancos de dados que o utilizam. Aplicado em rolling fashion.
        - **Opção 2 (Out-of-place / Mover - Recomendado):** Criar um novo DB Home com a versão/patch desejado. Ir para a página do banco de dados -> Clicar em "Move to Another Database Home" -> Selecionar o DB Home alvo. Atualiza apenas aquele banco de dados, mais rápido e menos disruptivo.
- **Disponibilidade Durante Patching:** Com RAC, patches de GI e DB Home podem ser aplicados em rolling fashion, permitindo zero downtime do serviço de banco de dados, embora a capacidade máxima seja temporariamente reduzida durante o reinício das instâncias. Aplicações devem seguir práticas MAA para tolerar reinícios de instâncias (Application Continuity).
- **Upgrade do Grid Infrastructure (GI):**
    - Permite usar versões mais recentes do Oracle Database.
    - Envolve upgrade do software GI em todos os nós, em rolling fashion.
    - Recomenda-se rodar precheck.
    - **Restrições:** Bloqueado se houver manutenção de infra agendada < 24h. Operações de Data Guard, gerenciamento de nós/CPUs, DB Homes/DBs, restore, IORM são bloqueadas durante o upgrade.
- **Upgrade do Oracle Database:**
    - **Preparação:** Backup; Testar em ambiente não-produtivo; Rodar precheck de upgrade; Criar DB Home com a versão alvo; Garantir que todos PDBs podem ser abertos; Desabilitar backups automáticos e fazer backup manual. Backups automáticos pré-upgrade não servem para restore point-in-time pós-upgrade.
    - **Processo (via Console/API):**
        1. Na página do DB, selecionar "Upgrade".
        2. Escolher a versão alvo e o DB Home alvo pré-criado.
        3. Rodar precheck e corrigir problemas.
        4. Clicar em "Upgrade Database".
    - **Processo Interno Automático:** Precheck -> Criação de Guaranteed Restore Point -> Movimentação para DB Home alvo -> Execução do DBUA.
- **Upgrade com Data Guard:** Pode fazer upgrade do primário ou standby primeiro (standby-first recomendado). Redo Apply é desabilitado durante o upgrade; verificar após.
