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
