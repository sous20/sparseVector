# Calculate Mean of Sparse Numeric Vector

Computes the mean of a sparse numeric vector, including all zero
elements in the calculation. This operation is performed efficiently
without converting to dense format.

## Usage

``` r
# S4 method for class 'sparse_numeric'
mean(x, ...)
```

## Arguments

- x:

  A `sparse_numeric` object

- ...:

  Additional arguments (currently unused)

## Value

A numeric value representing the mean

## Examples

``` r
x <- as(c(1, 0, 0, 4, 0), "sparse_numeric")
mean(x)  # Returns 1
#> [1] 1
```
