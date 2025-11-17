# Plot Two Sparse Numeric Vectors

Creates a scatter plot showing the overlapping non-zero elements of two
sparse numeric vectors.

## Usage

``` r
# S4 method for class 'sparse_numeric,sparse_numeric'
plot(x, y, ...)
```

## Arguments

- x:

  A `sparse_numeric` object

- y:

  A `sparse_numeric` object

- ...:

  Additional arguments passed to plot()

## Value

Invisible NULL (creates a plot)

## Examples

``` r
x <- as(c(1, 0, 3, 0, 5), "sparse_numeric")
y <- as(c(0, 2, 2, 0, 4), "sparse_numeric")
plot(x, y)
```
