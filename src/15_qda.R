#Complete Quadratic Discriminate analysis

qda_fit <- qda(classification~., data = red_wine_data_testing_fact)

qda_prediction <- predict(qda_fit, newdata = red_wine_data_testing_fact)

(qda_missclassification <- 1-
    mean(qda_prediction$class == red_wine_data_testing_fact$classification))
