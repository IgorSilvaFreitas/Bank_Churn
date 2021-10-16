#Base de dadps
dados <- readr::read_csv("GitHub/Churn XGBoost/churn.csv")

##CredtiScore
dados |> ggplot2::ggplot(aes(x=CreditScore))+
  ggplot2::geom_histogram(fill="blue",
                          alpha=0.5,
                          col="white")

#Separando segundo se saiu ou não do banco
g1 <- dados |> 
  dplyr::filter(Exited==1) |> 
  ggplot2::ggplot(aes(x = CreditScore))+
  ggplot2::geom_histogram(fill = "blue",
                          alpha = 0.5,
                          col = "White") +
  ggplot2::labs(y = "Frequência",
                title = "Histograma para o creditscore quando ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
        text = element_text(size=15))

g2 <- dados |> 
  dplyr::filter(Exited==0) |> 
  ggplot2::ggplot(aes(x = CreditScore))+
  ggplot2::geom_histogram(fill = "red",
                          alpha = 0.5,
                          col = "White") +
  ggplot2::labs(y = "Frequência",
                title = "Histograma para o creditscore quando não ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
        text = element_text(size=15))

gridExtra::grid.arrange(g1, g2, nrow=2)

#Comportamentos semelhantes



## Geography
cont_geo <- dados |> 
  dplyr::count(Geography)

cont_geo |> 
  ggplot2::ggplot(aes(x = Geography, y = n))+
  ggplot2::geom_bar(stat="identity",
           fill="blue",
           alpha = 0.8) +
  ggplot2::geom_text(aes(label = n), 
            vjust=-0.5)

#Separando segundo churn
cont_geo_sim <- dados |> 
  dplyr::filter(Exited==1) |> 
  dplyr::count(Geography)

g3 <- cont_geo_sim |> 
  ggplot2::ggplot(aes(x = Geography, y = n))+
  ggplot2::geom_bar(stat="identity",
                    fill="blue",
                    alpha = 0.8) +
  ggplot2::geom_text(aes(label = n), 
                     vjust=-0.5) +
  ggplot2::labs(x = "País", y = "Frequência",
                title = "Gráfico de frequências por País quando ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
        text = element_text(size=15))

cont_geo_nao <- dados |> 
  dplyr::filter(Exited==0) |> 
  dplyr::count(Geography)

