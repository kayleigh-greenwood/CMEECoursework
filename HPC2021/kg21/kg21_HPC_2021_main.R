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

  # create mean of octaves
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
  sumoct500 <- c()
  sumoct1000 <- c()
  sumoct2500 <- c()
  sumoct5000 <- c()
  
  
  for (i in 1:100){
      load(file=paste("to_delete/kgResult/resultiter", i, ".rda", sep=""))
    
      burn_in_threshold <- burn_in_generations/interval_oct
      # gives the last index of oct that is part of the burn in generation
      
      equil_threshold <- burn_in_threshold
      
      abundanceoctaves <- abundanceoctaves[(equil_threshold+1):length(abundanceoctaves)]
      # filters out data before burn in generations
      
      sumoct <- c(abundanceoctaves[[1]])
      for (i in 2:length(abundanceoctaves)){ 
        sumoct <- sum_vect(sumoct, abundanceoctaves[[i]])
      }
      meanoct <- sumoct/length(abundanceoctaves)
      # creates a mean octave vector for all those in this iteration
      
      if (size == 500){
      sumoct500 <- sum_vect(sumoct500, meanoct)
    } else if (size == 1000) {
      sumoct1000 <- sum_vect(sumoct1000, meanoct)
    } else if (size == 2500) {
      sumoct2500 <- sum_vect(sumoct2500, meanoct)
    } else if (size == 5000) {
      sumoct5000 <- sum_vect(sumoct5000, meanoct)
    } 
    # adds to relevant sum depending on size
  }  
  
  meanoct500 <- sumoct500/25
  meanoct1000 <- sumoct1000/25
  meanoct2500 <- sumoct2500/25
  meanoct5000 <- sumoct5000/25

  combined_results <- list(meanoct500, meanoct1000, meanoct2500, meanoct5000) #create your list output here to return
  
  # save results to an .rda file
  save(combined_results, file = "cluster_octave_results.rda")
}
  
### sumoct results a few times

# OCTAVE RESULTS
# sumoct500
# [1] 3.3210530 2.7455943 2.4735527 2.3017003 2.1222470 1.8718514 1.4593860 0.8061967 0.1491802

# sumoct1000
#  [1] 6.65362911 5.48791312 4.93669950 4.55815569 4.16370404 3.59566578 2.73605005 1.51060336 0.39541773 0.01273489

# sumoct2500
# [1] 1.097956e+01 9.015459e+00 8.150157e+00 7.495795e+00 6.636754e+00 5.703724e+00 4.278743e+00 2.392159e+00 7.236815e-01 6.095666e-02 6.067417e-05

# sumoct5000
#  [1] 1.349400e+01 1.130978e+01 9.996325e+00 9.206014e+00 8.409399e+00 7.138242e+00 5.260504e+00 2.900949e+00 9.034062e-01 8.735990e-02 9.103186e-04

