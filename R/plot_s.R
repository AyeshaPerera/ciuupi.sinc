#' Plot the graph of \eqn{s} function
#'
#' @description
#' This module plots the even function \eqn{s} that is used to specify the
#' confidence interval for \eqn{\theta} that utilizes the uncertain prior
#' information.
#'
#'
#' @param bsc.list A list produced by the function
#' \code{\link{bsc_ciuupi_sinc}}.
#'
#' @return
#' The plot of the even function \eqn{s} used in the specification of the
#' confidence interval.
#'
#' @export
#'
#' @author A. Perera and P. Kabaila
#'
#' @importFrom graphics mtext par points abline plot
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
#' plot_s(bsc.list)
#'
plot_s <- function(bsc.list){

  bsvec <- bsc.list$par
  d <- bsc.list$d
  n.ints <- bsc.list$n.ints
  alpha <- bsc.list$alpha
  rho <- bsc.list$rho

  # Compute the values of the functions b and s
  # on x.grid the grid of x-values
  x.grid <- seq(0, (d+2), by = 0.02)
  bsc.x <- bsc_at_x(x.grid, bsc.list)

  # Compute the values of the function s at the
  # knots
  xseq <- seq(0, d, by = d/n.ints)
  svec <- c(bsvec[n.ints:(2*n.ints-1)]+qnorm(1 - alpha/2), qnorm(1 - alpha/2))

  graphics::par(col.main="blue", cex.main=0.9)
  # Plot the graph of the function s
  graphics::plot(x.grid, bsc.x$s, type = "l", xlab = "x",
                 ylab = "", las = 1, lwd = 1, xaxs = "i",
                 main = paste("s function for alpha=",alpha,", rho=",
                              signif(rho, digits=4)),
                 col = "blue")
  graphics::points(xseq, svec, pch = 19, col = "blue", cex=0.55)
  graphics::abline(h=qnorm(1-alpha/2))
  graphics::mtext(paste("d=", signif(d, digits=6), ", q=n.ints=",
                        n.ints), cex = 0.9)

}
