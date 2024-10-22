#' Computes the scaled expected length for known error variance.
#'
#'
#'In the case of two nested linear regression models, this function computes the
#'scaled expected length of the confidence interval that utilizes uncertain prior
#'information when the error variance is known. The scaled expected length is
#'defined as the ratio of the expected length of the CIUUPI confidence interval
#'to the expected length of the standard \eqn{1 - \alpha} confidence interval.
#'
#' @param gamma.param The value of \eqn{\gamma} at which the coverage
#' probability
#' function is evaluated.
#' @param bsc.list A list including the values of the knots of \eqn{b} and
#' \eqn{s_c} functions.
#' @param t.vec description
#' @param d A positive number that specifies the interval (-d,d)
#' @param alpha The nominal coverage of the CI is 1 - alpha
#' @param rho Correlation
#' @param no.nodes.GL Number of nodes used in Gauss Legendre
#'
#' @importFrom JuliaCall julia_call
#'
#' @noRd
#'
#' @return The value of Scaled expected length
#'
#' @examples
#' \dontrun{
#' sc.knots.vec <-c(0.7,0.7,0.7,0.7, 0.6,0.5)
#' b.knots.vec <-c(0.7,0.7,0.7,0.6,0.5)
#' bsc.list <- c(b.knots.vec, sc.knots.vec)
#' t.vec <- as.numeric(seq(0, 5))
#' d <- 6
#' alpha <- 0.05
#' rho <- 0.58
#' gamma.param <- 10
#' no.nodes.GL <- 20
#' }
#'
#' SEL_ciuupi(gamma.param, bsc.list, t.vec, d, alpha, rho, no.nodes.GL)
#'
SEL_ciuupi <- function(gamma.param, bsc.list, t.vec, d, alpha, rho, no.nodes.GL){
  # Computes the values of SEL
  #
  # Input:
  # sc.knots.vec: the vector (sc0, sc1, ..., sck)
  # t.vec: the vector (t0, t1, ..., tk)
  # d: a positive number that specifies the interval [-d,d]
  # alpha: The nominal coverage of the CI is 1 - alpha
  # rho: correlation
  # gamma.param: parameter
  # no.nodes.GL: number of nodes used in Gauss Legendre
  #
  # output:
  # value of SEL
  #
  # Written by A.Perera January 2023

  out <- JuliaCall::julia_call("SEL_ciuupi_julia", gamma.param, bsc.list, t.vec, d, alpha, rho, no.nodes.GL)
  return(out)
}
