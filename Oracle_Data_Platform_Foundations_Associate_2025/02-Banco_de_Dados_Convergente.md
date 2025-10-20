# Anotações: Banco de Dados Convergente Oracle

> Fonte: Módulo 2: Converged Database

## Evoluçaõ do Desenvolvimento de Apicações

- **Simplicidade Passada:** Antigamente, o desenvolvimento de aplicações de negócio era mais simples, usando uma única ferramenta e banco de dados.
- **Complexidade Atual:** Empresas precisam de aplicações mais sofistica (Data-Driven Apps) para se manterem competitivas. Essas apps devem não só capturar dados, mas também antecipar necessidades e gerar insights em tempo real.
- **Aplicações Data-Driven:**
    - Operam com **diversos tipos de dados**: Espacial, documentos (JSON/XML), sensores (IoT), transacional, graph, etc.
    - Extraem valor dos dados de formas novas: Machine Learning (Recomendações, detecção de fraude), Graph Analytics (identificar influenciadores), Análise Espacial (rastrear entregas).
    - São construídas com **metodologias modernas**: Microderviços, processamento de eventos, desenvolvimento orientado a API, Low-Code.
    - Exigem **entrega contínua (CI/CD)** e alta disponibilidade (24/7), sem tolerância a downtime para patching.

---

## A Abordagem de Bancos de Dados de Propósito Único (Single-Purpose Databases)

Cada microsserviço ou aspecto da aplicação utiliza um banco de dados especializado e otimizado para um único tipo de dado ou carga de trabalho (ex: um BD de documentos, um BD de grafos, um BD relacional).

- **Vantagem Inicial:** Facilita o início de projetos, pois o desenvolvedor escolhe um BD que se encaixa perfeitamente no propósito inicial e usa APIs que parecem "naturais" para aquele modelo.
- **Desvantagens (A Complexidade Escondida):**
    - **Fragmentação de Dados:** Os dados da empresa ficam espalhados por múltiplos bancos de dados isolados.
    - **Complexidade Inesperada:** Mesmo projetos simples acabam precisando de múltiplos tipos de dados e workloads, exigindo vários bancos de propósito único. Mudanças nos requisitos durante o projeto (ex: precisar de analytics em dados de documentos) aumentam a complexidade.
    - **Curva de Aprendizado:** Cada BD exige conhecimento de APIs/linguagens proprietárias (diferentes do SQL padrão) e modelos transacionais distintos.
    - **Vendor Lock-In:** APIs proprietárias podem prender a aplicação a um fornecedor específico de BD ou nuvem.
    - **Código Complexo:** Necessidade de escrever e manter código para mover dados entre os diferentes bancos e mantê-los sincronizados.
    - **Sobrecarga Operacional:** Cada BD exige gerenciamento especializado (tuning, segurança, escalabilidade, patching) com ferramentas distintas.
    - **Risco e Custo:** A organização assume o ônus da integração, re-implementação de políticas de segurança em cada BD, e lida com a complexidade de garantir alta disponibilidade e escalabilidade de forma customizada.

---

## O Banco de Dados Convergente

O **Converged Database** é um banco de dados que possui **suporte nativo** para todos os tipos de dados modernos (relacional, JSON, XML, graph, spatial) e paradigmas de desenvolvimento em **um único produto**.

- **Engenharia Integrada:** As diferentes funcionalidades são projetadas para **trabalhar juntas**, permitindo que desenvolvedores misturem e combinem tipos de dados e modelos de forma transparente.
- **Exemplo de Consulta Híbrida:** Uma consulta de recomendação pode abranger múltiplos modelos:
    1. Encontrar amigos de um cliente (Graph);
    2. Identificar amigos que viram filmes similares (JSON);
    3. Filtrar por avaliações 5 estrelas (Key-Value).
- **Flexibilidade Arquitetural:** Não força um modelo monolítico. Permite que cada serviço de aplicação seja modularizado, usando seu próprio **contêiner de dados independente** (Pluggable Database - PDB). A arquitetura não é ditada pelo tipo de dado.
- **Elimina Fragmentação:** Oferece suporte a todos os tipos de dados em um único banco.
- **API Uniforme:** Fornece **SQL** e **REST** como interfaces comuns para acessar todos os tipos de dados e workloads, reduzindo a curva de aprendizado.

---

## Simplificando Metodologias Modernas com o BD Convergente Oracle

O BD Convergente oferece tecnologias sinérgicas para simplificar paradigmas de desenvolvimento modernos:

- **Microserviços:**
    - Desafio: Gerenciar um BD separado para cada microsserviço pode ser complexo.
    - **Solução Oracle:** Usar **Pluggable Databases (PDBs)**. Cada microsserviço pode ter seu PDB, que é um contêiner de dados logicamente separado, mas que roda dentro de uma única instância Oracle. Isso fornece o isolamento necessário com a simplicidade de gerenciar um único banco. Assim como se usam contêiners Kubernetes para aplicações, usam-se PDBs para os dados.
- **Outras Metodologias (Implícito):** A capacidade de lidar com eventos, APIs, low-code, etc., é facilitada pela natureza integrada e pelas ferramentas do ecossistema Oracle (como APEX para low-code).


---

## Autonomous JSON Database (AJD)

AJD é uma oferta específica dentro do Autonomous Database (ADB), otimizada para aplicações focadas em JSON. O JSON possui um formato simples para modelar dados com objetos, arrays, strings, números e booleanos. Possui uma popularidade crescente.

