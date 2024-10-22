#' Computes the confidence interval that utilizes uncertain prior information
#' for a given observed vector \eqn{Y}
#'
#' @description
#' For known \eqn{\sigma} this function computes the confidence interval that
#' utilizes uncertain prior information for the
#' parameter of interest for a given observed vector \eqn{Y}.
#' If \eqn{\sigma} is not provided this function estimates the value of
#' \eqn{\sigma} provided that \eqn{(n-p)>30}.
#'
#'
#' @param a The \eqn{p} vector \eqn{\bm{a}} used to specifies the parameter of
#' interest (\eqn{\theta=\bm{a}^\top \beta})
#' @param c The \eqn{p} vector \eqn{\bm{a}} used to specifies the uncertain prior
#' information (\eqn{\tau=\bm{c}^\top \beta}). The uncertain prior information is
#' that \eqn{\tau=0}.
#' @param X The \eqn{n \times p} design matrix.
#' @param alpha The desired minimum coverage probability
#' is 1\eqn{-}\eqn{\alpha}
#' @param bsc.list A list produced by the function
#' \code{\link{bsc_ciuupi_sinc}}.
#' @param t The numerical value used to specify the uncertain prior information
#' \eqn{\tau=\bm{c}^\top \beta}. The uncertain prior information is
#' that \eqn{\tau=0}.
#' @param y The response vector of length \eqn{n}
#' @param sig Standard deviation of the random error. If not provided, then the
#' function will estimate the standard deviation under the condition that
#' \eqn{n-p \ge 30}.
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
#'
#' For a given response vector \eqn{Y} and desing matrix \eqn{X} this function
#' computes the confidence interval for the parameter of interest \eqn{\theta}
#' that has a minimum coverage probability \eqn{1-\alpha},
#' that utilizes the uncertain prior information \eqn{\tau=0}
#'
#' @author P.Kabaila and A.Perera
#'
#' @references
#' \itemize{
#'   \item \href{https://doi.org/10.1016/j.jspi.2009.03.018}{Kabaila, P.
#'   & Giri, K. (2009). Confidence intervals in regression utilizing prior
#'   information. Journal of Statistical Planning and Inference 139, 3419-3429.}
#'   \item \href{https://cran.r-project.org/package=ciuupi}{ciuupi 1.2.3}.
#' }
#'
#' @return
#' The lower and upper limits of the confidence interval for \eqn{\theta} that
#' utilizes the uncertain prior information.
#' @export
#'
#' @examples
#' a <- c(0, 2, 0, -2)
#' c <- c(0, 0, 0, 1)
#' x1 <- c(-1, 1, -1, 1)
#' x2 <- c(-1, -1, 1, 1)
#' X <- cbind(rep(1, 4), x1, x2, x1*x2)
#' alpha <- 0.05
#' t <- 0
#' y <- c(87.2, 88.4, 86.7, 89.2)
#' sig <- 0.8
#' rho <- 0.6
#' alpha <- 0.05
#' opt.ciuupi <- bsc_ciuupi_sinc(rho, alpha)
#' ciuupi_observed_value(a, c, X, alpha, opt.ciuupi, t, y, sig=sig)
#'
ciuupi_observed_value <- function(a, c, X, alpha, bsc.list, t, y, sig = NULL){

  # Use the QR decomposition of the design matrix X
  # to find the inverse of X'X
  qrstr <- qr(X)
  R <- qr.R(qrstr)
  XTXinv <- chol2inv(R)

  # Find beta hat, theta hat and tau hat
  beta.hat <- XTXinv %*% t(X) %*% y
  theta.hat <- as.numeric(t(a) %*% beta.hat)
  tau.hat <- as.numeric(t(c) %*% beta.hat - t)

  # If sigma is not specified, find an estimate of sigma
  if(is.null(sig)){
    cat("NOTE: Error variance not supplied by user.
        Error variance will be estimated from data.", "\n")

    if(dim(X)[1] - dim(X)[2] < 30){
      cat("WARNING: n - p < 30", "\n")
    }

    # If sig is missing, estimate it from the data
    n <- dim(X)[1]
    p <- dim(X)[2]
    num <- t(y - X %*% beta.hat) %*% (y - X %*% beta.hat)
    sigsq <- num / (n - p)
    sig <- sqrt(sigsq)

  }

  # Find gamma hat
  v.tau <- as.numeric(t(c) %*% XTXinv %*% c)
  gam.hat <- tau.hat / (sig * sqrt(v.tau))

  # Find variance of theta hat on sigma squared
  v.theta <- as.numeric(t(a) %*% XTXinv %*% a)

  # Compute the confidence interval
  bsvec <- bsc.list$par
  d <- bsc.list$d
  n.ints <- bsc.list$n.ints

  bsfuns <- bsc_at_x(gam.hat, bsc.list)

  new.ci <- theta.hat - sig * sqrt(v.theta) * bsfuns[, 2] +
    c(-1, 1) * sig * sqrt(v.theta) * bsfuns[, 3]

  data.frame(lower = new.ci[1], upper = new.ci[2],
             row.names = c("ciuupi"))

}
