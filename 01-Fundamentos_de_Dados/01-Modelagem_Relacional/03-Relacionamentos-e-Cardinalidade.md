## Aula 08: O que são Relacionamentos

Um relacionamento é uma **associação ou vínculo** entre duas ou mais entidades. Ele representa uma interação ou dependência que existe entre elas no mundo real.

Sem relacionamentos, teríamos apenas conjuntos de dados isolados. Os relacionamentos permitem cruzar informações entre tabelas, evitando a redundância de dados e garantindo a consistência. É o que transforma dados em um sistema de informação coeso.

- Exemplo: Em vez de repetir todos os dados de um cliente em cada pedido que ele faz, nós relacionamos a entidade `PEDIDO` com a entidade `CLIENTE`.

No Diagrama Entidade-Relacionamento, um relacionamento é representado por um **losango**, que conecta as entidades envolvidas.

## Grau de um Relacionamento

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
