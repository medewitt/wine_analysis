#LDA

library(MASS)

#create the LDA Model
lda_model <- lda(formula = classification ~., data = red_wine_data_training, 
                 prior = c(1,1,1)/3, CV = FALSE)

#Use the LDA model against the testing data set

pred_lda_model <- predict(lda_model, newdata = red_wine_data_testing)

head(pred_lda_model$posterior,3)

#Look at the confusion matrix

table(pred_lda_model$class, red_wine_data_testing$classification)
#-----------------------------------------------------------------------------------------
#Tune
table(red_wine_data_factors$classification)
217/1599
1319/1599
63/1599

#create the LDA Model
lda_model <- lda(formula = classification ~., data = red_wine_data_training, 
                 prior = c(.1357, 0.8249, 0.0394), CV = FALSE)

#Use the LDA model against the testing data set

pred_lda_model <- predict(lda_model, newdata = red_wine_data_testing)

head(pred_lda_model$posterior,3)

#Look at the confusion matrix

(lda_table <-table(pred_lda_model$class, red_wine_data_testing$classification))
