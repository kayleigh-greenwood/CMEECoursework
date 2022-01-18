# CMEE 2021 HPC excercises R code main pro forma
# you don't HAVE to use this but it will be very helpful.  If you opt to write everything yourself from scratch please ensure you use EXACTLY the same function and parameter names and beware that you may loose marks if it doesn't work properly because of not using the proforma.

name <- "Kayleigh Greenwood"
preferred_name <- "Kayleigh"
email <- "kg21@imperial.ac.uk"
username <- "kayleigh-greenwood"

# please remember *not* to clear the workspace here, or anywhere in this file. If you do, it'll wipe out your username information that you entered just above, and when you use this file as a 'toolbox' as intended it'll also wipe away everything you're doing outside of the toolbox.  For example, it would wipe away any automarking code that may be running and that would be annoying!


# Question 1
species_richness <- function(community){
  return (length(unique(community)))
  # return how many unique numbers(species) there are in the vector(community)
}


# Question 2
init_community_max <- function(size){
  return (seq(1,size))
  # create vector representing community with maximum species richness
}

# Question 3
init_community_min <- function(size){
  return (rep(1,size))
  # create vector representing community with minimum species richness
}

# Question 4
choose_two <- function(max_value){
  return (sample(max_value, 2, replace = FALSE))
  # choose two random indexes within the sequence from 1 to max_value
}

# Question 5
neutral_step <- function(community){
  # remove one individual from the community and replace it with the offspring of another
  indexes <- choose_two(length(community))
  # choose which individual to replace and which individual's offspring to replace it
  newcommunity <- community[-(indexes[1])]
  # remove (kill off) the chosen individual from the community
  newcommunity <- append(newcommunity, community[indexes[2]], after=(indexes[1]-1))
  # replace the old individual with the chosen offspring
  community <- newcommunity
  # reset the community variables for the next loop
  return (community)
}


# Question 6
neutral_generation <- function(community){
  if ((length(community)%%2)==0){
    stepspergen <- (length(community)/2)
  } else {
    direction <- sample(c(1,2), 1)
    if (direction==1){
      stepspergen <- ((length(community)/2)+0.5)
    } else {
      stepspergen <- ((length(community)/2)-0.5)
    }
  }
  # determined how many steps are within one generation of the community, depends on size of community
  # the reason a generation is composed of generation/2 amount of steps is that a generation is the amount of time expected between birth and reproduction, not the time between birth and death, which is longer if generations overlap
  # For example, if there are 10 individuals in the system then 5 neutral steps correspond to 5births and 5 deaths, one generation. 
  
  for (i in 1:(stepspergen)){
    community <- neutral_step(community)
    # complete all steps within the generation
  }
  return(community)
}



# Question 7
neutral_time_series <- function(community,duration)  {
  # do a neutral theory simulation and return a time series of species richness in the system
  speciesrichness <- c()
  speciesrichness <- append(speciesrichness, species_richness(community))
  for (i in 1:duration){
    # run simulation
    community <- neutral_generation(community)
    speciesrichness <- append(speciesrichness, species_richness(community))
  }
  return (speciesrichness)
}

# Question 8
question_8 <- function() {
  # answers the following question:
  # What state will the system always converge to if you wait long enough? Why is this?
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  
  community <- init_community_max(100)
  speciesrichness <- neutral_time_series(community, 200)
  
  plot(speciesrichness, type="l", xlab="Generation", ylab="Species Richness", main="Species Richness Over Time")
  return("The system will always converge to a species richness of 1. This will happen so long as speciation is 0. This is because the only possibilities are either; species richness stays the same (if when an individual dies, it is replaced by offspring of its' own species), or species richness declines (when an individual dies, it is replaced by an individual of another species). Because there is always a change that species richness will decrease, this means that species richness will decline over time and eventually, the community will consist of only one species.")
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
  # remove one individual from the community and replace it with a new species

  random <- runif(1, min = 0, max = 1)
  # generate random number between 0 and 1 to determine whether to introduce new species or not
  
  smallestmissing <- function(community){
    `%!in%` <- Negate(`%in%`)
    for (i in (1:(max(community)+1))){
      if (i %!in% community){
        return (i)
      }
    }
  }  
  if (random <= speciation_rate){
    index <- sample(length(community), 1)
    # choose which individual to replace
  
    newcommunity <- community[-(index)]
    # remove (kill off) the chosen individual from the community
    
    newcommunity <- append(newcommunity, smallestmissing(community), after=((index)-1))
    # replace the old individual with the chosen offspring

  } else {
    indexes <- choose_two(length(community))
    # choose which individual to replace and which individual's offspring to replace it
    
    newcommunity <- community[-(indexes[1])]
    # remove (kill off) the chosen individual from the community
    
    newcommunity <- append(newcommunity, community[indexes[2]], after=(indexes[1]-1))
    # replace the old individual with the chosen offspring
  }
  
  community <- newcommunity
  return (community)
}

