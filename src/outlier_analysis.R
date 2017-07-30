(normality_test <- apply(red_wine_data_raw, 2, shapiro.test))

fit1 <-lm(quality ~ free_sulfur_dioxide, data = red_wine_data_raw)
par(mfrow=c(2,2))
plot(fit1, main = "Free Sulfur Dioxide")

fit2 <-lm(quality ~ total_sulfur_dioxide, data = red_wine_data_raw)
par(mfrow=c(2,2))
plot(fit2, main = "Total Sulfur Dioxide")

fit3 <-lm(quality ~ residual_sugar, data = red_wine_data_raw)
par(mfrow=c(2,2))
plot(fit3, main = "Residual Sugar")

fit4 <-lm(quality ~ chlorides, data = red_wine_data_raw)
par(mfrow=c(2,2))
plot(fit3, main = "Chlorides")

fit5 <-lm(quality ~ alcohol, data = red_wine_data_raw)
par(mfrow=c(2,2))
plot(fit5, main = "Alcohol")

fit6 <-lm(quality ~ volatile_acidity, data = red_wine_data_raw)
par(mfrow=c(2,2))
plot(fit6, main = "Alcohol")

fit7 <-lm(quality ~ pH, data = red_wine_data_raw)
par(mfrow=c(2,2))
plot(fit7, main = "pH")

fit8 <-lm(quality ~ citric_acid, data = red_wine_data_raw)
par(mfrow=c(2,2))
plot(fit8, main = "Citric Acid")
