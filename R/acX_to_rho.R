#' Computes the correlation (\eqn{\rho}) between \eqn{\widehat{\theta}}
#' and \eqn{\widehat{\tau}}
#'
#' @description Computes the correlation between \eqn{\widehat{\theta}}
#' and \eqn{\widehat{\tau}} using the \eqn{p}-vectors \eqn{a} and \eqn{c} and the design
#' matrix \eqn{X}. The value of \eqn{\rho} is computed using the following formula,
#' \deqn{ \rho = \dfrac{a^\top (X^\top X)^{-1} c}{(v_{\theta} v_\tau)^{1/2}} }
#' where
#' \eqn{v_{\theta}}
#' =\eqn{a^\top}(\eqn{X^\top} \eqn{X})\eqn{^{-1}}\eqn{a} and
#' \eqn{v_{\tau}}
#' =\eqn{c^\top}(\eqn{X^\top}\eqn{X})\eqn{^{-1}}\eqn{c}.
#'
#' @references
#' \itemize{
#'   \item Based on \href{https://cran.r-project.org/package=ciuupi}{ciuupi 1.2.3}
#' }
#'
#' @param a A specified nonzero \eqn{p}-vector which is used to define the parameter
#' of interest as \eqn{\theta=a^\top\beta}
#' @param c A specified nonzero $p$-vector which is defined as
#' \eqn{\tau = c^\top-\beta - t} that is used in the definition of the uncertain
#' prior information \eqn{\tau=0}.
#' @param X The \eqn{n \times p} design matrix
#'
#' @author P.Kabaila
#'
#' @return The correlation (\eqn{\rho}) between \eqn{\widehat{\theta}}
#' and \eqn{\widehat{\tau}}
#'
#' @export
#'
#' @examples
#' a <- c(0, 2, 0, -2)
#' c <- c(0, 0, 0, 1)
#' x1 <- c(-1, 1, -1, 1)
#' x2 <- c(-1, -1, 1, 1)
#' X <- cbind(rep(1, 4), x1, x2, x1*x2)
#' rho <- acX_to_rho(a, c, X)
#' print(rho)
#'
acX_to_rho <- function (a, c, X){
  if (ncol(X) > nrow(X)) {
    stop("p > n")
  }
  qrstr <- qr(X)
  R <- qr.R(qrstr)
  XTXinv <- chol2inv(R)
  rho <- (t(a) %*% XTXinv %*% c)/sqrt(t(a) %*% XTXinv %*%
                                        a %*% t(c) %*% XTXinv %*% c)
  as.vector(rho)
}

