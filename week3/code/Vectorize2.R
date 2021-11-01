# Runs the stochastic Ricker equation with gaussian fluctuations

rm(list = ls())
# clear the workspace

stochrick <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
# runif structure: runif(n, min, max. creates vector)
{

  N <- matrix(NA, numyears, length(p0))  
  # initialize empty matrix of 'numyears' amount of rows
  # and length(p0) amount of columns

  N[1, ] <- p0  
  # set first row of matrix to p0

  for (pop in 1:length(p0)) { 
  #   # loop through the populations (each column number)

    for (yr in 2:numyears){ 
    # for each pop (row) after 1, loop through the years (columns)

       N[yr, pop] <- N[yr-1, pop] * exp(r * (1 - N[yr - 1, pop] / K) + rnorm(1, 0, sigma)) 
       # To each population in each year, add one fluctuation from normal distribution
    
      }
  
   }
 return(N)

}

print("Non-vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrick()))

# Now write another function called stochrickvect that vectorizes the above to
# the extent possible, with improved performance: 

# write stochrickvect
stochrickvect <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{

  N <- matrix(NA, numyears, length(p0))  
  # initialize empty matrix of 'numyears' amount of rows
  # and length(p0) amount of columns

  N[1, ] <- p0
  # set first row of matrix to p0

  randoms <- rnorm((numyears*p0), 0, sigma)


  for (yr in 2:numyears){ 
  # for each row number from 2 to the end

    N[yr, ] <- N[yr-1, ] * exp(r * (1 - N[yr - 1, ] / K) + randoms[yr]) 
    # the vector for this year is the vector from last year with a function applied
    # To each population in each year, add one fluctuation from normal distribution
  
    }

 return(N)

}

print("Vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrickvect()))