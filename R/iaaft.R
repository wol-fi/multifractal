iaaft <- function(x, xdist=x, N=1, tolerance=0.01, maxit=100, adjust.var=TRUE,
                  zero.mean=TRUE, quiet=TRUE, diff=FALSE, criterion=c("periodogram"),
                    rel.convergence=TRUE, method=c("shell")){
  rescale_ia <- function(X,Y,method=c("shell")){
    X[sort(X,index=T,method=method)$ix] <- sort(Y,method=method)
    return(X)
  }
  if(criterion!="periodogram" && criterion!="acf"){
    cat("Criterion",criterion,"unknown, using periodogram\n")
    criterion <- c("periodogram")
  }
  n <- length(x)
  if(n==length(xdist)){
    if(adjust.var){
      sigx <- sqrt(var(x))
      sigxdist <- sqrt(var(xdist))
      x <- x*sigxdist/sigx
    }

    xdist.mean <- NULL
    if(zero.mean){
      xdist.mean <- mean(xdist)
      xdist <- xdist-xdist.mean
    }

    c <- sort(xdist,method=method)
    S <- fft(x)
    # r <- sample(xdist)

    if(criterion=="acf")
      Xacf <- acf(x,plot=FALSE,lag.max=n-1) ## for acf convergence criterion
    else
      Xspc <- spectrum(x,plot=FALSE)    ## for periodogram convergence criterion

    rr <- list()
    for(j in 1:N){
      r <- sample(xdist)
      convergence <- FALSE
      it <- 0                              ## initialize iteration counter
      if(diff) diff.vect <- rep(NA,maxit)  ## take along a difference vector
      else diff.vect <- NULL
      rel.diff <- NA                       ## initialize relative difference

      while(!convergence && it<=maxit){
        R <- fft(r)
        s <- fft(complex(modulus=Mod(S),argument=Arg(R)),inverse=TRUE)/n
        r.new <- rescale_ia(Re(s),c,method=method)
        if(criterion=="acf"){
          Racf <- acf(r,plot=FALSE,lag.max=n-1)
          diff.new <- sum((Racf$acf-Xacf$acf)^2)/n
        }
        else{
          Rspc <- spectrum(r,plot=FALSE)
          diff.new <- sum((Rspc$spec-Xspc$spec)^2)/n
        }
        if(it>=1){
          if(rel.convergence)
            diff <- abs((diff.new-diff.old)/diff.old)
          else
            diff <- diff.new
          if(diff<tolerance)
            convergence <- TRUE
        }
        if(!quiet) cat("Iteration: ",it,", Difference in ACF =",diff.new,", relative Improvement = ",diff,"\n")
        diff.old <- diff.new
        if(diff) diff.vect[it] <- diff.new
        r <- r.new
        it <- it+1
      }

      if(!is.null(xdist.mean)) r <- r+xdist.mean

      rr[[j]] <- r
      # return(r)
    }
    rr <- do.call("cbind", rr)
    return(rr)
  } else {
    cat("Series need to have same length, exiting!!\n")
  }
}
