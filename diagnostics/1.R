# Verify that the data imported correctly
library(testthat)

stopifnot(expect_that(dim(red_wine_data)[1] == 1599, is_true()) &&
          expect_that(dim(red_wine_data)[2] == 12, is_true()))
