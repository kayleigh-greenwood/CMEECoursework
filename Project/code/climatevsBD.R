# comparing change in climate and BD over time by country

#################################################################################################################################################
## SET UP WORKSPACE ##
#################################################################################################################################################
setwd("~/CMEECoursework/Project/code")
rm(list=ls())

#################################################################################################################################################
## IMPORT DATA ##
#################################################################################################################################################
countryBD<- readRDS("../data/RawDataFiles/NHMBiodiversityData/countryBD.RDS")
countryClimate<- readRDS("../data/RawDataFiles/WorldBankClimateData/countryclimate.RDS")

#################################################################################################################################################
## WRANGLE DATASETS  ##
#################################################################################################################################################

# match up timeframes in datasets
countryClimate <- countryClimate[(c(colnames(countryBD)))]
# countryBD only has 18 years of data, countryClimate has 120
# create subset of countryClimate that has same 18 years as countryBD (consider using another biodiversity dataset)

# remove rows with NAs
countryBD <- na.omit(countryBD)
countryClimate<- na.omit(countryClimate)

# Match up countrys in datasets
matchingcountrys <- intersect(row.names(countryBD),row.names(countryClimate))
# make sure a country is only included in either table if it is present in both

countryBD <- countryBD[rownames(countryBD) %in% matchingcountrys, ]
countryClimate <- countryClimate[rownames(countryClimate) %in% matchingcountrys, ]

#this leaves 158 countries

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
countryClimate2 <- tibble::rownames_to_column(countryClimate, "country")

# pivot both dataframes longer
library(tidyr)
countryClimate2 <- pivot_longer(countryClimate2, -c(country), values_to = "Climate", names_to = "Year")
countryBD2 <- pivot_longer(countryBD2, -c(country), values_to = "Biodiversity", names_to = "Year")

# merge data frames into one
alldata <- merge(countryClimate2, countryBD2, by=c("country", "Year"))

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

####################
## VISUALISE DATA ##
####################


# plot continents
cols = c('deeppink', 'deepskyblue', 'darkorange', 'darkorchid','chartreuse', 'darkgreen')
plot(alldata$Climate, alldata$Biodiversity, col=cols[alldata$Continent])

legend(-15,0.6, sort(unique(alldata$Continent)),col=cols,pch=1)

# plot continents separately 
print(levels(as.factor(alldata$Continent)))

ggplot(alldata, aes(x = Climate, y = Biodiversity, Continent)) +
  geom_point(size = 4, shape = 4) +
  geom_point(data = ~filter(.x, Continent == "Africa"), colour = "red") +
  labs(title = "Africa")

ggplot(alldata, aes(x = Climate, y = Biodiversity, Continent)) +
  geom_point(size = 4, shape = 4) +
  geom_point(data = ~filter(.x, Continent == "Asia"), colour = "red") +
  labs(title = "Asia")

ggplot(alldata, aes(x = Climate, y = Biodiversity, Continent)) +
  geom_point(size = 4, shape = 4) +
  geom_point(data = ~filter(.x, Continent == "Europe"), colour = "red") +
  labs(title = "Europe")

ggplot(alldata, aes(x = Climate, y = Biodiversity, Continent)) +
  geom_point(size = 4, shape = 4) +
  geom_point(data = ~filter(.x, Continent == "North America"), colour = "red") +
  labs(title = "North America")

ggplot(alldata, aes(x = Climate, y = Biodiversity, Continent)) +
  geom_point(size = 4, shape = 4) +
  geom_point(data = ~filter(.x, Continent == "Oceania"), colour = "red") +
  labs(title = "Oceania")

ggplot(alldata, aes(x = Climate, y = Biodiversity, Continent)) +
  geom_point(size = 4, shape = 4) +
  geom_point(data = ~filter(.x, Continent == "South America"), colour = "red") +
  labs(title = "South America")



# plot regions
cols = c('deepskyblue', 'darkorange', 'darkgreen','chartreuse', 'darkorchid', 'darkgoldenrod1', 'deeppink')
plot(alldata$Climate, alldata$Biodiversity, col=cols[alldata$Region])

legend(-18,0.6, sort(unique(alldata$Region)),col=cols,pch=1)

# plot regions separately (to visualise)
library(ggplot2)
library(dplyr)

print(levels(as.factor(alldata$Region)))


ggplot(alldata, aes(x = Climate, y = Biodiversity, Region)) +
  geom_point(size = 4, shape = 4) +
  geom_point(data = ~filter(.x, Region == "East Asia & Pacific"), colour = "red") +
  labs(title = "East asia & Pacific")

