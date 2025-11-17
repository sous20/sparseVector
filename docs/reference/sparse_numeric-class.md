# Sparse Numeric Vector Class

An S4 class to represent sparse numeric vectors efficiently by storing
only non-zero values and their positions. This is useful for vectors
with many zero elements, saving memory and computation time.

## Slots

- `value`:

  A numeric vector containing the non-zero values

- `pos`:

  An integer vector containing the positions (indices) of non-zero
  values

- `length`:

  An integer specifying the total length of the vector (including zeros)
