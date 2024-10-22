#' Plot the graph of \eqn{\big(\text{CP}(\gamma;b,s)} - \eqn{(1 - \alpha)\big)}
#'
#' @description
#' This module plots the graph of (\eqn{\text{CP}(\gamma;b,s)} - \eqn{(1 - \alpha)}),
#' where \eqn{\text{CP}(\gamma;b,s)} is the coverage probability of the
#' confidence interval for \eqn{\theta} that utilizes the uncertain prior
#' information at \eqn{\gamma} and \eqn{(1-\alpha)} is the desired minimum
#' coverage probability. Here \eqn{\gamma} is \eqn{\tau/(\sigma v_\tau^{1/2})}
#' and the vector of \eqn{\gamma} considered is \code{seq(0, (d+4), by = 0.01)}
#'
#'
#'
#' @param bsc.list A list produced by the function
#' \code{\link{bsc_ciuupi_sinc}}.
#'
#' @return
#' The graph of the coverage probability
#'
#' @author A. Perera and P.Kabaila
#'
#' @export
#'
#' @references
#' \itemize{
#'   \item \href{https://doi.org/10.1016/j.jspi.2009.03.018}{Kabaila, P.
#'   & Giri, K. (2009). Confidence intervals in regression utilizing prior
#'   information. Journal of Statistical Planning and Inference 139, 3419-3429.}
#'   \item \href{https://cran.r-project.org/package=ciuupi}{ciuupi 1.2.3}.
#' }
#'
#' @importFrom graphics par points abline mtext plot
#'
#' @examples
#' rho <- 0.6
#' alpha <- 0.05
#' bsc.list <- bsc_ciuupi_sinc(rho, alpha)
#' plot_cp(bsc.list)
#'
plot_cp <- function(bsc.list){

  bsvec <- bsc.list$par
  rho <- bsc.list$rho
  d <- bsc.list$d
  n.ints <- bsc.list$n.ints
  alpha <- bsc.list$alpha

  # Compute the coverage probability for
  # a grid of values of gamma
  gams <- seq(0, (d+4), by = 0.01)


  cp <- cp_at_gamma(gams, bsc.list)

  # Plot the coverage probability
  graphics::par(col.main="blue", cex.main=0.9)
  graphics::plot(gams, cp - (1 - alpha), type = "l", lwd = 1, ylab = "",
                 las = 1, xaxs = "i", main =
                   paste("cov. prob. - (1 - alpha) for alpha=", alpha,
                         ", rho=", signif(rho, digits=4)),
                 col = "blue", xlab = expression(paste("|", gamma, "|")))
  graphics::abline(h = 0, lty = 2)
  min.cp <- min(cp)
  graphics::mtext(paste("Desired min CP=", 1 - alpha, ". Actual min CP =",
                        signif(min.cp, digits=10)), cex = 0.9)

}
