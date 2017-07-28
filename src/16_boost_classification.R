library(gbm)

#Perform boosting regression analysis

boost_wine_fact <- gbm(classification ~., data = red_wine_data_training_fact, distribution = "bernoulli", n.trees = 5000,
                  interaction.depth = 4)


#partial dependence plots

par(mfrow = c(2,2))
plot(boost_wine_fact, i = "alcohol")
plot(boost_wine_fact, i = "citric_acid")

yhat_boost <- predict(boost_wine_fact, newdata = red_wine_data_testing_fact, n.trees = 5000)

(boost_missclassification <- 1-
    mean(yhat_boost== red_wine_data_testing_fact$classification))