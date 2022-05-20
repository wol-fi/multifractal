# multifractal

Reference Manual: [multifractal.pdf](multifractal.pdf)

*Keywords:* MFDFA, MMAR, IAAFT, IAAWT, Surrogate Analysis

## Overview

This is an improved package for multifractal detrended fluctuation analysis (MF-DFA), simulation of multifractal series (Multifractal Model of Asset Returns, MMAR), and surroagte analysis using Iterated Amplitude Adjusted Fourier Transform (IAAFT) and Iterated Amplitude Adjusted Wavelet Transform (IAAWT). It allows to enhance the robustness and reliability of classic MF-DFA via overlapping windows. It further enables to test the significance of multifractality via IAAFT surrogates. Simulations are based on Mandelbrot's multifractal model of asset returns (MMAR).

## Installation

``` r
    devtools::install_github("wol-fi/multifractal")
```

## Usage

The below example illustrates a multifractal analysis of the S&P 500 stock market index (daily, 1992-2022). The example dataset is provided by the package.

``` r
    library(multifractal)

    ## preparation:
    # load the example dataset 'sp500' and calculate daily log-returns
    p <- sp500
    r <- diff(log(p$Adj.Close)) 
```

### Multifractal Analysis
``` r
    
    # estimate the statistics
    mdl <- mfdfa(r, overlap=T)

    ## plot the output
    plot(mdl)
```
![](fig1.png)

Interpretation:
* *upper-left:* Fluctuation plot. The slopes of the lines represent the Hurst exponents (one line per moment q). If the lines are parallel then the series is monofractal (e.g., classic Brownian motion), otherwise multifractal. 
* *upper-right:* Multifractal spectrum. The wider, the stronger the degree of multifractality and non-linear auto-correlation. Hölder exponents are abbreviated by \alpha.
* *lower-left:* generalized Hurst exponents. Would be approximately flat if monofractal.
* *lower-right:* Scaling function. Is linear if monofractal, otherwise convex. 
    
##### Extract Persistence and Multifractal Strength
``` r
    stats <- print(mdl)
    #> 
    #> Persistence: 
    #>  0.4634505   ... =  anti-persistent, neg. auto-corr. 
    #> 
    #> Multifractal Strength:
    #>  diff. Hurst =  0.1146917 
    #>  diff. Hölder =  0.2261127
    
    diff(mdl)
    #> diff Hurst diff Hölder 
    #>  0.1146917   0.2261127 
```
##### Test Significance
``` r
    sig <- significance(mdl, size=10, pval=0.1)
    #>          diff_Holder
    #> original   0.2261127
    #> 90% C.I.   0.2061173
    #> 
    #>  multifractality is significant
```


##### Compute the Temporal Return Persistence

``` r
Ht <- localH(mdl)
plot(Ht, dates=p$Date[-1])
```
![](fig2.png)

Interpretation:

Above 0.5 means that the S&P 500 currently has a positive auto-correlation, below 0.5 means that returns are anti-persistent.

### Simulate Multifractal Series

An example of simulating multifractal returns and prices series.

``` r
B <- mfsim()    # simulate the multifractal Brownian Motion

r <- diff(B)    # take the increments as log-returns
r <- (r - mean(r))/sd(r) * 0.01 + 0     # transform returns into desired mean and standard deviation

p <- exp(cumsum(r))     # transform return into price
plot(p, type="l)

```
![](fig3.png)

### References
Chris Keylock's IAAWT was translated from [Matlab](https://ch.mathworks.com/matlabcentral/fileexchange/62382-iterated-amplitude-adjusted-wavelet-transform-iaawt-for-time-series-randomisation)

#### Applications
*Finance:*
Schadner, W. (2021). On the persistence of market sentiment: A multifractal fluctuation analysis. *Physica A*, **581**, 126242. [link](https://doi.org/10.1016/j.physa.2021.126242)

*Social Science:*
Schadner, W. (2021). U.S. Politics from a multifractal perspective. *Chaos, Solitons & Fractals*, **155**, 111677. [link](https://doi.org/10.1016/j.chaos.2021.111677)

#### Methodology
*MF-DFA:*
Kantelhardt, J.W., et al. (2002). Multifractal detrended fluctuation analysis of nonstationary time series. *Physica A*, **316**(1-4), p.87-114. [link](https://doi.org/10.1016/S0378-4371(02)01383-3)

*IAAWT:*
Keylock, C.J. (2017). Multifractal surrogate-data generation algorithm that preserves pointwise Hölder regularity structure, with initial applications to turbulence. *Physical Review E*, **95**, 032123. [link](https://doi.org/10.1103/PhysRevE.95.032123)

*IAAFT:*
Schreiber, T. and Schmitz, A. (2000). Surrogate time series. *Physica D*, **142**(3–4), p.346–382. [link](https://doi.org/10.1016/S0167-2789(00)00043-9)
