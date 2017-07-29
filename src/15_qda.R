#Complete Quadratic Discriminate analysis

qda_fit <- qda(classification~., data = red_wine_data_testing_fact)

qda_prediction <- predict(qda_fit, newdata = red_wine_data_testing_fact)

(qda_missclassification <- 1-
    mean(qda_prediction$class == red_wine_data_testing_fact$classification))


(qda_table <- table(qda_prediction$class, red_wine_data_testing_fact$classification))

(qda_good <- (qda_table[1,1])/(qda_table[1,1]+qda_table[2,1]+qda_table[3,1]))
(qda_medium <- (qda_table[2,2])/(qda_table[1,2]+qda_table[2,2]+qda_table[3,2]))
(qda_poor <- (qda_table[3,3])/(qda_table[1,3]+qda_table[2,3]+qda_table[3,3]))

qda_accuracy <-cbind(qda_good, qda_medium, qda_poor)