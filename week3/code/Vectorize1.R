M <- matrix(runif(1000000),1000,1000)
# generates 1000000 numbers from a uniform distribution
# enters them into a matrix of 1000x1000

SumAllElements <- function(M){
  # creates and defines a function that takes a matrix as the argument
  Dimensions <- dim(M)
  # assigns the dimensions of the matrix to a variable 
  # so format of variable is (number1 number2)
  Tot <- 0
  # creates variable and assigns value of 0
  for (i in 1:Dimensions[1]){
    # loops through numbers from 1 to number1 (highest row number of matrix)
    # loops through rows of matrix
    for (j in 1:Dimensions[2]){
      # loops through numbers from 1 to number 2 (highest column number in matrix)
      # for each row, loops through columns
      Tot <- Tot + M[i,j]
      # updates value of Tot to
      # the previous value, plus the value at the current location
      # eventually means all values in the matrix are added
    }
  }
  return (Tot)
  # returns value of Tot for use outside of the variable
}
 
print("Using loops, the time taken is:")
print(system.time(SumAllElements(M)))
# calculates time taken for above function to run 
# system.time calculates how long code takes to run
# result will vary with every run 

print("Using the in-built vectorized function, the time taken is:")
print(system.time(sum(M)))
# compares to inbuilt sum function
# faster because looping isn't used