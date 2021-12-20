# CMEE 2021 HPC excercises R code main pro forma

name <- "Kayleigh Greenwood"
preferred_name <- "Kayleigh"
email <- "kg21@imperial.ac.uk"
username <- "kg21"

# Question 1
species_richness <- function(community){
  return (length(unique(community)))
  # return how many unique numbers(species) there are in the vector(community)
}


# Question 2
init_community_max <- function(size){
  return (seq(1,size))
  # create vector representing community with maximum species richness (no two individuals are of the same species)
}

# Question 3
init_community_min <- function(size){
  return (rep(1,size))
  # create vector representing community with minimum species richness (all individuals are of the same species)
}

# Question 4
choose_two <- function(max_value){
  return (sample(max_value, 2, replace = FALSE))
  # choose two independent (cant choose same twice) random indexes within the sequence from 1 to max_value
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
  
  return (newcommunity)
}


# Question 6
neutral_generation <- function(community){
  
  # determined how many steps are within one generation of the community (depends on size of community)
  if ((length(community)%%2)==0){
    stepspergen <- (length(community)/2)
    # if there are an even number of individuals, this can be divided by 2 to get steps
  } else {
    # if there are an odd number of individuals, this must be rounded to an integer to get a whole number of steps
    direction <- sample(c(1,2), 1)
    # will sample 2 outcomes both with a 50% chance
    if (direction==1){
      # so half of the time, steps is rounded up
      stepspergen <- ((length(community)/2)+0.5)
    } else {
      # and half of the time, steps is rounded down
      stepspergen <- ((length(community)/2)-0.5)
    }
  }
  # the reason a generation is composed of community/2 amount of steps is that a generation is the amount of time expected between birth and reproduction, not the time between birth and death, which is longer if generations overlap
  # For example, if there are 10 individuals in the system then 5 neutral steps correspond to 5 births and 5 deaths, one generation. 
  
  for (i in 1:(stepspergen)){
    community <- neutral_step(community)
    # perform neutral_step to redefine community for all steps within the generation
  }
  return(community)
  # returns the state of the community once one generation has passed
}



# Question 7
neutral_time_series <- function(community,duration)  {
  # do a neutral theory simulation for 'duration' amount of generations, and return a time series of species richness in the system
  
  speciesrichness <- c(species_richness(community))
  # store species richness of initial community

  for (i in 1:duration){
    community <- neutral_generation(community)
    # update community every generation
    speciesrichness <- append(speciesrichness, species_richness(community))
    # store new species richness of this community every generation
  }
  return (speciesrichness)
}

# Question 8
question_8 <- function() {
  graphics.off()
  
  community <- init_community_max(100)
  # initialize community of maximum species richness
  
  speciesrichness <- neutral_time_series(community, 200)
  # record species richness every generation for 200 generations
  
  plot(speciesrichness, type="l", xlab="Generation", ylab="Species Richness", main="Species Richness Over Time")
  # plot the species richness over the 200 generations
  
  return("The system will always converge to a species richness of 1. This will happen so long as speciation is 0. This is because the only possibilities are either; species richness stays the same (if when an individual dies, it is replaced by offspring of its' own species), or species richness declines (when an individual dies, it is replaced by an individual of another species). Because there is always a change that species richness will decrease, this means that species richness will decline over time and eventually, the community will consist of only one species.")
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
  # remove one individual from the community and replace it with a new species

  random <- runif(1, min = 0, max = 1)
  # generate random number between 0 and 1 to determine whether to introduce new species or not
  
  if (random <= speciation_rate){
    # if the random number is below speciation rate, a new species is introduced
    
    # choose ID number for new species by finding out the lowest ID number not being used currently
    # avoids numbers ending up in the thousands, and makes it easier to judge the total amount of species at a glance
    smallestmissing <- function(community){
      `%!in%` <- Negate(`%in%`)
      # define a 'not in' operator
      for (i in (1:(max(community)+1))){
        # loops through numbers from 1 until the number above the highest in community currently
        if (i %!in% community){
          # as soon as one not being used is found, it is returned
          return (i)
        }
      }
    } 

    index <- sample(length(community), 1)
    # choose which individual to replace
  
    newcommunity <- community[-(index)]
    # remove (kill off) the chosen individual from the community
    
    newcommunity <- append(newcommunity, smallestmissing(community), after=((index)-1))
    # replace the old individual with the chosen offspring

  } else {
    # if the random number is above the speciation rate, replace with species already in community
    indexes <- choose_two(length(community))
    # choose which individual to replace and which individual's offspring to replace it
    
    newcommunity <- community[-(indexes[1])]
    # remove (kill off) the chosen individual from the community
    
    newcommunity <- append(newcommunity, community[indexes[2]], after=(indexes[1]-1))
    # replace the old individual with the chosen offspring
  }
  
  return (newcommunity)
}

