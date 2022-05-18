
iaawt <- function(x, xdist=x, N=1, accerror=.001, error_change=100){
  n <- length(x)
  errors <- c()
  sgates <- list()

  Faf <- FSfarras()$af
  Fsf <- FSfarras()$sf
  af <- dualfilt1()$af
  sf <- dualfilt1()$sf

  exactlevels <- log(n)/log(2)
  numlevels <- floor(log(n)/log(2))
  count <- 1
  if (abs(numlevels-exactlevels)>0){
    # We need to zero pad
    temp <- matrix(0, 2^(numlevels+1), 1)
    count <- 2^(numlevels+1)-n+1
    temp[count:length(temp), 1] <- x
    x <- temp
  }
  n <- length(x)

  # wavelet decomp
  Y <- dualtree(x, numlevels, Faf, af)
  Yl <- Y[[numlevels + 1]]
  Yh <- Y[1:numlevels]

  #  real and amplitudes
  ampYh <- phaseYh <- list()
  for(j in 1:numlevels){
    Yhh <- Yh[[j]][[1]] + Yh[[j]][[2]]*1i
    ampYh[[j]] <- abs(Yhh)
    phaseYh[[j]] <- Arg(Yhh)
  }
  sortval <- sort(x[count:n])
  stdval <- sd(sortval)
  ns <- length(sortval)

  sortval2 <- sort(xdist)
  stdval2 <- sd(sortval2)

  for(k in 1:N){
    print(paste0('Making surrogate number_', k))

    # make a random dataset and take its imag and phases
    shuffind <- sample(1:ns)
    shuffind <- shuffind - 1 + count
    z <- rep(NA,ns)
    z[shuffind] <- sortval
    z[1:(count-1)] <- 0
    Z <- dualtree(z, numlevels, Faf, af)
    Zl <- Z[[numlevels + 1]]
    Zh <- Z[1:numlevels]

    newphase <- list()
    for(j in 1:numlevels){
      Zhh <- Zh[[j]][[1]] + Zh[[j]][[2]] * 1i
      newphase[[j]] <- Arg(Zhh)
    }

    amperror <- 100
    waverror <- 100
    counter <- 1

    newZh <- list()
    while((amperror[counter] > accerror) & (waverror[counter] > accerror)){
      # cat(".")
      # wavelet construction
      oldz <- z
      for(j in 1:numlevels){
        zz <- ampYh[[j]]*exp(1i*newphase[[j]])
        newZh[[j]] <- list(Re(zz), Im(zz))
      }

      newZh[[numlevels + 1]] <- Yl
      z <- idualtree(newZh, numlevels, Fsf, sf)

      wavdiff <- mean(mean(abs(Re(z) - Re(oldz))))
      waverror[counter+1]  <-  wavdiff/stdval

      # impose original values
      oldz <- z
      data2sort <- z[count:n]
      shuffind <- sort(Re(data2sort), index.return=T)$ix
      shuffind <- shuffind - 1 + count
      z[shuffind]  <-  sortval2
      z[1:(count-1)] <- 0
      ampdiff <- mean(mean(abs(Re(z)-Re(oldz))))
      amperror[counter+1]  <-  ampdiff/stdval2

      # Wavelet step
      nZ <- dualtree(z, numlevels, Faf, af)
      nZl <- nZ[[numlevels + 1]]
      nZh <- nZ[1:numlevels]
      # get phases and imag
      for (j in 1:numlevels){
        nZhh <- nZh[[j]][[1]] + nZh[[j]][[2]] * 1i
        newphase[[j]] <- Arg(nZhh)
      }

      toterror <- amperror[counter+1] + waverror[counter+1]
      oldtoterr <- amperror[counter] + waverror[counter]
      if(abs((oldtoterr-toterror)/toterror) < (accerror/error_change)){
        amperror[counter+1] <- -1
        waverror[counter+1] <- -1
      }
      counter <- counter + 1
      rm(list=c("nZh", "nZl"))
    }

    sgates[[k]] <- z[(count+1):length(z)]
    errors[k] <- toterror
  }
  sgates <- do.call("cbind", sgates)

  return(sgates)
}
