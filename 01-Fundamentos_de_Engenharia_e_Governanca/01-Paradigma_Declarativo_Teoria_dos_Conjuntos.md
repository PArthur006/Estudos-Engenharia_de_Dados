# 1. Paradigma Declarativo e Teoria dos Conjuntos

## 1.1 Procedural vs. Declarativo

O vício da engenharia de software é pensar em loops processando linha por linha. No banco de dados, iterar elemento por elemento destrói a performance, gera gargalo de rede e aumenta o custo computacional na nuvem. O SQL é uma linguagem declarativa: o foco não é ditar o “como” o motor deve andar pelos dados, mas declarar “o que” deve ser isolado.

## 1.2 Teoria dos Conjuntos na Prática

Bancos relacionais operam por blocos maciços de dados (Sets).

- Uma tabela é um conjunto matemático ($A$).
- Cada linha (registro) é um elemento $x$ pertencente a esse conjunto ($x$ *pertence* *a* $A$).
- A cláusula `WHERE`não é um `if`, é a declaração de um subconjunto. Quando você faz um `SELECT * FROM clientes WHERE status = 'ativo'`, você está declarando a criação de um novo conjunto $S$.
- O `INNER JOIN` representa a interseção de dois conjuntos. É a operação $A$ *interseção $B$.* Você pega o conjunto de dados do ECC, cruza com o conjunto do S4, e o banco te devolve apenas o bloco de dados que existe simultaneamente nos dois universos.
- O `EXCEPT` (ou `MINUS`) representa a diferença matemática. É o teste de integridade primário para descobrir quais chaves primárias ficaram para trás em uma migração de dados.

## 1.3 Filtros Seguros e Gargalos

Filtros são aplicados principalmente com a cláusula `WHERE` , suportando operadores de comparação (=, >, <, ≥, ≤, <>), lógicos (`AND`, `OR`, `NOT`), `LIKE`, `IN`, `BETWEEN`, e `IS NULL`.

**Perigo do `LIKE`:** Iniciar uma busca com caractere curinga anula a utilidade dos índices da tabela. O banco é forçado a fazer um Full Table Scan (ler o banco inteiro), o que é insustentável em tabelas de grande volume.

**Segurança por Design:** A cláusula `SELECT` deve ser explícita. Omitir colunas desnecessárias não é apenas uma questão de performance de rede, mas a aplicação prática do Princípio do Menor Privilégio, evitando a exposição de Informações Pessoais Identificáveis (PII) em logs e extrações.

## 1.4 A Limitação do Except

O comando `EXCEPT` exige simetria perfeita. Para comparar o sistema de origem com o de destino, ambos os lados da query precisam ter exatamente as mesmas colunas e tipos de dados. Se a auditoria exigir dados auxiliares sobre o registro que falhou (como a data de criação no sistema antigo), o `EXCEPT` deixa de ser uma opção viável.

Em uma necessidade de dar um desconto de 10% para 50 mil clientes, por exemplo, você executa uma única instrução: `UPDATE clientes SET valor = valor * 0.9 WHERE status = 'ativo'`. O banco de dados abre uma transação, bloqueia o bloco físico no disco, altera os 50 mil registros simultaneamente em nível de hardware, e fecha a transação. É massivo, eficiente e barato.