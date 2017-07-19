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
# cv_error<-c()
# for(i in 1:10){
#   lm_fit_cv <- glm(quality ~ volatile_acidity + chlorides + free_sulfur_dioxide 
#                 + total_sulfur_dioxide, data = red_wine_data)
#   cv_error[i] <- cv.glm( red_wine_data, lm_fit_cv, K= 10)$delta[1]
# }

#Bootstrap
# boot_lm <- function (data, index){
#   return(coef(lm(quality ~ volatile_acidity + chlorides + free_sulfur_dioxide + total_sulfur_dioxide,
#               data = data, subset = index)))
# }
# boot_lm(red_wine_data, sample(100, 100, replace = T))
# 
# boot(red_wine_data, boot_lm, 1000)

#Feature selection using model selection and cv

predict.regsubsets <- function (object, newdata, id, ...){
  form = as.formula (object$call[[2]])
  mat = model.matrix(form, newdata)
  coefi = coef(object, id= id)
  xvars = names (coefi)
  mat[,xvars]%*%coefi
}

k <- 10
folds <- sample (1:k, nrow(red_wine_data_training), replace = TRUE)
cv_error_train <- matrix(NA, k, 11, dimnames = list(NULL, paste(1:11)))

for (j in 1:k){
  best_fit <- regsubsets(quality~., data = red_wine_data_training [folds !=j,],
                         nvmax = 11)
  for (i in 1:11){
    pred <- predict.regsubsets(best_fit, red_wine_data_training[folds==j,], id = i)
    cv_error_train[j,i] <- mean( (red_wine_data_training$quality[folds==j]-pred)^2)
  }
}

(mean_cv_errors_train <- apply(cv_error_train, 2, mean))
plot(mean_cv_errors_train, type = 'b', main = "Best Model Selection", xlab = "# Parameters Considered",
     ylab = "MSE")
which.min(mean_cv_errors_train)

##Based on the training data set it appears that using 6-10 variablkes results in about the same error.
#let's use 7

reg_best <- regsubsets(quality ~., data = red_wine_data_training, nvmax = 4)
coef(reg_best, 4)

variables_to_consider <- names (coef(reg_best,7))[-1]

variables_paste <- paste("quality", "~", paste(variables_to_consider, 
                                                      collapse = "+"))
summary(reg_best)
variables_paste

#Now complete analysis for testing error
k <- 5
folds <- sample (1:k, nrow(red_wine_data_testing), replace = TRUE)
cv_error_pred <- matrix(NA, k, 11, dimnames = list(NULL, paste(1:11)))

for (j in 1:k){
  best_fit <- regsubsets(quality~., data = red_wine_data_testing [folds !=j,],
                         nvmax = 11)
  for (i in 1:11){
    pred <- predict.regsubsets(best_fit, red_wine_data_testing[folds==j,], id = i)
    cv_error_pred[j,i] <- mean( (red_wine_data_testing$quality[folds==j]-pred)^2)
  }
}

(mean_cv_errors_pred <- apply(cv_error_pred, 2, mean))

MSE_lsr <- mean_cv_errors_pred[7]

plot(mean_cv_errors_pred, type = 'b', main = "Best Model Selection", xlab = "# Parameters Considered",
     ylab = "MSE")
lines(mean_cv_errors_pred, type = "c")

#Run boostrap

boot_lm <- function (data, index){
  return(coef(lm(quality ~ volatile_acidity+chlorides+free_sulfur_dioxide+
                   total_sulfur_dioxide+pH+sulphates+alcohol,
                 data = data, subset = index)))
}

#Plot predicted Model vs Predictors Etc



boot_lm(red_wine_data, sample(1000, 1000, replace = T))

(lm_boot_output <- boot(red_wine_data, boot_lm, 1000))

plot(lm_boot_output, index = 4)

###Now fit model on data to see the testing error
best_linear_model <- lm(quality ~ volatile_acidity+chlorides+free_sulfur_dioxide+
                          total_sulfur_dioxide+pH+sulphates+alcohol, 
                        data = red_wine_data_training)
library(modelr)

linear_model_grid <- red_wine_data_testing %>% 
  modelr::add_predictions(best_linear_model) %>% 
  add_residuals(best_linear_model) %>% 
  mutate(index = 1:nrow(red_wine_data_testing)) %>% 
  dplyr::select(volatile_acidity,chlorides,free_sulfur_dioxide,
         total_sulfur_dioxide,pH, sulphates,alcohol, quality, pred, resid, index)

m_linear <-melt(as.data.frame(linear_model_grid), 
                id= c("index", "quality", "pred", "resid"))

ggplot(m_linear,aes(x=value, y = resid))+
  facet_wrap(~variable, scales = "free_x")+
    geom_point()+
    geom_smooth()

ggplot(m_linear, aes(x= quality, y = pred))+
  geom_point()

ggplot(m_linear, aes(x= quality, y = resid))+
  geom_point()
