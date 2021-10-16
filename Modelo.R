#Base de dados
library(readr)
dados <- read_csv("GitHub/Churn XGBoost/churn.csv")


#Excluindo coluna com número da linha
dados <- dados[,-1]


#O número de id do cliente não deve afetar o modelo, então será excluída também
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


#Balanceando

#1- Transformar todas as variáveis em numéricas
aux <- dados |> distinct(Surname)
#Essa variável em específico possuí 2932 categorias diferentes, porém a base de dados possui 10mil observações,
#então essa variável será excluída

dados <- dados[,-1]
aux2 <- dados |> distinct(Geography)
#0-France, 1-Spain, 2-Germany

aux3 <- dados |> distinct(Gender)
#0-Female, 1-Male

dados <- dados |> mutate(Geography = factor(Geography, levels = c("France","Spain","Germany"), labels = c(0,1,2)),
                         Gender = factor(Gender, levels = c("Female","Male"),labels = c(0,1)))





#2- Balanceando os dados
library(imbalance)
dados <- as.data.frame(dados)
reb <- mwmote(dados, numInstances = 5926, classAttr = "Exited")

dados2 <- rbind(dados, reb)

#3- analisando se o balanceamento está correto
cont_dad2 <- dados2 |>
  count(Exited)

cont_dad2 |> ggplot(aes(x=Exited, y=n))+
  geom_bar(stat="identity",
           fill="black") +
  geom_text(aes(label = n), 
            vjust=-0.5)


#Transformando variáveis para fator quando necessário

#Devido ao balanceamento, as "observações" geradas pela função vieram número quebrados
for (i in 10000:length(dados2$CreditScore)){
  if(dados2$Geography[i] < 1.5){
    dados2$Geography[i] <- 1
  }else if(dados2$Geography[i] < 2.5){
    dados2$Geography[i] <- 2
  }else {dados2$Geography[i] <- 3}
}

for (i in 10000:length(dados2$CreditScore)){
  if(dados2$Gender[i] < 1.5){
    dados2$Gender[i] <- 1
  }else {dados2$Gender[i] <- 2}
}

for (i in 10000:length(dados2$CreditScore)){
  if(dados2$HasCrCard[i] < 1.5){
    dados2$HasCrCard[i] <- 1
  }else {dados2$HasCrCard[i] <- 2}
}

for (i in 10000:length(dados2$CreditScore)){
  if(dados2$IsActiveMember[i] < 1.5){
    dados2$IsActiveMember[i] <- 1
  }else {dados2$IsActiveMember[i] <- 2}
}

for (i in 10000:length(dados2$CreditScore)){
  if(dados2$Exited[i] < 1.5){
    dados2$Exited[i] <- 1
  }else {dados2$Exited[i] <- 2}
}

for (i in 10000:length(dados2$NumOfProducts)){
  if(dados2$NumOfProducts[i] < 1.5){
    dados2$NumOfProducts[i] <- 1
  }else if(dados2$NumOfProducts[i] < 2.5){
    dados2$NumOfProducts[i] <- 2
  }else if(dados2$NumOfProducts[i] < 3.5){
    dados2$NumOfProducts[i] <- 3
    }else {dados2$NumOfProducts[i] <- 4}
}

#fatorizando
dados2 <- dados2 |> dplyr::mutate(Geography = factor(Geography, levels = c(1,2,3), labels = c("France","Spain","Germany")),
                         Gender = factor(Gender,levels = c(1,2), labels = c("Female","Male")))

dados2$Geography <- as.factor(dados2$Geography)
dados2$Gender <- as.factor(dados2$Gender)
dados2$NumOfProducts <- as.factor(dados2$NumOfProducts)
dados2$HasCrCard <- as.factor(dados2$HasCrCard)
dados2$IsActiveMember <- as.factor(dados2$IsActiveMember)
dados2$Exited <- as.factor(dados2$Exited)


#Pré processamentos

#Separando em amostras treino e teste para verificação de métricas
library(caret)
data <- caret::createDataPartition(y=dados2$Exited, p=0.75, list = F)

treino <- dados2[data,]
teste <- dados2[-data,]


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
#Acurácia = 0.8998
#sensibilidade = 0.9372
#specificidade(recall) = 0.8624
#F1 = 0.9034



#Modelo SVM exponential String Kernel
modelo_linear <- caret::train(Exited~ ., data=treino, method="svmLinear",trControl=controle)

#Aplicando o modelo na amostra Teste
preditor2 <- predict(modelo_linear, teste)

#Estimando o erro fora da amostra
caret::confusionMatrix(preditor2,teste$Exited)
#Métricas inferiores ao xgboost

?specificity()
#Modelo rpart
modelo_rpart <- caret::train(Exited~ ., data=treino, method="rpart",trControl=controle)

#Aplicando o modelo na amostra Teste
preditor3 <- predict(modelo_rpart, teste)

#Estimando o erro fora da amostra
caret::confusionMatrix(preditor3,teste$Exited)
#Métricas inferiores ao xgboost


# Modelo completo (logito)
modelo_logit <- glm(Exited ~., data = treino, family = binomial("logit"))

#Aplicando o modelo na amostra Teste
preditor4 <- predict(modelo_rpart, teste)

#Estimando o erro fora da amostra
caret::confusionMatrix(preditor4,teste$Exited)
#Métricas inferiores ao xgboost





##Salvando objetos necessários para predição
save(preproc4, preproc5, controle, modelo_xgb, file="bankchurn.RData")
