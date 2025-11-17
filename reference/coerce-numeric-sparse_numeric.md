# Coerce Numeric Vector to Sparse Numeric

Converts a regular numeric vector to a sparse_numeric object by
extracting non-zero values and their positions.

## Arguments

- from:

  A numeric vector

## Value

A `sparse_numeric` object

## Examples

``` r
x <- as(c(1, 0, 0, 4, 0, 2), "sparse_numeric")
```
