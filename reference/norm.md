# Compute the Norm of a Sparse Numeric Vector

Calculates the L2 (Euclidean) norm of a sparse numeric vector, which is
the square root of the sum of squared elements. This operation is
performed efficiently using only the non-zero values.

## Usage

``` r
norm(x, ...)

# S4 method for class 'sparse_numeric'
norm(x, ...)
```

## Arguments

- x:

  A `sparse_numeric` object

- ...:

  Additional arguments (currently unused)

## Value

A numeric value representing the L2 norm

## Examples

``` r
x <- as(c(3, 0, 4), "sparse_numeric")
norm(x)  # Returns 5
#> [1] 5
```
