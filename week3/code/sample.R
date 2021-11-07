######################################################
## Example of vectorization using lapply and sapply ##
######################################################

######### Functions ##########

## A function to take a sample of size n from a population "popn" and return its mean
myexperiment <- function(popn,n){
    # creates function that takes input of a population size, and desired sample size of mean
    pop_sample <- sample(popn, n, replace = FALSE)
    # stores result of sample in variable
    # format of sample: sample(x, size, replace=FALSE, prob=NULL)
    # sample takes a sample of the specified size from the elements of x,
    # either with or without replacement
    # replacement refers to the concept of picking marbles out of a bag
    # it determines whether we put the first marble back in after we have picked it out and recorded it
    # so here, as replace is false, the same value cannot be drawn again if it has been picked
    return(mean(pop_sample))
    # calculate the mean of the sample
}

## Calculate means using a for loop without preallocation:
## creates a vector with 'num' length, containing various sampled means of the same size 'n' from the population size popn
loopy_sample1 <- function(popn, n, num){
    # creates function that takes input of a population size, and desired sample size of mean, and number
    result1 <- vector() 
    #Initialize empty vector of size 1 
    for(i in 1:num){
        # loops through numbers from 1 up to specified number 'num'
        result1 <- c(result1, myexperiment(popn, n))
        # assigns vector to result 1
        # updates vector 'result 1' to contain itself, and a new value
        # that new value being the result of the function 'myexperiment'
        # function returns mean of a sample size(n) within population size (popn)
        # repeats the same thing in each loop but sample always returns a different value so each loop will be different
        # means vector is resized in every iteration of the for loop
    }
    return(result1)
}


## To run "num" iterations of the experiment using a for loop on a vector with preallocation. 
## Outputs a vector
## does the same thing as above function but with preallocation
loopy_sample2 <- function(popn, n, num){
    result2 <- vector(,num) 
    # Preallocate expected size
    # vector produces an empty vector of the given length and mode
    # vector format: vector(mode, length)
    # creates empty vector of length num
    for(i in 1:num){
        # loops through numbers from 1 to specified length of vector
        result2[i] <- myexperiment(popn, n)
        # for each location in the vector, a mean of sample size n is generated
    }
    return(result2)
}

## To run "num" iterations of the experiment using a for loop on a list with preallocation:
## Outputs a list
loopy_sample3 <- function(popn, n, num){
    result3 <- vector("list", num) 
    # Preallocate expected size
    # only difference from above is that output format is a list
    for(i in 1:num){
        result3[[i]] <- myexperiment(popn, n)
    }
    return(result3)
}


## To run "num" iterations of the experiment using vectorization with lapply:
## Outputs a list
lapply_sample <- function(popn, n, num){
    result4 <- lapply(1:num, function(i) myexperiment(popn, n))
    # combines three lines of code from looping example into one
    # the three actions being combined are 
    # 1. creating an empty list/vector (in this case, list) of length num
    # 2. creating a for loop to loop through locations in vector
    # both are replaced by '1:num'
    # 3. running myexperiment function for each location in vector
    #  replaced by function(i) myexperiment(popn, n)
    return(result4)
}

## To run "num" iterations of the experiment using vectorization with sapply:
## Outputs a list
sapply_sample <- function(popn, n, num){
    result5 <- sapply(1:num, function(i) myexperiment(popn, n))
    # identical to above function but sapply outputs vector not list
    return(result5)
}


### generate a population
set.seed(12345) # this will make sure same result is generated every time
popn <- rnorm(10000) # Generate the population
hist(popn) # prints a histogram of population n

### run and time the different funtions

n <- 20 # sample size for each experiment
num <- 1000 # Number of times to rerun the experiment

print("Using loops without preallocation on a vector took:" )
print(system.time(loopy_sample1(popn, n, num)))

print("Using loops with preallocation on a vector took:" )
print(system.time(loopy_sample2(popn, n, num)))

print("Using loops with preallocation on a list took:" )
print(system.time(loopy_sample3(popn, n, num)))

print("Using the vectorized sapply function on a list took:" )
print(system.time(sapply_sample(popn, n, num)))

print("Using the vectorized lapply function on a list took" )
print(system.time(lapply_sample(popn, n, num)))