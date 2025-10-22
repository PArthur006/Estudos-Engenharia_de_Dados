### Normalização

É um conjunto de regras (Formas Normais) aplicadas ao projeto de banco de dados para organizar as tabela.

- **Objetivos:**
    - Reduzir a redundância (repetição) de dados.
    - Ampliar a integridade dos dados.
    - Melhorar o desempenho.
- **Função:** Evita **anomalias** (falhas) que podem ocorrer durante operações de `INSERT`, `UPDATE` ou `DELETE`.

### Formas Normais Principais:

- **Primeira Forma Normal (1FN):**
    - **Regra:** A tabela não deve conter atributos compostos ou multivalorados. Todas as colunas devem conter valores **atômicos** (únicos, indivisíveis). Não deve haver grupos repetidos de colunas.
    - **Ação:** Remover os grupos de itens repetidos, geralmente criando uma nova tabela para eles.
- **Segunda Forma Normal (2FN):**
    - **Regra:** A tabela deve estar em 1FN e todos os atributos não-chave devem depender funcionalmente da **chave primária inteira**.
    - **Contexto:** Esta regra é relevante principalmente para tabelas com **chaves primárias compostas**.
    - **Ação:** Remover atributos que dependem apenas de parte da chave composta para uma nova tabela separada.
- **Terceira Forma Normal (3FN):**
    - **Regra:** A tabela deve estar em 2FN e nã pode conter atributos não-chave que dependam de outros atributos não-chave (ou seja, sem **dependência transitiva**).
    - **Ação:** Remover os campos que dependem de outros campos (que não são a chave) para uma nova tabela.
    - **Exemplo:** Se a tabela `FUNCIONARIO` tem `ID_CEP` (que não é chave) e `Nome_Rua` (que depende do `ID_CEP`), `Nome_Rua` deve ser movido para uma tabela `CEP`.
