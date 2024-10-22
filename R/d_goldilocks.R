#' d_goldilocks
#'
#' @param alpha d_goldilocks
#' @param rho.vec d_goldilocks
#'
#' @return
#' d_goldilocks
#'
#' @noRd
d_goldilocks <- function (alpha, rho.vec){
  if (alpha <= 0.1) {
    b.alpha <- 4.747653 - 17.386735 * alpha
  }
  else {
    b.alpha <- 3.00898
  }
  4.1 + b.alpha * abs(rho.vec)
}
