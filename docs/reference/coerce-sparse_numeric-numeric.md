# Coerce Sparse Numeric to Numeric Vector

Converts a sparse_numeric object to a regular numeric vector by filling
in zeros at appropriate positions.

## Arguments

- from:

  A `sparse_numeric` object

## Value

A numeric vector

## Examples

``` r
x <- as(c(1, 0, 0, 4), "sparse_numeric")
y <- as(x, "numeric")
```
