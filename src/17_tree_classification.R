#Classification Tree
library(tree)

tree_wine <- tree(classification ~., data = red_wine_data_training_fact)

plot(tree_wine)
text(tree_wine, pretty = 0)

cv_tree_wine <- cv.tree( tree_wine, FUN = prune.misclass)

plot(cv_tree_wine$size, cv_tree_wine$dev, type = "b")

prune_wine_tree <- prune.misclass(tree_wine, best = 6)

wine_tree_pred <-predict(prune_wine_tree, newdata = red_wine_data_testing_fact)

(tree_missclassification <- 1-
    mean(wine_tree_pred== red_wine_data_testing_fact$classification))