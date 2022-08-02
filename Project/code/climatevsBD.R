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
## MERGE DATAFRAMES ##
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

####################
## VISUALISE DATA ##
####################

#change continent  and region to factor so i can plot them as colors
alldata$Continent <-  as.factor(alldata$Continent)
alldata$Region <-  as.factor(alldata$Region)

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





# time to create a model !!

# # create new dataset for dummy variables
# dummydata <- data.frame(alldata$Climate, alldata$Biodiversity, alldata$Continent)
# colnames(dummydata) <- c('Climate', 'Biodiversity', 'Continent')
# 
# # install.packages('fastDummies')
# library(fastDummies)
# dummydata <- dummy_cols(dummydata, select_columns = 'Continent', remove_first_dummy = TRUE)



# create model
# Africa is reference category 
model <- lm(Biodiversity~Climate*Continent, data = alldata)

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
    print(i)
    groupData = data[which(data[[category]]==groups[[i]]), ]
    p <- add_lines(p, data = groupData,
                   y = fitted(lm(data = groupData, groupData[[y]] ~ groupData[[x]])),
                   x = groupData[[x]],
                   line = list(color = paste('rgb', '(', paste(colors[, i], collapse = ", "), ')')),
                   name = groups[[i]],
                   showlegend = FALSE)
    p <- add_markers(p, data = groupData,
                     x = groupData[[x]],
                     y = groupData[[y]],
                     # symbol = groupData[[category]],
                     marker = list(color=paste('rgb','(', paste(colors[, i], collapse = ", "))))
  }
  p <- layout(p, xaxis = list(title = x), yaxis = list(title = y))
  return(p)
}

plotly_interaction(alldata, "Climate", "Biodiversity", "Continent")






###### method of assessing each country as its own linear model ######
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
