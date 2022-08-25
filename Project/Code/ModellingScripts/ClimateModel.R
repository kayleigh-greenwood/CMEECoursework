# comparing change in climate and BD over time by country

#################################################################################################################################################
## SET UP WORKSPACE ##
#################################################################################################################################################
rm(list=ls())

library(tidyr) # for pivot_longer
library(tibble) # for rownames_to_column
library(graphics) # for boxplot
library(grDevices) # for pdf
library(countrycode) # for countrycode
library(ggplot2) # for various plotting commands
library(dplyr) # for left join
library(plotrix) # for std.error
library(stats) # for lm
library(rnaturalearth) # for ne_countries

#################################################################################################################################################
## IMPORT DATA ##
#################################################################################################################################################
countryBD<- readRDS("../../Data/BiodiversityData/WrangledBiodiversityData.RDS")
countryClimate<- readRDS("../../Data/ClimateData/WrangledClimateData.RDS")

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
matchingcountrys <- intersect(countryBD$Country, countryClimate$Country)
# make sure a country is only included in either table if it is present in both

countryBD <- countryBD[countryBD$Country %in% matchingcountrys, ]
countryClimate <- countryClimate[countryClimate$Country %in% matchingcountrys, ]


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

## OBTAIN SENSITIVITY SCORES ##
###############################

# loop through countrys and find significant correlation coefficients
for (country in seq_along(matchingcountrys)){
  
  BDvalues <- as.numeric(as.vector(countryBD[country,]))
  Climatevalues <- as.numeric(as.vector(countryClimate[country,]))
  
  myDF <- data.frame(colnames(countryBD), BDvalues, Climatevalues)
  
  # fit model
  model <- (lm(BDvalues~Climatevalues))

  #add correlation result to results data frame
  resultsDF$corr[country] <- as.numeric(model[[1]][2])
  resultsDF$se[country] <- as.numeric(sqrt(diag(vcov(model)))[2])
}

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
    resultsDF[row, 3] <- 'S. America'
  }
}

resultsDF$continent <- replace(resultsDF$continent, resultsDF$continent=='Americas', 'N. America')

for (row in 1:nrow(resultsDF)){
  if (resultsDF[row, 4]=='North America'){
    resultsDF[row, 3] <- 'N. America'
  }
}

######################
## remove outliers and other values
#####################

# pivot BD dataframe longer
countryBD <- pivot_longer(countryBD, -c(Country), values_to = "Biodiversity", names_to = "Year")
countryClimate <- pivot_longer(countryClimate, -c(Country), values_to = "Climate", names_to = "Year")

# merge data frames into one
alldata <- merge(countryClimate, countryBD, by=c("Country", "Year"))

# investigate surprising outliers
Oceaniasubset <- subset(resultsDF, resultsDF$continent == "Oceania")
Oceanianoutlier <- as.character(row.names(Oceaniasubset[which(Oceaniasubset$corr == min(Oceaniasubset$corr)), ]))
outlierdata <- alldata[c(which(alldata$Country == Oceanianoutlier)), ]
fijiplot <- plot(outlierdata$Climate, outlierdata$Biodiversity) # looks normal
# standard error of Bosnia and Herzegovina is larges (mid-range)


##################################
## VISUALISE SENSITIVITY SCORES ##
##################################

####################################
## Map with gradient colour scale ##
####################################

theme_set(theme_bw())

world <- ne_countries(scale = "medium", returnclass = "sf")

ClimateMapData <- map_data("world")
resultsDFmapping <- tibble::rownames_to_column(resultsDF, "country") # create new results DF where country is a column so that it can be joined with another df
names(ClimateMapData)[names(ClimateMapData) == 'region'] <- 'country' # change the name of the countries column to match the other DF

ClimateMapData <- left_join(ClimateMapData, resultsDFmapping, by='country') # join the data frames

minval <- min(resultsDF$corr)
maxval <- max(resultsDF$corr)

pdf(file="../../Images/ClimateSensitivityMap.pdf")

# base plot
ClimateMap <- ggplot(ClimateMapData, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill= corr), colour = "black") 

# add colours
ClimateMap <- ClimateMap + scale_fill_gradient2(name="Sensitivity Score", midpoint = 0, mid = "white", high = "darkgoldenrod2", low = "blue4", limits = c(-0.2400587, 0.0775445), space="Lab") # maybe would be better to make all countries below zero on a different colour gradient

# Remove axis titles and details
ClimateMap <- ClimateMap + theme(axis.text.x=element_blank(), 
                   axis.ticks.x=element_blank(),
                   axis.text.y=element_blank(),
                   axis.ticks.y=element_blank(),
                   axis.title.y = element_blank(),
                   axis.title.x = element_blank())
ClimateMap <- ClimateMap + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = c(0.1, 0.25))

ClimateMap

dev.off()



##################################
## COMPARING SENSITIVITY SCORES ##
##################################

ggplot(data = resultsDF, mapping = aes(y=corr, x=continent, xlab = "Continent", ylab = "Sensitivity Score")) +
  geom_point() + #plot sensitivity score against continent (Scatter)
  ylab("Sensitivity Score")

pdf(file="../../Images/ClimateSensitivityBoxplot.pdf")
boxplot(corr ~ continent, data=resultsDF,  xlab = "Continent", ylab = "Climate Change Sensitivity Score") # plot sensitivity score against continent (boxplot)
dev.off()

##################################################
## DESCRIPTIVE STATISTICS OF SENSITIVITY SCORES ##
##################################################

mean(resultsDF$corr)
std.error(resultsDF$corr)
range(resultsDF$corr)
###################################
## model continental differences ##
###################################


# reset reference category as most abundant
abundancetable <- table(resultsDF$continent)

resultsDF$continent <- relevel(factor(resultsDF$continent), ref = "Africa")
sensitivitymodel <- lm(resultsDF$corr ~ resultsDF$continent, weights = 1/(resultsDF$se))
summary(sensitivitymodel)
