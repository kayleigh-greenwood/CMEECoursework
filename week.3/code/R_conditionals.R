# Examples of functions with conditionals

## Block 1 ##

# Define function is.even
is.even <- function(n = 2){
  # creates fuction(is.even) that takes one argument(n)
  # is.even checks if an integer is even
  if (n %% 2 == 0)
  # runs if statement if n is even
  {
    return(paste(n,'is even!'))
    # return this statement and don't carry on with function
  } 
  return(paste(n,'is odd!'))
  # return this statement if the if statement hasn't run
}

# test function is.even
is.even(6)

## Block 2 ##

# define is.power2
is.power2 <- function(n = 2){
  # creates function (is.power2) that takes one argument(n)
  # is.power2 checks if an integer is even

  if (log2(n) %% 1==0)
  # runs if statement if n is a power of 2
  {
    return(paste(n, 'is a power of 2!'))
    # return this statement and end function
  } 
  return(paste(n,'is not a power of 2!'))
  # returns this statement if the if statement hasnt run
}

# test is.power2
is.power2(4)

## Block 3 ##

# Define function is.prime
is.prime <- function(n){
  # defines function(is.prime) that takes one arguement(n)
  # is.prime checks if a number is prime

  if (n==0){
    return(paste(n,'is a zero!'))
  }
  if (n==1){
    return(paste(n,'is just a unit!'))
  }
  ints <- 2:(n-1)
  # previous if statements mean this only runs if n isn't 0 or 1
  # creates variable(ints) that stores a sequence from 2 to the number before n
  if (all(n%%ints!=0)){
    # runs if statement if n isn't a factor of anything in the ints sequence
    return(paste(n,'is a prime!'))
  } 
  return(paste(n,'is a composite!'))
}

# test function is.prime
is.prime(3)