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
