#' Autoregressive model with L2 regularization
#'
#' @param x numeric vector with the training time series.
#' @param lags integer, number of lags for prediction.
#' @param beta float, regularization param.
#'
#' @return Lista con:
#' \itemize{
#'   \item coef: vector, coefficients for
#'   \item lags: integer, number of lags
#'   \item beta: float, regularization param.
#'   \item mae: float, mean absolute error for training
#'   \item X: matrix, design matrix
#'   \item y: vector, output vector
#'   \item y_pred: predictions over the training set
#' }
#' @export
#'
#' @examples
#' x <- c(1, 2, 3, 4, 5, 6)
#' out <- fit_ar_l2(x, lags = 3, beta = 0.1)
#' print(out$coef)
#' print(out$mae)
fit_ar_l2 <- function(x, lags, beta) {

  x <- as.numeric(x)
  n <- length(x)

  if (lags < 1L) {
    stop("`lags` should be >= 1.")
  }
  if (n <= lags) {
    stop("The size of `x` should be grater than `lags`.")
  }
  if (beta < 0) {
    stop("`beta` must be >= 0 (non-negative L2 reg param).")
  }

  # Number of data batches
  n_rows <- n - lags

  # Design matrix, where each row is: (x_t, x_{t+1}, ..., x_{t+lags-1})
  X <- matrix(NA_real_, nrow = n_rows, ncol = lags)
  for (i in seq_len(n_rows)) {
    X[i, ] <- x[i:(i + lags - 1L)]
  }

  # Prediction vector: y_t = x_{t+lags}
  y <- x[(lags + 1L):n]

  # Add intercept.
  Z <- cbind(Intercept = 1, X)
  p <- ncol(Z)

  # Penalization matrix
  penalty <- diag(c(0, rep(beta, p - 1L)))

  # Closed rigde-regression solution: (Z'Z + penalty)^(-1) Z'y
  XtX <- crossprod(Z)        # t(Z) %*% Z
  Xty <- crossprod(Z, y)     # t(Z) %*% y
  coef <- solve(XtX + penalty, Xty)

  # Training predictions
  y_pred <- as.vector(Z %*% coef)

  # MAE for training
  mae <- mean(abs(y - y_pred))

  list(
    coef   = coef,
    lags   = lags,
    beta   = beta,
    mae    = mae,
    X      = X,
    y      = y,
    y_pred = y_pred
  )
}
