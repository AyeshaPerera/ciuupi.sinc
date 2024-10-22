#' g_fn
#'
#' @param eta g_fn
#' @param start.vec g_fn
#' @param t.vec g_fn
#' @param d g_fn
#' @param alpha g_fn
#' @param rho g_fn
#' @param gamma.vec g_fn
#' @param no.nodes.GL g_fn
#' @param num.ints g_fn
#' @param nl.info g_fn
#' @param n.ints g_fn
#'
#' @noRd
#'
#' @return
#' g_fn
#'
g_fn <- function(eta, start.vec, t.vec, d, alpha, rho,
                 gamma.vec, no.nodes.GL, num.ints, nl.info, n.ints){
  # This module computes bsvec for given eta.
  # This is then used to evaluate g(eta) for given eta,
  # where g(eta) = gain - loss.
  #
  # Output
  # list with elements bsvec and g(eta)
  #
  # Written by P. Kabaila in January 2023

  lambda <- exp(eta)

  #Optimization_ciuupi(start.vec, lambda, t.vec, d, alpha, rho, n.ints, gamma.vec, no.nodes.GL, num.ints, nl.info=F)
  list.incl.bsvec <- Optimization_ciuupi(start.vec, lambda, t.vec, d, alpha, rho, n.ints,
                                         gamma.vec, no.nodes.GL, num.ints, F)

  b.s.vec <- list.incl.bsvec$par

  # sel_min_max(b.s.vec, t.vec, d, alpha, rho, no.nodes.GL)
  temp <- sel_min_max(b.s.vec, t.vec, d, alpha, rho, no.nodes.GL)
  sel.min <- temp$sel_min
  sel.max <- temp$sel_max
  gain <- 1 - sel.min^2
  loss <- sel.max^2 - 1
  g <- gain - loss

  list(bsvec = b.s.vec, g = g)

}
