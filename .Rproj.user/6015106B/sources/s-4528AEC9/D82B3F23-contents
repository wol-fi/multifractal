
mfdfa <- function (x, scale=NA, q=-5:5, m = 1, overlap=FALSE){

  ret <- list()
  ret$x <- x

  X <- cumsum(x - mean(x))
  l <- length(X)

  if(is.na(scale[1])) scale <- round(logseq(32, l/10, n=20))

  ls <- length(scale)
  lq <- length(q)
  qRMS <- Fq <- matrix(NA, lq, ls)
  seg <- list()
  segments <- matrix(NA, ls, 1)
  Hq <- matrix(NA, lq, ls)
  seg <- list()

  # plot Fluctuation functions
  if(!overlap){
    # without overlap
    for (i in 1:ls) {
      seg[[i]] <- floor(length(X)/scale[i])
      rmvi <- c()
      for (vi in 1:seg[[i]]) {
        Index = ((((vi - 1) * scale[i]) + 1):(vi * scale[i]))
        C <- polyfit(Index, X[Index], m)
        fit <- polyval(C,Index)
        rmvi[vi] <- sqrt(mean((X[Index]-fit)^2))
      }
      for(nq in 1:lq){
        qRMS <- rmvi^q[nq]
        Fq[nq, i] <- mean(qRMS)^(1/q[nq])
      }
      Fq[which(q==0), i] <- exp(0.5*mean(log(rmvi^2)))
    }
  } else {
    # with overlap
    for(ns in 1:ls){
      cat(".")
      segs <- scale[ns]

      if(segs == l){
        Index <- 1:l
        C <- polyfit(Index, X[Index], m)
        fit <- polyval(C,Index)
        rms <- sqrt(mean((X[Index]-fit)^2))
      } else {
        rms <- rep(NA, l-segs)
        for(v in 1:(l-segs)){
          Index <- v:(v+segs)
          C <- polyfit(Index, X[Index], m)
          fit <- polyval(C,Index)
          rms[v] <- sqrt(mean((X[Index]-fit)^2))
        }
      }

      for(nq in 1:lq){
        qRMS <- rms^q[nq]
        Fq[nq, ns] <- mean(qRMS)^(1/q[nq])
      }
      Fq[which(q==0), ns] <- exp(0.5*mean(log(rms^2)))
    }
  }

  Hq <- R2 <- rep(NA, lq)
  x <- log(scale)
  for(j in 1:lq){
    y <- log(Fq[j,])
    mdl <- lm(y ~ x)
    if(q[j] == 2) ret$fit2 <- mdl
    Hq[j] <- mdl$coefficients[2]
    R2[j] <- cor(y, mdl$fitted.values)^2
  }

  ret$Fq <- Fq
  ret$Hq <- Hq
  ret$n <- l
  ret$scale <- scale
  ret$q <- q

  tq <- Hq * q - 1
  alpha <- diff(tq) / diff(q)
  f_alpha <- (q[1:(lq-1)] * alpha) - tq[1:(lq-1)]

  ret$alpha <- alpha
  ret$tq <- tq
  ret$f_alpha <- f_alpha
  ret$R2 <- R2
  ret$m <- m

  class(ret) <- "multifractal"
  return(ret)
}

plot.multifractal <- function(mdl, newindow=TRUE, ...){
  y <- log(mdl$Fq)
  x <- log(mdl$scale)
  ylim <- c(min(y), max(y))

  op <- par()
  if(newindow) windows()
  par(mfrow=c(2,2))
  par(mar = c(3,3,1.5,0.5))
  par(mgp=c(1.5,0.5,0))
  plot(x, y[1,], ylim=ylim, type="l", panel.first = grid(), main="log-log Fq", xlab="log scale", ylab="log Fq")
  for(i in 2:nrow(y)) lines(x, y[i,])


  da <- round(max(mdl$alpha)-min(mdl$alpha),3)
  dh <- round(max(mdl$Hq)-min(mdl$Hq),3)

  plot(mdl$alpha, mdl$f_alpha, type="o", pch=4, panel.first = grid(), main="MF spectrum", ylab=expression(f(alpha)), xlab=expression(alpha))
  text(x=min(mdl$alpha), y=min(mdl$f_alpha), adj=c(0,0), label=bquote(alpha[max]-alpha[min]==.(da)))

  plot(mdl$q, mdl$Hq, type="o", panel.first = grid(), main="Hq", pch=4, xlab="q", ylab="H(q)")
  text(x=min(mdl$q), y=min(mdl$Hq), adj=c(0,0), label=bquote(H(q)[max]-H(q)[min]==.(dh)))

  plot(mdl$q, mdl$tq, type="o", panel.first = grid(), main="Scaling Function", pch=4, xlab="q", ylab=expression(tau(q)))

  op <- op[names(op) %in% c("cin","cra","csi","cxy","din","page") == FALSE]
  par(op)
}

print.multifractal <- function(mdl, ...){
  coef <- c(max(mdl$Hq) - min(mdl$Hq), max(mdl$alpha) - min(mdl$alpha))
  names(coef) <- c("dH", "dAlpha")

  H <- mdl$Hq[which(mdl$q==2)]
  pers <- ifelse(H>0.5, "trending, pos. auto-corr", "anti-persistent, neg. auto-corr.")
  if(H==0.5) pers <- "fully random"
  cat("\nPersistence: \n", H, "  ... = ", pers,
      "\n\nMultifractal Strength:\n diff. Hurst = ", coef[1],
      "\n diff. Hölder = ", coef[2])


  ret <- list(coef=coef, H=H)
  return(coef)
}

significance <- function(mdl, size=100, pval=0.05, overlap=FALSE, ...){
  x <- mdl$x
  scale <- mdl$scale
  q <- mdl$q
  m <- mdl$m

  spreads <- c()
  for(i in 1:size){
    cat(".")
    xs <- iaaft(x)
    mdls <- mfdfa(xs, scale, q, m, overlap=overlap)
    spreads[i] <- max(mdls$alpha) - min(mdls$alpha)
  }

  lvl <- quantile(spreads, 1-pval)
  olvl <- max(mdl$alpha) - min(mdl$alpha)

  ret <- matrix(c(olvl, lvl))
  colnames(ret) <- "diff_Holder"
  rownames(ret) <- c("original", paste0((1-pval)*100, "% C.I."))
  msg <- ifelse(olvl > lvl, "multifractality is significant", "multifractality is NOT significant")
  cat("\n")
  print(ret)
  cat("\n", msg, "\n\n")
  return(ret)
}
