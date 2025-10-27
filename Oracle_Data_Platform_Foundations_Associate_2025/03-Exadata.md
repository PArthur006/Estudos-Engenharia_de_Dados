# 03 - Exadata (Cloud e On-Premise)

## Definição

**Exadata** é uma plataforma de hardware e software de altíssima performance, projetada e otimizada especificamente para rodar o banco de dados Oracle. É considerada a infraestrutura ideal para cargas de trabalho críticas que exigem o máximo de desempenho, escalabilidade e disponibilidade.

## Componentes Chave

A "mágica" do Exadata vem da sua arquitetura única, que inclui:

- **Servidores de Banco de Dados (DB Servers):** Servidores de alta performance que executam as instâncias do Oracle Database.
- **Servidores de Armazenamento Inteligente (Storage Servers):** O grande diferencial. Eles possuem software que permite descarregar (offload) parte do processamento SQL diretamente para o armazenamento.
    - **Smart Scan:** Em vez de trazer blocos de dados inteiros para os DB servers, os Storage Servers filtram os dados na origem, enviando apenas as linhas e colunas relevantes para a consulta. Isso reduz drasticamente o tráfego de I/O e a carga na CPU dos DB servers.
- **Rede InfiniBand de Alta Velocidade:** Uma rede interna de baixíssima latência e altíssima largura de banda que conecta todos os componentes.
- **Persistent Memory (PMEM):** Usada como um cache ultrarrápido para acelerar operações de log e I/O.

## Modelos de Implantação

O Exadata está disponível em diferentes modelos para atender a diversas needs:

1.  **Exadata On-Premise:** A máquina física (appliance) instalada no data center do cliente.
2.  **Exadata Cloud@Customer:** A máquina física do Exadata é instalada no data center do cliente, mas é gerenciada como um serviço de nuvem pela Oracle. O cliente tem o controle da localidade dos dados (soberania de dados) com a flexibilidade da nuvem.
3.  **Exadata Cloud Service (ExaCS):** A infraestrutura do Exadata como um serviço na nuvem pública da Oracle (OCI). Oferece a máxima performance do Exadata com a elasticidade e o modelo de pagamento por uso da nuvem.
