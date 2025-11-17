# Standardize a Sparse Numeric Vector

Standardizes a sparse numeric vector by subtracting the mean and
dividing by the standard deviation. The result is a new sparse_numeric
vector with mean 0 and standard deviation 1. This operation is performed
efficiently without converting to dense format.

## Usage

``` r
standardize(x, ...)

# S4 method for class 'sparse_numeric'
standardize(x, ...)
```

## Arguments

- x:

  A `sparse_numeric` object

- ...:

  Additional arguments (currently unused)

## Value

A standardized `sparse_numeric` object

## Examples

``` r
x <- as(c(1, 2, 3, 4, 5), "sparse_numeric")
x_std <- standardize(x)
mean(x_std)  # Approximately 0
#> [1] 0
```
