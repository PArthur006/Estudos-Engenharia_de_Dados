# Anotações: Estratégia de Gerenciamento de Dados e Ofertas Oracle

> Fonte: Módulo 1: Data Management Introduction

## 1. Estratégia Oracle: "Simplesmente Completo / Completamente Simples"

A Oracle adota uma abordagem para o gerenciamento de dados que visa ser **completa** em termos de funcionalidade e **simples** de usar e gerenciar.

- **Desenvolvimento Moderno:** A estratégia abraça as transformações rápidas no desenvolvimento ed aplicativos, simplificando como aplicações, modelos de dados e analytics são implantados e utilizados.
- **Banco de Dados Convergente:** O Oracle Database é um banco de dados **convergente**, oferecendo suporte otimizado para **todos os tipos de dados** (Relacional, JSON, Graph, Text, Blockchain, Spatial, etc.) e **cargas de trabalho** (transacionais e analíticas) em uma única plataforma.
    - **Benefício:** Elimina a fragmentação de dados, permitindo consultas e transações que abrangem diferentes tipos de dados (estruturados e não estruturado) e agregam valor a partir de todos eles.
- **Suporte a Workloads:** Capacidade única de rodar **qualquer combinação de workloads** (transações, key-value, IOT, data warehouse operacional, data lake, machine learning) sobre **qualquer combinação de dados**.
- **Arquitetura Descentralizada:** Facilita a implementação e operação de **aplicativos descentralizados**, suportando técnicas como eventos de código/dados, desenvolvimenot orientado a API, low-code e geo-distribuição.

---

## 2. Oracle Autonomous Database (ADB): A Base da Estratégia

O ADB é um serviço de banco de dados na nuvem que automatiza muitas tarefas de gerenciamento.

- **Totalmente Gerenciado:** A Oracle gerencia completamente a infraestrutura e o banco de dados (provisionamento, ajuste fino, patching, backups, segurança, recuperação de desastres).
- **Automação Inteligente:**
    - **Autoajuste (Auto-tuning):** Otimiza o desempenho automaticamente.
    - **Autoescalonamento (Auto-scaling):** Aumenta ou diminui os recursos (CPU/Armazenamento) elasticamente com base na carga de trabalho, otimizando custos.
    - **Recursos Avançados:** Oferece soluções automatizadas para tarefas complexas como indexação automática (auto-indexing) e particionamento (auto-partitioning).
- **Produtividade:**
    - Permite que as equipes foquem nos dados e na resolução de problemas de negócio, em vez de tarefas administrativas do BD.
    - Inclui ferramentas de **self-service** para analytics e acesso a dados.
    - Simplifica arquiteturas de engenharia de dados complexas.
- **Suporte a APIs:** O ADB agora suporta a API do **MongoDB**,ampliando a compatibilidade para desenvolvedores.
- **Foco em Missão Crítica:** Mantém a robustez tradicional da Oracle em alta disponibilidade, segurança e soluções operacionais comprovadas, essenciais para aplicações críticas.

---

## 3. Comparativo das Ofertas de Banco de Dados Oracle

A Oracle oferece diferentes modelos de implantação para seus bancos de dados:

|Modelo| Gerenciamento de Infraestrutura | Gerenciamento de Banco de Dados | Indicado Para
|:--|---|---|:--|
|**On-Premise** | Cliente | Cliente | Controle total sobre todo o ambiente.
|**Co-Gerenciamento (DBCS, ExaCS)** | Oracle | Cliente | Clientes que precisam de mais controle sobre o BD (versões < 19, aplicações específicas como E-Business Suite).
| **Totalmente Gerenciado (ADB)** | Oracle | Oracle | Maioria dos clientes buscando modernização, menor custo e maior produtividade.

- **Vantagem ed Custo do ADB:** Por ser totalmente gerenciado e automatizado, o ADB oferece um **custo total de propriedade (TCO)** significativamente menor.
    - **Pesquisa Wikibon:** Analisou o custo de rodar Oracle ATP (Autonomous Transaction Processing) comparado a:
        - **In-Premise:** ATP custou quase **metade**.
        - **AWS RDS (Oracle):** Rodar Oracle no RDS da Amazon custou o **mesmo ou até 50% mais** que on-premise (especialmente com DR), enquanto ATP foi significativamente mais barato.

---

## 4. Migração para o Autonomous Database (ADB)

A Oracle facilita a migração de bancos de dados existentes para o ADB.

- **Ferramenta de Análise Pré-Migração:** Ajuda a identificar recursos ou configurações no banco de dados on-premise que podem não ser suportados diretamente no ADB.
- **Processo de Migração Padrão:**
    1. **Exportação:** Usar o **Oracle Data Pump** para exportar os dados do banco on-premise.
    2. **Transferência:** Mover os arquivo exportados para o **Oracle Cloud Object Storage**.
    3. **Importação:** Usar o **Data Pump** para importar os dados do Object Storage para o ADB.
