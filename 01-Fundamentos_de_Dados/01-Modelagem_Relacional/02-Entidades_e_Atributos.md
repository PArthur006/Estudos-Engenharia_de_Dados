## Aula 03: Modelos Conceitual, Lógico e Físico

### Níveis da Modelagem de Dados: As Camadas de Abstração

A modelagem de dados é um processo dividido em etapas que nos leva de uma ideia de alto nível sobre as necessidades do negócio até a implementação técnica em um banco de dados. Cada nível de modelagem serve a um propósito específico e se comunica com um público diferente.

- **a) Modelo Conceitual:**
    - É a visão de mais alto nível do baco de dados. Representa os conceitos de negócio e suas regras, focando em "o quê" o sistema deve armazenar, e não em "como" ele vai armazenar.
    - **Características Principais:**
        - **Independente de Tecnologia:** Não se preocupa com qual SGBD será usado, nem com detalhes técnicos como tipos de dados ou índices.
        - **Foco no Negócio:** Descreve as principais entidades e como elas se relacionam.
        - **Ferramenta Principal:** Utiliza o **Modelo Entidade-Relacionamento(MER)** e seu diagrama (**DER**) para representar visualmente a estrutura.
    - Tem como público-alvo analistas de negócio, stakeholders e gerentes. Serve como um ponto de partida para garantir que o modelo de dados está alinhado com as regras e processos da empresa.
- **b) Modelo Lógico:**
    - É a evolução do modelo conceitual. Ele traduz as entidades e relacionamentos em uma estrutura mais detalhada, geralmente a do modelo relacional (tabelas), mas ainda sem se prender a um SGBD específico.
    - **Características Principais:**
        - **Estrutura Detalhada:** Define as tabelas, as colunas (atributos) para cada tabela, e especifica as **chaves primárias** e **chaves estrangeiras** que implementam os relacionamentos.
        - **Normalização:** É nessa fase que aplicamos as regras de normalização para evitar redundância e garantir a integridade dos dados.
        - **Ainda independente de SGBD:** Embora já pareça com um banco de dados relacional, ele não define tipos de dados específicos de um sistema.
    - Tem como público alvo DBAs, arquitetos de dados e desenvolvedores. É a planta detalhada para a contrução do banco de dados.
- **c) Modelo Físico:**
    - É a representação final e implementável do banco de dados. Aqui, todas as decisões técnicas são tomadas com base no SGBD escolhido.
    - **Características Principais:**
        - **Dependente de Tecnologia:** É projetado para um SGBD específico.
        - **Detalhes de Implementação:** Define com precisão os nomes das tabelas e colunas, os tipos de dados exatos, as restrições, os índices para otimização de consultas, e outros elementos físicos como particionamento de tabelas.
        - Este modelo é usado para gerar o script SQL (DDL - Data Definition Language) que irá criar a estrutura do banco de dados no servidor.
    - Tem como público-alvo os DBAs e desenvolvedores que irão implementar e manter o banco de dados.

### Arquitetura de Três Níveis e Esquema

- **Arquitetura de Três Níveis (ANSI-SPARC):** É um padrão que formaliza a separação entre a visão do usuário, a estrutura lógica e o armazenamento físico.
    - **Nível Externo:** Como os usuários e aplicações veem os dados (views, relatórios).
    - **Nível Conceitual:** A visão unificada de todo o banco de dados (Corresponde ao **Modelo Lógico**).
    - **Nível Interno:** Como os dados são fisicamente armazenados no disco (Corresponde ao **Modelo Físico**).
- **Esquema do Banco de Dados (Schema):** É a descrição formal da estrutura do banco de dados, o "esqueleto". O processo de modelagem (conceitual, lógico, físico) é o que utilizamos para projetar e definir o esquema final que será implementado.

### Etapas do Desenvolvimento de um Banco de Dados

O processo de modelagem se encaixa perfeitamente no ciclo de vida de desenvolvimento de um sistema de banco de dados.
1. **Análise de Requisitos:** A fase inicial, onde se coleta e se analisa as necessidades de informação dos usuários e do negócio. Entrevistas, análise de documentos e workshops são comuns aqui.
2. **Projeto Conceitual:** Usando os requisitos levantados, cria-se o **Modelo Conceitual (DER)**. É a fase de traduzir as regras de negócio em entidades e relacionamentos.
3. **Projeto Lógico:** O Modelo Conceitual é mapeado para o **Modelo Lógico**. Entidades se tornam tabelas, atributos se tornam colunas e relacionamentos são implementados com chaves estrangeiras.
4. **Projeto Físico:** O Modelo Lógico é traduzido para o **Modelo Físico**, considerando as particularidades do SGBD escolhido para otimizar o desempenho, a segurança e o armazenamento.
5. **Implementação e Manutenção:** o script gerado a partir do Modelo Físico é executado para criar o banco de dados. A manutenção contínua garante que o banco de dados continue atendendo às necessidades.

