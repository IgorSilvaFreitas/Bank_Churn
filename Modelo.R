#Base de dados
library(readr)
dados <- read_csv("C:/Users/Igor/Documents/GitHub/Churn XGBoost/XGBoost_Bank_Churn/churn.csv")


#Excluindo coluna com número da linha
dados <- dados[,-1]


#O número de id do cliente não deve afetar o modelo, então será excluída também
dados <- dados[,-1]

#Excluir o último nome do cliente
dados <- dados[,-1]

#Verificando classes das variáveis
str(dados)

#Verificando dados faltantes
library(naniar)
gg_miss_var(dados)
#Não há dados faltantes


#Análisando a variável de interesse
library(ggplot2)
library(dplyr)
cont_dad <- dados |>
  count(Exited)

cont_dad |> ggplot(aes(x=Exited, y=n))+
  geom_bar(stat="identity",
           fill="black") +
  geom_text(aes(label = n), 
            vjust=-0.5)

cont_dad[1,2]-cont_dad[2,2]
#A variável é desbalanceada


#Transformando variáveis para fator quando necessário


#fatorizando

dados$Geography <- as.factor(dados$Geography)
dados$Gender <- as.factor(dados$Gender)
dados$NumOfProducts <- as.factor(dados$NumOfProducts)
dados$HasCrCard <- as.factor(dados$HasCrCard)
dados$IsActiveMember <- as.factor(dados$IsActiveMember)
dados$Exited <- as.factor(dados$Exited)


#Pré processamentos

#Separando em amostras treino e teste para verificação de métricas
library(caret)
data <- caret::createDataPartition(y=dados$Exited, p=0.75, list = F)

treino <- dados[data,]
teste <- dados[-data,]

#Balanceando amostra treino
treino <- downSample(x=treino[,-11],y=treino$Exited)
treino <- treino |> rename(Exited=Class)
table(treino$Exited)


#Exlcuindo variáveis que possuem baixa variabilidade, e por isso, provavelmente não terá relevância
preproc <- preProcess(treino, method = c("nzv"))
treino <- predict(preproc,treino)
teste <- predict(preproc,teste)
#nenhuma variável removida

#Excluindo variáveis com alta correlação
preproc2 <- preProcess(treino, method = c("corr"))
treino <- predict(preproc2,treino)
teste <- predict(preproc2,teste)
#nenhuma variável removida

#Excluindo variáveis quantitativas linearmente dependente
preproc3<-caret::findLinearCombos(treino[,-c(2,3,7,8,9,11)])
preproc
#nenhuma a excluir

#padronização das variáveis
preproc4 <- caret::preProcess(treino , method = c("center", "scale"))
treino <- predict(preproc4, treino)
teste <- predict(preproc4, teste)

#normalização das variáveis
preproc5 <- caret::preProcess(treino, method = "YeoJohnson")
treino <- predict(preproc5, treino)
teste <- predict(preproc5, teste)


#Reamostragem 
set.seed(100)
controle <- caret::trainControl(method="repeatedcv", 
                                number=10, repeats=3)


#Modelo xgboost
modelo_xgb <- caret::train(Exited~ ., data=treino, method="xgbLinear",trControl=controle)
modelo_xgb


#Aplicando o modelo na amostra Teste
preditor <- predict(modelo_xgb, teste)

#Estimando o erro fora da amostra
result <- caret::confusionMatrix(preditor,teste$Exited)
accuracy <- result$overall[1]
precision <- result$byClass[1]
recall <- result$byClass[2]
f1 <- result$byClass[7]
#Acurácia = 0.7787115
#sensibilidade = 0.7864322
#specificidade(recall) = 0.7485265
#F1 = 0.8498507



#Modelo SVM exponential String Kernel
modelo_linear <- caret::train(Exited~ ., data=treino, method="svmLinear",trControl=controle)

#Aplicando o modelo na amostra Teste
preditor2 <- predict(modelo_linear, teste)

#Estimando o erro fora da amostra
result2 <- caret::confusionMatrix(preditor2,teste$Exited)
accuracy2 <- result2$overall[1]
precision2 <- result2$byClass[1]
recall2 <- result2$byClass[2]
f1.2 <- result2$byClass[7]
#Métricas inferiores ao xgboost

?specificity()
#Modelo rpart
modelo_rpart <- caret::train(Exited~ ., data=treino, method="rpart",trControl=controle)

#Aplicando o modelo na amostra Teste
preditor3 <- predict(modelo_rpart, teste)

#Estimando o erro fora da amostra
result3 <- caret::confusionMatrix(preditor3,teste$Exited)
accuracy3 <- result3$overall[1]
precision3 <- result3$byClass[1]
recall3 <- result3$byClass[2]
f1.3 <- result3$byClass[7]


# Modelo completo (logito)
modelo_logit <- glm(Exited ~., data = treino, family = binomial("logit"))

#Aplicando o modelo na amostra Teste
preditor4 <- predict(modelo_logit, teste)

#Estimando o erro fora da amostra
result4 <- caret::confusionMatrix(preditor4,teste$Exited)
accuracy4 <- result4$overall[1]
precision4 <- result4$byClass[1]
recall4 <- result4$byClass[2]
f1.4 <- result4$byClass[7]
#Métricas inferiores ao xgboost


#Modelo randomforest
modelo_rf <- caret::train(Exited~ ., data=treino, method="rf", ntree=500,trControl=controle)
modelo_rf


#Aplicando o modelo na amostra Teste
preditor <- predict(modelo_rf, teste)

#Estimando o erro fora da amostra
result5 <- caret::confusionMatrix(preditor,teste$Exited)
accuracy5 <- result5$overall[1]
precision5 <- result5$byClass[1]
recall5 <- result5$byClass[2]
f15 <- result5$byClass[7]


#Tempo para cada modelo
modelo_xgb$times
modelo_linear$times
modelo_rpart$times
modelo_rf$times


#O objetivo é melhor a eficácia de encontrar quem tem maior tendência ao churn,
#por isso o modelo escolhido será aquele com melhor recall e com o menor tempo
recall
recall2
recall3
recall4
recall5
#O modelo escolhido será o support vector machine


##Salvando objetos necessários para predição
save(preproc4, preproc5, controle, modelo_linear, file="bankchurn.RData")
