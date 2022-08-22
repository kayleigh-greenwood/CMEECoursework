# Comparing biodiversity trends with trends of land use change ( built up areas)

#################################################################################################################################################
## SET UP WORKSPACE ##
#################################################################################################################################################

rm(list=ls())

library(plotrix) # for std.error
library(graphics) # for boxplot
library(grDevices) # for pdf and dev.off
library(rnaturalearth) # for ne_countries
library(stats) # for lm 
library(ggplot2) # for many plotting functions
library(countrycode) # for countrycode
library(dplyr) # for left_join

#################################################################################################################################################
## IMPORT DATA ##
#################################################################################################################################################

countryBD <- readRDS("../../Data/BiodiversityData/WrangledBiodiversityData.RDS")
countryBuilt <- readRDS("../../Data/LandUseData/WrangledLandUseData.RDS")

#################################################################################################################################################
## WRANGLE DATASETS  ##
#################################################################################################################################################

#match years of data
countryBD <- countryBD[c(intersect(colnames(countryBD), colnames(countryBuilt)))]
countryBuilt <- countryBuilt[(c(intersect(colnames(countryBD), colnames(countryBuilt))))]

# remove rows with NAs
countryBD <- na.omit(countryBD)
countryBuilt <- na.omit(countryBuilt)

# make sure a country is only included in either table if it is present in both
matchingcountrys <- intersect(countryBD$Country, countryBuilt$Country)
countryBD <- countryBD[countryBD$Country %in% matchingcountrys, ]
countryBuilt <- countryBuilt[countryBuilt$Country %in% matchingcountrys, ]

##################################
## PREPARE AND MERGE DATAFRAMES ##
##################################

#create results data frame
resultsDF <- data.frame(matchingcountrys)

# adjust column name
colnames(resultsDF)[1] <- "country"

#make the countrys the row names
resultsDF$corr <- NA
resultsDF$se <- NA

# loop through countrys and find significant correlation coefficients
for (country in seq_along(matchingcountrys)){
  
  BDvalues <- as.numeric(as.vector(countryBD[country,]))
  Builtvalues <- as.numeric(as.vector(countryBuilt[country,]))
  
  # fit model
  model <- (lm(BDvalues~Builtvalues))
  
  #add correlation result to results data frame
  resultsDF$corr[country] <- as.numeric(model[[1]][2])
  resultsDF$se[country] <- as.numeric(sqrt(diag(vcov(model)))[2])
}

#add in continents and regions
resultsDF$continent <- countrycode(sourcevar = resultsDF$country,
                                   origin = "country.name",
                                   destination = "continent")
resultsDF$region <- countrycode(sourcevar = resultsDF$country,
                                origin = "country.name",
                                destination = "region")
# add western sahara to north africa
resultsDF[172, "region"] <- "Middle East & North Africa"
# this adds north and south america as 'the americas' so i must separate:

for (row in 1:nrow(resultsDF)){
  if (resultsDF[row, "region"]=='Latin America & Caribbean'){
    resultsDF[row, 4] <- 'S. America'
  }
}

resultsDF$continent <- replace(resultsDF$continent, resultsDF$continent=='Americas', 'N. America')

for (row in 1:nrow(resultsDF)){
  if (resultsDF[row, "region"]=='North America'){
    resultsDF[row, 4] <- 'N. America'
  }
}

##################################################
## DESCRIPTIVE STATISTICS OF SENSITIVITY SCORES ##
##################################################

mean(resultsDF$corr)
std.error(resultsDF$corr)
range(resultsDF$corr)

##################################
## VISUALISE SENSITIVITY SCORES ##
##################################

####################################
## Map with gradient colour scale ##
####################################

theme_set(theme_bw())

world <- ne_countries(scale = "medium", returnclass = "sf")

mapdata <- map_data("world")

names(mapdata)[names(mapdata) == 'region'] <- 'country' # change the name of the countries column to match the other DF

mapdata <- left_join(mapdata, resultsDF, by='country') # join the data frames

pdf(file="../../Images/LandUseSensitivityMap.pdf")

# base plot
map <- ggplot(mapdata, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill= corr), colour = "black") 

# add colours
map <- map + scale_fill_gradient2(name="Sensitivity Score", midpoint = 0, mid = "white", high = "darkgoldenrod2", low = "blue4", limits = c(-3.222472, 2.756498), space="Lab") # maybe would be better to make all countries below zero on a different colour gradient

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

pdf(file="../../Images/LandUseSensitivityBoxplot.pdf")
boxplot(corr ~ continent, data=resultsDF,  xlab = "Continent", ylab = "Sensitivity Score") # plot sensitivity score against continent (boxplot)
dev.off()

###################################
## model continental differences ##
###################################
mean(resultsDF$corr)

# remove countries with SE of 0
resultsDF <- subset(resultsDF, se != 0)

sensitivitymodel <- lm(resultsDF$corr ~ resultsDF$continent, weights = 1/(resultsDF$se))
summary(sensitivitymodel)

