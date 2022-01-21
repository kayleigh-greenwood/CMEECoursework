#################################################################
## How to apply a function to the rows and columns of a matrix ##
#################################################################


### Build a matrix ###

M <- matrix(rnorm(100), 10, 10)
# creates a 10x10 matrix of 100 random numbers 

### Take the mean of each row ###

RowMeans <- apply(M, 1, mean)
# creates variable (RowMeans) and assigns result of apply to it
# format: apply(X, margin, function)
# M: x can be an array or matrix
# 1: margin is a vector giving the subscripts which the function will be applied over
    # eg margin of 1 indicates rows
    # margin 2 indicates columns
    # margin(1,2) indicates rows and columns
# mean: here, the function 'mean' will be applied to each row of M
print("Row Means: ")
print (RowMeans)

### Now the variance ###

RowVars <- apply(M, 1, var)
# 'var' will be applied to each row of M
print("Row Vars: ")
print (RowVars)

### By column ###

ColMeans <- apply(M, 2, mean)
# 'mean' will be applied to each column of M
print("Col Means: ")
print (ColMeans)