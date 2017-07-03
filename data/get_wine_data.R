library(tidyverse)

red_wine_data <-as_tibble(read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv",
                          sep =  ";"))

colnames(red_wine_data)<-c("fixed_acidity", "volatile_acidity", "citric_acid",
                           "residual_sugar", "chlorides", "free_sulfur_dioxide",
                           "total_sulfur_dioxide", "density", "pH", "sulphates",
                           "alcohol", "quality")
red_wine_data <- mutate(red_wine_data, total_sulfur_dioxide = as.numeric(total_sulfur_dioxide))

summary(red_wine_data)
