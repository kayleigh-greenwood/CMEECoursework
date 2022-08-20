# Comparing biodiversity trends with trends of land use change ( built up areas)

#################################################################################################################################################
## SET UP WORKSPACE ##
#################################################################################################################################################

setwd("~/CMEECoursework/Project/code")
rm(list=ls())

#################################################################################################################################################
## IMPORT DATA ##
#################################################################################################################################################

#read in BD and climate data
countryBD <- readRDS("../data/RawDataFiles/NHMBiodiversityData/countryBD.RDS")
countryBuilt <- readRDS("../data/RawDataFiles/LandUseBuiltUp/countrybuilt.RDS")

#################################################################################################################################################
## WRANGLE DATASETS  ##
#################################################################################################################################################

#match years of data
countryBD <- countryBD[(c(intersect(colnames(countryBD), colnames(countryBuilt))))]
countryBuilt <- countryBuilt[(c(intersect(colnames(countryBD), colnames(countryBuilt))))]

# remove rows with NAs
countryBD <- na.omit(countryBD)
countryBuilt <- na.omit(countryBuilt)

# make sure a country is only included in either table if it is present in both
matchingcountrys <- intersect(row.names(countryBD),row.names(countryBuilt))

countryBD <- countryBD[rownames(countryBD) %in% matchingcountrys, ]
countryBuilt <- countryBuilt[rownames(countryBuilt) %in% matchingcountrys, ]

#leaves 175 countries

#################################################################################################################################################
## METHOD 1 ##
#################################################################################################################################################
# method that makes one model of all countries

#######################
## PREPARE AND MERGE DATAFRAMES ##
#######################
# first put all data in the same  table such that the data points could be plotted where continent is a different colour

# make row names into a column
library(tibble)
countryBD2 <- tibble::rownames_to_column(countryBD, "country")
countryBuilt2 <- tibble::rownames_to_column(countryBuilt, "country")

# pivot both dataframes longer
library(tidyr)
countryBuilt2 <- pivot_longer(countryBuilt2, -c(country), values_to = "built", names_to = "Year")
countryBD2 <- pivot_longer(countryBD2, -c(country), values_to = "Biodiversity", names_to = "Year")

# merge data frames into one
alldata <- merge(countryBuilt2, countryBD2, by=c("country", "Year"))

#add continent and region
library(countrycode)
alldata$Continent <- countrycode(sourcevar = alldata$country,
                                 origin = "country.name",
                                 destination = "continent")
alldata$Region <- countrycode(sourcevar = alldata$country,
                              origin = "country.name",
                              destination = "region")

# this adds north and south america as 'the americas' so i must separate:
for (row in 1:nrow(alldata)){
  if (alldata[row, 6]=='Latin America & Caribbean'){
    alldata[row, 5] <- 'South America'
  }
}

alldata$Continent <- replace(alldata$Continent, alldata$Continent=='Americas', 'North America')

for (row in 1:nrow(alldata)){
  if (alldata[row, 5]=='North America'){
    alldata[row, 6] <- 'North America'
  }
}


#change continent  and region to factor so i can plot them as colors
alldata$Continent <-  as.factor(alldata$Continent)
alldata$Region <-  as.factor(alldata$Region)

# plot continents
cols = c('deeppink', 'deepskyblue', 'darkorange', 'darkorchid','chartreuse', 'darkgreen')
plot(alldata$built, alldata$Biodiversity, col=cols[alldata$Continent])

legend(25000,0.55, sort(unique(alldata$Continent)),col=cols,pch=1)


##################
## CREATE MODEL ##
##################

model <- lm(Biodiversity~built*Continent, data = alldata)

################
## PLOT MODEL ##
################

plotly_interaction <- function(data, x, y, category, colors = col2rgb(viridis(nlevels(as.factor(data[[category]])))), ...) {
  # Create Plotly scatter plot of x vs y, with separate lines for each level of the categorical variable. 
  # In other words, create an interaction scatter plot.
  # The "colors" must be supplied in a RGB triplet, as produced by col2rgb().
  
  require(plotly)
  require(viridis)
  require(broom)
  
  groups <- unique(data[[category]])
  
  p <- plot_ly(...)
  
  for (i in 1:length(groups)) {
    groupData = data[which(data[[category]]==groups[[i]]), ]
    p <- add_lines(p, data = groupData,
                   y = fitted(lm(data = groupData, groupData[[y]] ~ groupData[[x]])),
                   x = groupData[[x]],
                   line = list(color = paste('rgb', '(', paste(colors[, i], collapse = ", "), ')')),
                   name = groups[[i]],
                   showlegend = TRUE)
    p <- add_markers(p, data = groupData,
                     x = groupData[[x]],
                     y = groupData[[y]],
                     marker = list(color=paste('rgb','(', paste(colors[, i], collapse = ", "))),
                     showlegend = FALSE)
  }
  p <- layout(p, xaxis = list(title = x), yaxis = list(title = y))
  return(p)
}

