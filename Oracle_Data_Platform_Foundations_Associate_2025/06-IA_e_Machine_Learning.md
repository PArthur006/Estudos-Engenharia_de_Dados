# 06 - Serviços de IA e Machine Learning na OCI

## Estratégia da Oracle: IA Perto dos Dados

A estrategia da Oracle é levar os algoritmos de **Inteligência Artificial (IA)** e **Machine Learning (ML)** para onde os dados estão, ou seja, **diretamente dentro do Oracle Database**. Isso minimiza a movimentação de dados, reduz a latência, simplifica a arquitetura e aumenta a segurança.

## Principais Serviços e Ferramentas

1.  **Oracle Machine Learning (OML):**
    - **OML4SQL:** Permite que DBAs e desenvolvedores SQL construam, avaliem e apliquem modelos de ML usando apenas comandos SQL. Os algoritmos rodam diretamente na engine do banco.
    - **OML4Py / OML4R:** Oferece APIs Python e R para cientistas de dados, permitindo que eles usem linguagens e bibliotecas familiares para interagir com os dados e algoritmos no banco, mas com a execução sendo empurrada (pushed down) para o banco de dados para maior performance.
    - **AutoML:** Uma interface gráfica que automatiza o processo de seleção de algoritms, features e tuning de hiperparâmetros, tornando o ML acessível a não especialistas.

2.  **OCI AI Services:**
    - São serviços pré-treinados que podem ser consumidos via API para adicionar funcionalidades de IA a aplicações. Eles se integram facilmente com dados armazenados na OCI.
    - **OCI Vision:** Análise de imagens (detecção de objetos, OCR).
    - **OCI Language:** Processamento de Linguagem Natural (análise de sentimento, extração de entidades).
    arraigado
    - **OCI Speech:** Transcrição de áudio para texto.
    - **OCI Anomaly Detection:** Detecção de anomalias em dados de séries temporais.

## Integração com Autonomous Database

O Autonomous Database vem com o Oracle Machine Learning totalmente integrado. Isso significa que é possível treinar e executar um modelo de ML em dados armazenados no ADB sem precisar de nenhuma infraestrutura adicional e sem mover os dados para fora do banco.
