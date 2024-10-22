#' @title Computes the function \eqn{b}
#' @description This module evaluates the function b(t) for given (b1, b2, ..., bk).
#'
#' b(t) =
#' b1 * (sinc(t1 - 1) - sinc(t1 + 1)) +
#'    .
#'    .
#'    .+
#' bk * (sinc(tk - k) - sinc(tk + k))
#'
#' @param t value of the test statistic
#' @param b.knots.vec the vector (b1, b2, ..., bk)
#' @param t.vec the vector (t0, t1, ..., tk)
#' @param d a positive number that specifies the interval (-d,d)
#'
#' @importFrom JuliaCall julia_call
#'
#'
#' @return Vector (b(1), b(2), ..., b(k)
#' @examples
#' \dontrun{
#' t <- 1
#' b.knots.vec <- c(0.1,0.3,0.5,0.3,0.1)
#' t.vec <- seq(0, 5)
#' d <- 6
#' b_fn(t, b.knots.vec, t.vec, d)
#'}
#' @noRd
#'
#'
b_fn <- function(t, b.knots.vec, t.vec, d){

  out <- JuliaCall::julia_call("b_fn_julia", t, b.knots.vec, t.vec, d)

  return(out)
}