ggplot(alldata, aes(x = Climate, y = Biodiversity, Region)) +
  geom_point(size = 4, shape = 4) +
  geom_point(data = ~filter(.x, Region == "Europe & Central Asia"), colour = "red") +
  labs(title = "Europe & Central Asia")

ggplot(alldata, aes(x = Climate, y = Biodiversity, Region)) +
  geom_point(size = 4, shape = 4) +
  geom_point(data = ~filter(.x, Region == "Latin America & Caribbean"), colour = "red") +
  labs(title = "Latin America & Caribbean")

ggplot(alldata, aes(x = Climate, y = Biodiversity, Region)) +
  geom_point(size = 4, shape = 4) +
  geom_point(data = ~filter(.x, Region == "Middle East & North Africa"), colour = "red") +
  labs(title = "Middle East & North Africa")

ggplot(alldata, aes(x = Climate, y = Biodiversity, Region)) +
  geom_point(size = 4, shape = 4) +
  geom_point(data = ~filter(.x, Region == "North America"), colour = "red") +
  labs(title = "North America")

ggplot(alldata, aes(x = Climate, y = Biodiversity, Region)) +
  geom_point(size = 4, shape = 4) +
  geom_point(data = ~filter(.x, Region == "South Asia"), colour = "red") +
  labs(title = "South Asia")

ggplot(alldata, aes(x = Climate, y = Biodiversity, Region)) +
  geom_point(size = 4, shape = 4) +
  geom_point(data = ~filter(.x, Region == "Sub-Saharan Africa"), colour = "red") +
  labs(title = "Sub-Saharan Africa")


##################
## CREATE MODEL ##
##################

# # create new dataset for dummy variables
# dummydata <- data.frame(alldata$Climate, alldata$Biodiversity, alldata$Continent)
# colnames(dummydata) <- c('Climate', 'Biodiversity', 'Continent')
# 
# # install.packages('fastDummies')
# library(fastDummies)
# dummydata <- dummy_cols(dummydata, select_columns = 'Continent', remove_first_dummy = TRUE)
# realised I didn't need to do this as R treatse factors as dummy variables

# Africa is reference category 
model <- lm(Biodiversity~Climate*Continent, data = alldata)

################
## PLOT MODEL ##
################

# plot continents
cols = c('deeppink', 'deepskyblue', 'darkorange', 'darkorchid','chartreuse', 'darkgreen')
plot(alldata$Climate, alldata$Biodiversity, col=cols[alldata$Continent])

legend(-15,0.6, sort(unique(alldata$Continent)),col=cols,pch=1)

#install.packages('car')
library(car)
avPlots(model)

# install.packages('lsmeans')
library(lsmeans)

# get gradients
slopes <- lstrends(model, "Continent", var = "Climate")

# make plot with a level for each continent
library('plotly')
library('viridis')
library('broom')


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

plotly_interaction(alldata, "Climate", "Biodiversity", "Continent")

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
resultsDF$se <- NA

###############################
## OBTAIN SENSITIVITY SCORES ##
###############################

# loop through countrys and find significant correlation coefficients
for (country in seq_along(matchingcountrys)){
  
  BDvalues <- as.numeric(as.vector(countryBD[country,]))
  Climatevalues <- as.numeric(as.vector(countryClimate[country,]))
  
  myDF <- data.frame(colnames(countryBD), BDvalues, Climatevalues)
  
  # fit model
  model <- (lm(BDvalues~Climatevalues))
  #plot(Climatevalues, BDvalues)
  #title(matchingcountrys[country])
  #abline(model)
  #add correlation result to results data frame
  resultsDF$corr[country] <- as.numeric(model[[1]][2])
  resultsDF$se[country] <- as.numeric(sqrt(diag(vcov(model)))[2])
}

#remove unnecessary variables from loop
rm(list=c("BDvalues", "Climatevalues","model", "country"))

# get continents and region
library(countrycode)
resultsDF$continent <- countrycode(sourcevar = row.names(resultsDF),
                          origin = "country.name",
                          destination = "continent")
resultsDF$region <- countrycode(sourcevar = row.names(resultsDF),
                          origin = "country.name",
                          destination = "region")

# this adds north and south america as 'the americas' so i must separate:
for (row in 1:nrow(resultsDF)){
  if (resultsDF[row, 4]=='Latin America & Caribbean'){
    resultsDF[row, 3] <- 'S America'
  }
}

resultsDF$continent <- replace(resultsDF$continent, resultsDF$continent=='Americas', 'N America')

for (row in 1:nrow(resultsDF)){
  if (resultsDF[row, 4]=='North America'){
    resultsDF[row, 3] <- 'N America'
  }
}

