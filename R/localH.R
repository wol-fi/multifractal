
localH <- function(mdl, scale=5:21, m=1, align="center"){

  if(class(mdl) != "multifractal") stop("The input 'mdl' is not of class 'multifractal'. Pleas use the 'mfdfa' to create 'mdl'.")

  x <- mdl$x
  n <- length(x)
  ls <- length(scale)

  X <-cumsum(x - mean(x))

  RMS <- list()
  for(ns in 1:ls){
    rms <- rep(NA, n)
    sc <- scale[ns]
    cat(sc)
    for(v in 1:(n-sc)){
      Index <- v:(v+sc-1)
      C <- polyfit(Index, X[Index], m)
      fit <- polyval(C, Index)
      rms[v] <- sqrt(mean((X[Index] - fit)^2))
    }
    RMS[[ns]] <- rms
  }

  if(align == "center"){
    for(ns in 1:ls){
      sc <- scale[ns]
      nh <- (sc-1)/2
      hfil <- rep(NA, nh)
      rms <- RMS[[ns]][1:(n-nh)]
      if(round(nh) == nh){
        RMS[[ns]] <- c(hfil, rms)
      } else {
        RMS[[ns]] <- c(hfil, NA, rms)
      }
    }
  } else if(align == "right") {
    for(ns in 1:ls){
      rms <- RMS[[ns]]
      RMS[[ns]] <- c(rep(NA,sum(is.na(rms))), na.omit(rms))
    }
  } else if(align != "left"){
    warning("alignment misspecified")
  }

  q <- mdl$q
  if(2 %in% q){
    Hq2 <- mdl$Hq[which(mdl$q == 2)]
  } else {
    stop("The moment order 'q' does not contain the value 2. Please re-run 'mfdfa' with 'q' covering 2.")
  }


  fit2 <- mdl$fit2
  Regfit <- fit2$coefficients[1] + fit2$coefficients[2] * log(scale)

  maxL <- n
  Ht <- matrix(NA, n, ls)
  for(ns in 1:ls){
    rms <- RMS[[ns]]
    resRMS <- Regfit[ns] - log(rms)
    logscale <- log(maxL)- log(scale[ns])
    Ht[,ns] <- resRMS/logscale + Hq2
  }

  iqr <- data.frame(t(apply(Ht, 1, quantile, na.rm=T)))
  res <- cbind(rowMeans(Ht), iqr$X75. - iqr$X25.)
  res <- data.frame(Ht=rowMeans(Ht), iqr=iqr$X75. - iqr$X25.)
  res$iqr[which(is.na(res$Ht))] <- NA
  res[res == 0] <- NA
  rownames(res) <- names(mdl$x)
  # res <- as.matrix(res)

  class(res)[2] <- "data.frame"
  class(res)[1] <- "localH"

  return(res)
}

plot.localH <- function(Ht, dates=NA,...){
  
  if(is.na(dates[1])) dates <- rownames(Ht)
  dates <- dates[which(!is.na(Ht$Ht))]
  Ht <- Ht[!is.na(Ht$Ht), ]
  
  xx <- c(dates, rev(dates))
  yy <- c(Ht$Ht + Ht$iqr/2, rev(Ht$Ht - Ht$iqr/2))
  
  plot(dates, Ht$Ht, type="l", xlab="time", ylab=expression(H[t]), main="Local Persistence")
  polygon(xx, yy, col = "lightgray", border=NA)
  lines(dates, Ht$Ht)
  abline(h=0.5, lty="dashed")
}


