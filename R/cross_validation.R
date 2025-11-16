#' Title
#'
#' @param x vector, time series data
#' @param folds integer, number of folds for CV
#'
#' @returns list, with folds for training and validation
#' @export
#'
#' @examples
#' result <- cv_dataset_creation(1:25, 5)
#' print(result$train_batch_1)
#' print(result$fold_1)
#' print(result$fold_2)
#' print(result$fold_3)
#' print(result$fold_4)
#' print(result$fold_5)
cv_dataset_creation <- function(x, folds = 5) {
  n <- length(x)
  n_per_fold <- n %/% folds  # Size of each fold

  cv_list <- vector("list", folds)
  names(cv_list) <- paste0("fold_", seq_len(folds))

  for (i in seq_len(folds)) {

    # Index for the validation fold
    start_val <- (i - 1L) * n_per_fold + 1L
    # Last fold holds the remaining part
    end_val <- if (i < folds) i * n_per_fold else n

    # Training before validation block
    train_1 <- if (start_val > 1L) x[1:(start_val - 1L)] else x[integer(0)]

    # Training after validation block
    train_2 <- if (end_val < n) x[(end_val + 1L):n] else x[integer(0)]

    # Validation block
    val <- x[start_val:end_val]

    cv_list[[i]] <- list(
      train_batch_1 = train_1,
      val           = val,
      train_batch_2 = train_2
    )
  }

  return(cv_list)
}
