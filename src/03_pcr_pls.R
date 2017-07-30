library(pls)
library(glmnet)

# PCR
pcr_fit <- pcr( quality ~ ., data=red_wine_data_training, scale=TRUE, validation="CV" )

validationplot(pcr_fit, val.type = "MSEP")

#Lowest when all components are used
pcr_fit$loadings
(ncomps <- ncol(red_wine_data_testing)-1)
PCR_pred <- predict( pcr_fit, red_wine_data_testing, ncomp=9 )
(MSE_pcr = mean( ( red_wine_data_testing$quality - PCR_pred )^2 ))


#PLS Regression

pls_fit <- plsr( quality ~ ., data = red_wine_data_clean, subset = train_rows, 
                 scale=TRUE, validation="CV" )

summary(pls_fit)

validationplot(pls_fit, val.type = "MSEP")

#Looks like # predictors is at a minimum between 3 and 11
pls_fit$loadings
pls_pred <- predict( pls_fit, red_wine_data_testing, ncomp=3 )
(MSE_pls = mean( ( red_wine_data_testing$quality - pls_pred )^2 ))