- **Preservação de Otimizações:** É possível manter os índices e otimizações existentes feitos on-premise, se desejado.
- **Oracle Database Migration Service:** Um serviço na nuvem que **automatiza** os passos acima, simplificando a migração de bancos on-premise ou de outras nuvens para o ADB.

---

## 5. Certificação de Aplicações e Ecossistema ADB

- **Aplicações Oracle:** JD Edwards, PeopleSoft e Siebel já são **certificados** para rodar com ADB. E-Business Suite (EBS) está em processo de certificação.
- **Serviço Gerenciamento:** Existem serviços na nuvem da Oracle que gerenciam tanto o ADB quanto a camada intermediária (middle tier) de aplicações Oracle migradas.
- **Aplicações de Terceiros:** A Oracle trabalha com parceiros (ISVs) para certificar suas aplicações (ex: MESTEC, MineSense, NEC, Zebra).
- **Ferramentas de Terceiros:** Ferramentas populares de BI e análise (ex: Tableu, BusinessObjects) são certificadas para funcionar com ADB.

---

## 6. Oracle APEX (Application Express)

Apex é a plataforma de desenvolvimento **low-code** da Oracle, integrada ao banco de dados.

- **Produtividade:** Permite construir aplicações web orientadas a dados **rapidamente** (estimativas de 10x e 50x mais rápido que codificação tradicional).
- **Facilidade:** Vem com componentes prontos para formulários, relatórios, gráficos, busca facetada, etc.
- **Automação:** Gerencia automaticamente a camada intermediária (conexões, estado, mapeamento de dados), simplificando o desenvolvimento.
- **ADB + APEX:** Uma combinação poderosa. Existe uma versão do ADB otimizada para aplicações APEX.
    - **Exemplo:** Wilson Truck Lines reconstruiu em 2 dias com APEX uma aplicação que levou 3 meses para codificar na AWS com métodos tradicionais.

---

## 7. Autonomous Data Warehouse (ADW): Além do Tradicional

O ADW é mais do que um data warehouse rápido na nuvem.

- **Ferramentas Self-Service:** Inclui ferramentas para que analistas e cientistas de dados possam carregar, transformar (ETL visual drag-and-drop) e modelar dados (OLAP) sem depender de engenheiros.
- **Analytics Convergente:** Integra funcionalidades avançadas como Graph Analytics, Spatial Analytics e Machine Learning diretamente na plataforma.
- **AutoML:** Uma funcionalidade que permite gerar modelos de Machine Learning automaticamente a partir de um conjunto de dados, simplificando o trabalho do cientista de dados.
- **Data Lake Integration:** Integra-se com Object Storage (na Oracle Cloud ou outras nuvens) para permitir consultas que combinam dados do data warehouse e do data lake.
- **Exemplo:** Seattle Sounders FC usa ADW para analisar estatísticas esportivas e construir modelos de ML para melhorar o desempenho do time.

---

## 8. Multicloud e Oracle Cloud Infrastructure (OCI)

A Oracle reconhece e realidade multicloud e oferece flexibilidade.

- **Estratégia Multicloud:** Muitas empresas (mais de 80%, segundo Gartner) usam dois ou mais provedores de nuvem para aproveitar o melhor de cada um, reduzir riscos e custos.
- **Benefícios Multicloud:** Inovação "best-of-breed", redundância, redução de latência, conformidade, economia e menor dependência de um único fornecedor.
- **Conectividade:**
    - **OCI FastConnect:** Conexão privada e dedicada entre o cliente e a OCI.
    - **Parceiros:** Uso de provedores como Megaport para conexões privadas entre nuvens (ex: OCI e AWS VPC).
    - **Interconexão Oracle + Microsoft Azure:** Uma parceria que oferece conexão direta (FastConnect + ExpressRoute) com baixa latência (<2ms) entre OCI e Azure, identidade unificada e suporte colaborativo.
- **Opções de Implantação Híbrida/Dedicada:**
    - **OCI Dedicated Region:** Uma região OCI completa instalada no data center do cliente, gerenciada pela Oracle (para soberania de dados ou baixa latência).
    - **Exadata Cloud@Customer / ADB Cloud@Customer:** Hardware Exadata e serviços ADB entregues como serviços no data center do cliente, gerenciados pela Oracle.

---

## 9. Facilitadores de Adoção OCI/ADB

- **BYOL (Bring Your Own License):** Permite usar licenças Oracle Database on-premise existentes na OCI, reduzindo custos.
- **Cloud Lift Services:** Equipe de engenharia da Oracle que ajuda clientes a migrar cargas de trabalho on-premise para OCI gratuitamente.
- **Support Rewards Program:** Clientes OCI recebem créditos (rewards) por dólar gasto na nuvem, que podem ser usados para abater a fatura de suporte de licenças on-premise.
- **Always Free Tier:** Oferece instâncias gratuitas do Autonomous Database (e outros serviços OCI) para aprendizado e experimentação.
- **LiveLabs:** Laboratórios práticos gratuitos para testar tecnologias Oracle na nuvem Always Free.
