

setwd("C:/Users/LENOVO/Desktop/Clases/Minería de datos/Github/HT4-Mineria-de-Datos")
datatest <- read.csv("house-prices-advanced-regression-techniques/test.csv")
datatrain <- read.csv("house-prices-advanced-regression-techniques/train.csv")

prices <- read.csv("house-prices-advanced-regression-techniques/sample_submission.csv")

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

write.csv(cuantitativas_precios,"C:/Users/LENOVO/Desktop/Clases/Minería de datos/Github/HT4-Mineria-de-Datos/cuantitativas_precios.csv")
