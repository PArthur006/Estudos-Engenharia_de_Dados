# 02 - Autonomous Database (ADB)

## Definição

O **Autonomous Database (ADB)** é o principal produto de banco de dados da Oracle na nuvem (OCI). É um serviço de banco de dados que utiliza **Inteligência Artificial (IA)** e **Machine Learning (ML)** para se gerenciar de forma autônoma.

## Características Principais

A autonomia do ADB se manifesta em três pilares:

1.  **Self-Driving (Autodirigido):**
    - **Provisionamento e Escalonamento:** Ajusta automaticamente a computação e o armazenamento, sem downtime.
    - **Tuning Automático:** Otimiza continuamente as consultas e a estrutura do banco de dados para máxima performance.
    - **Indexação Automática:** Cria, remove e ajusta índices com base na carga de trabalho.

2.  **Self-Securing (Autoprotegido):**
    - **Aplicação de Patches:** Aplica patches de segurança e atualizações de forma automática e online, sem interromper as operações.
    - **Criptografia:** Criptografa os dados em repouso (TDE) e em trânsito (TLS) por padrão.
    - **Auditoria e Monitoramento:** Monitora ameaças e audita acessos para prevenir atividades maliciosas.

3.  **Self-Repairing (Autorreparável):**
    - **Backups Automáticos:** Realiza backups completos e incrementais de forma automática.
    - **Detecção de Falhas:** Detecta e se recupera de falhas de hardware e software automaticamente.
    - **Alta Disponibilidade:** Garante um SLA de 99.995% de disponibilidade (incluindo manutenção).

## Tipos de Workload

O ADB é oferecido em diferentes versões otimizadas para cargas de trabalho específicas:
- **Autonomous Transaction Processing (ATP):** Para cargas de trabalho transacionais, como OLTP, aplicações web e relatórios em tempo real.
- **Autonomous Data Warehouse (ADW):** Para cargas de trabalho analíticas, como Business Intelligence, Data Warehousing e Machine Learning.
