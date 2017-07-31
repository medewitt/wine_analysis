# Example Unit Testing Script

library(validate)
expect_that(1, equals(1))

(cf <-red_wine_data_raw %>% 
  check_that(fixed_acidity >0, volatile_acidity>0, quality >0, residual_sugar>0, chlorides>0, 
             is.na(red_wine_data_raw)==FALSE, nrow(red_wine_data_raw)==1599, ncol(red_wine_data_raw)==12))

summary(cf)
names(red_wine_data_raw)
par(mfrow = c(1,1))
barplot(cf, main="data import tests")