##################################################
## DESCRIPTIVE STATISTICS OF SENSITIVITY SCORES ##
##################################################

mean(resultsDF$corr)
# install.packages("plotrix")
library('plotrix')
std.error(resultsDF$corr)
range(resultsDF$corr)

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
# class(world)

# ggplot(data = world) +
#   geom_sf() +
#   ggtitle("World map", subtitle = paste0("(", length(unique(world$NAME)), " countries)"))
#########
library('ggplot2')
library('tidyverse')

mapdata <- map_data("world")
library(tibble)
resultsDFmapping <- tibble::rownames_to_column(resultsDF, "country") # create new results DF where country is a column so that it can be joined with another df
names(mapdata)[names(mapdata) == 'region'] <- 'country' # change the name of the countries column to match the other DF

mapdata <- left_join(mapdata, resultsDFmapping, by='country') # join the data frames

pdf(file="../images/climatesensitivitymapgradient.pdf")
# base plot
map <- ggplot(mapdata, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill= corr), colour = "black") 

# add colours
map <- map + scale_fill_gradient2(name="Sensitivity Score", midpoint = 0, mid = "white", high = "darkgoldenrod2", low = "blue4", limits = c(-0.25, 0.1), space="Lab") # maybe would be better to make all countries below zero on a different colour gradient

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
####################################
## Map with binned data colour gradient ##
####################################



# ggplot(data = world) +
#   geom_sf() +
#   ggtitle("World map", subtitle = paste0("(", length(unique(world$NAME)), " countries)"))

mapdata <- map_data("world")
# wrangle results data to prepare for mapping
resultsDFmapping <- tibble::rownames_to_column(resultsDF, "country") # create new results DF where country is a column so that it can be joined with another df
names(mapdata)[names(mapdata) == 'region'] <- 'country' # change the name of the countries column to match the other DF





mapdata <- left_join(mapdata, resultsDFmapping, by='country') # join the data frames


world <- ne_countries(scale = "medium", returnclass = "sf")



# Generate a list of expressions that will become the legend labels
# lbls <- list(expression(-0.25 <= x < -0.20), expression(-0.20 <= x < -0.15), expression(-0.15 <= x < -0.10), expression(-0.10 <= x < -0.05), expression(-0.05 <= x < 0), expression(0 <= x < 0.05), expression(0.05 <= x < 0.10))


# add column for which bin the correlation value is in 
mapdata$corrbins <- cut(mapdata$corr, include.lowest = TRUE,
                        breaks = c( -0.25, -0.2, -0.15, -0.1, -0.05, 0, 0.05, 0.1),
                        labels = c("(-) 0.25 to < 0.20", "(-) 0.20 to < 0.15", "(-) 0.15 to < 0.10", "(-) 0.10 to < 0.05", "(-) 0.05 to < 0", "0 to < 0.05", "0.05 to < 0.10"))


pdf(file="../images/climatesensitivitymapbins.pdf")
# Base plot
map <- ggplot(mapdata, aes(x = long, y = lat, group = group)) +
        geom_polygon(aes(fill= corrbins), colour = "black") 


# Amend colour gradient
map <- map + scale_fill_manual(name = "Sensitivity Score", 
                               values = c("firebrick4", "firebrick3", "firebrick2", "lightcoral", "pink", "lightgreen", "green4"), 
                               guide=guide_legend(reverse=TRUE)
                            )

# Remove axis titles and details
map <- map + theme(axis.text.x=element_blank(), 
        axis.ticks.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_blank())
# map <- map + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())

map
dev.off()

##################################
## COMPARING SENSITIVITY SCORES ##
##################################

library(ggplot2)

ggplot(data = resultsDF, mapping = aes(y=corr, x=continent, xlab = "Continent", ylab = "Sensitivity Score")) +
  geom_point() + #plot sensitivity score against continent (Scatter)
  ylab("Sensitivity Score")

pdf(file="../images/climatesensitivityboxplot.pdf")
boxplot(corr ~ continent, data=resultsDF,  xlab = "Continent", ylab = "Sensitivity Score") # plot sensitivity score against continent (boxplot)
dev.off()

###################################
## model continental differences ##
###################################
mean(resultsDF$corr)
sensitivitymodel <- lm(resultsDF$corr ~ resultsDF$continent, weights = 1/(resultsDF$se))
summary(sensitivitymodel)





















################
## CLUSTERING ##
################
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


##########################################################
## CHECK IF LATITUDE CORRELATES WITH SENSITIVITY SCORES ##
##########################################################

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
