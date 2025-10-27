# Configuração e Estrutura Física (SQL Server)

## Componentes Físicos do Banco de Dados

Um Banco de Dados (BD) no SQL Server é composto por arquivos físicos no disco:

- **Arquivo de Dados Primário (.mdf):** É o ponto de partida do BD.
    - Guarda os dados das tabelas, índices e a estrutura (metadados).
    - **Regra:** Todo BD tem obrigatoriamente 1 arquivo `.mdf`.
- **Arquivo de Log de Transações (.ldf):** Registra todas as modificações (INSERT, UPDATE, DELETE, etc.).
    - Essencial para recuperação de desastres (restore) e para garantir a integridade das transações (ACID).
    - **Regra:** Todo BD tem pelo menos 1 arquivo `.ldf`.

---

