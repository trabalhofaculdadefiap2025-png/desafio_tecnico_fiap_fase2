[TECH CHALLENGE IADT] Sistema de Suporte ao Diagnóstico de Câncer de Mama (Fase 2)

💡 Descrição do Projeto
Este projeto é a evolução de um sistema de Machine Learning para auxílio ao diagnóstico médico.

Fase 1: Realizado um  modelo clássico (Decision Tree e Random Forest) e uma interface Streamlit.

Fase 2 (Atual): O foco foi a otimização de performance e interpretabilidade. Implementando Algoritmos Genéticos (GA) para otimizar os hiperparâmetros do modelo, alcançando máxima segurança (Recall 100%), e integrando Modelos de Linguagem (LLMs) via API do Google Gemini para gerar explicações clínicas detalhadas e humanizadas sobre os diagnósticos.

💾 Dataset e Fonte de Dados

O projeto utiliza o conjunto de dados de diagnóstico de câncer de mama. Link para Download: [https://www.kaggle.com/datasets/uciml/breast-cancer-wisconsin-data/data]

💻 Estrutura do Repositório


<img width="1210" height="196" alt="image" src="https://github.com/user-attachments/assets/e001e758-631f-4c71-9e38-607d576bbd53" />

⚙️ Instruções de Execução (via Docker)

Devido à integração com a IA Generativa, é necessário configurar a chave de API.

Pré-requisitos:

1-Ter o Docker instalado.
2-Criar um arquivo .env na raiz do projeto com sua chave: GEMINI_API_KEY=sua_chave_aqui

Passo 1: Construir a Imagem
docker build -t suporte-diagnostico-fase2.

Passo 2: Rodar o Container
É fundamental passar o arquivo de variáveis de ambiente (.env) na execução: docker run -p 8501:8501 --env-file .env suporte-diagnostico-fase2
Acesse em: http://localhost:8501

🔬 Relatório Técnico: Fase 2

1. Contextualização (O Ponto de Partida)
Na Fase 1, o  modelo baseline foi  (Decision Tree) alcançou um Recall de 90% para casos malignos. Embora bom, o modelo ainda apresentava 5 Falsos Negativos no conjunto de teste. Em medicina, falsos negativos são críticos. O objetivo da Fase 2 foi zerar esse erro.

2. Otimização via Algoritmos Genéticos (GA)
Utilizei a biblioteca DEAP para evoluir os hiperparâmetros do modelo Decision Tree.

Codificação (Genes): O cromossomo foi composto por max_depth, min_samples_leaf, criterion (gini/entropy) e splitter (best/random).

Função Fitness: Definida para maximizar o Recall da classe Maligna (1). O algoritmo premiava indivíduos que identificavam corretamente o câncer, mesmo que sacrificasse levemente a precisão global.

Operadores: Seleção por Torneio (Tournament), Cruzamento Uniforme (Uniform Crossover) e Mutação Inteira (Integer Mutation).

Resultado da Evolução: Após rodar 3 experimentos com diferentes taxas de mutação e tamanhos de população, o algoritmo convergiu para uma solução robusta e surpreendentemente simples:

Melhores Hiperparâmetros: max_depth=2, min_samples_leaf=10, criterion='entropy', splitter='best'.

Interpretação: O GA descobriu que uma árvore rasa (profundidade 2), mas baseada em grupos estatísticos sólidos (mínimo 10 amostras), generaliza melhor e evita o overfitting, garantindo segurança máxima.

3. Integração com LLMs (Interpretabilidade)
Para resolver o problema da "Caixa Preta", integrei o modelo Gemini 2.5 Flash/Pro.

Prompt Engineering: Desenvolvi um prompt de sistema que instrui o LLM a atuar como um "Analista de IA Médica".

Fluxo: O Python envia a probabilidade matemática + os dados brutos do paciente -> O LLM analisa os valores (ex: destaca se o perimeter_worst está extremo) -> O LLM gera um texto em linguagem natural justificando o diagnóstico.

4. Comparativo Final de Desempenho
A tabela abaixo demonstra o impacto direto das estratégias da Fase 2:
<img width="943" height="332" alt="image" src="https://github.com/user-attachments/assets/354196ac-dd48-4e76-8911-de57c9639600" />
