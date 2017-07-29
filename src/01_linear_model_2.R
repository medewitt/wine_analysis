#Purpose: multi-linear regression
library(boot)
library(leaps)
library(caret)
set.seed(336)

#Create the full linear model
(full_lm_model <- lm(as.numeric(red_wine_data_training$quality)~., data = red_wine_data_training))

#First review for collinearity in the figures


cor(red_wine_data_training)

#pH, fixed acidity and citric acid all have relatively strong correlatiions. This makes sense as
#pH is a measure of acidity. Perhaps we should remove pH as a measure as it indirectly measures
#both fixed acidity and citric acid content.

#Feature selection using model selection and cv

# Create the prediction function to use in cross validation
predict.regsubsets <- function (object, newdata, id, ...){
  form = as.formula (object$call[[2]])
  mat = model.matrix(form, newdata)
  coefi = coef(object, id= id)
  xvars = names (coefi)
  mat[,xvars]%*%coefi
}

red_wine_training_line <- red_wine_data_training %>% 
  dplyr::select(-pH)

x<-predict(BoxCoxTrans(red_wine_data_testing$total_sulfur_dioxide), red_wine_data_testing$total_sulfur_dioxide)

#Complete the K Folds cross validation on the training data set
k <- 10
folds <- sample (1:k, nrow(red_wine_training_line), replace = TRUE)
cv_error_train <- matrix(NA, k, 10, dimnames = list(NULL, paste(1:10)))

for (j in 1:k){
  best_fit <- regsubsets(quality~., data = red_wine_training_line [folds !=j,],
                         nvmax = 10)
  for (i in 1:10){
    pred <- predict.regsubsets(best_fit, red_wine_training_line[folds==j,], id = i)
    cv_error_train[j,i] <- mean( (red_wine_training_line$quality[folds==j]-pred)^2)
  }
}

(mean_cv_errors_train <- apply(cv_error_train, 2, mean))
plot(mean_cv_errors_train, type = 'b', main = "Best Model Selection", xlab = "# Parameters Considered",
     ylab = "MSE")
which.min(mean_cv_errors_train)

##Based on the training data set it appears that using 3-10 variablkes results in about the same error.
#let's use 3

reg_best <- regsubsets(quality ~., data = red_wine_data_training, nvmax = 3)
coef(reg_best, 3)

variables_to_consider <- names (coef(reg_best,3))[-1]

variables_paste <- formula(paste0("quality", "~", paste(variables_to_consider, 
                                                      collapse = "+")))
summary(reg_best)
variables_paste

#Run boostrap

# boot_lm <- function (data, index){
#   return(coef(lm(variables_paste,
#                  data = data, subset = index)))
# }




#Plot predicted Model vs Predictors Etc
# 
# boot_lm(red_wine_training_line, sample(1000, 1000, replace = T))
# 
# (lm_boot_output <- boot(red_wine_training_line, boot_lm, 1000))
# 
# plot(lm_boot_output, index = 3)

###Now fit model on data to see the testing error
best_linear_model <- lm(variables_paste, 
                        data = red_wine_data_training)


#Calculate mse

MSE_lsr <- mean((red_wine_data_testing$quality -predict(best_linear_model, 
                                                   newdata = red_wine_data_testing))^2)

library(modelr)

linear_model_grid <- red_wine_data_testing %>% 
  modelr::add_predictions(best_linear_model) %>% 
  add_residuals(best_linear_model) %>% 
  mutate(index = 1:nrow(red_wine_data_testing)) %>% 
  dplyr::select(volatile_acidity, sulphates,alcohol, quality, pred, resid, index)

m_linear <-melt(as.data.frame(linear_model_grid), 
                id= c("index", "quality", "pred", "resid"))

(linear_resid <- ggplot(m_linear,aes(x=value, y = resid))+
  facet_wrap(~variable, scales = "free_x")+
    geom_point()+
    geom_smooth()+
  labs(
    title = 'Residuals vs Predictors',
    caption = "Using Best Subset Linear Regression"
  )
)

ggsave("graphs/residual_linear_model.pdf")

ggplot(m_linear, aes(x= quality, y = pred))+
  geom_point()

ggplot(m_linear, aes(x= quality, y = resid))+
  geom_point()
