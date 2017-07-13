library(pls)
library(glmnet)
y <- red_wine_data_training$quality
model_matrix <- model.matrix( quality ~ ., data=red_wine_data_training )
cv_out <- cv.glmnet( model_matrix, y, alpha=0 )
bestlam <- cv_out$lambda.min

ridge_mod <- glmnet( model_matrix, y, alpha=0 )

#Predict using new test values
ridge_pred <- predict( ridge_mod, s=bestlam, newx=model.matrix( quality ~ ., 
                                                                data=red_wine_data_testing ) )
(MSE_ridge <- mean( ( red_wine_data_testing$quality - ridge_pred )^2 ))

####################################
#############Lasso
####################################

cv_out <- cv.glmnet( model_matrix, y, alpha=1 )

bestlam <- cv_out$lambda.min

lasso_mod <- glmnet( model_matrix, y, alpha=1 )

lasso_pred <- predict( lasso_mod, s = bestlam, 
                       newx= model.matrix( quality ~ ., data = red_wine_data_testing ) )

(MSE_lasso <- mean( ( red_wine_data_testing$quality - lasso_pred )^2 ))
a<-predict( lasso_mod, type="coefficients", s=bestlam )
a


