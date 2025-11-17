#' @import methods
NULL
#' @name sparse_numeric-class
#' @title Sparse Numeric Vector Class
#'
#' @description An S4 class to represent sparse numeric vectors efficiently by storing
#' only non-zero values and their positions. This is useful for vectors
#' with many zero elements, saving memory and computation time.
#'
#' @slot value A numeric vector containing the non-zero values
#' @slot pos An integer vector containing the positions (indices) of non-zero values
#' @slot length An integer specifying the total length of the vector (including zeros)
#'
NULL
#' @importFrom methods setClass setValidity setMethod setGeneric new validObject setAs
NULL
setClass(
  Class = "sparse_numeric",
  slots = c(
    value = "numeric",
    pos = "integer",
    length = "integer"
  )
)

## setValidity() method

#' @importFrom methods setValidity
setValidity(
  Class = "sparse_numeric",
  method = function(object) {
    errors = character()

    # Checks that the value vector is numeric class
    if (!is.numeric(object@value)) {
      errors = c(errors, "Value vector must be numeric class")
    }

    # Checks that position vector is integer class
    if (!is.integer(object@pos)) {
      errors = c(errors, "Position vector must be integer class")
    }

    # Check equal length of value and position vectors
    if (length(object@value) != length(object@pos)) {
      errors = c(errors, "Value and position vector lengths must be equal")
    }

    # Check for zeros in value vector
    if (any(object@value == 0)) {
      errors = c(errors, "Value vector must not contain zeros")
    }

    # Check for NA or NaN in value vector
    if (any(is.na(object@value)) || any(is.nan(object@value))) {
      errors = c(errors, "Value vector must not contain NA or NaN")
    }

    # Check for NA in positions
    if (any(is.na(object@pos))) {
      errors = c(errors, "Position vector must not include NA")
    }

    # Check that all positions are positive
    if (any(object@pos <= 0)) {
      errors = c(errors, "All positions must be positive integers")
    }

    # Check for duplicate positions
    if (any(duplicated(object@pos))) {
      errors = c(errors, "Position vector should not contain duplicated")
    }

    # Check that positions are sorted
    if (is.unsorted(object@pos)) {
      errors = c(errors, "Position vector must be sorted")
    }

    # Check length attribute
    if (length(object@length) != 1 || !is.integer(object@length)) {
      errors = c(errors, "Length attribute must be a single integer value")
    } else if (object@length < max(object@pos)) {
      errors = c(errors, "Length attribute must be greater than or equal to maximum position")
    } else if (object@length != as.integer(object@length) || object@length <= 0) {
      errors = c(errors, "Length attribute must be a positive integer")
    }

    # Return TRUE if no errors, else return error vector
    if (length(errors) == 0) {
      return(TRUE)
    } else {
      return(errors)
    }

  })

# Initialize method

#' @importFrom methods setMethod new
setMethod("initialize", "sparse_numeric",
          function(.Object, value = numeric(0), pos = integer(0), length = 0L) {
            .Object@value = value
            .Object@pos = as.integer(pos)
            .Object@length = as.integer(length)
            return(.Object)
          }
)

## add generic function + method

#' Add Two Sparse Numeric Vectors
#'
#' Performs element-wise addition of two sparse numeric vectors and returns
#' a sparse numeric vector.
#'
#' @param x A \code{sparse_numeric} object
#' @param y A \code{sparse_numeric} object
#' @param ... Additional arguments (currently unused)
#'
#' @return A \code{sparse_numeric} object representing the element-wise sum
#'
#' @export
#'
#' @examples
#' x <- as(c(1, 0, 3, 0), "sparse_numeric")
#' y <- as(c(0, 2, 1, 0), "sparse_numeric")
#' result <- sparse_add(x, y)
#' # Returns sparse vector: [1, 2, 4, 0]
setGeneric(
  "sparse_add",
  function(x, y, ...) {
    standardGeneric("sparse_add")
  }
)

#' @rdname sparse_add
#' @export
setMethod(
  "sparse_add",
  signature(x = "sparse_numeric", y = "sparse_numeric"),
  function(x, y, ...) {
    if (x@length != y@length) {
      stop("Arguments must have the same length")
    }

    all_positions = sort(unique(c(x@pos, y@pos)))

    if (length(all_positions) == 0) {
      return(new("sparse_numeric",
                 value = numeric(0),
                 pos = integer(0),
                 length = x@length))
    }

    x_vals = rep(0, length(all_positions))
    y_vals = rep(0, length(all_positions))

    x_match = match(x@pos, all_positions)
    y_match = match(y@pos, all_positions)

    x_vals[x_match] = x@value
    y_vals[y_match] = y@value

    result_vals = x_vals + y_vals
    non_zero = result_vals != 0

    new("sparse_numeric",
        value = result_vals[non_zero],
        pos = all_positions[non_zero],
        length = x@length)
  }
)

