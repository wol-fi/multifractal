\name{ffGn}
\alias{ffGn}
\title{Fast Fractional Gaussian Noise }
\description{A fast algorithm for simulating fractal Gaussian noise.}
\usage{ffGn(n=1000, H=0.5, mu=0, sigma=1)}
\arguments{
  \item{n}{length of the simulated series.}
  \item{H}{a numeric value within 0 and 1 denoting the Hurst exponent. This describes the persistence (i.e., level of linear auto-correlation). Above 0.5 is persistent, below 0.5 is anti-persistent.}
  \item{mu}{mean value of the series.}
  \item{sigma}{standard deviation of the series.}
}

\value{Returns a series of simulated fractal Gaussian noise.}
\references{Mandelbrot, B. B., Fisher, A. J., & Calvet, L. E. (1997). A multifractal model of asset returns.}
\author{Wolfgang Schadner}

\note{Translated from Matlab into R. Original Matlab code by B. Scott Jackson.}

\seealso{\code{\link{mfsim}}, \code{\link{mfdfa}}}
\examples{
  x <- ffGn(H=0.8)
  
  # fractal Brownian motion:
  B <- cumsum(x)
  plot(B)
}
\keyword{fractal}