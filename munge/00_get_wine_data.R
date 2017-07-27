library(tidyverse)

red_wine_data_raw <-as_tibble(read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv",
                          sep =  ";"))

colnames(red_wine_data_raw)<-c("fixed_acidity", "volatile_acidity", "citric_acid",
                           "residual_sugar", "chlorides", "free_sulfur_dioxide",
                           "total_sulfur_dioxide", "density", "pH", "sulphates",
                           "alcohol", "quality")
red_wine_data_raw <- mutate(red_wine_data_raw, total_sulfur_dioxide = as.numeric(total_sulfur_dioxide))

red_wine_data_clean <- red_wine_data_raw[-c(1080, 1082),]

