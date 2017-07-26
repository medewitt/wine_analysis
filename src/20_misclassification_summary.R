#Now Combine all the Misclassification to a single files


combined_misclassification<- as_tibble(rbind(knn_best_misclassification, naive_bayes_missclass
                                             , lda_missclass, qda_missclassification)) %>% 
  mutate(Fit_Technique = c("KNN", "Naive Bayes", "LDA", "QDA"))

colnames(combined_misclassification)<-c("Misclassification", "Model")

combined_misclassification<- combined_misclassification %>% 
  mutate(Misclassification_round = round (Misclassification, 3))

(classification_plot <-ggplot(combined_misclassification, aes (x= Model, y = Misclassification))+
    geom_bar(stat = "identity")+
    labs(
      title = "Overall Misclassification for Each Classification Type",
      subtitle = "Predicting the Quality Asssement"
    )+
    geom_label(aes(x= Model, y = Misclassification, label = Misclassification_round ), position = "dodge"))
ggsave("graphs/misclassification_plot.pdf")
