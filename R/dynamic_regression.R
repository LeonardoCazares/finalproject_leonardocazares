#' Dynamic training/testing
#'
#' @param x_train training univariate time serie
#' @param x_test testing univariate time serie
#' @param beta optimized regularization param
#' @param lags optimized number of lags
#'
#' @returns
#' \itemize{
#'   \item y_pred: vector, out-of-sample predictions
#'   \item lags: integer, number of used lags
#'   \item beta: float, value of used regularization param
#' }
#' @export
#'
#' @examples
#' x <- seq(1,2, length.out = 100)
#' x_train <- x[1:80]
#' x_test <- x[81:100]
#' beta <- 1e-5
#' lags <- 1
#' out <- dynamic_regression(x_train, x_test, beta, lags)
#' print(x_test)
#' print(out$y_pred)
dynamic_regression <- function(x_train, x_test, beta, lags) {
  # One prediction per test point
  length_test <- length(x_test)

  # Vector for predictions
  y_pred = numeric(length = length_test)

  # Vector for dynamic training
  x_train_dynamic <- x_train
  lenght_dynamic_train <- length(x_train_dynamic)

  for (step in 1:length_test) {
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

  list(y_pred = y_pred,
       lags = lags,
       beta = beta)

}
