library(gbm)

#Perform boosting regression analysis

boost_wine <- gbm(quality ~., data = red_wine_data_training, distribution = "gaussian", n.trees = 5000,
                  interaction.depth = 4)

par(mfrow=c(1,1))
summary(boost_wine)

boost_reg_outputs <- summary(boost_wine)

(boost_reg_plot <- ggplot(boost_reg_outputs, aes(x= reorder(var, rel.inf), y = rel.inf))+
  geom_bar(stat = "identity")+
    coord_flip()+
    ylab("Relative Importantance")+
    xlab("Predictor"))

#partial dependence plots

par(mfrow = c(1,2))
plot(boost_wine, i = "alcohol")
plot(boost_wine, i = "citric_acid")

yhat_boost <- predict(boost_wine, newdata = red_wine_data_testing, n.trees = 5000)

(MSE_boost_reg <- mean((yhat_boost-red_wine_data_testing$quality)^2))

boost_wine$Terms

example_boost<-(pretty.gbm.tree(boost_wine))

