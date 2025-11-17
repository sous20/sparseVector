# sparseVector

This package provides an S4 class for representing sparse numeric
vectors efficiently by storing only non-zero values and their positions.
It includes methods for common vector operations including arithmetic,
statistical functions, and transformations that maintain sparsity where
possible.

## Installation

You can install the development version from GitHub:

``` r
# install.packages("devtools")
devtools::install_github("sous20/sparseVector")
#> Using GitHub PAT from the git credential store.
#> Downloading GitHub repo sous20/sparseVector@HEAD
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/private/var/folders/vk/52v3w4hn36974vvx4x4q66m00000gn/T/RtmpUd4ES0/remotes71503b762ae0/sous20-sparseVector-a48fdaf/DESCRIPTION’ ... OK
#> * preparing ‘sparseVector’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building ‘sparseVector_0.1.0.tar.gz’
#> Installing package into '/private/var/folders/vk/52v3w4hn36974vvx4x4q66m00000gn/T/Rtmpdi9Tts/temp_libpath608b53fe908e'
#> (as 'lib' is unspecified)
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
