#Purpose: The purpose of this script to complete a naive Bayes analysis on the wine data.
#     The data has already had factors applied to it in one of the earlier steps.

#Libraries
library(e1071)

#Create the naive bayes model for classification using our training data set
naive_bayes_model <- naiveBayes(classification ~., data = red_wine_data_training)

summary(naive_bayes_model)

print(naive_bayes_model)

naive_bayes_pred <- predict(naive_bayes_model, newdata = red_wine_data_testing)

#Displaye the confusion matrix
(naive_bayes_confusion <-as.matrix(table(naive_bayes_pred, red_wine_data_testing$classification)))

#Add the totals to the summary rows/ columns. Good for tables later
(naive_bayes_confusion<-addmargins(naive_bayes_confusion))

#Create the misclassification rates to understand where the model suceeded (or failed)
(naive_bayes_good_misclassification <- 
    1- naive_bayes_confusion[1,1]/naive_bayes_confusion[1,4])

(naive_bayes_medium_misclassification <- 
    1- naive_bayes_confusion[2,2]/naive_bayes_confusion[2,4])

(naive_bayes_poor_misclassification <- 
    1- naive_bayes_confusion[3,3]/naive_bayes_confusion[3,4])
