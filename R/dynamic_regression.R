#' Dynamic ridge autoregressive forecasting
#'
#' This function performs a dynamic training scheme of a ridge-autoregressive model over
#' a univariate time-series. At each step it:
#' \itemize{
#'   \item fits an AR(p) model (where p = # of lags) with ridge penalty using only the last `window`
#'         observations from the training part of the current time series,
#'   \item predicts a one-step-ahead forecast,
#'   \item updates the training series by dropping its first value and
#'         appending the next observed value from `x_test`, maintaining
#'         the length of the training batch equal to the `window`.
#' }
#' The number of predictions is equal to `length(x_test)`.
#'
#' The model includes an intercept which is **not** penalized.
#'
#' @param x_train numeric vector, training time series.
#' @param x_test numeric vector, test time series (future observed values).
#' @param beta non–negative scalar, ridge regularization parameter (lambda).
#' @param p integer, number of lags in the AR(p) model.
#' @param window integer, size of the rolling training window at each step.
#'   Must satisfy `window > p` and `window <= length(x_train)`.
#'
#' @return numeric vector of predictions of length `length(x_test)`.
#'
#' @importFrom utils tail
#' @importFrom stats embed
#'
#' @export
#'
#' @examples
#' set.seed(2025)
#' x <- arima.sim(model = list(ar = 0.7), n = 200)
#' x_train <- x[1:160]
#' x_test  <- x[161:200]
#' preds <- dynamic_regression(x_train, x_test,
#'                           beta = 1, p = 3, window = 50)
#' length(preds)  # should be length(x_test)
dynamic_regression <- function(x_train, x_test, beta, p, window) {

  # Initial checks for the lenght of x_train, x_test, number of lags and the window

  if (!is.numeric(x_train) || !is.numeric(x_test)) {
    stop("`x_train` and `x_test` must be numeric vectors.")
  }

  n_train <- length(x_train)
  n_test  <- length(x_test)

  if (window <= p) {
    stop("The considered window must be strictly greater than the number of lags.")
  }

  if (window > n_train) {
    stop("The training set must be bigger than the window for training.")
  }

  if (beta < 0) {
    stop("Regularization parameter must the non-negative.")
  }

  preds <- numeric(n_test) # Num. of predictions

  # Current training data, update during each training step
  current <- x_train
  base_n  <- n_train  # Oroginal size of the training dataset

  for (i in seq_len(n_test)) {

    # Hold the last 'window'-number of values in the training set
    series_window <- tail(current, window)
    m <- length(series_window) # Lenght of the current training batch

    # Design matrix
    mat <- embed(series_window, p + 1)
    y_train <- mat[, 1] # Label columns
    X_lags  <- mat[, -1, drop = FALSE]  # Columns with lag

    # Add the reg. penalization for all the p-features but the interception
    X <- cbind(1, X_lags) # Interception column
    k <- ncol(X) # Number of features, inluding interception
    penalty <- diag(k)
    penalty[1, 1] <- 0 # Set the pen. term. for the interception as zero

    # Solve the estimator for the coefficients in the ridge reg.
    XtX <- crossprod(X)
    Xty <- crossprod(X, y_train)
    coef_ridge <- solve(XtX + beta * penalty, Xty)

    # Make the out-of-sample prediction
    new_x_lags <- rev(tail(series_window, p))
    new_x <- c(1, new_x_lags) # Add interception
    preds[i] <- drop(new_x %*% coef_ridge) # Get the scalar o.s. prediction

    # Update the training batch
    if (length(current) == base_n) {
      current <- c(current[-1], x_test[i])
    } else {
      current <- c(tail(current, base_n - 1), x_test[i])
    }
  }

  preds
}
