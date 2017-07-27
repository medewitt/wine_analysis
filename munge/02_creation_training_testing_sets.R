#The purpose of this script is to segregate the data into testing and training data sets

set.seed(336)

n <- nrow(red_wine_data_factors)
train_rows <- sample(seq(n), size = .7 * n)

red_wine_data_training_fact <- red_wine_data_factors[ train_rows, ]
red_wine_data_testing_fact  <- red_wine_data_factors[-train_rows, ]

red_wine_data_testing <- red_wine_data_clean[train_rows,]
red_wine_data_training <-red_wine_data_clean[-train_rows,]
