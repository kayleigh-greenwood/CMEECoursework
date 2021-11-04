### for loop, which resizes a vector repeatedly

NoPreallocFun <- function(x){
    # creates a function which takes a number as input
    a <- vector() 
    # empty vector
    for (i in 1:x) {
        # for 1 to inputted number
        a <- c(a, i)
        # updates value of a to a new vector
        # comprising of the old vector, with a new item
        # that item being i, the number for this loop
        # vector is resized in each iteration of the loop
        # more memory has to be allocated each time
        # print(a)
        # print(object.size(a))
        # prints size of vector a
    }
}

system.time(NoPreallocFun(1000))
# checks run time

### pre-allocated vector

# if we pre-allocate a vector that fits all values,
# R doesn't have to reallocate

PreallocFun <- function(x){
    # creates function that takes input of a vector
    a <- rep(NA, x) 
    # pre-allocated vector
    # rep means replicate values in vector 'x'
    # x input of rep is a vector
    # eg rep(8,4) would replicate 8, 4 times
    # so here, 'rep' replicates NA, x amount of times
    # this creates a vector of the same size as the inputted number
    for (i in 1:x) {
        # loops through numbers from 1 to x
        a[i] <- i
        # updates current location in vector with number
        # print(a)
        # print(object.size(a))
        # prints size of vector
    }
}

system.time(PreallocFun(1000))