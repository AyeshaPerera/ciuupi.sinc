#' Evaluates the functions \eqn{b} and \eqn{s} at \eqn{x}
#'
#' Evaluates the functions \eqn{b} and \eqn{s} at \eqn{x} using a given list of
#' optimal knots \eqn{b} and \eqn{s_c}, as produced by the function
#' \code{\link{bsc_ciuupi_sinc}}.
#'
#' @param x a value or a vector of x at which the functions \eqn{b} and \eqn{s}
#' are to be evaluated.
#' @param bsc.list A list produced by the function
#' \code{\link{bsc_ciuupi_sinc}}.
#'
#' @importFrom stats qnorm
#'
#' @author A. Perera and P. Kabaila
#'
#' @return
#' Returns the dataframe containing \eqn{x} and the corresponding values of the
#' functions \eqn{b} and \eqn{s}.
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
#' rho <- 0.6
#' alpha <- 0.05
#' opt.ciuupi <- bsc_ciuupi_sinc(rho, alpha)
#'
#' x.seq <- seq(-10,10, length.out=1000)
#' bsc.x <- bsc_at_x(x.seq, opt.ciuupi)
#'
bsc_at_x <- function(x, bsc.list){

  d <- bsc.list$d
  n.ints <- bsc.list$n.ints


  alpha <- bsc.list$alpha
  t.vec <- bsc.list$t.vec

  b.s.vec <- bsc.list$par
  b.knots.vec <- b.s.vec[1:(n.ints - 1)]
  sc.knots.vec <- b.s.vec[n.ints:length(b.s.vec)]


  x <- sort(x)

  x1 <- x[which(x <= -d)]
  x2 <- x[which(x > -d & x < d)]
  x3 <- x[which(x >= d)]

  bx <-sapply(x2, b_fn, b.knots.vec=b.knots.vec, t.vec=t.vec, d=d)
  sx <- sapply(x2, s_fn, sc.knots.vec=sc.knots.vec, t.vec=t.vec,
               alpha=alpha, d=d)




  c.alpha <- stats::qnorm((1 - alpha/2))

  if(length(x2)==0){
    bx.vals <- c(rep(0, length(x1)), rep(0, length(x3)))
    sx.vals <- c(rep(c.alpha, length(x1)), rep(c.alpha, length(x3)))
  }else{
    bx.vals <- c(rep(0, length(x1)), bx, rep(0, length(x3)))
    sx.vals <- c(rep(c.alpha, length(x1)), sx, rep(c.alpha, length(x3)))
  }

  data.frame(x = x, b = bx.vals, s = sx.vals)
}
