Ricker <- function(N0=1, r=1, K=10, generations=50)
{
  # Runs a simulation of the Ricker model
  # Returns a vector of length generations
  
  N <- rep(NA, generations)    
  # Creates a vector of NA, repeated 'generations' times
  
  N[1] <- N0 
  # sets the value of the first item in vector N, which is input as an argument
  for (t in 2:generations)
  # loops from 2 to generations
  {
    N[t] <- N[t-1] * exp(r*(1.0-(N[t-1]/K)))
    # perform the ricker equation to update N
  }
  return (N)
}

plot(Ricker(generations=10), type="l")


# notes 
# difference equation, not differential equation
# discrete time equation
# updating the value of a variable with respect to what its value was in a previous time step
# r is growth rate parameter
# taking value from particular time step, mlutiplying by growth factor and ...
# simulating this equation in the script
# function takes value of pop at time 0, assigns values incase values arent passed to the function and it can be run wihtout arguments
# rep function used for preallocation to create empty vector containing NAs, has address in memory and ready to receive information
# N[t] line is the replication of the equation within the scri[t]
# returns n, then plots r
# gives figure
# says index because as default it has assumed they are values in a vector

# k can fluctuate as many things can affect carrying capacity
# r (growth rate) could fluctuate. r is the same as fitness of the population
# r is a property of the organism. hiw fast can it grow with no constraints? will fluctuate with temperature, and other factors. 
# we are taking r and multiplying it by k which accoutns for competition
# N can fluctuate. migration can affect N. density-independent-death can affect N (eg lightening hits the population)