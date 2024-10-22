#' Compute the scaled expected length of the CIUUPI for a given vector of
#' \eqn{\gamma}.
#'
#' Evaluate the scaled expected length of the confidence interval that utilizes
#' uncertain prior information (CIUUPI) at a given \eqn{\gamma}.
#'
#' @param gamma.vec The value of \eqn{\gamma} or a vector of \eqn{\gamma} that
#' at which the coverage probability is needed to be evaluated.
#' @param bsc.list A list produced by the function
#' \code{\link{bsc_ciuupi_sinc}}.
#'
#' @return Computes the scaled expected length of the CIUUPI for a given vector
#' of  \eqn{\gamma}
#'
#' @export
#'
#' @author A.Perera
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
#'
#' gamma.vec <- seq(0,10, length.out=10)
#' sel.gamma <- sel_at_gamma(gamma.vec, bsc.list)
#'
sel_at_gamma <- function(gamma.vec, bsc.list){

  sel_fn <- function(x){
    return(SEL_ciuupi(bsc.list=bsc.list$par,
                      t.vec=bsc.list$t.vec, d=bsc.list$d,
                      alpha=bsc.list$alpha,
                      rho=bsc.list$rho, gamma.param=x,
                      no.nodes.GL=bsc.list$no.nodes.GL))}

  sel <- sapply(gamma.vec, sel_fn)

  return(sel)
}
