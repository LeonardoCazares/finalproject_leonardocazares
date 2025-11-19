#' Split function to obtain train and test datasets.
#'
#' @param x vector, the total univariate time series to be considered
#' @param dates vector, the respective dates for x (same length as x)
#' @param p numeric, percentage of the time series used for testing,
#'
#' @returns List with:
#' \itemize{
#'   \item x_train: vector, training set
#'   \item x_test: vector, testing set
#'   \item dates_train: vector, training dates
#'   \item dates_test: vector, testing dates
#' }
#' @export
#'
#' @examples
#' x <- 1:20
#' dates <- as.Date("2024-01-01") + 0:19
#' split <- train_test_split(x, dates, p = 0.2)
#' split$x_train
#' split$x_test
#' split$dates_train
#' split$dates_test
train_test_split <- function(x, dates, p = 0.05) {

  if (!is.numeric(p) || length(p) != 1L || p <= 0 || p >= 1) {
    stop("`p` must be a single number in (0, 1).")
  }

  n <- length(x)
  if (n == 0L) {
    stop("`x` must have at least one element.")
  }

  if (length(dates) != n) {
    stop("`dates` must have the same length as `x`.")
  }

  # number of points for testing
  n_test  <- max(1L, floor(n * p))
  # number of points for training
  n_train <- n - n_test

  # Time series spliting
  x_train <- x[1:n_train]
  x_test <- x[(n_train + 1L):n]

  # Dates spliting
  dates_train <- dates[1:n_train]
  dates_test <- dates[(n_train + 1L):n]

  list(
    x_train = x_train,
    x_test = x_test,
    dates_train = dates_train,
    dates_test = dates_test
  )
}
