## Aula 08: O que são Relacionamentos

Um relacionamento é uma **associação ou vínculo** entre duas ou mais entidades. Ele representa uma interação ou dependência que existe entre elas no mundo real.

Sem relacionamentos, teríamos apenas conjuntos de dados isolados. Os relacionamentos permitem cruzar informações entre tabelas, evitando a redundância de dados e garantindo a consistência. É o que transforma dados em um sistema de informação coeso.

- Exemplo: Em vez de repetir todos os dados de um cliente em cada pedido que ele faz, nós relacionamos a entidade `PEDIDO` com a entidade `CLIENTE`.

No Diagrama Entidade-Relacionamento, um relacionamento é representado por um **losango**, que conecta as entidades envolvidas.

### Grau de um Relacionamento

O "Grau" de um relacionamento é definido pelo **número de entidades** que participam dele.

- **a) Relacionamento Unário (ou Recursivo) - Grau 1:**
    - É um relacionamento de uma entidade **com ela mesma**. As ocorrências da entidade se relacionam entre si.
    - Em uma entidade `FUNCIONARIO`, pode haver um relacionamento "supervisiona", onde um funcionário (o gerente) supervisiona outros funcionários. Ambos são da mesma entidade `FUNCIONARIO`.
- **b) Relacionamento Binário - Grau 2:**
    - É o tipo mais comum. Ocorre quando há uma associação entre **duas entidades distintas**.
    - Exemplos:
        - Um `MEDICO` atende um `PACIENTE`.
        - Um `CLIENTE` faz um `PEDIDO`.
        - Um `AUTOR` escreve um `LIVRO`.
- **c) Relacionamento Ternário - Grau 3:**
    - Ocorre quando há uma associação simultânea entre **três entidades distintas**.
    - Um relacionamento ternário **não** é a mesma coisa que três relacionamentos binários. Ela representa uma única associação que só faz sentido com as três entidades juntas.
    - Exemplo: Um `MEDICO` prescreve um `MEDICAMENTO` para um `PACIENTE` em uma `CONSULTA`. A relação "prescreve" envolve as três simultaneamente.

### Relacionamentos entre Tabelas

No modelo lógico, os relacionamentos são implementados fisicamente através de **chaves estrangeiras (Foreign Keys)**. Uma tabela armazena a chave primária da outra tabela com a qual se relaciona, criando assim o vínculo entre os registros.

---
---

## Aula 10: Cardinalidades

A cardinalidade especifica o **número de instâncias** (linhas) de uma entidade que podem (ou devem) se relacionar com as instâncias de outra entidade. Ela define as regras quantitativas do relacionamento.

É sempre lida em pares (mínimo, máximo):

- **Cardinalidade Mínima:** Indica se o relacionamento é opicional (**0**) ou obrigatório (**1**).
- **Cardinalidade Máxima:** Indica o número máximo de instâncias que podem se relacionar (1 ou N para "muitos").

### Simbologia para Cardinalidades (Notações)

Existem várias formas de representar a cardinalidade em um Diagrama Entidade-Relacionamento (IDER). As duas mais comuns são:

1. **Notação de Peter Chen:**
    - Utiliza os números `1` e as letras `N` ou `M` escritos ao lado da linha que conecta as entidades ao losango do relacionamento.
    - Exemplo: `1` de um lado e `N` do outro para um relacionamento "um-para-muitos".
2. **Notação "Pé de Galinha" (Crow's Foot):**
    - É uma notação mais gráfica e visual, muito popular em ferramentas de modelagem.
    - **Símbolos:**
        - `o` (círculo): Representa "zero" (opcional).
        - `|` (traço): Representa "um" (obrigatório).
        - `<` (pé de galinha): Representa "muitos".
    - A combinação dos símbolos de mínimo (círculo ou traço) e máximo (traço ou pé de galinha) define a cardinalidade completa.

### Tipos de Relacionamento Binário

1. **Relacionamento Um-para-Um (1:1):** Uma Instância A só pode se relacionar com, no máximo, **uma** instância da Entidade B, e vice-versa.
    - Exemplo: Um `MARIDO` é casado com uma `ESPOSA`.
2. **Relacionamento Um-para-Muitos (1:N):** Uma instância da Entidade A pode se relacionar com **várias** instâncias da Entidade B, mas uma instância da Entidade B só pode se relacionar com, no máximo, **uma** instância da Entidade A.
    - É o tipo de relacionamento mais comum.
    - Exemplo: Um `CLIENTE` pode fazer muitos `PEDIDOS`, mas um `PEDIDO` pertence a apenas um `CLIENTE`.
3. **Relacionamento Muitos-para-Muitos (N:M):** Uma instância de A pode se relacionar com **várias** instâncias da Entidade B, e uma instância da Entidade B também pode se relacionar com **várias** instâncias da Entidade A.
    - Um `ALUNO` pode se matricular em **muitas** `DISCIPLINAS`, e uma `DISCIPLINA` pode ter **muitos** `ALUNOS`.

### Desmembrando o Relacionamento Muitos-para-Muitos (N:M)

- Relacionamentos N:M não podem ser implementados diretamente em um banco de dados relacional.
- Como solução, o relacionamento N:M deve ser "quebrado" ou "desmembrado", dando origem a uma nova entidade (ou tabela) no meio do caminho.
    - Essa nova entidade é chamada de **Entidade Associativa** (no modelo conceitual) ou **Tabela de Junção** (no modelo lógico).
    - **Estrutura:** A entidade associativa "herda" as chaves primárias das duas entidades originais, que se tornam suas chaves estrangeiras. A combinação dessas duas chaves estrangeiras geralmente forma a chave primária composta da nova tabela.
    - **Resultado:** O relacionamento N:M original é transformado em **dois** relacionamentos **1:N**.
        - `ALUNO` (1)---(N) `MATRICULA` (N)---(1) `DISCIPLINA`

---
---