---
---

## Aula 04: Modelo Entidade-Relacionamento (MER) e seu Diagrama (DER)

### O Modelo Entidade-Relacionamento (MER)

- O Modelo Entidade-Relacionamento, proposto por Peter Chen em 1976, é uma abordagem de alto nível para a modelagem de dados. Ele nos permite criar um **modelo conceitual**, que descreve a estrutura de um banco de dados de uma forma visual e intuitiva, focando nos dados e em como eles se conectam, sem se preocupar com os detalhes técnicos da implementação.
- O objetivo principal do MER é traduzir os requisitos de negócio em um formato padronizado e claro. Ele serve como uma ponte de comunicação entre os analistas de negócio (que entendem as regras) e os desenvolvedores/DBAs (que vão construir o sistema).

### Entendendo os Conceitos: MER vs. DER

É comum usar os termos MER e DER quase como sinônimos, mas há uma distinção importante:

- **MER (Modelo Entidade-Relacionamento):** Refere-se à **abordagem teórica**, ao conjunto de conceitos e regras que usamos para pensar e descrever a estrutura dps dados. É o modelo mental.
- **DER (Diagrama Entidade-Relacionamento):** É a **representação gráfica** e visual do MER. É o desenho que utiliza símbolos padronizados para ilustrar o modelo, tornando-o fácil de entender e discutir. É a planta baixa do banco de dados.

Em resumo, usamos o **modelo (MER)** para pensar e o **diagrama (DER)** para desenhar e comunicar.

### Componentes Fundamentais do DER

O Diagrama Entidade-Relacionamento é construído com quatro elementos básicos que se conectam para formar a estrutura completa do banco de dados.

1. **Entidade:** Um objeto ou conceito do mundo real sobre o qual desejamos armazenar informações. Deve ser algo claramente identificável.
    - **Exemplos:** `CLIENTE`, `PRODUTO`, `FUNCIONÁRIO`, `PEDIDO`.
    - Representada por um **Retângulo**.
2. **Atributo:** Uma característica ou propriedade que descreve uma entidade.
    - **Exemplos:** Para a entidade `CLIENTE`, os atributos poderiam ser `Nome`, `CPF`, `Email`, `DataNascimento`.
    - Representado por uma **Elipse**.
3. **Relacionamento:** A associação ou interação que existe entre duas ou mais entidades. Geralmente é nomeado com um verbo.
    - **Exemplo:** Um `CLIENTE` **faz** um `PEDIDO`. Um `FUNCIONÁRIO` **registra** uma `COMPRA`.
    - Representado por um **Losango**.
4. **Linhas (Ligações):** Conectam os componentes do diagrama, mostrando quais atributos perencem a quais entidades e quais entidades participam de quais relacionamentos.

### Exemplo de um Diagrama Entidade-Relacionamento (DER) Simples

