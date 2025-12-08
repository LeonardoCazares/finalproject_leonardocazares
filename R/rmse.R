#' Root mean square error (RMSE)
#'
#' Computes the RMSE between one ground-truth time serie and a respective time series
#'
#' @param y_gt numeric, ground-truth time serie
#' @param y_pred numeric, prediction time serie
#'
#' @returns scalar, RMSE value
#' @export
#'
#' @examples
#' y_gt <- 1:15
#' y_pred <- y_gt + rnorm(15, 0, 0.1)
#' rmse_value <- rmse(y_gt, y_pred)
#' print(rmse_value)
rmse <- function(y_gt, y_pred) {
  return(sqrt(mean((y_gt - y_pred)**2)))
}