## multiply generic function + method

#' Multiply Two Sparse Numeric Vectors
#'
#' Performs element-wise multiplication of two sparse numeric vectors and
#' returns a sparse numeric vector.
#'
#' @param x A \code{sparse_numeric} object
#' @param y A \code{sparse_numeric} object
#' @param ... Additional arguments (currently unused)
#'
#' @return A \code{sparse_numeric} object representing the element-wise product
#'
#' @export
#'
#' @examples
#' x <- as(c(2, 0, 3, 0), "sparse_numeric")
#' y <- as(c(0, 2, 1, 0), "sparse_numeric")
#' result <- sparse_mult(x, y)
#' # Returns sparse vector: [0, 0, 3, 0]
setGeneric(
  "sparse_mult",
  function(x, y, ...) {
    standardGeneric("sparse_mult")
  }
)

#' @rdname sparse_mult
#' @export
setMethod(
  "sparse_mult",
  signature(x = "sparse_numeric", y = "sparse_numeric"),
  function(x, y, ...) {
    if (x@length != y@length) {
      stop("Arguments must have the same length")
    }

    common_positions = intersect(x@pos, y@pos)

    if (length(common_positions) == 0) {
      return(new("sparse_numeric",
                 value = numeric(0),
                 pos = integer(0),
                 length = x@length))
    }

    x_vals = x@value[match(common_positions, x@pos)]
    y_vals = y@value[match(common_positions, y@pos)]

    result_vals = x_vals * y_vals
    non_zero = result_vals != 0

    new("sparse_numeric",
        value = result_vals[non_zero],
        pos = common_positions[non_zero],
        length = x@length)
  }
)

## subtract generic function + method

#' Subtract Two Sparse Numeric Vectors
#'
#' Performs element-wise subtraction of two sparse numeric vectors and
#' returns a sparse numeric vector.
#'
#' @param x A \code{sparse_numeric} object
#' @param y A \code{sparse_numeric} object
#' @param ... Additional arguments (currently unused)
#'
#' @return A \code{sparse_numeric} object representing the element-wise difference (x - y)
#'
#' @export
#'
#' @examples
#' x <- as(c(5, 0, 3, 0), "sparse_numeric")
#' y <- as(c(0, 2, 1, 0), "sparse_numeric")
#' result <- sparse_sub(x, y)
#' # Returns sparse vector: [5, -2, 2, 0]
setGeneric(
  "sparse_sub",
  function(x, y, ...) {
    standardGeneric("sparse_sub")
  }
)

#' @rdname sparse_sub
#' @export
setMethod(
  "sparse_sub",
  signature(x = "sparse_numeric", y = "sparse_numeric"),
  function(x, y, ...) {
    if (x@length != y@length) {
      stop("Arguments must have the same length")
    }

    all_positions = sort(unique(c(x@pos, y@pos)))

    if (length(all_positions) == 0) {
      return(new("sparse_numeric",
                 value = numeric(0),
                 pos = integer(0),
                 length = x@length))
    }

    x_vals = rep(0, length(all_positions))
    y_vals = rep(0, length(all_positions))

    x_match = match(x@pos, all_positions)
    y_match = match(y@pos, all_positions)

    x_vals[x_match] = x@value
    y_vals[y_match] = y@value

    result_vals = x_vals - y_vals
    non_zero = result_vals != 0

    new("sparse_numeric",
        value = result_vals[non_zero],
        pos = all_positions[non_zero],
        length = x@length)
  }
)

## cross product generic function + method

#' Compute Cross Product of Two Sparse Numeric Vectors
#'
#' Calculates the cross product (dot product) of two sparse numeric vectors,
#' returning a single numeric value equal to the sum of element-wise products.
#'
#' @param x A \code{sparse_numeric} object
#' @param y A \code{sparse_numeric} object
#' @param ... Additional arguments (currently unused)
#'
#' @return A numeric value representing the cross product
#'
#' @export
#'
#' @examples
#' x <- as(c(1, 0, 3, 0), "sparse_numeric")
#' y <- as(c(0, 2, 2, 0), "sparse_numeric")
#' result <- sparse_crossprod(x, y)
#' # Returns 6 (= 1*0 + 0*2 + 3*2 + 0*0)
setGeneric(
  "sparse_crossprod",
  function(x, y, ...) {
    standardGeneric("sparse_crossprod")
  }
)

