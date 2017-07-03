#Purpose: multi-linear regression

#Create the full linear model
(full_lm_model <- lm(as.numeric(red_wine_data_training$quality)~., data = red_wine_data_training))

#Create the stepwise linear regression with both forward and backwards regression

(step_model <- step(full_lm_model, direction = "both"))

#summary of the model
summary(step_model)

step_model$anova

par(mfrow = c(2,2))
plot(step_model)
par(mfrow = c(1,1))

#Now a reduced model

lm_fit <- lm(quality ~ volatile_acidity + chlorides + free_sulfur_dioxide + total_sulfur_dioxide,
             data = red_wine_data_training)

(train_rse <-summary(lm_fit)$sigma)

par(mfrow = c(2,2))
plot(lm_fit)
par(mfrow = c(1,1))

lm_predict <- predict(lm_fit, newdata = red_wine_data_testing)

pred_vs_actual <-as.data.frame(cbind(lm_predict,red_wine_data_testing$quality))
pred_vs_actual$residual_squared <- (pred_vs_actual[,1]-pred_vs_actual[,2])^2

(test_rse <- sum(pred_vs_actual$residual_squared)/dim(pred_vs_actual)[1])
