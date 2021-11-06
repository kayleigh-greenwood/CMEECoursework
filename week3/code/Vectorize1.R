# Sums all elements of a matrix. Compares sum() and a sum function

## Create matrix ##
M <- matrix(runif(1000000),1000,1000)
# generates 1000000 numbers from a uniform distribution
# enters them into a matrix of 1000x1000


## Define function ##
SumAllElements <- function(M){
  # creates and defines a function that takes a matrix as the argument
  
  Dimensions <- dim(M)
  # assigns the dimensions of the matrix to a variable 
  # so format of variable 'Dimensions' is (number1 number2)
  
  Tot <- 0
  # creates variable and assigns value of 0
  
  for (i in 1:Dimensions[1]){
    # loops through numbers from 1 to number1 in vector 'Dimensions' (highest row number of matrix)
    # essentially loops through rows of matrix (but not literally!)

    for (j in 1:Dimensions[2]){
      # loops through numbers from 1 to number2 in vector 'Dimensions' (highest column number in matrix)
      # for each row, essentially loops through columns (but doesn't literally!!)
      
      Tot <- Tot + M[i,j]
      # updates value of Tot to the sum of:
      # the previous value, and the value at the current location (M[i,j])
      # eventually means all values in the matrix are added
    }
  }

  return (Tot)
  # returns value of Tot for use outside of the variable
}
 

## Test run time of function ##

print("Using loops, the time taken is:")
print(system.time(SumAllElements(M)))
# calculates time taken for above function to run 
# system.time calculates how long code takes to run
# result will vary with every run 


## Test run time of built in tool ##

print("Using the in-built vectorized function, the time taken is:")
print(system.time(sum(M)))
# compares to inbuilt sum function
# faster because looping isn't used