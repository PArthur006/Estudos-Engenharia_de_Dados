# Introdução ao Business Intelligence (BI)

BI não é uma ferramenta. É um **processo** estratégico e tecnológico para analisar dados e apresentar informações acionáveis (*"actionable insights"*) com o objetivo de ajudar os gestores a tomar decisões de negócio mais inteligentes.

O Business Intelligence é o processo de transformar dados brutos (ex: uma linha de venda no banco de dados) em informação útil e consolidada (ex: "As vendas de Notebooks caíram 15% na região Sul neste trimestre").

## Objetivo do BI

O BI foca em responder perguntas sobre o negócio, principalmente olhando para o **passado** e o **presente**.

#### Perguntas descritivas

- "O que aconteceu?"
- "Qual foi o nosso faturamento total no mês passado?"

#### Perguntas Diagnósticas

- "Por que aconteceu?"
- "Qual produto teve a maior queda em vendas e em qual região?"

## BI vs. Engenharia de dados vs. Análise de Dados

### Engenheiro de Dados

É quem constrói a "infraestrutura". Ele cria os pipelines (ETLs), o Data Warehouse e garante que os dados cheguem com qualidade e performance.

### Analista de Dados

É quem usa o SQL e Python para encontrar padrões, responder às perguntas diagnósticas e entender o "porquê".

### Business Intelligence

É a camada de **visualização** que consome os dados do reservatório. É o resultado do trabalho da engenharia e da anáilse, entregue de forma visual para o gestor.

## OLTP vs. OLAP

#### OLPT (Online Transaction Processing)

É o banco de dados do *dia a dia* (o e-commerce, o sistema de caixa, o app do banco). Possui uma **estrutura normalizada** (3ª Forma Normal). Isso evita redundãncia e garante consistência na escrita.

Tem como foco a gravação rápida (`INSERT`, `UPDATE`).

#### OLAP (Online Analytical Processing)

É o banco de dados do BI (o Data Warehouse). Sua estrutura é **Desnormalizada**. A redundância é aceita e incentivada para acelerar as consultas. Por consequência, o BI não roda no banco OLTP. O trabalho da Engenharia de Dados é mover os dados do OLTP para o OLAP.

Seu foco é na Leitura Rápida (`SELECT` complexo, `SUM`, `AVG`).

## ETL

O coração do BI é o processo de **ETL (Extract, Transform, Load)**, que é o que a Engenharia de Dados faz.

1. **Extract:** Conectar-se aos sistemas OLTP e "puxar" os dados brutos.
2. **Transform:** É a etapa mais importante. Aqui você:
    - Limpa os dados (corrigir 'RJ' e 'Rio de Janeiro' para um padrão único).
    - Enriquece os dados (cruzar um CEP com uma tabela de regiões).
    - Modela os dados (transformar a estrutura normalizada OLTP na estrutura desnormalizada OLAP).
3. **Load:** Inserir os dados transformados e limpos no destino final, o **Data Warehouse (DW)**.

## Componentes de uma Solução de BI

- **Fontes de Dados:** Bancos OLTP, planilhas, arquivos, etc.
- **Pipeline de ETL:** A ferramenta que move e transforma os dados (ex: Pentaho, SAP Data Services, Python/Spark, Azure Data Factory).
- **Data Warehouse (DW):** O grande banco de dados OLAP, otimizado para análise (Redshift, Synapse, Oracle ADB).
- **Camada de Visualização (Ferramentas de BI):** O software que o usuário final usa para ver os gráficos (ex: Power BI, Tableu, Oracle Analytics Cloud).
