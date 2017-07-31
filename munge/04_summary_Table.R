#summary values for tables in the report

red_wine_data_index <-red_wine_data_raw%>% 
  mutate(id = seq.int(nrow(red_wine_data_raw)))

summary_table <- as.data.frame(red_wine_data_index) %>% 
  melt(id.vars = "id") %>% 
  group_by(variable) %>% 
  summarise(min = round(min(value),2), median = round(median(value),2), mean = round(mean(value),2), 
            max = round(max(value),2))
Descriptions <- c("fixed acidity (g(tartaric acid)/dm^3)", "volatile acidity (g(acetic acid)/dm^3)",
                  "citric acid (g/dm^3)", "residual sugar (g/dm^3)", "chlorides (g(sodium cloride)/dm^3",
                  "free sulfur dioxide (mg/dm^3)", "total sulfur dioxide (mg/dm^3)", "density (g/cm^3)",
                  "pH", "sulphates (g(potassium sulphate)/dm^3)", "alcohol (% vol.)", "quality")


table_to_print <-add_column(summary_table, Descriptions, .before = "variable") %>% 
  dplyr::select(-variable)
