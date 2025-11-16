#' Soft-thresholding
#'
#' Calculates soft-thresholding function
#'
#' @param a the first argument to soft-thresholding function; numeric scalar
#' @param lambda thresholding parameter; positive, numeric scalar
#'
#' @returns a numeric scalar
#' @export
#'
#' @examples
#' soft(5, 3)

soft <- function(a, lambda){
  sign(a) * max(abs(a)- lambda, 0)
}
