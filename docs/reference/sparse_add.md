# Add Two Sparse Numeric Vectors

Performs element-wise addition of two sparse numeric vectors and returns
a sparse numeric vector.

## Usage

``` r
sparse_add(x, y, ...)

# S4 method for class 'sparse_numeric,sparse_numeric'
sparse_add(x, y, ...)

# S4 method for class 'sparse_numeric,sparse_numeric'
e1 + e2
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

A `sparse_numeric` object representing the element-wise sum

## Examples

``` r
x <- as(c(1, 0, 3, 0), "sparse_numeric")
y <- as(c(0, 2, 1, 0), "sparse_numeric")
result <- sparse_add(x, y)
# Returns sparse vector: [1, 2, 4, 0]
```
