
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fxtas

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of fxtas is to …

## Installation

You can install the development version of fxtas from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("d-morrison/fxtas")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(fxtas)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist    
#>  Min.   : 4.0   Min.   :  2  
#>  1st Qu.:12.0   1st Qu.: 26  
#>  Median :15.0   Median : 36  
#>  Mean   :15.4   Mean   : 43  
#>  3rd Qu.:19.0   3rd Qu.: 56  
#>  Max.   :25.0   Max.   :120
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
