## Overview

This is an improved package for multifractal detrended fluctuation
(MF-DFA) and surroagte analysis (IAAFT, IAAWT). It allows to enhance the
robustness and reliability of classic MF-DFA via overlapping windows. It
further enables to test the significance of multifractality via IAAFT
surrogates.

## Installation

``` r
    devtools::install_github("wol-fi/multifractal")
```

## Usage

The below example illustrates a multifractal analysis of the S&P 500
stock market index (daily, 1992-2022). The example dataset comes with
the package (source: Yahoo finance).

``` r
    library(multifractal)

    ## preparation:
    # load the example dataset 'sp500' and calculate daily log-returns
    p <- sp500
    r <- diff(log(p$Adj.Close)) 

    ## multifractal analysis
    # estimate the statistics
    mdl <- mfdfa(r, overlap=T)
    #> ....................

    ## plot the output
    plot(mdl, newindow=F)
```
![](fig1.png)

``` r
    # Interpretation:
    #  - upper-left: Fluctuation plot. The slopes of the lines represent the Hurst exponents
    #                (one line per moment q). If the lines are parallel then the series is monofractal 
    #                (e.g., classic Brownian motion), otherwise multifractal. 
    #  - upper-right: Multifractal spectrum. The wider, the stronger the degree of multifractality and 
    #                non-linear auto-correlation. Hölder exponents are abbreviated by $\alpha$.
    #  - lower-left: generalized Hurst exponents. Would be approximately flat if monofractal.
    #  - lower-right: Scaling function. Is linear if monofractal, otherwise convex. 

    ## Extract Persistence and Multifractal Strength
    stats <- print(mdl)
    #> 
    #> Persistence: 
    #>  0.4634505   ... =  anti-persistent, neg. auto-corr. 
    #> 
    #> Multifractal Strength:
    #>  diff. Hurst =  0.1146917 
    #>  diff. Hölder =  0.2261127


    ## Test Significance
    sig <- significance(mdl, size=10, pval=0.1)
    #> ..........
    #>          diff_Holder
    #> original   0.2261127
    #> 90% C.I.   0.2061173
    #> 
    #>  multifractality is significant
```