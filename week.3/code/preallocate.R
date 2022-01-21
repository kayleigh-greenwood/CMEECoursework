#########################################################
# Compares times of pre-allocation to no pre-allocation #
#########################################################

### for loop, which resizes a vector repeatedly ###

# defines function NoPreallocFun
NoPreallocFun <- function(x){
    # creates a function which takes one argument(x)
    a <- vector() 
    # empty vector


    for (i in 1:x) {
        # for each number in the inclusive sequence of 1 to inputted number 'x'
        a <- c(a, i)
        # uses concatenate to append i to vector 'a'
        # vector is resized in each iteration of the loop, more memory has to be allocated each time

        print(a)
        print(object.size(a))
        # prints size of vector a
    }
}

# checks run time of NoPreallocFun
system.time(NoPreallocFun(1000))


### pre-allocated vector ###

# if we pre-allocate a vector that fits all values,
# R doesn't have to reallocate

# defines function PreallocFun
PreallocFun <- function(x){
    a <- rep(NA, x) 
    # pre-allocated vector
    # rep means replicate value 'NA' , 'x' amount of times
    # this creates a vector of the same size as the inputted number
    for (i in 1:x) {
        # inclusive loops (including x)
        a[i] <- i
        # updates each location in a with it's index number
        print(a)
        print(object.size(a))
        # prints size of vector 'a'
    }
}

# checks function PreallocFun
system.time(PreallocFun(1000))