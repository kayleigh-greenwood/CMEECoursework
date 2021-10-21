SomeOperation <- function(v){ # defines a function, which takes input of v, and stores it in a variables
  if (sum(v) > 0){ #note that sum(v) is a single (scalar) value
    return (v * 100) # if sum of v is greater than 0, multiply it by 100
    # if v's sum is positive after all positive and negative numbers are accounted for, the sum is multiplied by 100
  }
  return (v)
}

M <- matrix(rnorm(100), 10, 10)
print (apply(M, 1, SomeOperation))


# creates matrix(M) of normally distributed numbers (rnorm), 10by10 matrix
# the '1' in the print statement determines how it should be applied(eg row or column)
# sum is then applied for each row/column

# input v is the matrix
# sum(v) is the sum of each row in the matrix, as dimension 1 has been specified
# because it is a normal distribution is has both positive and negative numbers