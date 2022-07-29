# comparing change in climate and BD over time by country
setwd("~/CMEECoursework/Project/code")
rm(list=ls())

#read in BD and climate data
countryBD<- readRDS("../data/RawDataFiles/NHMBiodiversityData/countryBD.RDS")
countryClimate<- readRDS("../data/RawDataFiles/WorldBankClimateData/countryclimate.RDS")

# countryBD only has 18 years of data, countryClimate has 120
# create subset of countryClimate that has same 18 years as countryBD
countryClimate <- countryClimate[(c(colnames(countryBD)))]

# remove rows with NAs
countryBD <- na.omit(countryBD)
countryClimate<- na.omit(countryClimate)

# make sure a country is only included in either table if it is present in both
matchingcountrys <- intersect(row.names(countryBD),row.names(countryClimate))

countryBD <- countryBD[rownames(countryBD) %in% matchingcountrys, ]
countryClimate <- countryClimate[rownames(countryClimate) %in% matchingcountrys, ]

#this leaves 158 countries
################

#create results data frame
resultsDF <- data.frame(matchingcountrys)

#make the countrys the row names
row.names(resultsDF) <- matchingcountrys
resultsDF <- resultsDF[-1]
resultsDF$corr <- NA

# loop through countrys and find significant correlation coefficients

for (country in seq_along(matchingcountrys)){
  
  BDvalues <- as.numeric(as.vector(countryBD[country,]))
  Climatevalues <- as.numeric(as.vector(countryClimate[country,]))
  
  #myDF <- data.frame(colnames(countryBD), BD, Climate)
  
  # fit model
  model <- (lm(BDvalues~Climatevalues))
  plot(Climatevalues, BDvalues)
  abline(model)
  #check if p value is below 0.05 (make sure)
  if (as.numeric(summary(model)$coefficients[,4][2]) < 0.05){
    
    #add correlation result to results data frame
    resultsDF$corr[country] <- as.numeric(model[[1]][2])
  }
  
  #remove unnecessary variables
}

#remove unnecessary variables from loop
rm(list=c("BDvalues", "Climatevalues","model", "country"))

#remove NAs where p value wasn't significant
resultsDF <- na.omit(resultsDF)

#leaves 88 countries from 158 (50%)

# get number of continents and regions in this sample, this will be k

library(countrycode)
resultsDF$continent <- countrycode(sourcevar = row.names(resultsDF),
                          origin = "country.name",
                          destination = "continent")
resultsDF$region <- countrycode(sourcevar = row.names(resultsDF),
                          origin = "country.name",
                          destination = "region")

########### visualise results
install.packages(c("cowplot", "googleway", "ggplot2", "ggrepel", "ggspatial", "libwgeom", "sf", "rnaturalearth", "rnaturalearthdata"))
install.packages("classInt")
install.packages('sf') #if this isn't working, try 'sudo apt install libudunits2-dev' in terminal
library("ggplot2")
theme_set(theme_bw())
library("sf") 
library("rnaturalearth")
library("rnaturalearthdata")

world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)

ggplot(data = world) +
  geom_sf() +
  ggtitle("World map", subtitle = paste0("(", length(unique(world$NAME)), " countries)"))
#########
library('ggplot2')
library('tidyverse')

mapdata <- map_data("world")
library(tibble)
resultsDFmapping <- tibble::rownames_to_column(resultsDF, "country") # create new results DF where country is a column so that it can be joined with another df
names(mapdata)[names(mapdata) == 'region'] <- 'country' # change the name of the countries column to match the other DF

mapdata <- left_join(mapdata, resultsDFmapping, by='country') # join the data frames
mapdata <- mapdata %>%  filter(!is.na(mapdata$corr))   # remove NAs

map <- ggplot(mapdata, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill= corr), colour = "black")

map <- map + scale_fill_gradient(name = "Sensitivity Score", low = "red", high = "green", na.value = "grey50")
map


####### try clustering by continent

#library(ClusterR) ? do i need this?
library(cluster)
numcontinents <- length(unique(resultsDF$continent))
kvals <- kmeans(resultsDF$corr, numcontinents)
rm(numcontinents)
resultsDF$continentcluster <- as.numeric(kvals$cluster)

#print continents in clusters

for (cluster in 1:5){
  print(table(resultsDF[resultsDF$continentcluster == cluster, "continent"]))
}
rm(cluster)

#visualize

resultsDF$ID <- 1:88
plot(x=resultsDF$ID,y=resultsDF$corr, col=factor(resultsDF$continent))

require(ggplot2)
qplot(resultsDF$continent, resultsDF$corr)
qplot(resultsDF$continent, resultsDF$corr, 
      geom=c("boxplot"))


####### try clustering by region

numregions <- length(unique(resultsDF$region))
kvals <- kmeans(resultsDF$corr, numregions)
rm(numregions)
resultsDF$regioncluster <- as.numeric(kvals$cluster)

#print regions in clusters

for (cluster in 1:6){
  print(table(resultsDF[resultsDF$regioncluster == cluster, "region"]))
}
rm(cluster)

#visualize

plot(x=resultsDF$ID,y=resultsDF$corr, col=factor(resultsDF$region))


require(ggplot2)
qplot(resultsDF$region, resultsDF$corr)
qplot(resultsDF$region, resultsDF$corr, 
      geom=c("boxplot"))


##############################
# check if latitude correlates
##############################

# import latitude data
countrylatitude <- readRDS("../data/RawDataFiles/latitudeData/countrylatitude.RDS")

#convert to data frame
countrylatitude <- as.data.frame(countrylatitude)

#make the countrys the row names
row.names(countrylatitude) <- countrylatitude[,1]
countrylatitude <- countrylatitude[-1]

# add latitude values to results data frame
resultsDF <- merge(x=resultsDF, y=countrylatitude, by=0)

# visualize latitude relationship
plot(x=resultsDF$latitude, y= resultsDF$corr)

#fit model
latmodel <- (lm(resultsDF$corr~resultsDF$latitude))
summary(latmodel)
plot(resultsDF$corr ~ resultsDF$latitude)
abline(latmodel)
