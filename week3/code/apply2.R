SomeOperation <- function(v){ 
  # defines a function, which takes input of vector
  if (sum(v) > 0){ 
    # note that sum(v) is a single (scalar) value
    # sum() adds together all positive and negative values of v
    # so there is a possibility it could be zero
    # if statement for if sum(v) is greater than 0
    return (v * 100) 
    # if sum of v is greater than 0, multiply v by 100
    # if v's sum is positive after all positive and negative numbers are accounted for, the whole vector is multiplied by 100
  }
  return (v)
}

M <- matrix(rnorm(100), 10, 10)
# creates matrix(M) of normally distributed numbers (rnorm), 10by10 matrix


print (apply(M, 1, SomeOperation))
# sum(v) is the sum of each row in the matrix, as dimension 1 has been specified
# SomeOperation is applied to each row of M