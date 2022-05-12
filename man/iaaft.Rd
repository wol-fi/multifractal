\name{iaaft}
\alias{iaaft}
\title{Iterated Amplitude Adjusted Fourier Transform}

\description{
  Performs the iterated amplitude adjusted Fourier transformation (IAAFT) upon a time-series \code{x}. Code is based on  Henning Rust (2006).
}

\usage{iaaft(x, xdist=x, N=1, ...)}

\arguments{
  \item{x}{a numeric vector containing the values of the time-series.}
  \item{xdist}{a numeric vector containing the values of the distribution to match. Default is set to \code{xdist=x}.}
  \item{N}{number of surrogates to create. Default is 1.}
  \item{...}{additional parameters to control for accuracy.}
}

\details{The algorithm can be used to remove a time-series' \code{x} non-linear correlation structure (multi-fractality) while keeping the degree of linear correlation (persistence). It can further transform \item{x} to match any empirical distribution \code{xdist}.}

\value{Returns a numeric vector of the surrogated time-series.}

\examples{
  n <- 1000
  # random normal variable with positive auto-correlation:
  x <- sort(rnorm(n))
  # random variable from t-distribution:
  y <- rt(n, 5)
  z <- iaaft(x, y)
}

\seealso{\code{\link{iaawt}}}

\references{T. Schreiber and A. Schmitz (2000), Surrogate time series, \emph{Physica D}, 142, pp.346-382.}

\keyword{fractal}
