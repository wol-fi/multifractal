\name{mfsim}
\alias{mfsim}
\title{Simulation of Multifractal Brownian Motion}
\description{Simulates a multifaractal Brownian motion based on Mandelbrot's "Multifractal Model of Asset Returns" (MMAR) using a lognormal cascade.

Note: the series has a length of \eqn{b^k}.}
\usage{mfsim(b=2, k=10, H=0.5, mu=0, sigma=1)}
\arguments{
  \item{b}{an integer representing the number of subdivision (i.e., 2 for the binomial model).}
  \item{k}{an integer representing the number of iterations. Note: the series has a length of \eqn{b^k}.}
  \item{H}{a numeric value within 0 and 1 denoting the Hurst exponent. This describes the persistence (i.e., level of linear auto-correlation). Above 0.5 is persistent, below 0.5 is anti-persistent.}
  \item{mu}{the mean value of the normal cascade.}
  \item{sigma}{the standard deviation of the normal cascade.}
}

\value{Returns a simulated multifractal series.}
\references{Mandelbrot, B. B., Fisher, A. J., & Calvet, L. E. (1997). A multifractal model of asset returns.}
\author{Wolfgang Schadner}

\note{Translated from Matlab into R. Original Matlab code by Christian Wengert.}

\seealso{\code{\link{mfdfa}}, \code{\link{ffGn}}}
\examples{
  # multifractal B.M.:
  B <- mfsim()
  plot(B)
  
  # multifractal noise:
  r <- diff(B)  # e.g., stock returns
  
  
}
\keyword{fractal}