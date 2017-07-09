#Purpose: multi-linear regression
library(boot)
library(leaps)
set.seed(336)
#Create the full linear model
(full_lm_model <- lm(as.numeric(red_wine_data_training$quality)~., data = red_wine_data_training))

#Create the stepwise linear regression with both forward and backwards regression

(step_model <- step(full_lm_model, direction = "both"))

#summary of the model
summary(step_model)

step_model$anova

##K Folds Cross Validation
cv_error<-c()
for(i in 1:10){
  lm_fit_cv <- glm(quality ~ volatile_acidity + chlorides + free_sulfur_dioxide 
                + total_sulfur_dioxide, data = red_wine_data)
  cv_error[i] <- cv.glm( red_wine_data, lm_fit_cv, K= 10)$delta[1]
}

#Bootstrap
boot_lm <- function (data, index){
  return(coef(lm(quality ~ volatile_acidity + chlorides + free_sulfur_dioxide + total_sulfur_dioxide,
              data = data, subset = index)))
}
boot_lm(red_wine_data, sample(100, 100, replace = T))

boot(red_wine_data, boot_lm, 1000)

#Feature selection using model selection and cv

predict.regsubsets <- function (object, newdata, id, ...){
  form = as.formula (object$call[[2]])
  mat = model.matrix(form, newdata)
  coefi = coef(object, id= id)
  xvars = names (coefi)
  mat[,xvars]%*%coefi
}

k <- 5
folds <- sample (1:k, nrow(red_wine_data), replace = TRUE)
cv_error <- matrix(NA, k, 11, dimnames = list(NULL, paste(1:11)))

for (j in 1:k){
  best_fit <- regsubsets(quality~., data = red_wine_data [folds !=j,],
                         nvmax = 11)
  for (i in 1:11){
    pred = predict.regsubsets(best_fit, red_wine_data[folds==j,], id = i)
    cv_error[j,i] = mean( (red_wine_data$quality[folds==j]-pred)^2)
  }
}

(mean_cv_errors <- apply(cv_error, 2, mean))
plot(mean_cv_errors, type = 'b', main = "Best Model Selection", xlab = "# Parameters Considered",
     ylab = "MSE")
which.min(mean_cv_errors)

reg_best <- regsubsets(quality ~., data = red_wine_data, nvmax = 7)
coef(reg_best, 7)

###Now fit model on data to see the testing error
