#' Title
#'
#' @param b.s.vec description
#' @param t.vec description
#' @param d description
#' @param alpha description
#' @param rho description
#' @param no.nodes.GL description
#'
#' @importFrom JuliaCall julia_call
#'
#' @noRd
#'
#' @return
#' sel_min_max
#'
sel_min_max <- function(b.s.vec, t.vec, d, alpha, rho, no.nodes.GL)
{
  out <- JuliaCall::julia_call("sel_min_max_julia", b.s.vec, t.vec, d, alpha, rho, no.nodes.GL)
  return(out)
}

