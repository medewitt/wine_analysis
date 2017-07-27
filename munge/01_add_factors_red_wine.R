#This script will apply some factors to the total data set

#classification settings
poor_threshold <- 4
good_threshold <- 7

#This script creates the new levels and factors in a new data set

red_wine_data_factors<- red_wine_data_clean %>% 
  mutate(classification = case_when (quality <= poor_threshold ~ "poor", 
                                  quality >= good_threshold ~ "good", 
                                  TRUE ~"medium"))
red_wine_data_factors <- red_wine_data_factors %>% 
  dplyr::select(-quality)

table(red_wine_data_factors$classification)

red_wine_data_factors <- red_wine_data_factors %>% 
  mutate(classification = as.factor(classification))