plot_cluster_results <- function()  {
  
    # clear any existing graphs and plot your graph within the R window
    graphics.off()
  
    # load combined_results from your rda file
    load(file = "cluster_octave_results.rda")
    size500data <- combined_results[[1]]
    size1000data <- combined_results[[2]]
    size2500data <- combined_results[[3]]
    size5000data <- combined_results[[4]]

    
    # determine bin names

    binstartingvals500 <- c(1)
    for (i in (2:length(size500data))){
      binstartingvals500 <- append(binstartingvals500, binstartingvals500[i-1]*2)
    }
    binnames500 <- c()
    for (i in (1:length(size500data))){
      binnames500 <- append(binnames500, paste(binstartingvals500[i], "≤ x <", 2*binstartingvals500[i]))
    }
    
    binstartingvals1000 <- c(1)
    for (i in (2:length(size1000data))){
      binstartingvals1000 <- append(binstartingvals1000, binstartingvals1000[i-1]*2)
    }
    binnames1000 <- c()
    for (i in (1:length(size1000data))){
      binnames1000 <- append(binnames1000, paste(binstartingvals1000[i], "≤ x <", 2*binstartingvals1000[i]))
    }
    
    binstartingvals2500 <- c(1)
    for (i in (2:length(size2500data))){
      binstartingvals2500 <- append(binstartingvals2500, binstartingvals2500[i-1]*2)
    }
    binnames2500 <- c()
    for (i in (1:length(size2500data))){
      binnames2500 <- append(binnames2500, paste(binstartingvals2500[i], "≤ x <", 2*binstartingvals2500[i]))
    }
    
    binstartingvals5000 <- c(1)
    for (i in (2:length(size5000data))){
      binstartingvals5000 <- append(binstartingvals5000, binstartingvals5000[i-1]*2)
    }
    binnames5000 <- c()
    for (i in (1:length(size5000data))){
      binnames5000 <- append(binnames5000, paste(binstartingvals5000[i], "≤ x <", 2*binstartingvals5000[i]))
    }
    # plot the graphs
    # initialise multi panelled plot
    par(mfcol=c(2,2))
    
    # plot size 500 first
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
  return("Size is dependant on the dimension of the object, and the width needing to be multiplied by, and is therefore equivalent to width ^ dimension. This equation can be rearranged to make dimension the subject by taking a log of both sides and using the rule that log(n^x)=xlog(n). Given that an objects' dimension can be calculated by log(size)/log(width), I calculated the size (how many multiples of original object) needed to satisfy an increment to a certain width. Because the object was initially split into thirds along both axes, and so contains 3 sub-objects within its length, i decided a width i would use to calculate size would be 3. Because the object contains 8 copies of itself, the size would be 8 as the object would need to be 8 times as big to be 3 times as wide. I then input these numbers into the log equation to get dimension = log(8)/log(3), which gave 1.892789 as the objects' dimension. The dimension isn't quite 2, as the shape is not completely filled and therefore the surface area is not enough to classify as 2 dimensional. Because the dimension is not a whole number and is fractional, this shape is a fractal.")
}

# Question 22
question_22 <- function()  {
  width <- 3
  size <- 20
  dimension <- log(size)/log(width)
  return("The same equation can be used as above (log(size)/log(width)) to find dimension. For the same reasons, i used 3 as the width i wanted to multiply by. To determine size, i counted the amount of cubes within the menger sponge. Given that in the Sierpinski carpet above, i counted 8 copies of itself within the shape, this cubic shape will contain 8 cubes on the front and 8 on the back, but only 4 in the middle, making a total of 20 versions of itself, within itself, giving a size of 20. These numbers create the equation log(20)/log(3), which equate to the dimension of 2.726833. Again, this shape is not quite 3 dimensional as areas within it have been removed. As above, because the dimension is fractional, the object is a fractal.")
}

# Question 23
chaos_game <- function()  {
  # clear any existing graphs and plot your graph within the R window
  A <- c(0,0)
  B <- c(3,4)
  C <- c(4,1)
  xcoordlist = list(A[1])
  ycoordlist = list(A[2])
  coords <- list(A, B, C)
  currentcoordinate <- A
  for (x in 1:1000){
    i <- sample(c(1,2,3), 1)
    selectedcoord <- unlist(coords[i])
    halfdiff <- (selectedcoord - currentcoordinate)/2
    newcoord <- unlist(coordinate + halfdiff)
    xcoordlist = c(xcoordlist, newcoord[1])
    ycoordlist = c(ycoordlist, newcoord[2])
    currentcoordinate = newcoord
  }

  plot(xcoordlist, ycoordlist, pch = 20, cex = 0.5)
  return("At 100 repeats of the for loop, the result has no obvious pattern. At 1000 loops, a faint pattern emerges and ad 10000 loops, it becomes apparent that the pattern is a fractal.")
}



# Question 24

turtle <- function(start_position, direction, line_length)  {

  x1 <- start_position[1] + line_length*cos(direction)
  y1 <- start_position[2] + line_length*sin(direction)
  
  lines(x=c(start_position[1], x1), y=c(start_position[2], y1), xlim = c(0,x1), ylim = c(0,y1), xlab = "x", ylab = "y")
  return(c(x1, y1)) 
}


# Question 25

plot(x=0, y=0, xlim = c(0, 15), ylim = c(-10, 5), type="n", xlab = "x", ylab = "y")

