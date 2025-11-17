# sparseVector

Efficient sparse numeric vector implementation for R.

## Installation

You can install the development version from GitHub:

``` r
# install.packages("devtools")
devtools::install_github("sous20/sparseVector")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(sparseVector)
#> 
#> Attaching package: 'sparseVector'
#> The following object is masked from 'package:base':
#> 
#>     norm

# Create a sparse vector
x <- as(c(1, 0, 0, 4, 0), "sparse_numeric")
y <- as(c(0, 2, 0, 1, 0), "sparse_numeric")

# Perform operations
sparse_add(x, y)
#> Sparse numeric vector of length 5 
#> Non-zero values:
#>   [1] = 1
#>   [2] = 2
#>   [4] = 5
mean(x)
#> [1] 1
norm(x)
#> [1] 4.123106
```
