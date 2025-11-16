#' Cross-validation para modelo AR con L2
#'
#' @param x vector, time series to be used for cross validation
#' @param folds integer, number of folds considered for CV
#' @param lags interger, number of lags
#' @param beta float, reg. param. for regularization param
#'
#' @return List with,
#' \itemize{
#'   \item fold_mae: vector, each validation MAE per fold
#'   \item mean_mae: float, mean MAE across folds
#'   \item lags: integer, number of lags used
#'   \item beta: float, regularization factor
#' }
#' @export
#'
#' @example
#' output <- cv_ar_l2(1:365, folds = 12, lags = 7, beta = 0.1)
#' print(output$fold_mae)
#' print(output$mean_mae)
#' print(output$integer)
#' print(output$beta)
cv_ar_l2 <- function(x, folds = 5, lags = 7, beta = 0.1) {

  # Creation of training and validation folds
  cv_list <- cv_dataset_creation(x, folds = folds)

  # Set the vector for MAE's among the validation folds
  fold_mae <- numeric(length(cv_list))
  names(fold_mae) <- names(cv_list)

  ## For each of the training-validation pairs for each CV case
  #for (i in seq_along(cv_list)) {
#
  #  # Get i-th fold for CV
  #  fold_i <- cv_list[[i]]
#
  #  # Concatenate the two bunch of training data
  #  train_series <- c(fold_i$train_batch_1, fold_i$train_batch_2)
#
  #  # Train the i-th CV model on the splited training data
  #  fit <- fit_ar_l2(train_series, lags = lags, beta = beta)
#
  #  # Get the respective validation batch of data
  #  val <- fold_i$val
#
  #  # Check that the lenght of the validation dataset is greater than the number of lags
  #  if (length(val) <= lags) {
  #    fold_mae[i] <- NA_real_ # If not tha MAE is a NaN value
  #    next
  #  }
#
  #  n_val   <- length(val)
  #  n_rows  <- n_val - lags # Number of batches for validation
  #  X_val   <- matrix(NA_real_, nrow = n_rows, ncol = lags) # Design matrix for validation
#
  #  for (j in seq_len(n_rows)) {
  #    X_val[j, ] <- val[j:(j + lags - 1L)] # Create lags
  #  }
#
  #  y_val <- val[(lags + 1L):n_val] # Define labels
#
  #  # Add the interception term
  #  Z_val <- cbind(Intercept = 1, X_val)
#
  #  # With the training beta produce predictions
  #  y_hat_val <- as.vector(Z_val %*% fit$coef)
#
  #  # MAE for the respective validation fold
  #  fold_mae[i] <- mean(abs(y_val - y_hat_val))
  #}
#
  #mean_mae <- mean(fold_mae, na.rm = TRUE) # Mean MAE across validation folds
#
  #list(
  #  fold_mae = fold_mae,
  #  mean_mae = mean_mae,
  #  lags     = lags,
  #  beta     = beta
  #)
}
