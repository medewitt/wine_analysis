

which.max(red_wine_data$total_sulfur_dioxide)

red_wine_data_no_outliers <-red_wine_data[-1082,]
which.max(red_wine_data_no_outliers$total_sulfur_dioxide)
red_wine_data_no_outliers <-red_wine_data[-1080,]

k <- 5
folds <- sample (1:k, nrow(red_wine_data_no_outliers), replace = TRUE)
cv_error <- matrix(NA, k, 11, dimnames = list(NULL, paste(1:11)))

for (j in 1:k){
  best_fit <- regsubsets(quality~., data = red_wine_data_no_outliers [folds !=j,],
                         nvmax = 11)
  for (i in 1:11){
    pred = predict.regsubsets(best_fit, red_wine_data_no_outliers[folds==j,], id = i)
    cv_error[j,i] = mean( (red_wine_data_no_outliers$quality[folds==j]-pred)^2)
  }
}

(mean_cv_errors <- apply(cv_error, 2, mean))
plot(mean_cv_errors, type = 'b', main = "Best Model Selection", xlab = "# Parameters Considered",
     ylab = "MSE")
which.min(mean_cv_errors)

reg_best <- regsubsets(quality ~., data = red_wine_data_no_outliers, nvmax = 7)
coef(reg_best, 7)

