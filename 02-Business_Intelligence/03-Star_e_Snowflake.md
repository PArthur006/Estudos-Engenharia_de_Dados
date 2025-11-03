# Modelagem Dimensional: Star-Schema e Snowflake-Schema

> Star-Schema (Esquema Estrela) e Snowflake-Schema (Esquema Floco de Neve) não são coisas diferentes da Modelagem Dimensional. Eles são os **dois principais "layouts"** (padrões de design) para organizar suas tabelas Fato e Dimensão.

> A diferença fundamental entre eles é o nível de **Normalização** aplicado às tabelas de Dimensão.

## Star-Schema (Esquema Estrela)

> É o padrão da modelagem dimensional mais comum e preferido. As tabelas de Dimensão são **Totalmente Desnormalizadas**.

- **A estrutura:**
    - Uma **Tabela Fato** (ex: `Fato_Vendas`) fica no centro.
    - As **Tabelas Dimensão** (ex: `Dim_Cliente`, `Dim_Produto`, `Dim_Tempo`) são conectadas diretamente à tabela Fato.
    - Visualmente, parece uma estrela, com o Fato no meio e as Dimensões como "pontas".
    - **Vantagens:**
        1. **Performance (Velocidade):** É extremamente rápido para consultas. Uma consulta (`SELECT`) só precisa fazer **um** (`JOIN`) para ir do Fato a qualquer atributo de uma Dimensão.
        2. **Simplicidade:** O modelo é muito fácil de entender e consultar.
    - **Desvantagens:** 
        1. **Redundância:** Armazena muitos dados repetidos (mas de maneira proposital).
        2. **Armazenamento:** Usa mais espaço em disco (hoje em dia, armazenamento é barato e performance é ara, por isso este "contra" é irrelevante na maioria dos casos).

