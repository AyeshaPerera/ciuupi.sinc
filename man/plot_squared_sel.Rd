% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_squared_sel.R
\name{plot_squared_sel}
\alias{plot_squared_sel}
\title{Plot the graph of \eqn{\text{SEL}(\gamma; b, s)^2} of the confidence interval
that utilizes the uncertain prior information.}
\usage{
plot_squared_sel(bsc.list)
}
\arguments{
\item{bsc.list}{A list produced by the function
\code{\link{bsc_ciuupi_sinc}}.}
}
\value{
The graph of the \eqn{\text{SEL}(\gamma; b, s)^2}
}
\description{
This module plots the graph of \eqn{\text{SEL}(\gamma; b, s)^2},
where \eqn{\text{SEL}(\gamma; b, s)} is the scaled expected length of the
confidence interval for \eqn{\theta} that utilizes the uncertain prior
information at \eqn{\gamma}. Here \eqn{\gamma} is \eqn{\tau/(\sigma v_\tau^{1/2})}
and the vector of \eqn{\gamma} considered is \code{seq(0, (d+4), by = 0.01)}
}
\examples{
rho <- 0.6
alpha <- 0.05
bsc.list <- bsc_ciuupi_sinc(rho, alpha)
plot_squared_sel(bsc.list)

}
\references{
\itemize{
  \item \href{https://doi.org/10.1016/j.jspi.2009.03.018}{Kabaila, P.
  & Giri, K. (2009). Confidence intervals in regression utilizing prior
  information. Journal of Statistical Planning and Inference 139, 3419-3429.}
  \item \href{https://cran.r-project.org/package=ciuupi}{ciuupi 1.2.3}.
}
}
\author{
A. Perera and P.Kabaila
}
