#Purpose: Run principle component analysis and 
#         see if we can reduce the dimensionality in the dataset

pca_red_wine<- red_wine_data_clean %>%
  dplyr::select(-quality) %>% 
  as.data.frame() %>% 
  na.omit()

summary(pca_red_wine)
str(pca_red_wine)

(pca<-prcomp(pca_red_wine, scale. = TRUE))
summary(pca)
plot(pca)