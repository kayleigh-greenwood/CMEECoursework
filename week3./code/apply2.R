#########################################
## Using apply to define own functions ##
#########################################

SomeOperation <- function(v){ 
  # defines a function, which takes input of vector
  if (sum(v) > 0){ 
    # note that sum(v) is a single (scalar) value
    # sum() adds together all positive and negative values of v
    # so there is a possibility it could be zero
    # if statement for what to do if sum(v) is greater than 0
    return (v * 100) 
    # return this if the if statement was true and exit function
    # if sum of v is greater than 0, multiply v by 100
    # if v's sum is positive after all positive and negative numbers are accounted for, the whole vector is multiplied by 100
  }
  return (v)
  # if the sum is equal to or less than 0, the function will return the vector
}

M <- matrix(rnorm(100), 10, 10)
# creates matrix(M) of normally distributed numbers (rnorm), 10by10 matrix


print (apply(M, 1, SomeOperation))
# Because dimension '1' has been specified, the function 'SomeOperation' will perform sum(v) on each row in the matrix