g4 <- cont_geo_nao |> 
  ggplot2::ggplot(aes(x = Geography, y = n))+
  ggplot2::geom_bar(stat="identity",
                    fill="red",
                    alpha = 0.8) +
  ggplot2::geom_text(aes(label = n), 
                     vjust=-0.5) +
  ggplot2::labs(x = "País", y = "Frequência",
                title = "Gráfico de frequências por País quando não ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15))
gridExtra::grid.arrange(g3, g4, nrow=2)


##Gender
cont_gen <- dados |> 
  dplyr::count(Gender)

cont_gen |> 
  ggplot2::ggplot(aes(x = Gender, y = n))+
  ggplot2::geom_bar(stat="identity",
                    fill="blue",
                    alpha = 0.8) +
  ggplot2::geom_text(aes(label = n), 
                     vjust=-0.5)


#Separando segundo churn
cont_gen_sim <- dados |> 
  dplyr::filter(Exited==1) |> 
  dplyr::count(Gender)

g5 <- cont_gen_sim |> 
  ggplot2::ggplot(aes(x = Gender, y = n))+
  ggplot2::geom_bar(stat="identity",
                    fill="blue",
                    alpha = 0.8) +
  ggplot2::geom_text(aes(label = n), 
                     vjust=-0.5) +
  ggplot2::labs(x = "Gênero", y = "Frequência",
                title = "Gráfico de frequências por País quando ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15))

cont_gen_nao <- dados |> 
  dplyr::filter(Exited==0) |> 
  dplyr::count(Gender)

g6 <- cont_gen_nao |> 
  ggplot2::ggplot(aes(x = Gender, y = n))+
  ggplot2::geom_bar(stat="identity",
                    fill="red",
                    alpha = 0.8) +
  ggplot2::geom_text(aes(label = n), 
                     vjust=-0.5) +
  ggplot2::labs(x = "Gênero", y = "Frequência",
                title = "Gráfico de frequências por País quando não ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15))
gridExtra::grid.arrange(g5, g6, nrow=2)

#O sexo feminino parece ser mais sucetivel ao cancelamento



##Age
dados |> ggplot2::ggplot(aes(x=Age))+
  ggplot2::geom_histogram(fill="blue",
                          alpha=0.5,
                          col="white")

#Separando segundo se saiu ou não do banco
g7 <- dados |> 
  dplyr::filter(Exited==1) |> 
  ggplot2::ggplot(aes(x = Age))+
  ggplot2::geom_histogram(fill = "blue",
                          alpha = 0.8,
                          col = "White") +
  ggplot2::labs(y = "Frequência",
                title = "Histograma para a idade quando ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15))

g8 <- dados |> 
  dplyr::filter(Exited==0) |> 
  ggplot2::ggplot(aes(x = Age))+
  ggplot2::geom_histogram(fill = "red",
                          alpha = 0.8,
                          col = "White") +
  ggplot2::labs(y = "Frequência",
                title = "Histograma para a idade quando não ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15))

gridExtra::grid.arrange(g7, g8, nrow=2)

#Os mais jovens parecem ser menos sucetiveis ao cancelamento


##Tenure
dados |> ggplot2::ggplot(aes(x=Tenure))+
  ggplot2::geom_histogram(fill="blue",
                          alpha=0.5,
                          col="white",
                          bins = 10)

#Separando segundo se saiu ou não do banco
g9 <- dados |> 
  dplyr::filter(Exited==1) |> 
  ggplot2::ggplot(aes(x = Tenure))+
  ggplot2::geom_histogram(fill = "blue",
                          alpha = 0.8,
                          col = "White",
                          bins = 10) +
  ggplot2::labs(y = "Frequência",
                title = "Histograma para a Tenure quando ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15))

g10 <- dados |> 
  dplyr::filter(Exited==0) |> 
  ggplot2::ggplot(aes(x = Tenure))+
  ggplot2::geom_histogram(fill = "red",
                          alpha = 0.8,
                          col = "White",
                          bins = 10) +
  ggplot2::labs(y = "Frequência",
                title = "Histograma para a Tenure quando não ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15))

gridExtra::grid.arrange(g9, g10, nrow=2)
#Sem diferenças



##Balance
dados |> ggplot2::ggplot(aes(x=Balance))+
  ggplot2::geom_histogram(fill="blue",
                          alpha=0.5,
                          col="white",
                          bins = 10) +
  ggplot2::scale_x_continuous(labels= scales::comma)

#Separando segundo se saiu ou não do banco
g11 <- dados |> 
  dplyr::filter(Exited==1) |> 
  ggplot2::ggplot(aes(x = Balance))+
  ggplot2::geom_histogram(fill = "blue",
                          alpha = 0.8,
                          col = "White") +
  ggplot2::labs(y = "Frequência",
                title = "Histograma para a Balance quando ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15)) +
  ggplot2::scale_x_continuous(labels= scales::comma)

g12 <- dados |> 
  dplyr::filter(Exited==0) |> 
  ggplot2::ggplot(aes(x = Balance))+
  ggplot2::geom_histogram(fill = "red",
                          alpha = 0.8,
                          col = "White") +
  ggplot2::labs(y = "Frequência",
                title = "Histograma para a Balance quando não ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15)) +
  ggplot2::scale_x_continuous(labels= scales::comma)

gridExtra::grid.arrange(g11, g12, nrow=2)
#Aparentemente, cliente com 0 dólares em conta tendem a não cancelar,
#e cliente com mais de 200mil dólares tendem a cancelar



##Number of products
cont_prod <- dados |> 
  dplyr::count(NumOfProducts)

cont_prod |> 
  ggplot2::ggplot(aes(x = NumOfProducts, y = n))+
  ggplot2::geom_bar(stat="identity",
                    fill="blue",
                    alpha = 0.8) +
  ggplot2::geom_text(aes(label = n), 
                     vjust=-0.5)


#Separando segundo churn
cont_prod_sim <- dados |> 
  dplyr::filter(Exited==1) |> 
  dplyr::count(NumOfProducts)

g13 <- cont_prod_sim |> 
  ggplot2::ggplot(aes(x = NumOfProducts, y = n))+
  ggplot2::geom_bar(stat="identity",
                    fill="blue",
                    alpha = 0.8) +
  ggplot2::geom_text(aes(label = n), 
                     vjust=-0.5) +
  ggplot2::labs(x = "Quantidade de produtos vendidos ao cliente", y = "Frequência de clientes",
                title = "Frequências por quantidade de produtos vendidos quando ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15))

cont_prod_nao <- dados |> 
  dplyr::filter(Exited==0) |> 
  dplyr::count(NumOfProducts)

g14 <- cont_prod_nao |> 
  ggplot2::ggplot(aes(x = NumOfProducts, y = n))+
  ggplot2::geom_bar(stat="identity",
                    fill="red",
                    alpha = 0.8) +
  ggplot2::geom_text(aes(label = n), 
                     vjust=-0.5) +
  ggplot2::labs(x = "Quantidade de produtos vendidos ao cliente", y = "Frequência de clientes",
                title = "Frequências por quantidade de produtos vendidos quando não ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15))
gridExtra::grid.arrange(g13, g14, nrow=2)
#Clientes que adquiriram 4 produtos tendem a cancelar



##Has Credit Card
dados <- dados |> mutate(HasCrCard = factor(HasCrCard, levels = c(0,1), labels = c("Não","Sim")))
cont_crc <- dados |> 
  dplyr::count(HasCrCard)

cont_crc |> 
  ggplot2::ggplot(aes(x = HasCrCard, y = n))+
  ggplot2::geom_bar(stat="identity",
                    fill="blue",
                    alpha = 0.8) +
  ggplot2::geom_text(aes(label = n), 
                     vjust=-0.5)


#Separando segundo churn
cont_crc_sim <- dados |> 
  dplyr::filter(Exited==1) |> 
  dplyr::count(HasCrCard)

g15 <- cont_crc_sim |> 
  ggplot2::ggplot(aes(x = HasCrCard, y = n))+
  ggplot2::geom_bar(stat="identity",
                    fill="blue",
                    alpha = 0.8) +
  ggplot2::geom_text(aes(label = n), 
                     vjust=-0.5) +
  ggplot2::labs(x = "Possui cartão de crédito", y = "Frequência",
                title = "Frequência de cliente segundo a possessão de cartão de crédito quando ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15))

cont_crc_nao <- dados |> 
  dplyr::filter(Exited==0) |> 
  dplyr::count(HasCrCard)

g16<- cont_crc_nao |> 
  ggplot2::ggplot(aes(x = HasCrCard, y = n))+
  ggplot2::geom_bar(stat="identity",
                    fill="red",
                    alpha = 0.8) +
  ggplot2::geom_text(aes(label = n), 
                     vjust=-0.5) +
  ggplot2::labs(x = "Possui cartão de crédito", y = "Frequência",
                title = "Frequência de cliente segundo a possessão de cartão de crédito quando não ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15))
gridExtra::grid.arrange(g15, g16, nrow=2)




##Is Active Member
dados <- dados |> mutate(IsActiveMember = factor(IsActiveMember, levels = c(0,1), labels = c("Não","Sim")))
cont_mem <- dados |> 
  dplyr::count(IsActiveMember)

cont_mem |> 
  ggplot2::ggplot(aes(x = IsActiveMember, y = n))+
  ggplot2::geom_bar(stat="identity",
                    fill="blue",
                    alpha = 0.8) +
  ggplot2::geom_text(aes(label = n), 
                     vjust=-0.5)


#Separando segundo churn
cont_mem_sim <- dados |> 
  dplyr::filter(Exited==1) |> 
  dplyr::count(IsActiveMember)

g17 <- cont_mem_sim |> 
  ggplot2::ggplot(aes(x = IsActiveMember, y = n))+
  ggplot2::geom_bar(stat="identity",
                    fill="blue",
                    alpha = 0.8) +
  ggplot2::geom_text(aes(label = n), 
                     vjust=-0.5) +
  ggplot2::labs(x = "É membro ativo", y = "Frequência",
                title = "Frequência de clientes ativos quando ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15))

cont_mem_nao <- dados |> 
  dplyr::filter(Exited==0) |> 
  dplyr::count(IsActiveMember)

g18 <- cont_mem_nao |> 
  ggplot2::ggplot(aes(x = IsActiveMember, y = n))+
  ggplot2::geom_bar(stat="identity",
                    fill="red",
                    alpha = 0.8) +
  ggplot2::geom_text(aes(label = n), 
                     vjust=-0.5) +
  ggplot2::labs(x = "É membro ativo", y = "Frequência",
                title = "Frequência de clientes ativos quando não ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15))
gridExtra::grid.arrange(g17, g18, nrow=2)
#Clientes não ativos tendem a ter cancelado



##Estimated salary
dados |> ggplot2::ggplot(aes(x=EstimatedSalary))+
  ggplot2::geom_histogram(fill="blue",
                          alpha=0.5,
                          col="white",
                          bins=10) +
  ggplot2::scale_x_continuous(labels= scales::comma)

#Separando segundo se saiu ou não do banco
g19 <- dados |> 
  dplyr::filter(Exited==1) |> 
  ggplot2::ggplot(aes(x = EstimatedSalary))+
  ggplot2::geom_histogram(fill = "blue",
                          alpha = 0.8,
                          col = "White",
                          bins=20) +
  ggplot2::labs(y = "Frequência",
                title = "Histograma para a EstimatedSalary quando ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15)) +
  ggplot2::scale_x_continuous(labels= scales::comma)

g20 <- dados |> 
  dplyr::filter(Exited==0) |> 
  ggplot2::ggplot(aes(x = EstimatedSalary))+
  ggplot2::geom_histogram(fill = "red",
                          alpha = 0.8,
                          col = "White",
                          bins=20) +
  ggplot2::labs(y = "Frequência",
                title = "Histograma para a EstimatedSalary quando não ocorreu churn") +
  ggthemes::theme_tufte() +
  ggplot2::theme(plot.title = element_text(hjust = 0.5, size=12, face="bold"),
                 text = element_text(size=15)) +
  ggplot2::scale_x_continuous(labels= scales::comma)

gridExtra::grid.arrange(g19, g20, nrow=2)



##Exited
cont_dad <- dados |>
  count(Exited)

cont_dad |> ggplot(aes(x=Exited, y=n))+
  geom_bar(stat="identity",
           fill="black") +
  geom_text(aes(label = n), 
            vjust=-0.5)
