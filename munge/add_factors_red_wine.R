#This script will apply some factors to the total data set

#classification settings
poor_threshold <- 4
good_threshold <- 8

#This script creates the new levels and factors in a new data set

red_wine_data_factors<- red_wine_data %>% 
  mutate(classification = if_else(quality <= poor_threshold, "poor", 
                                  ifelse(quality >= good_threshold, "good", "medium")))

red_wine_data_factors <- red_wine_data_factors %>% 
  mutate(classification = as.factor(classification))

