library(caret)
train <- read.csv('/Users/anilkumar/Documents/Masters/ML/Project/NewDataset/TrainData1.txt', header=F, sep='\t')
train[train == 1.00000000000001e+99] <- NA
sum(is.na(train))
# imputed_features <- knnImputation(train)
preProcValues <- preProcess(train, method = c("knnImpute","center","scale"))
library('RANN')
train_processed <- predict(preProcValues, train)
sum(is.na(train_processed))
labels <- read.csv('/Users/anilkumar/Documents/Masters/ML/Project/NewDataset/TrainLabel1.txt', sep='\n', header=F)
colnames(labels) <- c("label")
cbind2 <- cbind(train, labels)
# train_processed$label<-factor(list(labels))

set.seed(100)
index <- createDataPartition(cbind2$label, p=0.75, list=F)
trainSet <- cbind2[ index,]
testSet <- cbind2[-index,]
outcomeName<-'label'
predictors<-names(trainSet)[!names(trainSet) %in% outcomeName]

names(getModelInfo())

model_lr <- train(trainSet[,predictors], factor(trainSet[,outcomeName]), method='rf', importance=T)
plot(varImp(object=model_lr), main='Random Forest')

model_nb <- train(trainSet[,predictors], factor(trainSet[,outcomeName]), method='naive_bayes')
plot(varImp(object=model_nb), main='Naive Bayes')

model_nnet <- train(trainSet[,predictors], factor(trainSet[,outcomeName]), method='nnet', importance=T)


