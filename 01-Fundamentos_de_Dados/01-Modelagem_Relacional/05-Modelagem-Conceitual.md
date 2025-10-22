# Modelagem Conceitual

### Definição

O Modelo Conceitual é a prmeira etapa da modelagem e se baseia na **analise de requisitos**. É um detalhaento de alto nível, focado em entender e descrever todas as Regras de Negócio (RN) do sistema (minimundo), sem se preocupar com a tecnologia de implementação.

## Modelo Entidade-Relacionamento (MER)

- **História e Definição:** Criado por Peter Chen em 1976, o MER é uma abordagem conceitual para o design de bancos de dados. Ele se baseia na Teoria Relacional e enxerga o "minimundo" como um conjunto de **entidades** e **relacionamentos** entre elas.
- **Abstração:** O MER utiliza métodos de abstração (como classificação, agregação e generalização) para representar a realidade, omitindo peculiaridades que não são relevantes para o sistema.

### Elementos do MER: Entidades

- **Definição:** Qualquer objeto ou conceito do mundo real sobre o qual desejamos armazenar informações (ex: um cliente, um produto, um evento).
- **Tipos de Entidade (Conceitual):**
    - **Tipo Físico:** Algo tangível (ex: `Produto`, `Funcionario`).
    - **Tipo Lógico:** Algo abstrato ou conceitual (ex: `Venda`, `Curso`).
- **Categorias de Entidade:**
    - **Entidade Forte:** Existe independentemente de outras. É a entidade principal (ex: `PRODUTO` em um sistema de vendas).
    - **Entidade Fraca:** Sua existência **depende** de outra entidade (ex: `ITEM_VENDA` depende da existência de uma `VENDA`).
    - **Entidade Associativa:** Surge de um relacionamento **Muitos-para-Muitos (M:N)**. No MER, um relacionamento não pode ser associado diretamente a outra entidade. Para resolver isso, o relacionamento M:N é transformado em uma Entidade Associativa, que pode então se relacionar com outras (ex: a entidade `BRINDE` não se relaciona nem com `PRODUTO` nem com `VENDA`, mas sim com o `ITEM_DA_VENDA`, que é a entidade associativa que surgiu do relacionamento M:N entre `PRODUTO` e `VENDA`).

## Diagrama Entidade-Relacionamento (DER)

- **MER vs. DER:** O **MER** é o modelo conceitual (a ideia, a teoria). O **DER** é a sua **representação gráfica** (o fluxograma, o desenho).
- **Notação Clássica (Chen):**
    - **Entidades:** Retângulos;
    - **Relacionamentos:** Losangos (contendo um verbo);
    - **Atributos:** Elipses (conectados às suas entidades ou relacionamentos).
- **Notação Moderna (UML / "Pé de Galinha"):**
    - Frequentemente, os atributos são listados dentro do retângulo da entidade (como na UML), por ser uma representação mais limpa e fácil de ler.
- **Simbologia Gráfica (Revisão):** O DER possui notações específicas para atributos-chave, multivalorados, compostos, etc., e também para as cardinalidades (mínima e máxima).

### Extensões do DER: Generalização e Especialização

Utilizadas para representar hierarquias e heranças de atributos entre entidades.

- **Generalização:** É o processo de "subir" na hierarquia. Identifica atributos comuns em várias entidades (subgrupos) e os agrupa em uma entidade mais genérica (supergrupo ou "pai").
- **Especialização:** É o processo de "descer" na hierarquia. Identifica subgrupos dentro de uma entidade genérica. As entidades "filhas" (especializadas) **herdam** todos os atributos da entidade "pai" (genérica), mas podem ter seus próprios atributos específicos.
    - **Exemplo:** `MEDICO` é a entidade genérica. `MEDICO_RESIDENTE` e `MEDICO_EFETIVO` são especializações de `MEDICO`.
