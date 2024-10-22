#' mullers_method
#'
#' @param x.vec mullers_method
#' @param y.vec mullers_method
#'
#' @noRd
#'
#' @return
#' mullers_method
#'
mullers_method <- function (x.vec, y.vec){

  h2 <- x.vec[1] - x.vec[3]
  d2 <- y.vec[1] - y.vec[3]
  h1 <- x.vec[2] - x.vec[3]
  d1 <- y.vec[2] - y.vec[3]
  num.A <- h1 * d2 - h2 * d1
  denom.A <- h2 * h1 * (h2 - h1)
  A <- num.A/denom.A
  num.B <- h2^2 * d1 - h1^2 * d2
  denom.B <- h2 * h1 * (h2 - h1)
  B <- num.B/denom.B
  C <- y.vec[3]
  num <- -2 * sign(B) * C
  denom <- abs(B) + sqrt(B^2 - 4 * A * C)
  h <- num/denom
  x.vec[3] + h
}
