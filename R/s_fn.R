#' @title Computes the function \eqn{s}
#' @description This module evaluates the function \eqn{s} which is specified by the vector
#' \eqn{\big(s_c(0), s_c(1), \dots, s_c(5)\big)}.
#' \deqn{
#'     s(t) = z_{1 - \alpha/2} + s_c(t)
#' }
#' where
#' \deqn{
#'     s_c(t) = s_c(0) \, \text{sinc}(t) + \sum_{k=1}^{5} s_c(k) \, \big(\text{sinc}(t - k) + \text{sinc}(t + k)\big)
#' }
#'
#' @param t numerical value
#' @param sc.knots.vec the vector \eqn{\big(s_c(0), s_c(1), \dots, s_c(5)\big)}
#' @param t.vec the vector \eqn{\big(t_0, t_1, ..., t_k\big)}
#' @param alpha desired minimum coverage probability of the confidence interval is \eqn{1 - \alpha}
#' @param d a positive number that specifies the interval \eqn{[-d,d]}
#'
#' @importFrom JuliaCall julia_call
#'
#' @noRd
#'
#' @return Vector (s(0), s(1), ..., s(length(t.vec)-1))
#'
#' @examples
#' \dontrun{
#' t <- 1
#' sc.knots.vec <-c(-0.2248048, -0.1238696, 0.1684702, -0.2572436, -0.5921521, -0.9373879)
#' t.vec <- seq(0, 5)
#' d <- 6
#' alpha <- 0.05
#' s_fn(t, sc.knots.vec, t.vec, alpha, d)
#' }
#'
s_fn <- function(t, sc.knots.vec, t.vec, alpha, d){

  out <- JuliaCall::julia_call("s_fn_julia",t, sc.knots.vec, t.vec, alpha, d)
  return(out)

}


