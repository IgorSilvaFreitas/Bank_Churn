# Motivação

 Churn é um grande problema para a maioria das empresas, por isso é importante se averiguar o motivo e comportamento dos clientes que cometem churn. Podendo identificar clientes sucetiveis ao churn, a empresa pode adotar medidas preventivas para não perder o cliente, como aplicação de descontos ou acrescentar serviços sem custo adicional.


# Base de dados

A base de dados contém, inicialmente, 14 variáveis, sendo elas:

- Row Number
- Customer Id
- Surname
- Credit Score
- Geography
- Gender
- Age
- Tenure
- Balance
- Number of products
- Has credit card
- Is Active member
- Estimated Salary
- Exited (churn)

As três primeiras variáveis serão excluidas, tanto das análises descritivas quanto do modelo, pois são apenas identificação do cliente.

# Análises descritivas

## Dados faltantes

A base de dados não possui dados faltantes

## Análises independentes

Para cada variável do banco de dados foi realizado uma análise a fim de identificar o comportamento de suas distribuições, e os seguintes insights foram percebidos:

1. Há um desbalanceamento das classes na variável target. O balanceamento em casos de churn é necessário, pois o modelo deve ser capaz de errar o minimo possível os clientes propensos a churn.

2. Na França há o drobro de cliente se comparado a Alemanha e Espanha

3. Há apenas uma leve diferença na frequência de cliente segundo o sexo, onde há mais cliente homens

4. Boa parte dos cliente possui entre 25 e 50 anos

5. As observações de Tenure são diversificadas, obtendo seu ponto central em 5

6. Há uma enorme quantidade de cliente com a conta zerada

7. A variabilidade está concentra em 1 ou 2 produtos por cliente, poucos possuem 3 ou mais produtos

8. A maioria dos clientes possuem cartão de crédito

9. A maioria dos cliente tem sálario estimado entre 50 e 150 mil

## Análises cruzadas

O próximo passo foi avaliar a relação das covariáveis independentes com a variável target, obtendo-se tais insights:

1. Clientes que possuem baixo creditscore possuem maior tendência a cometer chuurn

2. Cliente alemães, proporcianalmente, tem maior tendência a cometer churn

3. O genêro não parece influenciar no churn

4. Pessoas mais velhas aparentam ser mais sucetíveis ao churn

5. Cliente que cometem churn aparentam ter Tenure mais próximas de 5

6. O balanço bancário não parece influenciar no churn

7. Aparentemente, quanto menos produtos maior a probabilidade de cometer churn

8. O fato de possuir cartão de crédito, proporcionalmente, não parece influenciar no churn

9. Aparentemente, clientes não ativos tem uma tendência levemente maior à cometer churn do que cliente ativos

10. O salário do cliente parece não influenciar no churn

# Tratamentos e pré processamentos

Variáveis categóricas Geography e Gender foram transformadas em dummies, a fim de tornar possível a realização de teste de correlação e combinação linear.

O passo seguinte foi separar a amostra treino e teste. Foi usada a função createdatapartition pois ela não seleciona amostras aleatoriamente, e sim com base em semelhanças. Sendo assim menos sucetível a gerar amostras desconexas com a base de dados.

Foi realizado um teste para analisar se existiam variáveis que possuiam baixa variabilidade, e como visto nas análises descritivas, nenhuma variável correspondeu a essa suposição.

A base não possui variáveis correlacionadas ou que são combinações lineares de outras, essa etapa é importante pois variáveis altamente correlacionadas tendem a causar overfitting ou 'quebrar o modelo' e variáveis que são combinações lineares serão 'inúteis', pois serão 2 ou mais variáveis que apresentam a mesma informação.

As variáveis categóricas, Geography, Gender e Exited estavam como numéricas, e foram transformadas em fator.

Pensando em possíveis problemas na coleta de dados um novo cliente, foram 'implantados' dados faltantes na amostra treino, a afim de gerar um pré processamento para dados falntes em novos clientes.

Por fim, foram testados 2 modelos para verificar qual possuia as melhores métricas, e também menor tempo de processamento. Os modelos e resultado são:

* XGBoost
- Acurácia = 0.77
- sensibilidade = 0.78
- specificidade(recall) = 0.74
- F1 = 0.85

* Linear Support Vector Machine
- Acurácia = 0.73
- sensibilidade = 0.73 
- specificidade(recall) = 0.73
- F1 = 0.81

# Conclusão

O modelo final escolhido foi o XGBoost, possuindo boas medidas de acurácia e sensibilidade, que é o acerto dos casos afirmativo para ocorrência de churn.


