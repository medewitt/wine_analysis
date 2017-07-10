range_scaler <- function(x){
  x = x- min(x)/(max(x)-min(x))
}
