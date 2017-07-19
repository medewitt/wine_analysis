summary(red_wine_data_factors)

library(reshape2)

as.data.frame(red_wine_data)%>% 
  melt() %>% 
  ggplot(aes(x= variable, y = value))+
  geom_boxplot()+
  coord_flip()

#add an index to the data for use with the histograms

red_wine_data_index <-red_wine_data%>% 
  mutate(id = seq.int(nrow(red_wine_data)))

as.data.frame(red_wine_data_index) %>% 
  melt(id.vars = "id") %>% 
  ggplot(aes(value))+facet_wrap(~variable, scales = "free_x")+geom_histogram()+
  geom_histogram(binwidth = function(x) 2 * IQR(x) / (length(x)^(1/3)))+
  labs(
    title = "Histograms of All Predictors"
  )+
  xlab("")

ggsave("graphs/histogram_all_pred.pdf")

#Review the histogram for the total sulfur dioxide
as.data.frame(red_wine_data_factors) %>% 
  melt() %>%
  filter(variable == "total_sulfur_dioxide") %>% 
  ggplot(aes( value))+
  geom_histogram()+
  labs(
    title = "Histogram of Total Sulfur Dioxide",
    caption = "From UCI Wine Data Set"
  )+
  xlab("Total Sulfur Dioxide")

# Review the histogram for the free sugar
as.data.frame(red_wine_data_factors) %>% 
  melt() %>%
  filter(variable == "free_sulfur_dioxide") %>% 
  ggplot(aes( value))+
  geom_histogram()+
  labs(
    title = "Histogram of Free Sulfur Dioxide",
    caption = "From UCI Wine Data Set"
  )+
  xlab("Free Sulfur Dioxide")

#Review the histogram for the residual sugar
as.data.frame(red_wine_data_factors) %>% 
  melt() %>%
  filter(variable == "residual_sugar") %>% 
  ggplot(aes( value))+
  geom_histogram()+
  labs(
    title = "Histogram of Residual Sugar",
    caption = "From UCI Wine Data Set"
  )+
  xlab("Total Residual Sugar")

##No clearly present outliers
ggplot(red_wine_data_factors, aes(x=quality))+
  geom_point(aes(y=residual_sugar))

ggplot(red_wine_data_factors, aes(x=quality))+
  geom_point(aes(y=free_sulfur_dioxide))

#There are two wines that have very high sulfur dioxide content and have a 7 rating. This could 
#pull our model the wrong direction, at least for regression if we use total sulfur as a predictor.

ggplot(red_wine_data_factors, aes(x=quality))+
  geom_point(aes(y=total_sulfur_dioxide))

ggplot(red_wine_data_factors, aes(y=quality))+
  geom_point(aes(x=total_sulfur_dioxide))


