# Initial genetic drift simulator
sim_genetic_drift <- function(p0 = 0.5, t=10, N=10)
{
  # INITIALIZATION
  
  population <- list()
  length(population) <- t+1 
  # + 1 to account for 10 generations including generation 0
  
  allele.freq <- rep(NA, t+1)
  # keeps track of allele freq over time
  
  k <- ceiling(2*N*p0)
  # At gen 0 there are this many copies of allele 0
  
  population[[1]] <- matrix(sample(c(rep(0,k), rep(1, 2*N-k))), nr=2)
  # shuffle alleles and assign into a 2 by N matrix
  
  allele.freq[1] <- sum(population[[1]]==0)/(2*N)
  # initial allele frequency
  
  # PROPAGATION
  for (i in 1:t) # don't need the +1 this time as we have already calculated the first generation
    {
    population[[i+1]]=matrix(sample(0:1, size = 2*N, prob = c(allele.freq[i], 1-allele.freq[i]), replace = TRUE), nr=2)
    allele.freq[i+1] <- sum(population[[i+1]]==0)/(2*N)
  }
  # OUTPUTS
  return(list(population=population, allele.freq=allele.freq))
}

# modified genetic drift simulator (to find persistence )
sim_genetic_drift <- function(p0 = 0.5, t=10, N=10)
{
  # INITIALIZATION
  
  population <- list()
  length(population) <- t+1 
  # + 1 to account for 10 generations including generation 0
  
  allele.freq <- rep(NA, t+1)
  # keeps track of allele freq over time
  
  k <- ceiling(2*N*p0)
  # At gen 0 there are this many copies of allele 0
  
  population[[1]] <- matrix(sample(c(rep(0,k), rep(1, 2*N-k))), nr=2)
  # shuffle alleles and assign into a 2 by N matrix
  
  allele.freq[1] <- sum(population[[1]]==0)/(2*N)
  # initial allele frequency
  
  # PROPAGATION
  for (i in 1:t) # don't need the +1 this time as we have already calculated the first generation
  {
    population[[i+1]]=matrix(sample(0:1, size = 2*N, prob = c(allele.freq[i], 1-allele.freq[i]), replace = TRUE), nr=2)
    allele.freq[i+1] <- sum(population[[i+1]]==0)/(2*N)
  }
  # OUTPUTS
  return(list(population=population, allele.freq=allele.freq))
}

# monte carlo simulation

result <- rep(NA, 2000)

for (i in 1:length(result))
{
  result[i] <- sim_genetic_drift(p0=0.5, N=200, t=10) $allele.freq[11]
}

