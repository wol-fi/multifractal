\name{localH}
\alias{localH}
\title{Local Hurst Exponent}

\description{Estimates the local Hurst exponent based on Ihlen and Vereijken (2014). This measures the current, temporal degree of persistence. A value larger 0.5 means positive auto-correlation and below 0.5 describes negative auto-correlation.}

\usage{localH(x, mdl, scale=5:21, m=1, align="center")}

\arguments{
  \item{x}{a numeric vector containing the values of the time-series.}
  \item{mdl}{an object of class \code{multifractal} estimated from the function \code{\link{mfdfa}}.}
  \item{scale}{an integer vector containing the time scales. These should be small to capture local correlation behavior, i.e. the current degree of persistence.}
  \item{m}{an integer representing the polynomial order of detrending, \code{m=1} defines linear detrending.}
  \item{align}{specifies the alignment within the estimation windows. Possible values are 'center', 'left' or 'right'.}
}

\details{The intertemporal persistence is estimated from the interpolating routine of Ihlen and Vereijken (2014). The multifractal model should be estimated in a first step using \code{\link{mfdfa}}.}

\value{Returns a two-column matrix of local Hurst exponent and related interquartile range.}

\examples{
  n <- 1024

  # random t-distributed variable:
  x <- rt(n, 3)

  mdl <- mfdfa(x, overlap=T)

  Ht <- localH(x, mdl)

}

\seealso{\code{\link{mfdfa}}}

\references{Ihlen E. A. F. and Vereijken B. (2014), Detection of co-regulation of local structure and magnitude of stride time variability using a new local detrended fluctuation analysis, \emph{Gait Posture}, 39(1), p.466-471.}

\keyword{fractal}
