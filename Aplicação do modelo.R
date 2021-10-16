#Função para o Modelo Machine Learning de Bank Churn

dados <- read_csv("C:/Users/Igor/Documents/GitHub/Churn XGBoost/churn.csv")


desafio <- function(dados){
  ## Verificando se pacote está instalado, e, se não, instalando
  if(require("caret") == "FALSE"){
    install.packages("caret")
  }
  
  if(require("RANN") == "FALSE"){
    install.packages("RANN")
  }
  
  if(require("xgboost") == "FALSE"){
    install.packages("mlr")
  }
  if(require("dplyr") == "FALSE"){
    install.packages("dplyr")
  }
  
  ## Carregando o pre-processamento e o classificador
  load("C:/Users/Igor/Documents/GitHub/Churn XGBoost/bankchurn.RData") 
  
  ##Tratamentos iniciais
  dados <- as.data.frame(dados)
  
  Cliente <- dados[,2]
  
  dados <- dados[,-c(1,2,3)]
  
  dados$Exited <- 9
  
  dados$Geography <- as.factor(dados$Geography)
  dados$Gender <- as.factor(dados$Gender)
  dados$NumOfProducts <- as.factor(dados$NumOfProducts)
  dados$HasCrCard <- as.factor(dados$HasCrCard)
  dados$IsActiveMember <- as.factor(dados$IsActiveMember)
  dados$Exited <- as.factor(dados$Exited)
  
  ## Aplicando o pre-processamento (podemos ter varios preproc.)
  dados_pp <- predict(preproc4,dados) 
  dados_pp <- predict(preproc5,dados_pp)
  
  ## aplicando o classificador nos dados
  pred <- predict(modelo_xgb, dados_pp) 
  
  ## Retornando previsão
  resultado <- data.frame(Cliente, pred)
  return(resultado)
  
}


#Retornando id do cliente e se ele irá ou não cancelar
desafio(dados)

