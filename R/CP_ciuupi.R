#' Computes the overall coverage probability
#'
#' @param b.s.vec the vector (b1, b2, ..., bk, sc0, sc1, ..., sck)
#' @param t.vec the vector (t0, t1, ..., tk)
#' @param d a positive number that specifies the interval (-d,d)
#' @param alpha The nominal coverage of the CI is 1 - alpha
#' @param rho correlation
#' @param gamma.param gamma parameter
#' @param no.nodes.GL Number of nodes used in Gauss Legendre
#'
#' @return value of the coverage probability
#'
#' @noRd
#'
#' @importFrom JuliaCall julia_call
#'
#' @examples
#' \dontrun{
#' sc.knots.vec <-c(0.7,0.7,0.7,0.7, 0.6,0.5)
#' b.knots.vec <-c(0.7,0.7,0.7,0.6,0.5)
#' b.s.vec <- c(b.knots.vec, sc.knots.vec)
#' t.vec <- as.numeric(seq(0, 5))
#' d <- 6
#' alpha <- 0.05
#' rho <- 0.6
#' gamma.param <- 3
#' no.nodes.GL <- 20
#'
#' CP_ciuupi(b.s.vec, t.vec, d, alpha, rho, gamma.param, no.nodes.GL)
#' }
#'
CP_ciuupi <- function(b.s.vec, t.vec, d, alpha, rho, gamma.param, no.nodes.GL){

  out <- JuliaCall::julia_call("CP_ciuupi_julia", b.s.vec, t.vec, d, alpha, rho, gamma.param, no.nodes.GL)
  return(out)

}