# Question 10
neutral_generation_speciation <- function(community,speciation_rate)  {
  if ((length(community)%%2)==0){
    stepspergen <- (length(community)/2)
  } else {
    direction <- sample(c(1,2), 1)
    if (direction==1){
      stepspergen <- ((length(community)/2)+0.5)
    } else {
      stepspergen <- ((length(community)/2)-0.5)
    }
  }
  # determined how many steps are within one generation of the community, depends on size of community
  # the reason a generation is composed of generation/2 amount of steps is that a generation is the amount of time expected between birth and reproduction, not the time between birth and death, which is longer if generations overlap
  # For example, if there are 10 individuals in the system then 5 neutral steps correspond to 5births and 5 deaths, one generation. 
  
  for (i in 1:(stepspergen)){
    community <- neutral_step_speciation(community, speciation_rate)
    # complete all steps within the generation
  }
  return(community)
}

# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  # do a neutral theory simulation and return a time series of species richness in the system
  speciesrichness <- c()
  speciesrichness <- append(speciesrichness, species_richness(community))
  for (i in 1:duration){
    # run simulation
    community <- neutral_generation_speciation(community, speciation_rate)
    speciesrichness <- append(speciesrichness, species_richness(community))
  }
  return (speciesrichness)
}

# Question 12
question_12 <- function()  {
  # answers the following question:
  # Explain what you found from this plot about the effect of initial conditions. 
  # Why does the neutral model simulation give you those particular results?”
  graphics.off()
  
  community1 <- init_community_max(100)
  community2 <- init_community_min(100)

  speciesrichness1 <- neutral_time_series_speciation(community1, 0.1, 200)
  speciesrichness2 <- neutral_time_series_speciation(community2, 0.1, 200)

  plot(speciesrichness1, type="l", col="green", xlab="Generation", ylab="Species Richness", main="Species Richness Over Time")
  lines(speciesrichness2, type="l", col="orange")
  legend("topright", legend=c("init_community_max", "init_community_min"), fill =c("green", "orange"))
  return("In this model, there are two aspects being specified in the initial conditions. The first is the community. This model shows two situations at the extremes of species richness within the community. This plot shows that the initial species richness of a community has little to no effect on species richness, as eventually species richness will reach a dynamic equilibrium (determined by speciation), regardless of the species richness of the initial population. This also means that the size of the community has no effect on the eventual species richness of the community. The second is speciation, which is what determines how species richness behaves over time for a community. The speciation rate set for a community determines the level at which the species richness will eventually come to a dynamic equilibrium around. The higher the speciation rate, the higher the eventual species richness dynamic equilibrium of that community. Without speciation, Species richness will converge to 1 regardless of initial species richness. Both a community with maximal initial species richness, and one with minimal initial species richness, will reach the same dynamic equilibrium after a few generations, if they have the same speciation rate. ")
}

# Question 13
species_abundance <- function(community)  {
  return (sort((as.data.frame(table(community)))$Freq, decreasing=TRUE))
  # turns community into frequency table to obtain frequencies, then data frame so that only frequencies can be accessed
  # then sorts in decreasing numerical order
}

