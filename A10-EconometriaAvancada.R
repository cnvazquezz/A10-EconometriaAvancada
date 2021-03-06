#Aula 10 - Previs�o ~ EconometriaAvancada

install.packages("forecast")                 #Instala Pacote Forecast
library(forecast)                            #Carrega o Pacote Forecast
library(readxl)      #Carregando o pacote Readxl, que efetua leitura dos arquivos do Excel                               


IPCA <- read_excel("C:/Econometria/IPCA.xls", col_types = c("date","numeric"))   #Carregando o arquivo
Inflacao <- ts(IPCA$IPCA,start = 2008, frequency = 12)    #Definindo como S�rie Temporal
View(Inflacao)

AR1 <- arima(Inflacao,order = c(1,0,0))  #Modelo Autorregressivo de ordem 1
AR1
AR2 <- arima(Inflacao, order=c(2,0,0))   #Modelo Autorregressivo de ordem 2
AR2

previsao1 <- forecast(AR1, 4)                            #Cria o objeto previsao1 com dados gerados para a previs�o dos 4 pr�ximos per�odos de um modelo AR1
previsao1                                                #Exibe o objeto previsao1
previstoAR1 <- previsao1$fitted
modelo1 <- data.frame(previstoAR1,Inflacao)
modelo1 <- ts(modelo1,start = 2008-01, frequency = 12) 
plot(modelo1, main="Previsto e Observado - AR1", 
     plot.type="single",
     ylab="Data",
     xlab="Infla��o", 
     col=c("Blue","Black"))

previsao2 <- forecast(AR2, 4)
previsao2
previstoAR2 <- previsao2$fitted
modelo2 <- data.frame(previstoAR2,Inflacao)
modelo2 <- ts(modelo2,start = 2008-01, frequency = 12) 
plot(modelo2, main="Previsto e Observado AR2", 
     plot.type="single",
     ylab="Data", 
     xlab="Infla��o", 
     col=c("green","pink"))

modeloconjunto <- data.frame(previstoAR1,previstoAR2,Inflacao)
modeloconjunto <- ts(modeloconjunto,start = 2008-01, frequency = 12)
plot(modeloconjunto, main="Previsto e Observado AR1, AR2", 
     plot.type="single",
     ylab="Data", 
     xlab="Infla��o", 
     col=c("Blue", "Green","Orange"))


#Previs�o com Modelos de M�dias M�veis

MA1 <- arima(Inflacao,order = c(0,0,1))  #Modelo M�dias M�veis de ordem 1
MA2 <- arima(Inflacao,order=c(0,0,2))   #Modelo M�dias M�veis de ordem 2

previsao01 <- forecast(MA1, 4)
previsao01
previstoMA1 <- previsao01$fitted
modelo01 <- data.frame(previstoMA1,Inflacao)
modelo01 <- ts(modelo01,start = 2008-01, frequency = 12) 
plot(modelo01, main="Previsto e Observado - MA1", 
     plot.type="single",
     ylab="Data", 
     xlab="Infla��o", 
     col=c("Green","Black"))

previsao02 <- forecast(MA2, 4)
previsao02
previstoMA2 <- previsao02$fitted
modelo02 <- data.frame(previstoMA2,Inflacao)
modelo02 <- ts(modelo02,start = 2008-01, frequency = 12) 
plot(modelo02, main="Previsto e Observado AR2", plot.type="single",ylab="Data", xlab="Infla��o", col=c("Yellow","Black"))

modeloconjunto2 <- data.frame(previstoMA1,previstoMA2,Inflacao)
modeloconjunto2 <- ts(modeloconjunto2,start = 2008-01, frequency = 12)
plot(modeloconjunto2, main="Previsto e Observado AR1, AR2", plot.type="single",ylab="Data", xlab="Infla��o", col=c("Green", "Yellow","Black"))



              #Gr�ficoS de Previs�o
plot(forecast(AR1, 4), main ="Previsao da Inflacao para 2017 - AR1", xlim=c(2017,2019))  #Gr�fico com as previs�es com um AR1
plot(forecast(AR2, 4), main ="Previsao da Inflacao para 2017 -AR2", xlim=c(2017,2019))   #Gr�fico com as previs�es com um AR2
