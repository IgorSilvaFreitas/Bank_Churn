# XGBoost Bank Churn
 Modelo e função para aplicação web para previsão de churn em bancos. Houve a comparação de 4 modelos, onde o XGBoost mostrou as melhores métricas de acurácia, recall, precisão e F1


# Pasos realizados
* Análise das variáveis sobre o cliente
* identificação de desbalancemento na variável de interesse
* Realização do balanceamento
* Realização de pré processamentos a fim de excluir variáveis pouco explicativas além da normalização e padronização das variáveis quantitativas
* Comparação dos modelos xgboost, svmLinear, rpart e Logit

# Métricas encontradas para o xgboost

* Acurácia = 0.8998
* sensibilidade = 0.9372
* specificidade(recall) = 0.8624
* F1 = 0.9034