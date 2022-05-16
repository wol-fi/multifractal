\name{iaawt}
\alias{iaawt}
\title{Iterated Amplitude Adjusted Wavelet Transform}

\description{
 Performs the iterated amplitude adjusted Wavelet transformation (IAAWT) upon a time-series \code{x}. The algorithm was translated from Chris Keylock's Matlab code into \R.
}

\usage{iaawt(x, xdist=x, N=1, ...)}

\arguments{
  \item{x}{a numeric vector containing the values of the time-series.}
  \item{xdist}{a numeric vector containing the values of the distribution to match. Default is set to \code{xdist=x}.}
  \item{N}{number of surrogates to create. Default is 1.}
  \item{...}{other parameters to control for the accuracy.}
}

\details{The algorithm can be used to randomize a time-series \code{x} phase while keeping the non-linear correlation structure (point-wise Hölder regularity). It can further transform \code{x} to match any empirical distribution \code{xdist}.}

\value{Returns a numeric vector or matrix of the surrogated time-series.}

\examples{
  n <- 1000
  # random normal variable with positive auto-correlation:
  x <- sort(rnorm(n))
  # random variable from t-distribution:
  y <- rt(n, 5)
  z <- iaawt(x, y)
}

\seealso{\code{\link{iaaft}}}

\note{Translated from Matlab into R. Original Matlab code by Chris Keylock.}

\author{Wolfgang Schadner}

\references{Keylock, C. J. (2017), Multifractal surrogate-data generation algorithm that preserves pointwise Holder regularity structure, with initial applications to turbulence, \emph{Physical Review E}, 95(3), 032123.}
