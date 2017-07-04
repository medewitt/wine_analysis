#Purpose: K nearest neighbors, 

library(class)

#To use the KNN function it is important to remember to keep the dimensionality the same
#and to remove the classifiers for the testing set.

knn_1<-knn(train = red_wine_data_training[,-13], test = red_wine_data_testing[,-13], 
           cl = red_wine_data_training$classification, k = 1)

knn_3<-knn(train = red_wine_data_training[,-13], test = red_wine_data_testing[,-13], 
    cl = red_wine_data_training$classification, k = 3)

knn_5<-knn(train = red_wine_data_training[,-13], test = red_wine_data_testing[,-13], 
           cl = red_wine_data_training$classification, k = 5)

knn_10<-knn(train = red_wine_data_training[,-13], test = red_wine_data_testing[,-13], 
           cl = red_wine_data_training$classification, k = 10)

#Now let's look at the confusion matrices and error rates
sum(red_wine_data_testing$classification==knn_1)/dim(red_wine_data_testing)[1]
sum(red_wine_data_testing$classification==knn_3)/dim(red_wine_data_testing)[1]
sum(red_wine_data_testing$classification==knn_5)/dim(red_wine_data_testing)[1]
sum(red_wine_data_testing$classification==knn_10)/dim(red_wine_data_testing)[1]

#Confusion matrices
table(knn_1, red_wine_data_testing$classification)
table(knn_3, red_wine_data_testing$classification)
table(knn_5, red_wine_data_testing$classification)
table(knn_10, red_wine_data_testing$classification)

#Now lets turn it into a function and understand the trends
knn_classification<-c()
for (i in 1:100){
  knn_value <-knn(train = red_wine_data_training[,-13], test = red_wine_data_testing[,-13], 
             cl = red_wine_data_training$classification, k = i)
  knn_classification<- rbind(knn_classification,
    sum(red_wine_data_testing$classification==knn_value)/dim(red_wine_data_testing)[1])
}

#Turn to tibble and add more information
knn_classification<-as_tibble(knn_classification) %>% 
  mutate(k_nearest = 1:100)

#Plot the pretty plot
ggplot(knn_classification, aes(k_nearest, V1))+
  geom_point(position = "jitter")+
  xlab("Number of Nearest Neighbors Used")+
  ylab("Classification Rate (correct classifications)")