# Question 10
neutral_generation_speciation <- function(community,speciation_rate)  {
  
  # determined how many steps are within one generation of the community (depends on size of community)
  if ((length(community)%%2)==0){
    # if there are an even number of individuals, community can be divided by 2 to get steps per generation
    stepspergen <- (length(community)/2)
    
  } else {
    # if there are an odd number of individuals, this must be rounded to an integer to get a whole number of steps
    
    direction <- sample(c(1,2), 1)
    # will sample 2 outcomes both with a 50% chance
    
    if (direction==1){
      # so half of the time, steps is rounded up
      stepspergen <- ((length(community)/2)+0.5)
      
    } else {
      # and half of the time, steps is rounded down
      stepspergen <- ((length(community)/2)-0.5)
    }
  }

  # use steps to determine how ma ny times to loop
  for (i in 1:(stepspergen)){
    community <- neutral_step_speciation(community, speciation_rate)
    # perform neutral_step_speciation to redefine community for all steps within the generation, now with a chance of speciation
  }
  
  return(community)
  # returns the state of the community once one generation has passed
  
}

# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  # do a neutral theory simulation for 'duration' amount of generations and return a time series of species richness in the system
  
  speciesrichness <- c(species_richness(community))
  # store species richness of initial community
  
  for (i in 1:duration){
    # loop for prefefined amount of generations
    
    community <- neutral_generation_speciation(community, speciation_rate)
    # update community every generation
    
    speciesrichness <- append(speciesrichness, species_richness(community))
    # store species richness ofthe new community every generation
    
  }
  return (speciesrichness)
}

# Question 12
question_12 <- function()  {
  graphics.off()
  
  # initialize communities with maximal and minimal species richness
  community1 <- init_community_max(100)
  community2 <- init_community_min(100)

  # create a time series of species richness over 200 generations for each community
  speciesrichness1 <- neutral_time_series_speciation(community1, 0.1, 200)
  speciesrichness2 <- neutral_time_series_speciation(community2, 0.1, 200)

  # plot the two changes in species richness together
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
  num_bins <- floor(log(max(abundance_vector))/log(2))+1
  
  # create the bin slots (eg 1,2,4,8,16)
  bins <- c(1)
  for (i in 2:(num_bins+1)){
    bins <- append(bins, bins[i-1]*2)
  }
  
  # pre-allocate 'output
  output <- rep(0, length(bins)-1)
  
  # create output (octave abundance vector)
  for (x in 1:(length(abundance_vector))){
    # loop with x to access corresponding contents in abundance_vector
    for (y in (1:(length(bins)))){
      # loop with  y to access corresponding contents in bins vector
      if ((abundance_vector[x] >= bins[y]) && (abundance_vector[x] < bins[y+1])){
        # determine which bin each value belongs in
        output[y] <- output[y]+1
        # increase value of that bin by one
      }
    }
  }
  
  return(output) 
}

# Question 15
sum_vect <- function(x, y) {
  # fill the shorter vector with zeros
  
  # determine which vector is longest
  maxlength <- max(c(length(x), length(y)))
  
  if (length(x) > length(y)){
    # if x is longer, fill the rest of y with zeros
    
    diff <- length(x) - length(y)
    y <- append(y, rep(0, diff))
  }else{
    # if y is longer, fill the rest of x with zeros
    
    diff <- length(y) - length(x)
    x <- append(x, rep(0, diff))
  }
  
  # add the vectors
  summedvects <- x + y
  return (summedvects)
}

