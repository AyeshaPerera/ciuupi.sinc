#' Computes the standard \eqn{1-\alpha} standard confidence interval
#'
#' @description
#' When \eqn{\sigma} is known this module computes the standard \eqn{1-\alpha}
#' confidence interval for the paramter of interest \eqn{\theta}.
#' If \eqn{\sigma} is not provided then the module will estimate the value of
#' \eqn{\sigma} using the provided data, given that \eqn{n-p \ge 30}.
#'
#'
#' @param a A specified nonzero \eqn{p}-vector which is used to define the parameter
#' of interest as \eqn{\theta=a^\top\beta}
#' @param X The \eqn{n \times p} design matrix
#' @param y The response vector of length \eqn{n}
#' @param alpha The desired minimum coverage probability
#' is 1\eqn{-}\eqn{\alpha}
#' @param sig Standard deviation of the random error. If not provided, then the
#' function will estimate the standard deviation under the condition that
#' \eqn{n-p \ge 30}.
#'
#' @importFrom stats qnorm
#'
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
#'
#' For a given response vector \eqn{Y} and desing matrix \eqn{X} this function
#' computes the standard confidence interval for the parameter of interest \eqn{\theta}
#' that has a minimum coverage probability \eqn{1-\alpha}.
#'
#'
#'
#' @return
#' The lower and upper limit of the standard confidence interval for \eqn{\theta}
#'
#' @author P.Kabaila
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
#' @examples
#' y <- c(87.2, 88.4, 86.7, 89.2)
#' x1 <- c(-1, 1, -1, 1)
#' x2 <- c(-1, -1, 1, 1)
#' X <- cbind(rep(1, 4), x1, x2, x1*x2)
#' a <- c(0, 2, 0, -2)
#' ci_standard(a, X, y, 0.05, sig = 0.8)
#'
ci_standard <- function(a, X, y, alpha, sig = NULL){

  # Use the QR decomposition of the design matrix X
  # to find the inverse of X'X
  qrstr <- qr(X)
  R <- qr.R(qrstr)
  XTXinv <- chol2inv(R)

  # Find beta hat, theta hat and tau hat
  beta.hat <- XTXinv %*% t(X) %*% y
  theta.hat <- as.numeric(t(a) %*% beta.hat)

  # If sigma is not specified, find an estimate of sigma
  if(is.null(sig)){
    cat("NOTE: Error variance not supplied by user.
        Error variance will be estimated from data", "\n")

    # If sig is missing, estimate it from the data
    n <- dim(X)[1]
    p <- dim(X)[2]
    sigsq <- (t(y - X %*% beta.hat) %*% (y - X %*% beta.hat)) / (n - p)
    sig <- as.numeric(sqrt(sigsq))

  }

  # Find variance of theta hat on sigma squared
  v.theta <- as.numeric(t(a) %*% XTXinv %*% a)

  # Find the standard confidence interval
  standard.ci <-
    theta.hat + c(-1, 1) * sig * sqrt(v.theta) * stats::qnorm(1 - alpha/2)

  data.frame(lower = standard.ci[1], upper = standard.ci[2],
             row.names = c("standard"))

}