#' @rdname sparse_crossprod
#' @export
setMethod(
  "sparse_crossprod",
  signature(x = "sparse_numeric", y = "sparse_numeric"),
  function(x, y, ...) {
    if (x@length != y@length) {
      stop("Arguments must have the same length")
    }

    common_positions = intersect(x@pos, y@pos)

    if (length(common_positions) == 0) {
      return(0)
    }

    x_vals = x@value[match(common_positions, x@pos)]
    y_vals = y@value[match(common_positions, y@pos)]

    return(sum(x_vals * y_vals))
  }
)

## Arithmetic operator methods

#' @rdname sparse_add
#' @param e1 A \code{sparse_numeric} object (left operand)
#' @param e2 A \code{sparse_numeric} object (right operand)
#' @export
setMethod("+",
          signature(e1 = "sparse_numeric", e2 = "sparse_numeric"),
          function(e1, e2) {
            sparse_add(e1, e2)
          }
)

#' @rdname sparse_mult
#' @param e1 A \code{sparse_numeric} object (left operand)
#' @param e2 A \code{sparse_numeric} object (right operand)
#' @export
setMethod("*",
          signature(e1 = "sparse_numeric", e2 = "sparse_numeric"),
          function(e1, e2) {
            sparse_mult(e1, e2)
          }
)

#' @rdname sparse_sub
#' @param e1 A \code{sparse_numeric} object (left operand)
#' @param e2 A \code{sparse_numeric} object (right operand)
#' @export
setMethod("-",
          signature(e1 = "sparse_numeric", e2 = "sparse_numeric"),
          function(e1, e2) {
            sparse_sub(e1, e2)
          }
)

## Coercion: numeric to sparse_numeric

#' @name coerce-numeric-sparse_numeric
#' @title Coerce Numeric Vector to Sparse Numeric
#'
#' @description Converts a regular numeric vector to a sparse_numeric object by
#' extracting non-zero values and their positions.
#'
#' @param from A numeric vector
#'
#' @return A \code{sparse_numeric} object
#'
#' @examples
#' x <- as(c(1, 0, 0, 4, 0, 2), "sparse_numeric")
#'
NULL
setAs("numeric", "sparse_numeric",
      function(from) {
        non_zero_ids = which(from != 0)

        new("sparse_numeric",
            value = from[non_zero_ids],
            pos = as.integer(non_zero_ids),
            length = as.integer(length(from)))
      }
)

#' @name coerce-sparse_numeric-numeric
#' @title Coerce Sparse Numeric to Numeric Vector
#'
#' @description Converts a sparse_numeric object to a regular numeric vector by
#' filling in zeros at appropriate positions.
#'
#' @param from A \code{sparse_numeric} object
#'
#' @return A numeric vector
#'
#' @examples
#' x <- as(c(1, 0, 0, 4), "sparse_numeric")
#' y <- as(x, "numeric")
#'
NULL
setAs("sparse_numeric", "numeric",
      function(from) {
        result = rep(0, from@length)
        result[from@pos] = from@value
        return(result)
      }
)

#' Show Method for Sparse Numeric Vectors
#'
#' Displays a sparse_numeric object by showing its length and non-zero values.
#'
#' @param object A \code{sparse_numeric} object
#'
#' @return Invisible NULL (prints to console)
#'
#' @export
setMethod("show", "sparse_numeric",
          function(object) {
            cat("Sparse numeric vector of length", object@length, "\n")
            if (length(object@pos) == 0) {
              cat("All zeros\n")
            } else {
              cat("Non-zero values:\n")
              for (i in seq_along(object@pos)) {
                cat(sprintf("  [%d] = %g\n", object@pos[i], object@value[i]))
              }
            }
          }
)

#' Plot Two Sparse Numeric Vectors
#'
#' Creates a scatter plot showing the overlapping non-zero elements of
#' two sparse numeric vectors.
#'
#' @param x A \code{sparse_numeric} object
#' @param y A \code{sparse_numeric} object
#' @param ... Additional arguments passed to plot()
#'
#' @return Invisible NULL (creates a plot)
#'
#' @export
#'
#' @examples
#' x <- as(c(1, 0, 3, 0, 5), "sparse_numeric")
#' y <- as(c(0, 2, 2, 0, 4), "sparse_numeric")
#' plot(x, y)
#' @importFrom graphics plot points legend text
setMethod("plot",
          signature(x = "sparse_numeric", y = "sparse_numeric"),
          function(x, y, ...) {
            # Find overlapping non-zero positions
            common_positions = intersect(x@pos, y@pos)

            if (length(common_positions) == 0) {
              plot(0, 0, type = "n",
                   xlab = "Position", ylab = "Value",
                   main = "Overlapping Non-Zero Elements",
                   xlim = c(0, max(x@length, y@length)),
                   ylim = c(0, 1))
              text(max(x@length, y@length)/2, 0.5,
                   "No overlapping non-zero elements")
              return(invisible(NULL))
            }

            x_vals = x@value[match(common_positions, x@pos)]
            y_vals = y@value[match(common_positions, y@pos)]

            plot(common_positions, x_vals,
                 col = "blue", pch = 16, cex = 1.5,
                 xlab = "Position", ylab = "Value",
                 main = "Overlapping Non-Zero Elements",
                 ylim = range(c(x_vals, y_vals)),
                 ...)
            points(common_positions, y_vals,
                   col = "red", pch = 17, cex = 1.5)
            legend("topright",
                   legend = c("x", "y"),
                   col = c("blue", "red"),
                   pch = c(16, 17))
          }
)

