# This code enables you to simulate a voter model
# That is a neutral model with nearest neighbour dispersal 
# Please look at the lectures and lecture notes for more information
# You don't need to edit the main code, but you can look if you wish.
# Please skip to the end of the file to look at what you can do with these simulations
# Note that you'll need to install a library - probably you've done this before.

# code starts here!

rm(list=ls()) # remove anything unwanted left behind in the R environment
graphics.off() # remove any existing graphics 

library(raster) # load library for plotting   

ExampleLandscape1 <- function(width=25)
{
  Landscape <- matrix(0,nrow=width,ncol=width)
  Landscape[3:width-1,3:width-1] <- 1
  return(Landscape)
}

ExampleLandscape2 <- function(width=25)
{
  Landscape <- matrix(sample(x = 1:2, size = (width*width),  prob=c(0.35,0.65), replace = TRUE),nrow=width,ncol=width)
  return(Landscape-1)
}

ExampleLandscape3 <- function(width=25,gaps=c(10,15,12,13,18,25,17,24))
{
  Landscape <- matrix(1,nrow=width,ncol=width)
  Landscape[gaps[1]:gaps[2],1:width] <- 0
  Landscape[gaps[1]:gaps[2],gaps[3]:gaps[4] ] <- 1
  Landscape[gaps[5]:gaps[6],gaps[7]:gaps[8]] <- 0
  return(Landscape)
}

SetupCommunity <- function(Landscape,NumberSpecies=2)
{
  Community <- matrix(sample(x = 1:NumberSpecies, size = (nrow(Landscape)*ncol(Landscape)), replace = TRUE),nrow=nrow(Landscape),ncol=ncol(Landscape))
  Community <- Community*Landscape*3-1
  return(Community)
}

VoterStep <- function(community,landscape,speciation=0.1)
{
  DeathRow <- sample(x = 1:(nrow(community)), 1)
  DeathCol <- sample(x = 1:(ncol(community)), 1)
  while(landscape[DeathRow,DeathCol] != 1)
  {
    DeathRow <- sample(x = 1:(nrow(community)), 1)
    DeathCol <- sample(x = 1:(ncol(community)), 1)
  }
  
  if (runif(1) <= speciation)
  {
    community[DeathRow,DeathCol] <- runif(1)
  }
  else
  { 
    BirthRow <- DeathRow + sample(x = 0:2, 1) - 1
    BirthCol <- DeathCol + sample(x = 0:2, 1) - 1
    while((((BirthRow < 1)||(BirthRow > nrow(community)))||((BirthCol < 1)||(BirthCol > ncol(community))))||(landscape[BirthRow,BirthCol] != 1))
    {
      BirthRow <- DeathRow + sample(x = 0:2, 1) - 1
      BirthCol <- DeathCol + sample(x = 0:2, 1) - 1
    }
    community[DeathRow,DeathCol] <-  community[BirthRow,BirthCol]
  }
  return(community)
}

RunSimulation <- function(community,landscape,speciation=0.1,NumSteps=100)
{
  for (i in 1:(NumSteps*length(landscape)/2))
  {
    community <- VoterStep(community=community,landscape=landscape,speciation=speciation)
  }
  return(community)
}

Landscape1 <- ExampleLandscape1(width=10)
Landscape2 <- ExampleLandscape2()
Landscape3 <- ExampleLandscape3()

Community1 <- SetupCommunity(Landscape1)
Community2 <- SetupCommunity(Landscape2)
Community3 <- SetupCommunity(Landscape3)

# your area for experimentation starts here.

plot(raster(Landscape1), main="Landscape1")
plot(raster(Community1), main="Community1")
Result <- RunSimulation(Community1,Landscape1,speciation=0,NumSteps=1000)
plot(raster(Result), main="Sim Result (Community1, Landscape1), speciation=0")

Result <- RunSimulation(Community1,Landscape1,speciation=0.2,NumSteps=1000)
plot(raster(Result), main="Sim Result (Community1, Landscape1), speciation=0.2")

Result <- RunSimulation(Community1,Landscape1,speciation=0.8,NumSteps=1000)
plot(raster(Result), main="Sim Result (Community1, Landscape1), speciation=0.8")

plot(raster(Landscape3), main="Landscape3")
plot(raster(Community3), main="Community3")
Result <- RunSimulation(Community3,Landscape3,speciation=0.001,NumSteps=1000)
plot(raster(Result), main="Sim Result (Community3, Landscape3), speciation=0.001")