elbow <- function(start_position, direction, length)  {
  for (i in 1:2){
    start_position = turtle(start_position, direction, length)
    direction = direction-(pi/4)
    length = length*0.95
  }
}

### par can be used to plot on same graph with different axes
### par(new=TRUE)
plot(x=0, y=0, xlim = c(0, 15), ylim = c(-10, 5), type="n", xlab = "x", ylab = "y")
# start_position=c(1,1)
# direction=0.6
# length=5

# Question 26
spiral <- function(start_position, direction, line_length, minimum_length=FALSE)  {
  if (minimum_length==FALSE){
    minimum_length = line_length*0.005
  }
  
  # first line: draws a line
  start_position = turtle(start_position, direction, line_length)
  
  # second line: calls the function again
  if (line_length >= minimum_length){
    return(spiral(start_position, direction-(pi/4), line_length*0.95, minimum_length))
  } else {
    return("Spiral is a recursive function, meaning it calls itself. Because we are not giving it any iterative limit, or time limit, the function will call itself infinitely. Every time spiral is called, the tutle function is run, which draws a line, and the parameters are reset. So as spiral is repeatedly called and the functions are repeatedly reset, the spiral function starts at the outermost point and continues to spiral inwards infinitely, creating an infinite loop.")
  }
}

plot(x=0, y=0, xlim = c(0, 15), ylim = c(-10, 5), type="n", xlab = "x", ylab = "y")
start_position=c(1,1)
direction = 0.6
length = 5


# Question 27
draw_spiral <- function(start_position=c(1,1), direction=0.6, line_length=5)  {
  plot(x=0, y=0, xlim = c(0, 15), ylim = c(-10, 5), type="n", xlab = "x", ylab = "y")
  return(spiral(c(1,1), 0.6, 5))
}

## my method of having spiral and draw spiral as one function

draw_spiral2 <- function(start_position=c(1,1), direction=0.6, line_length=5, minimum_length=FALSE)  {
  # clear any existing graphs and plot your graph within the R window
  # 
  if (minimum_length==FALSE){
    minimum_length = line_length*0.005
  }
  
  if (length(dev.list())==0){
    plot(x=0, y=0, xlim = c(0, 15), ylim = c(-10, 5), type="n", xlab = "x", ylab = "y")
  }
  
  if (line_length > minimum_length){
    
    start_position = turtle(start_position, direction, line_length)
    
    draw_spiral(start_position, direction-(pi/4), line_length*0.95, minimum_length)
  }
}

plot(x=0, y=0, xlim = c(0, 15), ylim = c(-10, 5), type="n", xlab = "x", ylab = "y")

# Question 28
tree <- function(start_position, direction, line_length, minimum_length=FALSE)  {
  if (minimum_length==FALSE){
    minimum_length = line_length*0.03
  }
    # draws a line and returns end point of line, refines this as new start point for next line
    start_position = turtle(start_position, direction, line_length)
  
    # calls the function again
    if (line_length >= minimum_length){
      # tree(start_position, direction-(pi/4), line_length*0.95, minimum_length)
      tree(start_position, direction+(pi/4), line_length*0.65, minimum_length)
      tree(start_position, direction-(pi/4), line_length*0.65, minimum_length)
    }
}


draw_tree <- function()  {
  plot(x=0, y=0, xlim = c(-6, 6), ylim = c(0, 10), type="n", xlab = "x", ylab = "y")
  tree(c(0, 0), 1.5708, 4)
}

# Question 29
fern <- function(start_position, direction, length, minimum_length=FALSE)  {
  if (minimum_length==FALSE){
    minimum_length = line_length*0.03
  }
  # draws a line and returns end point of line, refines this as new start point for next line
  start_position = turtle(start_position, direction, line_length)
  
  # calls the function again
  if (line_length >= minimum_length){
    fern(start_position, direction, line_length*0.87, minimum_length)
    fern(start_position, direction-(pi/4), line_length*0.38, minimum_length)
  }
}

draw_fern <- function()  {
  plot(x=0, y=0, xlim = c(-6, 6), ylim = c(0, 10), type="n", xlab = "x", ylab = "y")
  fern(c(0, 0), 1.5708, 4)
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


