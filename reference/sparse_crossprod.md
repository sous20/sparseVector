# Compute Cross Product of Two Sparse Numeric Vectors

Calculates the cross product (dot product) of two sparse numeric
vectors, returning a single numeric value equal to the sum of
element-wise products.

## Usage

``` r
sparse_crossprod(x, y, ...)

# S4 method for class 'sparse_numeric,sparse_numeric'
sparse_crossprod(x, y, ...)
```

## Arguments

- x:

  A `sparse_numeric` object

- y:

  A `sparse_numeric` object

- ...:

  Additional arguments (currently unused)

## Value

A numeric value representing the cross product

## Examples

``` r
x <- as(c(1, 0, 3, 0), "sparse_numeric")
y <- as(c(0, 2, 2, 0), "sparse_numeric")
result <- sparse_crossprod(x, y)
# Returns 6 (= 1*0 + 0*2 + 3*2 + 0*0)
```
