\name{significance}
\alias{significance}
\title{Significance of MF-DFA}

\description{
  Tests the significance of multifractality for an object of class \code{multifractal} based on \code{iaaft} surrogates.
}

\usage{
significance(model, size, pval, ...)
}

\arguments{
  \item{mdl}{an object of class \code{multifractal}. See \code{\link{mfdfa}} for further details.}
  \item{size}{a numeric value indicating the number of surrogates.}
  \item{pval}{a numeric value indicating the confidence level (p-value). Default is 0.05, i.e. 95\% confidence.}
}

\details{The significance of multifractality is computed by creating IAAFT surrogates and computing the corresponding multifractal spreads. The surrogates have same distribution, length and linear-correlation as the original series but are not exposed to multifractality. Therfore, the spread as computed on the surrogates represent the spourious degree of multifractality.}

\value{Returns a matrix of the original and spourious spreads of Hurst and Holder exponents.}

\examples{
  n <- 1024

  # random t-distributed variable:
  x <- rt(n, 3)

  mdl <- mfdfa(x, overlap=T)
  plot(mdl)
  significance(mdl)
}

\seealso{\code{\link{mfdfa}}}

\keyword{fractal}
