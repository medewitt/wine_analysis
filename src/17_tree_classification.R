#Classification Tree
library(tree)

tree_wine <- tree(classification ~., data = red_wine_data_training_fact)

par(mfrow=c(1,1))
plot(tree_wine)
text(tree_wine, pretty = 0)

cv_tree_wine <- cv.tree( tree_wine, FUN = prune.misclass)

plot(cv_tree_wine$size, cv_tree_wine$dev, type = "b")

#Choose 6 branchs based on the chart

prune_wine_tree <- prune.misclass(tree_wine, best = 6)

wine_tree_pred <-predict(prune_wine_tree, newdata = red_wine_data_testing_fact)

wine_preds <- colnames(wine_tree_pred)[apply(wine_tree_pred,1,which.max)]

(tree_missclassification <- 1-
    mean(wine_preds== red_wine_data_testing_fact$classification))

(tree_table <-table(wine_preds, red_wine_data_testing_fact$classification))

(tree_good <- round((tree_table[1,1])/(tree_table[1,1]+tree_table[2,1]),2))
(tree_medium <- round((tree_table[2,2])/(tree_table[1,2]+tree_table[2,2]),2))
# (tree_poor <- round((tree_table[3,3])/(tree_table[1,3]+tree_table[2,3]),2))

tree_accuracy <-cbind(tree_good, tree_medium, 0)


