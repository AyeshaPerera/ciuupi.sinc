#' Plot the graph of \eqn{\text{SEL}(\gamma; b, s)^2} of the confidence interval
#' that utilizes the uncertain prior information.
#'
#' @description
#' This module plots the graph of \eqn{\text{SEL}(\gamma; b, s)^2},
#' where \eqn{\text{SEL}(\gamma; b, s)} is the scaled expected length of the
#' confidence interval for \eqn{\theta} that utilizes the uncertain prior
#' information at \eqn{\gamma}. Here \eqn{\gamma} is \eqn{\tau/(\sigma v_\tau^{1/2})}
#' and the vector of \eqn{\gamma} considered is \code{seq(0, (d+4), by = 0.01)}
#'
#'
#' @param bsc.list A list produced by the function
#' \code{\link{bsc_ciuupi_sinc}}.
#'
#' @return
#' The graph of the \eqn{\text{SEL}(\gamma; b, s)^2}
#'
#' @export
#'
#' @author A. Perera and P.Kabaila
#'
#' @references
#' \itemize{
#'   \item \href{https://doi.org/10.1016/j.jspi.2009.03.018}{Kabaila, P.
#'   & Giri, K. (2009). Confidence intervals in regression utilizing prior
#'   information. Journal of Statistical Planning and Inference 139, 3419-3429.}
#'   \item \href{https://cran.r-project.org/package=ciuupi}{ciuupi 1.2.3}.
#' }
#'
#' @importFrom graphics par plot mtext abline
#' @importFrom stats qnorm
#'
#' @examples
#' rho <- 0.6
#' alpha <- 0.05
#' bsc.list <- bsc_ciuupi_sinc(rho, alpha)
#' plot_squared_sel(bsc.list)
#'
plot_squared_sel <- function(bsc.list){

  bsvec <- bsc.list$par
  d <- bsc.list$d
  n.ints <- bsc.list$n.ints
  alpha <- bsc.list$alpha
  rho <- bsc.list$rho

  # Compute the scaled expected length for
  # a grid of values of gamma
  gams <- seq(0, (d+4), by = 0.01)

  sel <- sel_at_gamma(gams, bsc.list)

  # Plot the coverage probability
  graphics::par(col.main="blue", cex.main=0.9)
  graphics::plot(gams, sel^2, type = "l", lwd = 1, ylab = "", las = 1, xaxs = "i",
                 main = "Squared SEL", col = "blue",
                 xlab = expression(paste("|", gamma, "|")))

  # c.alpha is the 1-alpha/2 quantile of the N(0,1) distribution
  c.alpha <- stats::qnorm(1 - alpha/2)

  temp <- sel_min_max(bsc.list$par, bsc.list$t.vec, bsc.list$d, alpha, bsc.list$rho, bsc.list$no.nodes.GL)
  sel.min.squared <- temp$sel_min^2
  sel.max.squared <- temp$sel_max^2

  graphics::mtext(paste("If prior info true, gain=",
                        signif(1 - sel.min.squared, digits=6),
                        ". Max possible loss=",
                        signif(sel.max.squared - 1, digits=6)), cex=0.9)
  graphics::abline(h = 1, lty = 2)

}

