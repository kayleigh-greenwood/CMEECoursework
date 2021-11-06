### if statements ###

# multi-line #

a <- TRUE 
# sets 'a' variable as TRUE
if (a == TRUE){
    # prints boolean state of a
    print ("a is TRUE")
    } else {
    print ("a is FALSE")
}

# single line #

z <- runif(1) 
# generate and store in 'z' 1 uniformly distributed random number 
if (z <= 0.5) {
    # run statement if the generated number is less than 0.5
    print("Less than half")
}

### for loops ###

# loop over sequence
for (i in 1:10){ 
    # generates inclusive sequence (1 and 10 included)
    j <- i * i
    # sets j as the square of i
    print(paste(i, " squared is", j))
    # prints the square of every number in the sequence
}

# loop over vector

for(species in c('Heliodoxa rubinoides', 'Boissonneaua jardini', 'Sula nebouxii')){
    # run loop for every item in that vector and set it as 'species'
    print(paste('The species is', species))
}

# loop over pre-existing vector

v1 <- c("a","bc","def")
# generate vector of strings
for (i in v1){
    # loop over items in vector, setting them as 'i'
    print(i)
}

### while loops ###

i <- 0
while (i < 10){
    i <- i+1
    # increment i by 1 until it reaches 10
    print(i^2)
    # print the square of i
}