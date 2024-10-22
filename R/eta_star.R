#' eta_star
#'
#' @param t.vec eta_star
#' @param d eta_star
#' @param alpha eta_star
#' @param rho eta_star
#' @param no.nodes.GL eta_star
#' @param num.ints eta_star
#' @param nl.info eta_star
#' @param n.ints eta_star
#'
#' @noRd
#'
#' @return
#' eta_star
#'
eta_star <- function(t.vec, d, alpha, rho, no.nodes.GL, num.ints, nl.info, n.ints){

  # Written by P. Kabaila in January 2023

  eta.ub <- -2.13

  gams <- seq(0, (d+2), by = 0.05)

  eta.vec <- rep(0, 3)
  g.vec <- rep(0, 3)

  # 1st evaluation of g
  eta.vec[1] <- eta.ub

  #start_standard_ci(n.ints)
  start.vec <- start_standard_ci(n.ints)

  len.bsvec <- length(start.vec)
  bsvec.matrix <- matrix(0, nrow = len.bsvec, ncol = 3)


  # g_fn(eta, start.vec, t.vec, d, alpha, rho, m, gamma.vec, no.nodes.GL,
  # num.ints, nl.info, gauss.nodes.cp,gauss.weights.cp, gauss.nodes.sel, gauss.weights.sel, n.ints)
  g.info <- g_fn(eta=eta.vec[1], start.vec=start.vec, t.vec=t.vec, d=d,
                 alpha=alpha, rho=rho, gamma.vec=gams, no.nodes.GL=no.nodes.GL,
                 num.ints=num.ints, nl.info=nl.info, n.ints=n.ints)


  g.vec[1] <- g.info$g
  bsvec.matrix[,1] <- g.info$bsvec


  if (g.vec[1] > 0){
    eta.ub.holds <- 1
    eta.vec[2] <- eta.vec[1] - 0.15
  }else{
    eta.ub.holds <- 0
    eta.vec[2] <- eta.vec[1] + 0.05
  }

  # 2nd evaluation of g
  start.vec <- bsvec.matrix[,1]

  # g_fn(eta, start.vec, t.vec, d, alpha, rho, m, gamma.vec, no.nodes.GL,
  #     num.ints, nl.info, gauss.nodes.cp,gauss.weights.cp, gauss.nodes.sel, gauss.weights.sel, n.ints)
  g.info <- g_fn(eta=eta.vec[2], start.vec=start.vec, t.vec=t.vec, d=d, alpha=alpha,
                 rho=rho, gamma.vec=gams, no.nodes.GL=no.nodes.GL,
                 num.ints=num.ints, nl.info=nl.info, n.ints=n.ints)

  g.vec[2] <- g.info$g
  bsvec.matrix[,2] <- g.info$bsvec

  # Secant method
  # The linear interpolation step is a weighted
  # average when g.vec[1] and g.vec[2] have
  # opposite signs.
  wt1 <- g.vec[2] / (g.vec[2] - g.vec[1])
  wt2 <- - g.vec[1] / (g.vec[2] - g.vec[1])
  # cat("eta.vec[1]=", eta.vec[1], ",  eta.vec[2]=", eta.vec[2], "\n")
  # cat("g.vec[1]=", g.vec[1], ",  g.vec[2]=", g.vec[2], "\n")
  # cat("wt1=", wt1, ", wt2=", wt2, "\n")
  eta.lin.interp <- wt1 * eta.vec[1] + wt2 * eta.vec[2]
  # cat("eta.lin.interp=", eta.lin.interp, "\n")
  eta.vec[3] <- eta.lin.interp

  # 3rd evaluation of g
  start.vec <- wt1 * bsvec.matrix[,1] + wt2 * bsvec.matrix[,2]
  # cat("For 3rd evaluation of g, start=", start, "\n")

  # g_fn(eta, start.vec, t.vec, d, alpha, rho, m, gamma.vec, no.nodes.GL,
  # num.ints, nl.info, gauss.nodes.cp,gauss.weights.cp, gauss.nodes.sel, gauss.weights.sel, n.ints)
  g.info <- g_fn(eta=eta.vec[3], start.vec=start.vec, t.vec=t.vec, d=d, alpha=alpha,
                 rho=rho, gamma.vec=gams, no.nodes.GL=no.nodes.GL,
                 num.ints=num.ints, nl.info=nl.info, n.ints=n.ints)

  g.vec[3] <- g.info$g
  bsvec.matrix[,3] <- g.info$bsvec

  # Apply Muller's method
  eta.star <- mullers_method(eta.vec, g.vec)

  list(eta.ub=eta.ub, rho=rho, d=d, alpha=alpha, eta.vec=eta.vec, g.vec=g.vec,
       bsvec.matrix=bsvec.matrix, eta.star=eta.star, eta.ub.holds=eta.ub.holds)

}



