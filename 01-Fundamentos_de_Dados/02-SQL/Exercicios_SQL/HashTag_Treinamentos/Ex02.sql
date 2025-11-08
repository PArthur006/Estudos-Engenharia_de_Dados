USE DB_MiniCurso_HashTag;
-- a) Faça uma consulta na tabela de lojas e ordene a tabela de acordo com a coluna de Num_Funcionarios, em ordem crescente.Obs: Sua consulta deve retornar as colunas de Loja (AS 'Nome da Loja'), Endereco (AS 'Endereço'), Num_Funcionarios (AS 'Qtd. Funcionários') e Telefone (AS 'Número para contato').
SELECT 
    Num_Funcionarios AS "Qtd. Funcionários",
    Loja AS "Nome da Loja",
    Endereco AS "Endereço",
    Telefone AS "Número para Contato"
FROM lojas
ORDER BY Num_Funcionarios;

-- b) Faça uma cosulta na tabela de clientes, ordenando a tabela de acordo com o nome (ordem alfabética) e sobrenome (ordem alfabética). Retorne todas as colunas e linhas da tabela.

SELECT * FROM clientes
ORDER BY Nome, Sobrenome;