# Runs the stochastic Ricker equation with gaussian fluctuations


##########################################################
###################### stochrick #########################
##########################################################

### clear the workspace ###
rm(list = ls())

### define function ###
stochrick <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
# defines function 'stochrick' with 5 arguments
  # p0 is vector of 1000 random numbers between 0.5 and 1.5
  # runif structure: runif(n, min, max. creates vector)
{

  N <- matrix(NA, numyears, length(p0))  
  # initialize empty matrix of 'numyears' amount of rows
  # and length(p0) amount of columns

  N[1, ] <- p0  
  # set first row of matrix to sequence of random numbers generated in p0

  for (pop in 1:length(p0)) { 
  # loop through numbers from 1 to length of p0. 
  # Will help to loop through the populations(as lenght of p0 is same as the amount of columns)
  # But doesn't loop through them directly, 'pop' is used to index at each iteration of the loop

    for (yr in 2:numyears){ 
    # loop through numbers from 2 to numyears
    # Will help to loop through the years of each population (as numyears is the same as the amount of rows)
    # But doesn't loop through rows directly, 'yr' is used to index at each iteration of the loop

       N[yr, pop] <- N[yr-1, pop] * exp(r * (1 - N[yr - 1, pop] / K) + rnorm(1, 0, sigma)) 
       # To each population in each year, add one fluctuation from normal distribution
    
      }
  
   }
 return(N)

}

### print time taken ###
print("Non-vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrick()))


##########################################################
#################### stochrickvect #######################
##########################################################

### instructions ###

# Now write another function called stochrickvect that vectorizes the above to
# the extent possible, with improved performance: 

### define function ###

stochrickvect <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{
# defines function 'stochrickvect' with 5 arguments
  # p0 is vector of 1000 random numbers between 0.5 and 1.5
  # runif structure: runif(n, min, max. creates vector)

  N <- matrix(NA, numyears, length(p0))  
  # initialize empty matrix of 'numyears' amount of rows
  # and length(p0) amount of columns

  N[1, ] <- p0
  # set first row of matrix to sequence of random numbers generated in p0

  randoms <- rnorm(numyears, 0, sigma)
  # generate one random number per row (as we are applying the whole function to the vector of each row 
  # so only need one random number per row instead of one per item per row)

  for (yr in 2:numyears){ 
  # loops through numbers from 2 to numyears
  # will help loop through years (as numyears is same as the amount of rows/years)
  # But doesn't loop through rows directly, 'yr' is used to index at each iteration of the loop

    N[yr, ] <- N[yr-1, ] * exp(r * (1 - N[yr - 1, ] / K) + randoms[yr]) 
    # as opposed to stochrick, because of the for loop in this equation, 'yr'
    # the vector for this year is the vector from last year with a function applied
    # To each population in each year, add one fluctuation from normal distribution
  
    }

 return(N)

}


### print time taken ###
print("Vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrickvect()))
