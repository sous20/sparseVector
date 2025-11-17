# Subtract Two Sparse Numeric Vectors

Performs element-wise subtraction of two sparse numeric vectors and
returns a sparse numeric vector.

## Usage

``` r
sparse_sub(x, y, ...)

# S4 method for class 'sparse_numeric,sparse_numeric'
sparse_sub(x, y, ...)

# S4 method for class 'sparse_numeric,sparse_numeric'
e1 - e2
```

## Arguments

- x:

  A `sparse_numeric` object

- y:

  A `sparse_numeric` object

- ...:

  Additional arguments (currently unused)

- e1:

  A `sparse_numeric` object (left operand)

- e2:

  A `sparse_numeric` object (right operand)

## Value

A `sparse_numeric` object representing the element-wise difference (x -
y)

## Examples

``` r
x <- as(c(5, 0, 3, 0), "sparse_numeric")
y <- as(c(0, 2, 1, 0), "sparse_numeric")
result <- sparse_sub(x, y)
# Returns sparse vector: [5, -2, 2, 0]
```
