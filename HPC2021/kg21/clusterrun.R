rm(list=ls())
graphics.off()
source("kg21_HPC_2021_main.R")

# read in the job number from the cluster:
iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
# job number for own computer:
# iterlist <- seq(100)

set.seed(iter)
# ensures each iteration generates different random numbers

# community sizes : 500,1000,2500,5000
# personal speciation rate: 0.0066439
speciation_rate <- 0.0066439

# set size depending on iter
  if (iter %% 4 == 1){
    size <- 500
  } else if (iter %% 4 == 2){
      size <-1000
  } else if (iter %% 4 == 3){
      size <- 2500
  } else if (iter %% 4 == 0){
    size <- 5000
}


cluster_run(speciation_rate, size, wall_time=1, interval_rich=1, interval_oct = (size/10), burn_in_generations = (8*size), output_file_name = paste("resultiter", iter, ".rda", sep=""))




