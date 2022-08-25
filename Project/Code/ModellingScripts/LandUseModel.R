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

###################################
## refine data, remove outliers ##
###################################

# pivot BD dataframe longer
countryBD <- pivot_longer(countryBD, -c(Country), values_to = "Biodiversity", names_to = "Year")
countryBuilt <- pivot_longer(countryBuilt, -c(Country), values_to = "Built", names_to = "Year")

# merge data frames into one
alldata <- merge(countryBuilt, countryBD, by=c("Country", "Year"))

# investigate surprising outliers
Europesubset <- subset(resultsDF, resultsDF$continent == "Europe")
Europeanoutlier <- as.character(Europesubset[which(Europesubset$corr == max(Europesubset$corr)), "country"])
outlierdata <- alldata[c(which(alldata$Country == Europeanoutlier)), ]
irelandplot <- plot(outlierdata$Built, outlierdata$Biodiversity) # looks normal

# remove the outlier of Ireland
resultsDF <- subset(resultsDF, country != "Ireland")

# investigate surprising outliers
SAmericasubset <- subset(resultsDF, resultsDF$continent == "S. America")
SAmericanoutlier <- as.character(SAmericasubset[which(SAmericasubset$corr == min(SAmericasubset$corr)), "country"])
outlierdata <- alldata[c(which(alldata$Country == SAmericanoutlier)), ]
hondurasplot <- plot(outlierdata$Built, outlierdata$Biodiversity) # looks normal

# remove the outlier of Honduras
resultsDF <- subset(resultsDF, country != "Honduras")

# investigate surprising outliers
Oceaniasubset <- subset(resultsDF, resultsDF$continent == "Oceania")
Oceanianoutlier <- as.character(Oceaniasubset[which(Oceaniasubset$corr == max(Oceaniasubset$corr)), "country"])
outlierdata <- alldata[c(which(alldata$Country == Oceanianoutlier)), ]
samoaplot <- plot(outlierdata$Built, outlierdata$Biodiversity) # looks normal

# remove outlier
resultsDF <- subset(resultsDF, country != "Samoa")

resultsDF$se[resultsDF$se== 0] <-8.131929e-08 

##################################
## VISUALISE SENSITIVITY SCORES ##
##################################

####################################
## Map with gradient colour scale ##
####################################

theme_set(theme_bw())

world <- ne_countries(scale = "medium", returnclass = "sf")

LandUseMapData <- map_data("world")

names(LandUseMapData)[names(LandUseMapData) == 'region'] <- 'country' # change the name of the countries column to match the other DF

LandUseMapData <- left_join(LandUseMapData, resultsDF, by='country') # join the data frames

minval = min(resultsDF$corr)
maxval = max(resultsDF$cor)
pdf(file="../../Images/LandUseSensitivityMap.pdf")

# base plot
LandUseMap<- ggplot(LandUseMapData, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill= corr), colour = "black") 

# add colours
LandUseMap<- LandUseMap+ scale_fill_gradient2(name="Sensitivity Score", midpoint = 0, mid = "white", high = "darkgoldenrod2", low = "blue4", limits = c(-0.121097, 0.07003952), space="Lab") # maybe would be better to make all countries below zero on a different colour gradient

# Remove axis titles and details
LandUseMap<- LandUseMap+ theme(axis.text.x=element_blank(), 
                   axis.ticks.x=element_blank(),
                   axis.text.y=element_blank(),
                   axis.ticks.y=element_blank(),
                   axis.title.y = element_blank(),
                   axis.title.x = element_blank())
LandUseMap<- LandUseMap+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = c(0.1, 0.25))

LandUseMap

dev.off()

##################################
## COMPARING SENSITIVITY SCORES ##
##################################

ggplot(data = resultsDF, mapping = aes(y=corr, x=continent, xlab = "Continent", ylab = "Sensitivity Score")) +
  geom_point() + #plot sensitivity score against continent (Scatter)
  ylab("Sensitivity Score")

pdf(file="../../Images/LandUseSensitivityBoxplot.pdf")
boxplot(corr ~ continent, data=resultsDF,  xlab = "Continent", ylab = "Land Use Change Sensitivity Score") # plot sensitivity score against continent (boxplot)
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
# make reference category the most numerous one

abundancetable <- table(resultsDF$continent)
resultsDF$continent <- relevel(factor(resultsDF$continent), ref = "Africa")


sensitivitymodel <- lm(resultsDF$corr ~ resultsDF$continent, weights = 1/(resultsDF$se))
summary(sensitivitymodel)

