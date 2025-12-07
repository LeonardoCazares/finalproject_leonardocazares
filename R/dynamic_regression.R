dynamic_regression <- function(x_train, x_test, beta, lags){

  # One prediction per test point
  length_test <- length(x_test)

  # Vector for predictions
  y_pred = numeric(length = length_test)

  # Vector for dynamic training
  x_train_dynamic <- x_train
  lenght_dynamic_train <- length(x_train_dynamic)

  for (step in 1:length_test){

    # Fit the ridge regression in the current dynamic training step
    out_dynamic <- fit_ar_l2(x_train_dynamic, lags, beta)

    x_train_last_window <- x_train_dynamic[]

  }

}
