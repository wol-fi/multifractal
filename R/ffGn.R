ffGn <- function(n=1000, H=0.5, mu=0, sigma=1){
  
  if(H >=1 | H <= 0) stop("Hurst exponent 'H' must be within 0 and 1.")
  
  # Calculate the fGn.
  if (H == 0.5){
    y <- rnorm(n)  # If H=0.5, then fGn is equivalent to white Gaussian noise.
  } else {
    
    Nfft <- 2^ceiling(log2(2*(n-1)))
    NfftHalf <- round(Nfft/2)
    # k <- [0:NfftHalf, seq(NfftHalf-1, 1, by=-1)]
    k <- c(0:NfftHalf, seq(NfftHalf-1, 1, by=-1))
    Zmag <- 0.5 * ( (k+1)^(2.*H) - 2.*k^(2.*H) + (abs(k-1))^(2.*H) )
    rm(k)
    Zmag <- Re(fft(Zmag))
    if ( sum(Zmag < 0) > 0 ){
      stop('The fast Fourier transform of the circulant covariance had negative values.')
    }
    Zmag <- sqrt(Zmag)
    # Store N and H values in persistent variables for use during subsequent calls to this function.
    Nlast <- n
    Hlast <- H
    Z <- complex(real=Zmag*rnorm(Nfft), imaginary=rnorm(Nfft))
    y <- Re(fft(Z, inverse = T)) * sqrt(Nfft)
    rm(Z)
    y <- y[1:n]
  }
  y <- y * sigma + mu
  
  return(y)
}
