### if statements

a <- TRUE 
if (a == TRUE){
    print ("a is TRUE")
    } else {
    print ("a is FALSE")
}


### single line if statement

z <- runif(1) ## generate a uniformly distributed random number 
if (z <= 0.5) {
    print("Less than half")
}

### for loops

for (i in 1:10){ # generates includive sequence
    j <- i * i
    print(paste(i, " squared is", j))
}

### for loop over vector

for(species in c('Heliodoxa rubinoides', 'Boissonneaua jardini', 'Sula nebouxii')){
    print(paste('The species is', species))
}

### for loop using pre-existing vector

v1 <- c("a","bc","def")
for (i in v1){
    print(i)
}

### while loops

i <- 0
while (i < 10){
    i <- i+1
    print(i^2)
}