- **Autonomous Database (ADB):** Versão gerenciada do Oracle Database na nuvem (Oracle cuida de instalação, configuração, backup, patching, etc.).
- **AJD vs. ATP:**
    - AJD é funcionalmente igual ao ATP (Autonomous Transaction Processing).
    - **Restrição:** Limite de 20GB para dados NÃO-JSON. O escalonamento é permitido apenas para dados JSON.
    - **Vantagem:** Preço mais baixo devido à restrição.
    - **Flexibilidade:** Pode ser atualizado para ATP a qualquer momento para remover a restrição.
- **Características "self" do ADB e AJD:**
    - **Self-Driving:** Gerenciamento, monitoramento e tuning automatizados. DBAs focam em tarefas de maior valor.
    - **Self-Securing:** Proteção contra ataques externos e usuários internos maliciosos; patching automático.
    - **Self-Repairing:** Previne downtime (< 2.5 min/mês, incluindo patching).
- **Competição com NoSQL:** AJD compete com bancos NoSQL de documentos (MongoDB, Couchbase, etc.).
    - **Benefícios NoSQL no AJD:** Elasticidade (escalar computação/storage), auto-scaling, baixa latência **sem sacrificar durabilidade e consistência**, custo competitivo.
    - **Benchmark YCSB:** AJD demonstrou performance comparável ou superior (dezenas de milhares de ops/seg com latência < 10ms) a um custo menor que MongoDB Atlas.
- **Mapeamento de Conceitos (MongoDB -> Oracle):**
    - **Database (Mongo):** Mapeado para **Schema (Oracle)**.
    - **Collection (Mongo):** Mapeado para **Table (Oracle)** com uma coluna JSON.
- **Oracle Database API for MongoDB:** Permite que ferramentas e drivers MongoDB se conectem diretamente ao ADB/AJD. Chamadas de API (ex: `insertOne`, `find`) são traduzidas para operações SQL no background.
- **O Melhor dos Dois Mundos:**
    - **Desenvolvedores NoSQL:** Podem usar APIs simples (get, put, update, find) e ferramentas familiares (MongoDB Compass, Mongoose).
    - **Desenvolvedores/Analistas SQL:** Podem usar todo o poder do SQL para consultas analíticas complexas diretamente sobre os dados JSON, juntar com dados relacionais e usar ferramentas baseadas em SQL (Tableu, Power BI).
- **Concectividade:** Ferramentas de BI que já sabem conectar via drivers Oracle podem acessar coleções SJON através de views relacionais criadas sobre os dados JSON.

---

## Oracle Graph no ADB

- **Modelagem de Grafos:** Entidades viram **vértices**, conexões viram **arestas (edges)**, e características viram **propriedades (properties)**. Arestas podem ter direção.
    - **Exemplo:** Tabela `Contas` vira vértices; tabela `Transações` vira arestas direcionadas entre os vértices das contas.
- **Capacidades:**
    - **Consultas:** Usando **Property Graph Query Language (PGQL)**, uma extensão do SQL para buscar padrões de grafos (ex: ciclos, caminhos).
    - **Visualização:** Expor conexões e padrões ocultos (ex: distribuição e acumulação indicando fraude).
    ** Análise (Graph Analytics): Mais de 60 algoritmos built-in, paralelos e in-memory, para tarefas como:
        - Detecção de Comunidades.
        - Análise de Caminhos (shortest path).
        - Ranking de Vértices (ex: PageRank para identificar importância/influência).
- **Casos de Uso:**
    - **Financeiro:** Anti-Lavagem de Dinheiro (AML) e Detecção de Fraude (ciclos são fortes indicadores).
    - **Manufatura/Redes:** Análise de "Bill of Materials" ou topologia de rede; análise de impacto (what-if).
    - **Recomendação:** Identificar clusters/similaridades entre clientes.
- **Oracle Graph:** Funcionalidade **gratuita** incluída em todas as edições do Oracle Database.

---

## Oracle Spatial no ADB

- **Valor:** Identificar padrões, relações e correlações baseadas na **localização** do mundo real. Quase todo dado empresarial tem um aspecto de localização.
- **Gerenciamento:** Oracle trata localização como apenas mais um atributo, com centenas de funções SQL para análise espacial.
- **Dados Suportados:** Pontos (lojas, clientes), redes (ruas), imagens de satélite, modelos 3D, etc.
- **Casos de Uso:** Verificar duplicidade de incidentes, encontrar o socorrista mais próximo, calcular impostos por localização, análise de concorrência, identificar ativos em zonas de risco, otimizar rotas.
- **Oferta Oracle Spatial:**
    1. **Core DB:** Funcinoalidade nativa no banco (tipos de dados, índices espaciais, operadores/funções SQL).
    2. **APIs/Serviços:** Para desenvolvedores usarem em Java, Python, JS, REST (visualização de mapas, cálculos de rotas).
    3. **Spatial Studio:** Ferramenta **self-service**, **no-code**, com interface drag-and-drop para analistas e não-tecnicos criarem mapas e realizarem análises espaciais sem código.
        - **Funcionalidade:** Geocoding (Converter endereços em coordenadas usando Oracle Maps Cloud Service),preparação de dados, criação de índices, publicação de mapas, workflows analíticos.
- **Disponibilidade:** Incluído no ADB (pode exigir mais recursos de computação), disponível no Oracle Cloud Marketplace, tutoriais no LiveLabs.
