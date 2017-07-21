
fit1 <-lm(quality ~ free_sulfur_dioxide, data = red_wine_data)
par(mfrow=c(2,2))
plot(fit1, main = "Free Sulfur Dioxide")

fit2 <-lm(quality ~ total_sulfur_dioxide, data = red_wine_data)
par(mfrow=c(2,2))
plot(fit2, main = "Total Sulfur Dioxide")

fit3 <-lm(quality ~ residual_sugar, data = red_wine_data)
par(mfrow=c(2,2))
plot(fit3, main = "Residual Sugar")

fit4 <-lm(quality ~ chlorides, data = red_wine_data)
par(mfrow=c(2,2))
plot(fit3, main = "Chlorides")
