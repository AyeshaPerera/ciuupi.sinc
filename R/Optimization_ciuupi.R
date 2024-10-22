#' Optimization with known error variance
#'
#' @param start.vec The start vector
#' @param lambda A number
#' @param t.vec The vector (t0, t1, ..., tk)
#' @param d A positive number that specifies the interval (-d,d)
#' @param alpha The nominal coverage of the CI is 1 - alpha
#' @param rho Correlation
#' @param n.ints description
#' @param gamma.vec A vector of gamma values.
#' @param no.nodes.GL Number of nodes used in Gauss Legendre
#' @param num.ints Number of intervals from 0 to d
#' @param nl.info logical; shall the original NLopt info been shown.
#'
#' @importFrom JuliaCall julia_call
#' @importFrom nloptr slsqp
#'
#' @return Optimization
#' @noRd
#'
#' @examples
#' \dontrun{
#' start.vec <- rep(0,15)
#' lambda <- 1
#' t.vec <- seq(0, 5)
#' d <- 8
#' alpha <- 0.05
#' rho <- 0.6
#' gamma.vec <- seq(0, 10, length.out=40)
#' no.nodes.GL <- 20
#' num.ints <- 20
#' Optimization_ciuupi(start.vec, lambda, t.vec, d, alpha, rho, gamma.vec, no.nodes.GL, num.ints)
#' }
#'
Optimization_ciuupi <- function(start.vec, lambda, t.vec, d, alpha, rho, n.ints,
                                gamma.vec, no.nodes.GL, num.ints, nl.info=F){

  out <- JuliaCall::julia_call("Optimization_ciuupi_julia", start.vec, lambda, t.vec, d, alpha, rho, n.ints,
                               gamma.vec, no.nodes.GL, num.ints, nl.info)
  return(out)

}
