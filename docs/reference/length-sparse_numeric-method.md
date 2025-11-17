# Get Length of Sparse Numeric Vector

Returns the total length of a sparse numeric vector (including zero
elements).

## Usage

``` r
# S4 method for class 'sparse_numeric'
length(x)
```

## Arguments

- x:

  A `sparse_numeric` object

## Value

An integer representing the total length

## Examples

``` r
x <- as(c(1, 0, 0, 4, 0), "sparse_numeric")
length(x)  # Returns 5
#> [1] 5
```
