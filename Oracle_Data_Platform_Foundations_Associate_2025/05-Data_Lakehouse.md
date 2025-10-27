# 05 - Data Lakehouse

## Definição

**Data Lakehouse** é uma arquitetura de dados moderna que combina a **flexibilidade e o baixo custo de um Data Lake** com a **performance, a governança e a confiabilidade de um Data Warehouse**.

A Oracle implementa essa arquitetura integrando o Autonomous Database com o OCI Object Storage.

## Arquitetura na OCI

A arquitetura Lakehouse na Oracle Cloud Infrastructure (OCI) é composta por:

1.  **Data Lake (Camada de Armazenamento):**
    - **OCI Object Storage:** Um serviço de armazenamento de objetos de baixo custo, altamente durável e escalável. É aqui que os dados brutos (estruturados, semiestruturados e não estruturados) são armazenados em seus formatos nativos (CSV, JSON, Parquet, Avro, etc.).

2.  **Data Warehouse (Camada de Processamento e Análise):**
    - **Autonomous Database (ADW):** Atua como a engine de consulta de alta performance.

## Como Funciona a Integração

A mágica acontece através das **Hybrid Tables** (ou External Tables em versões mais antigas).

- **Hybrid Tables:** São tabelas dentro do Autonomous Database que, na verdade, apontam para os dados armazenados no Object Storage.
- **Consulta Transparente:** Para o usuário final, a consulta a uma Hybrid Table é idêntica a consultar uma tabela normal dentro do banco. O Autonomous Database sabe como ler os dados diretamente do Object Storage, aplicar otimizações (como o Smart Scan em arquivos Parquet) e retornar o resultado.

## Vantagens da Abordagem Lakehouse

- **Fonte Única da Verdade:** Os dados brutos permanecem no Data Lake, e o Data Warehouse os acessa diretamente, evitando duplicação e inconsistência.
- **Flexibilidade:** Permite que cientistas de dados trabalhem com dados brutos no Lake, enquanto analistas de negócios consomem dados curados e performáticos no Warehouse.
- **Custo-Benefício:** Armazena grandes volumes de dados a um custo baixo no Object Storage e usa o poder computacional do Autonomous Database apenas quando necessário para consulta.
- **Governança e Segurança:** Aplica as robustas políticas de segurança e governança do Oracle Database aos dados que residem no Data Lake.
