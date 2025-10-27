# 04 - Converged Database

## Definição

**Converged Database** é o conceito de que o Oracle Database não é apenas um banco de dados relacional, mas uma plataforma que pode **armazenar e processar múltiplos modelos de dados** de forma nativa, em uma única engine de banco de dados.

## Vantagens

A abordagem de banco de dados convergente simplifica o desenvolvimento e a arquitetura de sistemas, eliminando a necessidade de gerenciar múltiplos bancos de dados especializados (poliglot persistence).

- **Simplicidade:** Reduz a complexidade de ter vários sistemas de banco de dados, cada um com seu próprio modelo de segurança, backup e gerenciamento.
- **Consistência:** Permite realizar transações ACID que abrangem diferentes modelos de dados.
- **Desenvolvimento Unificado:** Desenvolvedores podem usar uma única linguagem (SQL) e APIs consistentes para acessar e manipular todos os tipos de dados.
- **Menor Custo Total de Propriedade (TCO):** Menos sistemas para licenciar, manter e operar.

## Modelos de Dados Suportados

O Oracle Converged Database suporta nativamente:

- **Relacional:** O modelo tradicional de tabelas, linhas e colunas.
- **Documento (JSON):** Armazenamento e consulta de documentos JSON usando APIs SODA ou SQL/JSON.
- **Grafos (Graph):** Análise de relacionamentos e redes, como redes sociais ou detecção de fraudes.
arraigado
- **Espacial (Spatial):** Armazenamento e análise de dados geoespaciais (mapas, rotas, etc.).
- **Séries Temporais (Time Series):** Otimizado para dados que chegam em ordem cronológica, como dados de sensores (IoT).
- **Chave-Valor (Key-Value):** Acesso de alta performance a dados simples.
- **Blockchain:** Tabelas com proteção criptográfica contra alterações (Immutable Tables).
