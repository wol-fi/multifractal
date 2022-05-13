# Multifractal Model of Asset Return using a multiplicative lognormal cascade.
# Translated from Matlab into R by Wolfgang Schadner
# Matlab code: Christian Wengert

mfsim <- function(b=2, k=10, H=0.5, mu=0, sigma=1){
  
  if(H >=1 | H <= 0) stop("Hurst exponent 'H' must be within 0 and 1.")
  
  ln_mu <- exp(mu + 0.5 * sigma^2)
  ln_sigma <- ln_mu*sqrt(exp(sigma^2)-1)
  #Global parameters 
  TT <- b^k
  #Constants (initial weight)
  M0 <- 1.0
  #Fractal Brownian motion
  B <- cumsum(ffGn(TT, H))
  #Fractal time
  v <- lognormal_cascade(b, k, M0, ln_mu, ln_sigma)
  cdf_V <- cumsum(v)
  #Normalize the cdf
  cdf_V <- cdf_V/tail(cdf_V,1)
  #allocate
  MMAR <- matrix(0, TT, 1)
  #Compound
  for (i in 1:TT){
    #Get fractal time
    index <- cdf_V[i]*TT
    lower <- floor(index)
    if(lower<1) lower <- 1
    upper <- ceiling(index)
    if(upper>TT) upper <- TT
    
    #Interpolate for compounding  
    w2 <- cdf_V[i]
    w1 <- 1.0 - cdf_V[i]
    #Compound
    MMAR[i] <- w1*B[lower] + w2*B[upper]
  }
  
  return(MMAR)
}

lognormal_cascade <- function(b=2, k=10, v=1, ln_lambda=1.649, ln_theta=2.161){
  
  M <- rlnorm(b, ln_lambda, ln_theta)
  
  for(i in 1:k){
    M <- c(0.3,0.2)
    v <- c(v * M[1], v*M[2])
  }
  
  return(v) 
}




