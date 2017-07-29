#LDA

library(MASS)

#create the LDA Model
lda_model <- lda(formula = classification ~., data = red_wine_data_training_fact, 
                 prior = c(1,1,1)/3, CV = FALSE)

#Use the LDA model against the testing data set

pred_lda_model <- predict(lda_model, newdata = red_wine_data_testing_fact)

head(pred_lda_model$posterior,3)

#Look at the confusion matrix

table(pred_lda_model$class, red_wine_data_testing_fact$classification)
#-----------------------------------------------------------------------------------------
#Tune
table(red_wine_data_factors$classification)
217/1599
1319/1599
63/1599

#create the LDA Model
lda_model <- lda(formula = classification ~., data = red_wine_data_training_fact, CV = FALSE)

#Use the LDA model against the testing data set

pred_lda_model <- predict(lda_model, newdata = red_wine_data_testing_fact)

head(pred_lda_model$posterior,3)

#Look at the confusion matrix

(lda_table <-table(pred_lda_model$class, red_wine_data_testing_fact$classification))

(lda_missclass<-mean(pred_lda_model$class!=red_wine_data_testing_fact$classification))

(lda_good <- (lda_table[1,1])/(lda_table[1,1]+lda_table[2,1]+lda_table[3,1]))
(lda_medium <- (lda_table[2,2])/(lda_table[1,2]+lda_table[2,2]+lda_table[3,2]))
(lda_poor <- (lda_table[3,3])/(lda_table[1,3]+lda_table[2,3]+lda_table[3,3]))

lda_accuracy <-cbind(lda_good, lda_medium, lda_poor)
