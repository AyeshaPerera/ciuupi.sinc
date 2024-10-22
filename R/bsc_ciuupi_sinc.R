#' Computes the nodes of the functions \eqn{b} and \eqn{s_c} that
#' specify the confidence interval that utilizes uncertain prior information
#'
#' The confidence interval with uncertain prior information for the case of
#' two nested linear regression models takes the following form:
#' \deqn{\text{CI}(b,s) = \Big [ \widehat{\theta} - v_{\theta}^{1/2} \,
#' \sigma \, b(\widehat{\gamma}) \pm v_{\theta}^{1/2} \, \sigma \,
#' s(\widehat{\gamma}) \Big].}
#' This module computes the functions \eqn{b} and \eqn{s} using sinc function
#' interpolation.
#'
#' @details
#' Consider the linear regression model:
#' \deqn{Y=X\beta + \epsilon}
#' where \eqn{Y} is a random \eqn{n}-vector, \eqn{X} is the \eqn{n \times p}
#' design matrix, \eqn{\beta} is the unknown parameter \eqn{p}-vector and
#' \eqn{\epsilon} is the random error with a \eqn{N(0, \sigma^2 I)} distribution.
#' Suppose that the parameter of interest is:
#' \deqn{\theta = \bm{a}^{\top} \bm{\beta},}
#' where \eqn{\bm{a}} is a specified
#' nonzero \eqn{p}-vector.
#' Let
#' \deqn{\tau = \bm{c}^{\top} \bm{\beta} - t,}
#' where \eqn{\bm{c}} is a
#' specified nonzero \eqn{p}-vector that is linearly independent of \eqn{\bm{a}}
#' and \eqn{t} is a specified number.
#' Suppose that previous experience with similar data sets and/or expert
#' opinion and subject-matter background suggests that \eqn{\tau = 0}.
#' \href{https://doi.org/10.1016/j.jspi.2009.03.018}{Kabaila and Giri (2009)}
#' introduced a confidence interval for \eqn{\theta},
#' with a minimum coverage probability \eqn{1 - \alpha}, that utilizes this
#' uncertain prior information. This confidence interval takes the following
#' form:
#' \deqn{\text{CI}(b,s) = \Big [ \widehat{\theta} - v_{\theta}^{1/2} \,
#' \sigma \, b(\widehat{\gamma}) \pm v_{\theta}^{1/2} \, \sigma \,
#' s(\widehat{\gamma}) \Big],}
#' where \eqn{\widehat{\gamma} = \widehat{\tau} \big/ \big(\sigma \,
#' v_{\tau}^{1/2} \big)}, \eqn{v_{\tau} = \text{var}(\widehat{\tau}) /
#' \sigma^2 = \bm{c}^{\top}(\bm{X}^{\top} \bm{X})^{-1} \bm{c}} and
#' \eqn{v_{\theta} = \text{var}(\widehat{\theta}) / \sigma^2
#' = \bm{a}^{\top}(\bm{X}^{\top}\bm{X})^{-1}\bm{a}}.
#'
#' \href{https://doi.org/10.1016/j.jspi.2009.03.018}{Kabaila and Giri (2009)}
#' specified that the functions \eqn{b} and \eqn{s} should have the following
#' properties. For a sufficiently large number \eqn{d},
#' \itemize{
#'   \item \eqn{b: \mathbb{R} \rightarrow \mathbb{R}} is an odd continuous
#'   function, and \eqn{b(x) = 0} for all \eqn{|x| \ge d}
#'   \item \eqn{s: \mathbb{R} \rightarrow [0, \infty)} is an even continuous
#'   function, and \eqn{s(x) = z_{1 - \alpha/2}} for all \eqn{|x| \ge d}, where
#'   the quantile \eqn{z_a} is defined by \eqn{\text{Pr}(Z \le z_a) = a} for
#'   \eqn{Z \sim N(0,1)}.
#' }
#'
#' Let \eqn{\rho} denote the knwon correlation between \eqn{\widehat{\tau}}
#' and \eqn{\widehat{\theta}}. This value of \eqn{\rho} can be computed using
#' the function \code{\link{acX_to_rho}}.
#'
#' The functions \eqn{b} and \eqn{s} are specified using sinc function
#' interpolation as follows:
#' \deqn{b(t) = \sum_{k=-d}^d b(k) \, \text{sinc}(t - k)}
#' \deqn{s(t) = z_{1 - \alpha/2} + s_c(t)}
#' where
#' \deqn{s_c(t) = \sum_{k=-d}^d s_c(k) \, \text{sinc}(t - k)}
#' We place \eqn{q} number of nodes at equal distance \eqn{h} between \eqn{-d} and
#' \eqn{d} and use numerical non-linear constrained optimization to compute the
#' values of the functions \eqn{b} and \eqn{s_c} at these nodes. These values
#' are then used to specify the functions \eqn{b} and \eqn{s} using sinc
#' function interpolation.
#'
#'
#' @references
#' \itemize{
#'   \item \href{https://doi.org/10.1016/j.jspi.2009.03.018}{Kabaila, P.
#'   & Giri, K. (2009). Confidence intervals in regression utilizing prior
#'   information. Journal of Statistical Planning and Inference 139, 3419-3429.}
#'   \item \href{https://cran.r-project.org/package=ciuupi}{ciuupi 1.2.3}.
#' }
#'
#'
#'
#' @param rho The known correlation between  \eqn{\widehat\theta} and
#' \eqn{\widehat\tau}
#' @param alpha The desired minimum coverage probability
#' is 1\eqn{-}\eqn{\alpha}
#' @param nl.info logical; shall the original NLopt info been shown.
#'
#' @return
#' A list with the following components.
#' \itemize{
#'   \item \code{par} - The optimized \eqn{b} and \eqn{s_c} values at the nodes.
#'
#'   \item \code{value} - Value of the objective function corresponding to \code{par}.
#'
#'   \item \code{iter} - Number of iterations needed to obtain \code{par}.
#'
#'   \item \code{convergence} - The integer code produced by \code{NLopt}
#'   indicating successful completion (>1) or a possible error (<0).
#'
#'   \item \code{message} - String produced by \code{NLopt} and giving additional
#'   information.
#'
#'   \item \code{rho} - The known correlation between  \eqn{\widehat\theta} and
#'   \eqn{\widehat\tau}.
#'
#'   \item \code{n.ints} - Number of equally spaced nodes between \eqn{[0,d]}.
#'
#'   \item \code{t.vec} - The vector containing the equally spaced nodes.
#'
#'   \item \code{lambda} - The computed value of \eqn{\lambda} used in the
#'   objective function.
#'
#'   \item \code{d} - The number of equally spaced intervals between \eqn{[0,d]}.
#'
#'   \item \code{no.nodes.GL} - Number of nodes used in Gauss Legendre quadrature.
#'
#'   \item \code{alpha} - The desired minimum coverage probability
#'   is 1\eqn{-}\eqn{\alpha}.
#'
#'   \item \code{time.optimization} - Time taken to complete the optimization.
#' }
#'
#' @author A.Perera and P.Kabaila
#'
#' @export
#'
#' @examples
#' alpha <- 0.05
#' rho <- 0.6
#' bsc_ciuupi_sinc(rho, alpha)
#'
bsc_ciuupi_sinc <- function(rho, alpha, nl.info=F){

  d <- d_goldilocks(alpha, rho)

  n.ints <- ceiling(d / 0.75)

  start.vec <- rep(0, 2*n.ints-1)

  t.vec.1 <- seq(0, d, length.out=n.ints+1)
  t.vec <- t.vec.1[-length(t.vec.1)]

  gamma.vec <- seq(0, 10, length.out=100)
  no.nodes.GL <- 20
  num.ints <- 60

  start.time <- Sys.time()

  eta.star.null <- eta_star(t.vec, d, alpha, rho, no.nodes.GL, num.ints, nl.info, n.ints)

  lambda <- exp(eta.star.null$eta.star)

  out <- Optimization_ciuupi(start.vec, lambda, t.vec, d, alpha, rho, n.ints,
                             gamma.vec, no.nodes.GL, num.ints, nl.info)



  out$rho <- rho
  out$n.ints <- n.ints
  out$t.vec <- t.vec
  out$lambda <- lambda
  out$d <- d
  out$no.nodes.GL <- no.nodes.GL
  out$alpha <- alpha

  end.time <- Sys.time()
  out$time.optimization <- end.time - start.time

  return(out)
}


