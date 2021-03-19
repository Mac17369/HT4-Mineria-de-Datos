setwd("C:/Users/Kevin Macario/Desktop/Uvg/9no Semestre/Mineria de Datos/HT4-Mineria-de-Datos")
#setwd("C:/Users/LENOVO/Desktop/Clases/Minería de datos/Github/HT4-Mineria-de-Datos")
datatest <- read.csv("house-prices-advanced-regression-techniques/test.csv")
datatrain <- read.csv("house-prices-advanced-regression-techniques/train.csv")
library(dplyr)
prices <- read.csv("house-prices-advanced-regression-techniques/sample_submission.csv")

set.seed(666)

numstest <- sapply(datatest, is.numeric)
numtrain <-sapply(datatrain, is.numeric)

cdatatest <- datatest[,numstest]
cdatatrain <- datatrain[,numtrain]
names(cdatatest)
names(cdatatrain)
cdatatrain$SalePrice <- NULL

cdata <- bind_rows(cdatatest,cdatatrain)
cuantitativas_precios<-merge(x = cdata, y = prices, by = "Id")
cuantitativas_precios <-  na.omit(cuantitativas_precios)

#write.csv(cuantitativas_precios,"C:/Users/Kevin Macario/Desktop/Uvg/9no Semestre/Mineria de Datos/HT4-Mineria-de-Datos/cuantitativas_precios.csv")

#normalizacion
normC_precios <- scale(cuantitativas_precios[,2:38], center = TRUE, scale = TRUE)

corte <- sample(nrow(normC_precios),nrow(normC_precios)*0.7)
train<-normC_precios[corte,]
train<-as.data.frame(train)

test<-normC_precios[-corte,]
test<-as.data.frame(test)

#trabajando con datos Train
model <- lm(SalePrice ~ LotFrontage + LotArea + GrLivArea + BedroomAbvGr + TotRmsAbvGrd, data = train)
summary(model)

predModel<-predict(model, newdata = test)
resultadosTrain<-data.frame(predModel)

#residuales train
residuales <- train$SalePrice-predModel
hist(residuales, main="Distribucion de error de Residuales")

cfm<-confusionMatrix(test,predModel)
cfm

#sustituyendo variables colienales
model <- lm(SalePrice ~  LotArea + GrLivArea + TotRmsAbvGrd, data = train)
summary(model)

predModel<-predict(model, newdata = test)
resultadosTrain<-data.frame(predModel)

#residuales train
residuales <- train$SalePrice-predModel
hist(residuales, main="Distribucion de error de Residuales")