# Question 14
octaves <- function(abundance_vector) {
  
  # determine how many bins there will be for this vector
  numbins <- ceiling(log(max(abundance_vector))/log(2))
  
  # create the bin slots (eg 1,2,4,8,16)
  bins <- c(1)
  for (i in (2:(numbins+1))){
    bins <- append(bins, bins[i-1]*2)
  }
  
  # create output vector
  output <- rep(0, numbins)
  for (x in 1:length(abundance_vector)){
    for (y in 1:length(bins)){
      if ((abundance_vector[x] < bins[y]) && (abundance_vector[x] >= bins[y-1])){
        output[y-1] = output[y-1]+1
      }
    }
  }
  return (output)
}

# Question 15
sum_vect <- function(x, y) {
  # fill the shorter vector with zeros
  maxlength <- max(c(length(x), length(y)))
  if (length(x) > length(y)){
    diff <- length(x) - length(y)
    y = append(y, rep(0, diff))
  }else{
    diff <- length(y) - length(x)
    x = append(x, rep(0, diff))
  }
  
  # add the vectors
  summedvects <- x + y
  return (summedvects)
}

# Question 16 
question_16 <- function()  {
  graphics.off()
  
  communitysize <- 100
  # create community
  community1 <- init_community_max(communitysize)
  community2 <- init_community_min(communitysize)
  
  # run for first 200 generations
  speciation_rate <- 0.1
  
  for (i in 1:200){
    community1 <- neutral_generation_speciation(community1, speciation_rate)
    community2 <- neutral_generation_speciation(community2, speciation_rate)
  }
  
  # produce octave vector after first 200 generations
  oct_vect1 <- octaves(species_abundance(community1))
  oct_vect2 <- octaves(species_abundance(community2))
  
  # run 2000 more generations but stop to record octave vector every 20 generations
  for (i in 1:100){
    for (i in 1:20){
      community1 <- neutral_generation_speciation(community1, speciation_rate)
      community2 <- neutral_generation_speciation(community2, speciation_rate)
    }
    oct_vect1 <- sum_vect(oct_vect1, octaves(species_abundance(community1)))
    oct_vect2 <- sum_vect(oct_vect2, octaves(species_abundance(community2)))
    
  }

  # create mean
  oct_vect_mean1 <- oct_vect1/101
  oct_vect_mean2 <- oct_vect2/101
  
  # create bar names for first community
  
  largest_oct_vect_length <- max(length(oct_vect_mean1), length(oct_vect_mean2))
  #check which community is largest
  
  binstartingvals <- c(1)
  for (i in (2:largest_oct_vect_length)){
    binstartingvals <- append(binstartingvals, binstartingvals[i-1]*2)
  }
  binnames <- c()
    for (i in (1:largest_oct_vect_length)){
      binnames <- append(binnames, paste(binstartingvals[i], "≤ x <", 2*binstartingvals[i]))
    }

  
  # work out ylim
  allvalues <- append(oct_vect_mean1, oct_vect_mean2)
  limit <- max(allvalues)
  
  # put groups into table
  mydf1 <-t(oct_vect_mean1)
  mydf2 <-t(oct_vect_mean2)
  mydf <- rbind(mydf1, mydf2)
  mymatrix <- as.matrix(mydf)
  
  
  # overlaying barplots
  barplot(mymatrix, beside = TRUE, names.arg=binnames, main= "Mean Species Abundance Distribution", xlab = "Species Abundance (Individuals per species)", ylab = "Frequency (number of species)", ylim = c(0,(limit)*1.1), xpd = FALSE, col = c("palegreen", "orchid"), border = c("palegreen4", "orchid4"), width = 2) 
  # barplot(oct_vect_mean2, names.arg=binnames2, xpd = FALSE, col = "orchid", border = "orchid4", add=TRUE, width = 1, space = c(1.5, rep(2, length(binnames2)-1))) 
  legend("topright", legend=c("Initial maximal species richness", "Initial minimal species richness"), fill =c("palegreen", "orchid"))
  
  return ("The initial size of a community does not influence the pattern of frequency within each species abundance octave class, but frequency does increase as community increases. The number of individuals in a community influences the abundance of species with only one individual. An observed pattern is that the number of species with only one individual is usually around 10% of the community size.  A pattern is also seen in species abundance in that the lower species abundance is, the more species there are with that species abundance. 
           The initial speciation rate has a demonstrable effect on species abundance. Species rate seems to determine the distribution of species abundances. The higher the speciation rate, the higher the species diversity and therefore the individuals are distributed amongst more species, meaning species abundances are lower. The higher speciation rate gets, the more right skewed species abundance gets. The speciation rate determines the percentage of species that contain only one individual. For example, if speciation rate is 0.1, 10% of the species abundances will be 1. Therefore 10% of the community will be in their own unique species. Increasing speciation rate eradicates the higher species abundances. So speciation rate also affects the upper limit of species abundance. 
           The initial species richness has litle to no effect on eventual species abundance, especially after 2200 generations. Both species abundances displayed the same patterns at the same frequencies when in the same initial conditions.")
}

# Question 17
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name)  {
  ptm <- proc.time()[3]
  community <- init_community_min(size)
  counter = 0
  speciesrichness <- c()
  abundanceoctaves <- list()
  
  while (((proc.time()[3])-ptm) < (wall_time*60)) {
    counter = counter + 1
    community <- neutral_generation_speciation(community, speciation_rate)
    
    if (((counter %% interval_rich)==0) && (counter <= burn_in_generations)){
      speciesrichness <- append(speciesrichness, species_richness(community))
    }
    
    if ((counter %% interval_oct) == 0){
      abundanceoctaves <- append(abundanceoctaves, list(octaves(species_abundance(community))))
    }
  }
  elapsedtime <- (proc.time()[3]-ptm)
  save(speciesrichness, abundanceoctaves, community, elapsedtime, speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, file = output_file_name)
}

# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster
# personal speciation rate: 0.0066439
# Question 20 
process_cluster_results <- function()  {
  combined_results <- list() #create your list output here to return
  # save results to an .rda file
  
}

plot_cluster_results <- function()  {
    # clear any existing graphs and plot your graph within the R window
    # load combined_results from your rda file
    # plot the graphs
    
    return(combined_results)
}

# Question 21
question_21 <- function()  {
    
  return("type your written answer here")
}

# Question 22
question_22 <- function()  {
    
  return("type your written answer here")
}

# Question 23
chaos_game <- function()  {
  # clear any existing graphs and plot your graph within the R window
  
  return("type your written answer here")
}

# Question 24
turtle <- function(start_position, direction, length)  {
    
  return() # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position, direction, length)  {
  
}

# Question 26
spiral <- function(start_position, direction, length)  {
  
  return("type your written answer here")
}

# Question 27
draw_spiral <- function()  {
  # clear any existing graphs and plot your graph within the R window
  
}

# Question 28
tree <- function(start_position, direction, length)  {
  
}

draw_tree <- function()  {
  # clear any existing graphs and plot your graph within the R window

}

# Question 29
fern <- function(start_position, direction, length)  {
  
}

draw_fern <- function()  {
  # clear any existing graphs and plot your graph within the R window

}

# Question 30
fern2 <- function(start_position, direction, length, dir)  {
  
}
draw_fern2 <- function()  {
  # clear any existing graphs and plot your graph within the R window

}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Challenge_A <- function() {
  # clear any existing graphs and plot your graph within the R window

}

# Challenge question B
Challenge_B <- function() {
  # clear any existing graphs and plot your graph within the R window

}

# Challenge question C
Challenge_C <- function() {
  # clear any existing graphs and plot your graph within the R window

}

# Challenge question D
Challenge_D <- function() {
  # clear any existing graphs and plot your graph within the R window
  
  return("type your written answer here")
}

# Challenge question E
Challenge_E <- function() {
  # clear any existing graphs and plot your graph within the R window
  
  return("type your written answer here")
}

# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  
  return("type your written answer here")
}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.