# Question 16 
question_16 <- function()  {
  graphics.off()
  
  # create communities
  community1 <- init_community_max(100)
  community2 <- init_community_min(100)
  
  # run for first 200 generations
  speciation_rate <- 0.1
  
  for (i in 1:200){
    # update community each generation for 200 generation
    # produces community state at 200th generation
    community1 <- neutral_generation_speciation(community1, speciation_rate)
    community2 <- neutral_generation_speciation(community2, speciation_rate)
  }
  
  # produce octave vector after 200 generations
  oct_vect1 <- octaves(species_abundance(community1))
  oct_vect2 <- octaves(species_abundance(community2))
  
  # run 2000 more generations but stop to record octave vector every 20 generations
  for (i in 1:100){
    for (i in 1:20){
      # update community every generation
      community1 <- neutral_generation_speciation(community1, speciation_rate)
      community2 <- neutral_generation_speciation(community2, speciation_rate)
    }
    # but only every 20 generations, record species abundance octaves and add onto running sum
    oct_vect1 <- sum_vect(oct_vect1, octaves(species_abundance(community1)))
    oct_vect2 <- sum_vect(oct_vect2, octaves(species_abundance(community2)))
  }

  # create mean of octaves
  oct_vect_mean1 <- oct_vect1/101
  oct_vect_mean2 <- oct_vect2/101
  
  #check which community is largest so that sufficient bin names are produced
  largest_oct_vect_length <- max(length(oct_vect_mean1), length(oct_vect_mean2))
  
  # create bin names
  binstartingvals <- c(1)
  for (i in (2:largest_oct_vect_length)){
    # starts at two because each value is dependent on the bin before it
    binstartingvals <- append(binstartingvals, binstartingvals[i-1]*2)
    # creates vector of each starting value
  }
  binnames <- c()
    for (i in (1:largest_oct_vect_length)){
      # for each starting value, the full bine name is created
      binnames <- append(binnames, paste(binstartingvals[i], "≤ x <", 2*binstartingvals[i]))
    }

  
  # work out highest point on y axis
  allvalues <- append(oct_vect_mean1, oct_vect_mean2)
  limit <- max(allvalues)
  
  # put groups into matrix so that they can be plotted together
  mydf1 <-t(oct_vect_mean1)
  mydf2 <-t(oct_vect_mean2)
  mydf <- rbind(mydf1, mydf2)
  mymatrix <- as.matrix(mydf)
  
  
  # overlaying barplots
  barplot(mymatrix, beside = TRUE, names.arg=binnames, main= "Mean Species Abundance Distribution", xlab = "Species Abundance (Individuals per species)", ylab = "Frequency (number of species)", ylim = c(0,(limit)*1.1), xpd = FALSE, col = c("green", "orange"), border = c("green4", "orange4"), width = 2) 
  legend("topright", legend=c("Initial maximal species richness", "Initial minimal species richness"), fill =c("green", "orange"))
  
  return ("The initial size of a community does not influence the pattern of frequency within each species abundance octave class, but frequency does increase as community increases. The number of individuals in a community influences the abundance of species with only one individual. An observed pattern is that the number of species with only one individual is usually around 10% of the community size.  A pattern is also seen in species abundance in that the lower species abundance is, the more species there are with that species abundance. 
           The initial speciation rate has a demonstrable effect on species abundance. Species rate seems to determine the distribution of species abundances. The higher the speciation rate, the higher the species diversity and therefore the individuals are distributed amongst more species, meaning species abundances are lower. The higher speciation rate gets, the more right skewed species abundance gets. The speciation rate determines the percentage of species that contain only one individual. For example, if speciation rate is 0.1, 10% of the species abundances will be 1. Therefore 10% of the community will be in their own unique species. Increasing speciation rate eradicates the higher species abundances. So speciation rate also affects the upper limit of species abundance. 
           The initial species richness has litle to no effect on eventual species abundance, especially after 2200 generations. Both species abundances displayed the same patterns at the same frequencies when in the same initial conditions.")
}

# Question 17
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name)  {
  ptm <- proc.time()[3]
  community <- init_community_min(size)
  counter <- 0
  speciesrichness <- c()
  abundanceoctaves <- list()
  
  while (((proc.time()[3])-ptm) < (wall_time*60)) {
    counter <- counter + 1
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

# Question 20 

process_cluster_results <- function()  {
  
  # initialise empty vectors for octave sums for each communtity size
  sumoct500 <- c()
  sumoct1000 <- c()
  sumoct2500 <- c()
  sumoct5000 <- c()
  
  
  for (i in 1:100){
    # loop once for each result file
      load(file=paste("results/resultiter", i, ".rda", sep=""))
    
      equil_threshold <- burn_in_generations/interval_oct
      # gives the last index of oct that is part of the burn in generation
      
      abundanceoctaves <- abundanceoctaves[(equil_threshold+1):length(abundanceoctaves)]
      # filters out data before burn in generations (hoping that equilibrium will hav been reached by now)
      
      sumoct <- c(abundanceoctaves[[1]])
      # initialise the octave sum of this file using the first entry
      
      for (i in 2:length(abundanceoctaves)){ 
        # start from 2 as first entry has already been entered
        sumoct <- sum_vect(sumoct, abundanceoctaves[[i]])
        # add second octave to current octave, and so on to obtain a sum for all 100
      }
      meanoct <- sumoct/length(abundanceoctaves)
      # creates a mean octave vector for all those in this iteration
      
      # assign this mean octave to the corresponding sum variable depending on community size
      if (size == 500){
      sumoct500 <- sum_vect(sumoct500, meanoct)
    } else if (size == 1000) {
      sumoct1000 <- sum_vect(sumoct1000, meanoct)
    } else if (size == 2500) {
      sumoct2500 <- sum_vect(sumoct2500, meanoct)
    } else if (size == 5000) {
      sumoct5000 <- sum_vect(sumoct5000, meanoct)
    } 
  }  
  
  # creates a mean from all sums
  meanoct500 <- sumoct500/25
  meanoct1000 <- sumoct1000/25
  meanoct2500 <- sumoct2500/25
  meanoct5000 <- sumoct5000/25

  combined_results <- list(meanoct500, meanoct1000, meanoct2500, meanoct5000) 
  # combines all means into one variable in order to save
  
  # save results to a .rda file
  save(combined_results, file = "cluster_octave_results.rda")
}
  
plot_cluster_results <- function()  {
  
    graphics.off()
  
    # load combined_results from your rda file
    load(file = "cluster_octave_results.rda")
    
    # re-split the data according to communtiy size
    size500data <- combined_results[[1]]
    size1000data <- combined_results[[2]]
    size2500data <- combined_results[[3]]
    size5000data <- combined_results[[4]]

    
    # determine bin names for size 500
    binstartingvals500 <- c(1)
    for (i in (2:length(size500data))){
      binstartingvals500 <- append(binstartingvals500, binstartingvals500[i-1]*2)
    }
    binnames500 <- c()
    for (i in (1:length(size500data))){
      binnames500 <- append(binnames500, paste(binstartingvals500[i], "≤ x <", 2*binstartingvals500[i]))
    }
    
    # determine bin names for size 1000
    binstartingvals1000 <- c(1)
    for (i in (2:length(size1000data))){
      binstartingvals1000 <- append(binstartingvals1000, binstartingvals1000[i-1]*2)
    }
    binnames1000 <- c()
    for (i in (1:length(size1000data))){
      binnames1000 <- append(binnames1000, paste(binstartingvals1000[i], "≤ x <", 2*binstartingvals1000[i]))
    }
    
    # determine bin names for size 2500
    binstartingvals2500 <- c(1)
    for (i in (2:length(size2500data))){
      binstartingvals2500 <- append(binstartingvals2500, binstartingvals2500[i-1]*2)
    }
    binnames2500 <- c()
    for (i in (1:length(size2500data))){
      binnames2500 <- append(binnames2500, paste(binstartingvals2500[i], "≤ x <", 2*binstartingvals2500[i]))
    }
    
    # determine bin names for size 5000
    binstartingvals5000 <- c(1)
    for (i in (2:length(size5000data))){
      binstartingvals5000 <- append(binstartingvals5000, binstartingvals5000[i-1]*2)
    }
    binnames5000 <- c()
    for (i in (1:length(size5000data))){
      binnames5000 <- append(binnames5000, paste(binstartingvals5000[i], "≤ x <", 2*binstartingvals5000[i]))
    }
    
    # initialise multi paneled plot
    par(mfcol=c(2,2))
    
    # plot size 500 
    par(mfg=c(1,1))
    barplot(size500data, names.arg = binnames500, ylim=c(0,(1.1*(max(size500data)))), main= "Mean Species Abundance Distribution for Community Size 500", xlab = "Species Abundance (Individuals per species)", ylab = "Frequency (number of species)")
    
    # plot size 1000
    par(mfg=c(1,2))
    barplot(size1000data, names.arg = binnames1000, ylim=c(0,(1.1*(max(size1000data)))), main= "Mean Species Abundance Distribution for Community Size 1000", xlab = "Species Abundance (Individuals per species)", ylab = "Frequency (number of species)")
    
    # plot size 2500
    par(mfg=c(2,1))
    barplot(size2500data, names.arg = binnames2500, ylim=c(0,(1.1*(max(size2500data)))), main= "Mean Species Abundance Distribution for Community Size 2500", xlab = "Species Abundance (Individuals per species)", ylab = "Frequency (number of species)")
    
    # plot size 5000
    par(mfg=c(2,2))
    barplot(size5000data, names.arg = binnames5000, ylim=c(0,(1.1*(max(size5000data)))), main= "Mean Species Abundance Distribution for Community Size 5000", xlab = "Species Abundance (Individuals per species)", ylab = "Frequency (number of species)")
    
    
    return(combined_results)
}

# Question 21
question_21 <- function()  {
  width <- 3
  size <- 8
  dimension <- log(size)/log(width)
  return("Dimension: 1.892789. Size is dependant on the dimension of the object, and the width needing to be multiplied by, and is therefore equivalent to width ^ dimension. This equation can be rearranged to make dimension the subject by taking a log of both sides and using the rule that log(n^x)=xlog(n). Given that an objects' dimension can be calculated by log(size)/log(width), I calculated the size (how many multiples of original object) needed to satisfy an increment to a certain width. Because the object was initially split into thirds along both axes, and so contains 3 sub-objects within its length, i decided a width i would use to calculate size would be 3. Because the object contains 8 copies of itself, the size would be 8 as the object would need to be 8 times as big to be 3 times as wide. I then input these numbers into the log equation to get dimension = log(8)/log(3), which gave 1.892789 as the objects' dimension. The dimension isn't quite 2, as the shape is not completely filled and therefore the surface area is not enough to classify as 2 dimensional. Because the dimension is not a whole number and is fractional, this shape is a fractal.")
  }

# Question 22
question_22 <- function()  {
  width <- 3
  size <- 20
  dimension <- log(size)/log(width)
  return("Dimension:2.726833. The same equation can be used as above (log(size)/log(width)) to find dimension. For the same reasons, i used 3 as the width i wanted to multiply by. To determine size, i counted the amount of cubes within the menger sponge. Given that in the Sierpinski carpet above, i counted 8 copies of itself within the shape, this cubic shape will contain 8 cubes on the front and 8 on the back, but only 4 in the middle, making a total of 20 versions of itself, within itself, giving a size of 20. These numbers create the equation log(20)/log(3), which equate to the dimension of 2.726833. Again, this shape is not quite 3 dimensional as areas within it have been removed. As above, because the dimension is fractional, the object is a fractal.")
  }

# Question 23
chaos_game <- function()  {
  graphics.off()
  
  # store points, separately and in list
  A <- c(0,0)
  B <- c(3,4)
  C <- c(4,1)
  coords <- list(A, B, C)
  
  
  # initialise list for points
  xcoordlist <- list(A[1])
  ycoordlist <- list(A[2])
  
  # start at 0,0
  currentcoordinate <- c(0,0)
  
  
  for (x in 1:10000){
    
    # choose one index (and therefore point/coordinate pair) at random
    i <- sample(c(1,2,3), 1)
    
    # store randomly chosen coordinates
    selectedcoord <- unlist(coords[i])
    
    # determines length of half of difference between points
    halfdiff <- (selectedcoord - currentcoordinate)/2
    
    # determines coordinates of halfway point
    newcoord <- unlist(currentcoordinate + halfdiff)
    
    # adds new point to x and y coordinate lists
    xcoordlist <- c(xcoordlist, newcoord[1])
    ycoordlist <- c(ycoordlist, newcoord[2])
    
    # reset current coordinate for beginning of next loop
    currentcoordinate <- newcoord
  }

  # When loop is over, will be left with two lists of corresponding x and y coordinates, can be plotted as so
  plot(xcoordlist, ycoordlist, pch = 20, cex = 0.5)
  return("At 100 repeats of the for loop, the result has no obvious pattern. At 1000 loops, a faint pattern emerges and at 10000 loops, it becomes apparent that the pattern is a fractal, names the Sierpinski Gasket.")
}



# Question 24

turtle <- function(start_position, direction, length)  {

  # Calculate coordinates of end of line according to sin/cos triangle rules
  x1 <- start_position[1] + length*cos(direction)
  y1 <- start_position[2] + length*sin(direction)
  
  # plot line from initial coordinates to new coordinates
  lines(x=c(start_position[1], x1), y=c(start_position[2], y1), xlim = c(0,x1), ylim = c(0,y1), xlab = "x", ylab = "y")
  
  # return new coordinates
  return(c(x1, y1)) 
}


# Question 25
elbow <- function(start_position, direction, length)  {
  for (i in 1:2){
    # plot line and reset starting point
    start_position <- turtle(start_position, direction, length)
    # change angle
    direction <- direction-(pi/4)
    # reduce length
    length <- length*0.95
  }
}

# Question 26
spiral <- function(start_position, direction, length, minimum_length=FALSE)  {
  
  # define minimum length to stop infinite recursion
  # if statement and extra default parameter allows for the minimum length of the line to be determined by the length passed into function
  # this method ensures minimum_length is not re-defined in each loop
  if (minimum_length==FALSE){
    minimum_length <- length*0.005
  }
  
  # draws initial line
  start_position <- turtle(start_position, direction, length)
  
  # calls the function again as long as the lines are still above the minimum length
  if (length >= minimum_length){
    return(spiral(start_position, direction-(pi/4), length*0.95, minimum_length))
  } else {
    # ones lines have gotten to the minimum size, the text answer is returned
    return("Spiral is a recursive function, meaning it calls itself. Because we are not giving it any iterative limit, or time limit, the function will call itself infinitely. Every time spiral is called, the tutle function is run, which draws a line, and the parameters are reset. So as spiral is repeatedly called and the functions are repeatedly reset, the spiral function starts at the outermost point and continues to spiral inwards infinitely, creating an infinite loop.")
  }
}


# Question 27
draw_spiral <- function(start_position=c(1,1), direction=0.6, length=5)  {
  graphics.off()
  
  # plots empty plot
  plot(x=0, y=0, xlim = c(0, 15), ylim = c(-10, 5), type="n", xlab = "", ylab = "", axes=FALSE)
  
  # plots spiral
  return(spiral(c(1,1), 0.6, 5))
}

## my method of having spiral and draw spiral as one function (but must do graphics.off() beforehand)

draw_spiral2 <- function(start_position=c(1,1), direction=0.6, length=5, minimum_length=FALSE)  {
  
  # define minimum length to stop infinite recursion
  if (minimum_length==FALSE){
    minimum_length <- length*0.005
  }
  
  # if the plot hasn't already been opened
  if (length(dev.list())==0){
    plot(x=0, y=0, xlim = c(0, 15), ylim = c(-10, 5), type="n", xlab = "x", ylab = "y")
  }
  
  if (length > minimum_length){
    
    start_position <- turtle(start_position, direction, length)
    
    draw_spiral2(start_position, direction-(pi/4), length*0.95, minimum_length)
  }
}

# Question 28
tree <- function(start_position, direction, length, minimum_length=FALSE)  {
  
  # as above, set minimum length of line to stop infinite recursion
  if (minimum_length==FALSE){
    minimum_length <- length*0.03
  }
    # draws a line and returns end point of line, refines this as new start point for next line
    start_position <- turtle(start_position, direction, length)
  
    # calls the function again
    if (length >= minimum_length){
      # tree(start_position, direction-(pi/4), length*0.95, minimum_length)
      tree(start_position, direction+(pi/4), length*0.65, minimum_length)
      tree(start_position, direction-(pi/4), length*0.65, minimum_length)
    }
}


draw_tree <- function()  {
  graphics.off()
  
  # initializes empty plot
  plot(x=0, y=0, xlim = c(-6, 6), ylim = c(0, 10), type="n", xlab = "", ylab = "", axes=FALSE)
  
  # calls function to plot tree
  tree(c(0, 0), 1.5708, 4)
}

# Question 29
fern <- function(start_position, direction, length, minimum_length=FALSE)  {
  
  # as above, set minimum length of line to stop infinite recursion
  if (minimum_length==FALSE){
    minimum_length <- length*0.01
  }
  
  # draws a line and returns end point of line, refines this as new start point for next line
  start_position <- turtle(start_position, direction, length)
  
  # as long as length is above minimum, calls the function again
  if (length >= minimum_length){
    # draws straight line of reduced length
    fern(start_position, direction, length*0.87, minimum_length)
    
    # draws line at angle of reduced length
    fern(start_position, (direction+(pi/4)), length*0.38, minimum_length)
  }
}

draw_fern <- function()  {
  graphics.off()
  
  # initialize plot
  plot(x=0, y=0, xlim = c(-15, 15), ylim = c(0, 30), type="n", xlab = "", ylab = "", axes=FALSE)
  
  # draw fern
  fern(c(0, 0), 1.5708, 4)
}


# Question 30
fern2 <- function(start_position, direction, length, minimum_length=FALSE, dir)  {
  # change dir to its' inverse so that it changes every time a new line is plotted
    dir <- dir*-1
    
    # define minimum length as a function of length, to prevent infinite recursion
    if (minimum_length==FALSE){
      minimum_length <- length*0.005
    }
  
    # draws a line and returns end point of line, refines this as new start point for next line
      start_position <- turtle(start_position, direction, length)

    # as long as length is above the minimum, calls the function again
    if (length >= minimum_length){
        # draw straight line
        fern2(start_position, direction, length*0.87, minimum_length, dir)
      
      # draw side line (either left or right)
        # choose to plot either left or right depending on value of dir
        if (dir>0){
          fern2(start_position, direction = (direction+(pi/4)), length*0.38, minimum_length, dir)
        } else {
          fern2(start_position, direction= (direction-(pi/4)), length*0.38, minimum_length, dir)
        }
      }
}

draw_fern2 <- function()  {
  graphics.off()
  
  # initialize empty plot
  plot(x=0, y=0, xlim = c(-30, 30), ylim = c(0, 55), type="n", xlab = "", ylab = "", axes=FALSE)
  
  # call function to draw fern
  fern2(c(0, 0), direction=1.5708, length=7, dir=1)
}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Challenge_A <- function() {
  graphics.off()
  
  # rules
  # do a large number of repeat simulations
  
  
  
  # parameters:
  # speciation_rate=0.1
  # community = 100
  # generations = 200
  # burn in = 200 generations
  # generations = 2000 after burn in (2200 total)
  # init community min and max

}

# Challenge question B
Challenge_B <- function() {
  # turn off graphics and initialize new plot
  graphics.off()
  plot(x=0, y=0, xlim = c(0, 200), ylim = c(1, 100), type="n", xlab="Generation", ylab="Species Richness", main="Species Richness Time Series")
  colour_list <- c("chartreuse", "blue", "deeppink", "orangered", "aquamarine", "yellow", "darkgreen", "darkred", "darkgoldenrod4", "darkviolet")
  line_list <- c("Initial richness: 10", "Initial richness: 20","Initial richness: 30", "Initial richness: 40", "Initial richness: 50","Initial richness: 60","Initial richness: 70","Initial richness: 80","Initial richness: 90","Initial richness: 100")
  
  # loop through 10 different initial species richnesses
  for (i in c(1:10)){
    
    # initialize community of size 10
    community <- append(init_community_max(i*10), init_community_min(100-(i*10)))

    # record time series of species richness
    species_richness_series <- neutral_time_series_speciation(community, 0.1, 200)
    
    # # repeat this 10 more times, adding the results every loop to create a running total
    for (j in 1:10){
      species_richness_series <- species_richness_series + neutral_time_series_speciation(community, 0.1, 200)
    }
    
    # divide the total by 11 to get a mean species richness time series
    species_richness_series <- species_richness_series/11
    
    # plot 
    lines(species_richness_series, col=colour_list[i])
  }
  legend("topright", legend=line_list, fill=colour_list)
  
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
  graphics.off()
  
  # store points, separately and in list
  A <- c(0,0)
  B <- c(3,4)
  C <- c(4,1)
  coords <- list(A, B, C)
  
  # start at 0,0
  currentcoordinate <- c(2,4)
  
  
  # initialise list for points
  xcoordlist <- list(currentcoordinate[1])
  ycoordlist <- list(currentcoordinate[2])
  
  
  for (x in 1:10000){
    
    # choose one index (and therefore point/coordinate pair) at random
    i <- sample(c(1,2,3), 1)
    
    # store randomly chosen coordinates
    selectedcoord <- unlist(coords[i])
    
    # determines length of half of difference between points
    halfdiff <- (selectedcoord - currentcoordinate)/2
    
    # determines coordinates of halfway point
    newcoord <- unlist(currentcoordinate + halfdiff)
    
    # adds new point to x and y coordinate lists
    xcoordlist <- c(xcoordlist, newcoord[1])
    ycoordlist <- c(ycoordlist, newcoord[2])
    
    # reset current coordinate for beginning of next loop
    currentcoordinate <- newcoord
  }
  
  xcoordlist1 <- xcoordlist[1:10]
  ycoordlist1 <- ycoordlist[1:10]
  
  xcoordlist2 <- xcoordlist[11:10000]
  ycoordlist2 <- ycoordlist[11:10000]
  
  # When loop is over, will be left with two lists of corresponding x and y coordinates, can be plotted as so
  plot(xcoordlist2, ycoordlist2,pch = 20, cex = 0.5, col="floralwhite", xlim=c(0, 5), ylim=c(0,5), xlab="", ylab="")
  points(xcoordlist1, ycoordlist1, pch = 20, cex = 1, col="red")
  # tilting the screen with these colours shows the distinction between the groups
  
  return("Regardless of what the starting point is, the Sierpinski Gasket always be formed within the three triangular coordinates within the function. If the starting point is within the Sierpinski Gasket, so are all other points plotted. However, if the starting point is not within the Sierpinksi Gasket, a few points are plotted outside of the triangle until a coordinate finds itself within the triangle, and from here onwards the fractal is formed. Therefore, the location of the starting point within this function has no effect on where the Sierpinski Gasket is eventually plotted, and only has an effect on how many outliers are plotted outside of the fractal. The chaos game is defined such that the starting point can be anywhere inside or outside of the triangle(defined by A, B and C), and because of the functinos' iterative nature, the shape will eventually form the sierpinksi gasket. ")
}

# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  
  return("type your written answer here")
}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.