plotly_interaction(alldata, "built", "Biodiversity", "Continent")




















################################################################################################################################################
## METHOD 2 ##
################################################################################################################################################
# method of assessing each country as its own linear model

##################################
## PREPARE AND MERGE DATAFRAMES ##
##################################

#create results data frame
resultsDF <- data.frame(matchingcountrys)

#make the countrys the row names
row.names(resultsDF) <- matchingcountrys
resultsDF <- resultsDF[-1]
resultsDF$corr <- NA

# loop through countrys and find significant correlation coefficients

for (country in seq_along(matchingcountrys)){
  
  BDvalues <- as.numeric(as.vector(countryBD[country,]))
  Builtvalues <- as.numeric(as.vector(countryBuilt[country,]))
  
  #myDF <- data.frame(colnames(countryBD), BD, Climate)
  
  # fit model
  model <- (lm(BDvalues~Builtvalues))
  
  #plot models
  # plot(x=Builtvalues, y=BDvalues)
  abline(model)
  
  #add correlation result to results data frame
    resultsDF$corr[country] <- as.numeric(model[[1]][2])
  
}


#remove unnecessary variables from loop
rm(list=c("BDvalues", "Builtvalues","model", "country"))


#visualize

resultsDF$ID <- 1:175
plot(x=resultsDF$ID,y=resultsDF$corr)


#add in continents and regions
library(countrycode)
resultsDF$continent <- countrycode(sourcevar = row.names(resultsDF),
                                   origin = "country.name",
                                   destination = "continent")
resultsDF$region <- countrycode(sourcevar = row.names(resultsDF),
                                origin = "country.name",
                                destination = "region")


##################################
## VISUALISE SENSITIVITY SCORES ##
##################################

####################################
## Map with gradient colour scale ##
####################################

# install.packages(c("cowplot", "googleway", "ggplot2", "ggrepel", "ggspatial", "libwgeom", "sf", "rnaturalearth", "rnaturalearthdata"))
# install.packages("classInt")
# install.packages('sf') #if this isn't working, try 'sudo apt install libudunits2-dev' in terminal
library("ggplot2")
theme_set(theme_bw())
library("sf") 
library("rnaturalearth")
library("rnaturalearthdata")

world <- ne_countries(scale = "medium", returnclass = "sf")
library('tidyverse')

mapdata <- map_data("world")
library(tibble)
resultsDFmapping <- tibble::rownames_to_column(resultsDF, "country") # create new results DF where country is a column so that it can be joined with another df
names(mapdata)[names(mapdata) == 'region'] <- 'country' # change the name of the countries column to match the other DF

mapdata <- left_join(mapdata, resultsDFmapping, by='country') # join the data frames

pdf(file="../images/buildlandsensitivitymapgradient.pdf")
# base plot
map <- ggplot(mapdata, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill= corr), colour = "black") 

# add colours
map <- map + scale_fill_gradient2(name="Sensitivity Score", midpoint = 0, mid = "white", high = "darkgoldenrod2", low = "blue4", limits = c(-0.001, 0.001), space="Lab") # maybe would be better to make all countries below zero on a different colour gradient

# install.packages("viridis")
# library(viridis)
# map <- map + scale_fill_viridis(midpoint = 0, mid = "white")


# Remove axis titles and details
map <- map + theme(axis.text.x=element_blank(), 
                   axis.ticks.x=element_blank(),
                   axis.text.y=element_blank(),
                   axis.ticks.y=element_blank(),
                   axis.title.y = element_blank(),
                   axis.title.x = element_blank())
map <- map + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = c(0.1, 0.25))

map

dev.off()
####### try clustering by continent
##########################
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

resultsDF$ID <- 1:175
plot(x=resultsDF$ID,y=resultsDF$corr, col=factor(resultsDF$continent))

require(ggplot2)
qplot(resultsDF$continent, resultsDF$corr)
qplot(resultsDF$continent, resultsDF$corr, 
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