#' Get Length of Sparse Numeric Vector
#'
#' Returns the total length of a sparse numeric vector (including zero elements).
#'
#' @param x A \code{sparse_numeric} object
#'
#' @return An integer representing the total length
#'
#' @export
#'
#' @examples
#' x <- as(c(1, 0, 0, 4, 0), "sparse_numeric")
#' length(x)  # Returns 5
setMethod("length", "sparse_numeric",
          function(x) {
            return(x@length)
          }
)

#' Calculate Mean of Sparse Numeric Vector
#'
#' Computes the mean of a sparse numeric vector, including all zero elements
#' in the calculation. This operation is performed efficiently without
#' converting to dense format.
#'
#' @param x A \code{sparse_numeric} object
#' @param ... Additional arguments (currently unused)
#'
#' @return A numeric value representing the mean
#'
#' @export
#'
#' @examples
#' x <- as(c(1, 0, 0, 4, 0), "sparse_numeric")
#' mean(x)  # Returns 1
setMethod("mean", "sparse_numeric",
          function(x, ...) {
            if (length(x@pos) == 0) {
              return(0)
            }
            sum(x@value) / x@length
          }
)

#' Compute the Norm of a Sparse Numeric Vector
#'
#' Calculates the L2 (Euclidean) norm of a sparse numeric vector, which is
#' the square root of the sum of squared elements. This operation is performed
#' efficiently using only the non-zero values.
#'
#' @param x A \code{sparse_numeric} object
#' @param ... Additional arguments (currently unused)
#'
#' @return A numeric value representing the L2 norm
#'
#' @export
#'
#' @examples
#' x <- as(c(3, 0, 4), "sparse_numeric")
#' norm(x)  # Returns 5
setGeneric(
  "norm",
  function(x, ...) {
    standardGeneric("norm")
  }
)

#' @rdname norm
#' @export
setMethod(
  "norm",
  "sparse_numeric",
  function(x, ...) {
    if (length(x@value) == 0) {
      return(0)
    }
    sqrt(sum(x@value^2))
  }
)

#' Standardize a Sparse Numeric Vector
#'
#' Standardizes a sparse numeric vector by subtracting the mean and dividing
#' by the standard deviation. The result is a new sparse_numeric vector with
#' mean 0 and standard deviation 1. This operation is performed efficiently
#' without converting to dense format.
#'
#' @param x A \code{sparse_numeric} object
#' @param ... Additional arguments (currently unused)
#'
#' @return A standardized \code{sparse_numeric} object
#'
#' @export
#'
#' @examples
#' x <- as(c(1, 2, 3, 4, 5), "sparse_numeric")
#' x_std <- standardize(x)
#' mean(x_std)  # Approximately 0
setGeneric(
  "standardize",
  function(x, ...) {
    standardGeneric("standardize")
  }
)

#' @rdname standardize
#' @export
setMethod(
  "standardize",
  "sparse_numeric",
  function(x, ...) {
    # Calculate mean
    m = mean(x)
    # Calculate standard deviation
    if (x@length <= 1) {
      stop("Cannot standardize vector of length <= 1")
    }
    sum_sq_dev_nonzero = sum((x@value - m)^2)
    n_zeros = x@length - length(x@pos)
    sum_sq_dev_zeros = n_zeros * m^2
    total_sum_sq_dev = sum_sq_dev_nonzero + sum_sq_dev_zeros
    sd_val = sqrt(total_sum_sq_dev / (x@length - 1))
    if (sd_val == 0) {
      stop("Cannot standardize vector with zero standard deviation")
    }
    # Standardize values
    new_values = (x@value - m) / sd_val
    standardized_zero = -m / sd_val
    if (standardized_zero == 0) {
      non_zero = new_values != 0
      return(new("sparse_numeric",
                 value = new_values[non_zero],
                 pos = x@pos[non_zero],
                 length = x@length))
    } else {
      result = rep(standardized_zero, x@length)
      result[x@pos] = new_values
      non_zero_idx = which(result != 0)
      return(new("sparse_numeric",
                 value = result[non_zero_idx],
                 pos = as.integer(non_zero_idx),
                 length = x@length))
    }

  }
)
