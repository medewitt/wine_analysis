#Now Combine all the Test MSE to a single files


combined_linear_mse <- as_tibble(rbind(MSE_lsr, MSE_ridge, MSE_lasso, MSE_pcr, MSE_pls)) %>% 
  mutate(Fit_Technique = c("Least Squares", "Ridge", "Lasso", "PCR", "PLS"))

colnames(combined_linear_mse)<-c("MSE", "Model")

combined_linear_mse<- combined_linear_mse %>% 
  mutate(MSE_round = round (MSE, 3))

(MSE_plot <-ggplot(combined_linear_mse, aes (x= Model, y = MSE))+
  geom_bar(stat = "identity")+
  labs(
    title = "Overall MSE for Each Regression Type",
    subtitle = "Predicting the Quality Asssement"
  )+
  geom_label(aes(x= Model, y = MSE, label = MSE_round ), position = "dodge"))
