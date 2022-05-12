\name{mfdfa}
\alias{mfdfa}
\title{Multifractal Detrended Fluctuation Analysis}

\description{
 Performs the multifractal detrended fluctuation analysis upon a time-series \code{x}. Allows the improvement of overlapping windows.
}

\usage{mfdfa(x, scale=NA, q=-5:5, m = 1, overlap=FALSE)}

\arguments{
  \item{x}{a numeric vector containing the values of the time-series.}
  \item{scale}{an integer vector containing the time scales. It is recommended to use a log-equally spaced sequence for \code{scale}, for example via the function \code{logseq()}. When set to \code{NA} then it is calculated as \code{scale = round(logseq(from=32, to=length(x)/10, n=20))}.}
  \item{q}{a numeric vector containing values of moment orders.}
  \item{m}{an integer representing the polynomial order of detrending, \code{m=1} defines linear detrending.}
  \item{overlap}{a boolean indicating if using overlapping windows or not. If set to \code{TRUE} then the estimation is more robust and reliable, if set to \code{FALSE} then the computational time is faster.}
}

\details{The algorithm allows a basic but also improved (overlapping windows) estimation of a time-series' multi-scaling characteristica.
It comes with the methods \code{plot()} and \code{print()} to easily visualize/access the multifractal spectra and statistics. The function \code{significance()} allows to easily test the significance of multifractality.
}

\value{Returns an object of class \code{multifractal} containg multifractal statistics and more.}

\examples{
  n <- 1024

  # random t-distributed variable:
  x <- rt(n, 3)

  mdl <- mfdfa(x, overlap=T)
  plot(mdl)
  significance(mdl)
}

\seealso{\code{\link{significance}}}

\keyword{fractal}
