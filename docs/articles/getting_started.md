# Getting Started with sparseVector

## What is sparseVector?

The `sparseVector` package provides an efficient S4 class for
representing sparse numeric vectors in R. A sparse vector is one that
contains many zeros - instead of storing all elements, we only store the
non-zero values and their positions. This saves memory and speeds up
computations.

## Basic Usage

### Creating Sparse Vectors

Convert a regular numeric vector to sparse format:

``` r
library(sparseVector)

# Create a sparse vector from a numeric vector
x <- as(c(1, 0, 0, 4, 0, 2), "sparse_numeric")
x
#> Sparse numeric vector of length 6 
#> Non-zero values:
#>   [1] = 1
#>   [4] = 4
#>   [6] = 2
```

### Arithmetic Operations

Perform element-wise operations:

``` r
y <- as(c(0, 2, 0, 1, 0, 3), "sparse_numeric")

# Addition
sparse_add(x, y)
#> Sparse numeric vector of length 6 
#> Non-zero values:
#>   [1] = 1
#>   [2] = 2
#>   [4] = 5
#>   [6] = 5

# Multiplication
sparse_mult(x, y)
#> Sparse numeric vector of length 6 
#> Non-zero values:
#>   [4] = 4
#>   [6] = 6

# Subtraction
sparse_sub(x, y)
#> Sparse numeric vector of length 6 
#> Non-zero values:
#>   [1] = 1
#>   [2] = -2
#>   [4] = 3
#>   [6] = -1

# Cross product (dot product)
sparse_crossprod(x, y)
#> [1] 10
```

### Using Operators

You can also use standard R operators:

``` r
# Addition with +
x + y
#> Sparse numeric vector of length 6 
#> Non-zero values:
#>   [1] = 1
#>   [2] = 2
#>   [4] = 5
#>   [6] = 5

# Multiplication with *
x * y
#> Sparse numeric vector of length 6 
#> Non-zero values:
#>   [4] = 4
#>   [6] = 6

# Subtraction with -
x - y
#> Sparse numeric vector of length 6 
#> Non-zero values:
#>   [1] = 1
#>   [2] = -2
#>   [4] = 3
#>   [6] = -1
```

### Statistical Functions

Compute statistics efficiently:

``` r
# Mean (including zeros)
mean(x)
#> [1] 1.166667

# L2 Norm
norm(x)
#> [1] 4.582576

# Standardize
x_std <- standardize(x)
mean(x_std)
#> [1] -8.789266e-17
```

### Converting Back to Dense Format

``` r
# Convert sparse to regular numeric vector
as(x, "numeric")
#> [1] 1 0 0 4 0 2
```

## Why Use Sparse Vectors?

- **Memory Efficient**: Store only non-zero values
- **Computation Efficient**: Operations only compute on non-zero
  elements
- **Easy to Use**: Familiar R interface with + , \*, - operators
- **Type Safe**: S4 class with validation
