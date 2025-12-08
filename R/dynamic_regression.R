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
    coef_dynamic <- as.vector(out_dynamic$coef)

    # Get the out-of-sample prediction given the current x_train_dynamic
    x_train_last_window <- as.vector(x_train_dynamic[(lenght_dynamic_train - lags + 1):lenght_dynamic_train])
    y_hat <- sum(coef_dynamic * x_train_last_window)
    y_pred[step] <- y_hat

    # Augment a new point for the current dynamic training set
    x_train_dynamic <- c(x_train_dynamic, x_test[step])
    lenght_dynamic_train <- length(x_train_dynamic)
  }

  list(
    y_pred   = y_pred,
    lags   = lags,
    beta   = beta
  )

}
