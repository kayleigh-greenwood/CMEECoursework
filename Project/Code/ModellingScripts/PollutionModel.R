# comparing biodiversity trends with greenhosue gas trends

#################################################################################################################################################
## SET UP WORKSPACE ##
#################################################################################################################################################

rm(list=ls())

library(tibble) # for rownames_to_column
library(tidyr) # for pivot_longer
library(countrycode) # for countrycode
library(ggplot2) # for various plotting commands
library(graphics) # for boxplot
library(grDevices) # for pdf
library(dplyr) # for left_join
library(rnaturalearth) # for ne_countries
library(stats) # for lm

#################################################################################################################################################
## IMPORT DATA ##
#################################################################################################################################################

#read in BD and GHG data
countryBD <- readRDS("../../Data/BiodiversityData/WrangledBiodiversityData.RDS")
countryGHG <- readRDS("../../Data/PollutionData/WrangledPollutionData.RDS")

#################################################################################################################################################
## WRANGLE DATASETS  ##
#################################################################################################################################################

#match years of data
countryBD <- countryBD[(c(intersect(colnames(countryBD), colnames(countryGHG))))]
countryGHG <- countryGHG[(c(intersect(colnames(countryBD), colnames(countryGHG))))]

# remove rows with NAs
countryBD <- na.omit(countryBD)
countryGHG <- na.omit(countryGHG)

# make sure a country is only included in either table if it is present in both
matchingcountrys <- intersect(countryBD$Country, countryGHG$Country)

countryBD <- countryBD[countryBD$Country %in% matchingcountrys, ]
countryGHG <- countryGHG[countryGHG$Country %in% matchingcountrys, ]

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

# loop through countrys and find significant correlation coefficients

for (country in seq_along(matchingcountrys)){
  
  BDvalues <- as.numeric(as.vector(countryBD[country,]))
  GHGvalues <- as.numeric(as.vector(countryGHG[country,]))
  
  #myDF <- data.frame(colnames(countryBD), BD, GHG)
  
  # fit model
  model <- (lm(BDvalues~GHGvalues))

  #add correlation result to results data frame
  resultsDF$corr[country] <- as.numeric(model[[1]][2])
  resultsDF$se[country] <- as.numeric(sqrt(diag(vcov(model)))[2])
}

#add in continents and regions
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
##################################
## VISUALISE SENSITIVITY SCORES ##
##################################

####################################
## Map with gradient colour scale ##
####################################

theme_set(theme_bw())

world <- ne_countries(scale = "medium", returnclass = "sf")

mapdata <- map_data("world")
resultsDFmapping <- tibble::rownames_to_column(resultsDF, "country") # create new results DF where country is a column so that it can be joined with another df
names(mapdata)[names(mapdata) == 'region'] <- 'country' # change the name of the countries column to match the other DF

mapdata <- left_join(mapdata, resultsDFmapping, by='country') # join the data frames

pdf(file="../../Images/PollutionSensitivityMap.pdf")

# base plot
map <- ggplot(mapdata, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill= corr), colour = "black") 

# add colours
map <- map + scale_fill_gradient2(name="Sensitivity Score", midpoint = 0, mid = "white", high = "darkgoldenrod2", low = "blue4", limits = c(-0.0004, 0.00008), space="Lab") # maybe would be better to make all countries below zero on a different colour gradient

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

##################################
## COMPARING SENSITIVITY SCORES ##
##################################


ggplot(data = resultsDF, mapping = aes(y=corr, x=continent, xlab = "Continent", ylab = "Sensitivity Score")) +
  geom_point() + #plot sensitivity score against continent (Scatter)
  ylab("Sensitivity Score")

pdf(file="../../Images/PollutionSensitivityBoxplot.pdf")
boxplot(corr ~ continent, data=resultsDF,  xlab = "Continent", ylab = "Sensitivity Score") # plot sensitivity score against continent (boxplot)
dev.off()

###################################
## model continental differences ##
###################################
mean(resultsDF$corr)

# remove 13th country (cyprus) because SE was 0 and can't get inverse of 0 (it's infinity!)
resultsDF <- resultsDF[-13,]

sensitivitymodel <- lm(resultsDF$corr ~ resultsDF$continent, weights = 1/(resultsDF$se))
summary(sensitivitymodel)