![Imagem do Exemplo de um DER de uma biblioteca](https://svg.template.creately.com/1JJn07fBvaD)

---
---

## Aula 05: Apronfundando em Entidades

No contexto da modelagem de dados, uma **Entidade** é o bloco de construção fundamental. Ela representa um objeto, conceito ou evento do mundo real que é distinguível e sobre o qual queremos coletar e armazenar informações. Pense em uma entidade como uma "caixa" ou "gaveta" onde agrupamos dados sobre um assunto específico.

- **Definição Formal:** Uma entidade é um conjunto de objetos (chamados de instâncias) com as mesmas características (atributos).
- **Identificação:** Para ser uma entidade válida, devemos ser capazes de identificar de forma única cada ocorrência dela. Por exemplo, podemos distinguir um cliente de outro através de seu CPF ou de um código de cliente.
- **Exemplos Clássicos:** `PRODUTO`, `CLIENTE`, `NOTA_FISCAL`, `ALUNO`, `CURSO`, `FORNECEDOR`.

### Regras para Nomear Entidades

A forma como nomeamos as entidades é crucial para a clareza e a manutenibilidade do modelo de dados. Boas práticas de nomenclatura garantem que o diagrama seja facilmente compreendido por qualquer pessoa que o analise.

1. **Use substantivos:** Entidades representam "coisas". Portanto, devem ser nomeadas com substantivos.
    - Bom: `CLIENTE`, `CARRO`, `CONSULTA`.
    - Ruim: `CadastrarCliente`, `Comprar`, `Agendando`.
2. **Seja Específico e Significativo:** O nome deve descrever claramente o que a entidade representa, evitando ambiguidades.
    - Bom: `NOTA_FISCAL` em vez de apenas `DOCUMENTO`. `FUNCIONÁRIO` em vez de apenas `PESSOA` (a menos que o sistema lide com diferentes tipos de pessoas, como clientes e funcionários).
3. **Use Letras Maiúsculas e Singular:** Por convenção, para destacar as entidades no diagrama e diferenciá-las de outros elementos, seus nomes são escritos em letras maiúsculas e no singular.
    - Padrão: `PRODUTO`, `PEDIDO`.
    - Por que no singular? Porque a entidade representa o conceito ou o "molde" de um único objeto. A coleção de todos os produtos, por exemplo, estará dentro da tabela que será gerada a partir da entidade `PRODUTO`.
4. **Evite Abreviaturas e Nomes Muito Longos:** Nomes devem ser concisos, mas completos. Use abreviações apenas se forem universalmente conhecidas e aceitas no contexto do negócio.
    - Bom: `NOTA_FISCAL` em vez de `NF`.
    - Ruim: `RELATORIO_DE_VENDAS_CONSOLIDADAS_POR_REGIAO`. Isso poderia ser simplificado ou dividido.

### Instância de uma Entidade

Enquanto a **Entidade** é a representação abstrata e genérica (o molde), uma **instância** é uma ocorrência específica e real dessa entidade. É um único objeto que pertence àquele conjunto.

Pense na analogia de uma planilha:

- **Entidade:** É o nome da aba da planilha, que define o assunto. Por exemplo, "CLIENTES". Também pode ser vista como cabeçalho das colunas (`ID`, `Nome`, `Email`), que define a estrutura.
- **Instância de Entidade:** É cada **linha** preenchida na planilha. Cada linha representa um cliente único e real.

### Exemplo Prático

- **Entidade:** `ALUNO`
- **Instâncias da Entidade** `ALUNO`:
    - A aluna "Maria Silva", com matrícula "2025001".
    - O aluno "João Pereira", com matrícula "2024002".

No modelo relacional, a Entidade se tornará uma tabela e cada instância se tornará uma linha nessa tabela. O objetivo do nosso modelo é definir a estrutura perfeita para armazenar essas instâncias de forma organizada e consistente.

---
---

## Aula 06: Detalhando as Entidades com Atributos

### O que são Atributos

Se uma **Entidade** é a "gaveta" que armazena informações sobre um assunto, os **Atributos** são as "etiquetas" dentro dessa gaveta. Eles representam as propriedades ou características que descrevem e qualificam uma entidade. Cada instância de uma entidade terá um valor específico para cada um de seus atributos.

- **Definição:** Um atributo é um dado elementar que descreve uma característica de uma entidade.
- **Exemplo:** Se a entidade `PRODUTO`, seus atributos podem ser `Codigo`, `Nome`, `Descricao` e `Preco`. Para uma instância específica, teríamos:
    - `Codigo:` 1001
    - `Nome:` "Caderno Universitário
    - `Descricao:` "96 folhas, capa dura"
    - `Preco:` 15.90

### Representando Atributos no DER

No Diagrama Entidade-Relacionamento (DER) clássico, os atributos são representados por **elipses**, conectadas por uma linha à sua respectiva entidade.

### Tipos de Atributos

Os atributos podem ser classificados de acordo com sua estrutura e função, o que nos ajuda a criar um modelo de dados mais preciso.

- a) Atributo Simples
    - É um atributo indivisível, que não pode ser subdividido em partes menores com significado próprio.
    - **Exemplos:** `Preco`, `Sexo`, `EstadoCivil`, `QuantidadeEstoque`. Não há como "quebrar" o preço de um produto em partes menores que façam sentido isoladamente no modelo.
