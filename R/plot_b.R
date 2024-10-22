#' Plot the graph of \eqn{b} function
#'
#' @description
#' This module plots the odd function \eqn{b} that is used to specify the
#' confidence interval for \eqn{\theta} that utilizes the uncertain prior
#' information.
#'
#'
#' @param bsc.list A list produced by the function
#' \code{\link{bsc_ciuupi_sinc}}.
#'
#' @return
#' The plot of the odd function \eqn{b} used in the specification of the
#' confidence interval.
#'
#' @export
#'
#' @importFrom graphics par plot points mtext
#'
#' @author A. Perera and P. Kabaila
#'
#' @references
#' \itemize{
#'   \item \href{https://doi.org/10.1016/j.jspi.2009.03.018}{Kabaila, P.
#'   & Giri, K. (2009). Confidence intervals in regression utilizing prior
#'   information. Journal of Statistical Planning and Inference 139, 3419-3429.}
#'   \item \href{https://cran.r-project.org/package=ciuupi}{ciuupi 1.2.3}.
#' }
#'
#' @examples
#' rho <- 0.6
#' alpha <- 0.05
#' bsc.list <- bsc_ciuupi_sinc(rho, alpha)
#' plot_b(bsc.list)
#'
#'
plot_b <- function(bsc.list){

  bsvec <- bsc.list$par
  d <- bsc.list$d
  n.ints <- bsc.list$n.ints
  alpha <- bsc.list$alpha
  rho <- bsc.list$rho

  x.grid <- seq(0, (d+2), by = 0.02)

  bsc.x <- bsc_at_x(x.grid, bsc.list)

  bsc.list$t.vec

  xseq <- seq(0, d, by = d/n.ints)
  bvec <- c(0, bsvec[1:(n.ints-1)], 0)

  graphics::par(col.main="blue", cex.main=0.9)
  # Plot the graph of the function b
  graphics::plot(x.grid, bsc.x$b, type = "l", xlab = "x",
                 ylab = "", las = 1, lwd = 1, xaxs = "i",
                 main = paste("b function for alpha=",alpha,", rho=",
                              signif(rho, digits=4)),
                 col = "blue")
  graphics::points(xseq, bvec, pch = 19, col = "blue", cex=0.55)
  abline(h=0)
  graphics::mtext(paste("d=", signif(d, digits=6), ", n.ints=",
                        n.ints), cex = 0.9)

}