- b) Atributo Composto
    - É um atributo que pode ser dividido em subpartes menores, que também são atributos com significado próprio.
    - Tem por finalidade agrupar atributos relacionados para organizar melhor o modelo.
    - **Exemplo Clássico:** O atributo `Endereço` pode ser composto pelos atributos `Logradouro`, `Numero`, `Bairro`, `Cidade` e `CEP`.
    - **Representação no DER:** A elipse principal (`Endereco`) é conectada à entidade, e as elipses dos sub-atributos são conectadas à elipse principal.
- c) Atributo Multivalorado
    - É um atributo que pode ter **múltiplos valores** para uma mesma instância da entidade.
    - **Exemplo:** Uma pessoa (entidade `CLIENTE`) pode ter mais de um número de telefone ou mais de um email.
    - Na passagem para o modelo lógico (tabelas), atributos multivalorados geralmente dão origem a uma nova tabela para garantir a forma normal.
    - **Representação no DER:** É representado por uma **elipse dupla**.
- d) Atributo Determinante (Identificador ou Chave)
    - É um atributo (ou conjunto de atributos) cujo valor **identifica de forma única** cada instância de uma entidade. Ele não pode se repetir dentro da mesma entidade e, geralmente, não pode ser nulo.
    - É a base para a criação da **Chave Primária** no banco de dados. É o que nos permite encontrar um registro específico sem qualquer ambiguidade.
    - **Exemplos:**
        - `CPF` para a entidade `CLIENTE`.
        - `Matricula` para a entidade `ALUNO`.
        - `CodigoDeBarras` para a entidade `PRODUTO`.
    - **Representação no DER:** O nome do atributo na elipse é **sublinhado**.

---
---


## Aula 09: Chave Primária, Estrangeira e outras

Chaves são colunas ou um conjunto de colunas em uma tabela usadas para identificar, localizar e relacionar registros de forma única e inequívoca. São a base para a integridade e os relacionamentos em um banco de dados.

### Tipos de Chaves

1. **Chave Candidata (Candidate Key):**
    - Qualquer coluna ou conjunto de colunas que tem o potencial para ser a chave primária.
    - **Regra:** Seus valores devem ser únicos para cada linha da tabela.
    - Uma tabela pode ter várias chaves candidatas.
    - Exemplo: Em uma tabela `ALUNOS`, tanto o `CPF` quanto o `Número de Matrícula` são chaves candidatas, pois ambos identificam um aluno de forma única.
2. **Chave Primária (Primary Key - PK):**
    - É a **chave candidata escolhida** para ser o identificador principal da tabela.
    - **Regras Fundamentais:**
        1. **Unicidade:** Não pode haver valores duplicados na coluna da PK.
        2. **Não Nulidade:** Não pode conter valores nulos (NULL).
    - Cada tabela só pode ter **uma** chave primária.
3. **Chave Estrangeira (Foreign Key - FK):**
    - É uma coluna (ou conjunto de colunas) em uma tabela que se refere à chave primária de outra tabela.
    - É o mecanismo que estabelece e reforça o **relacionamento** entre duas tabelas, garantindo a **integridade referencial** (ou seja, não se pode ter um `id_cliente` na tabela de `PEDIDOS` que não exista na tabela de `CLIENTES`).
4. **Chave Composta (Composite Key):**
    - Uma chave primária que é formada por **duas ou mais colunas**  combinadas.
    - A unicidade é garantida pela combinação dos valores das colunas, não por cada coluna individualmente.
    - Exemplo: Em uma tabela associativa `ITEM_PEDIDO`, a chave primária pode ser a combinação de `ID_Pedido` + `ID_Produto`.
5. **Chave Surrogada / Substituta (Surrogate Key):**
    - É uma chave **artificial**, geralmente um número inteiro sequencial (Ex: 1, 2, 3...) criada com o único propósito de ser a chave primária.
    - É usada quando não existe uma chave candidata "natural" (como um CPF) ou quando as chaves naturais são muito grandes, complexas ou podem mudar com o tempo. É a prática mais comum no mercado.

### Conceito de Domínio

- O domínio de um atributo é o **conjunto de todos os valores possíveis e permitidos** para aquele atributo.
- **Implicações:** Define o tipo de dado (texto, número, data), o tamanho, o formato e quaisquer outras restrições (constraints) que o valor pode assumir.
    - Exemplo: O domínio do atributo `UF` pode ser uma lista das 27 siglas dos estados brasileiros. O sistema não aceitaria um valor não presente na lista.

---
---
