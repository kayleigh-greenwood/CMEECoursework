# Comparing Invasive species trends with Biodiversity trends

#################################################################################################################################################
## SET UP WORKSPACE ##
#################################################################################################################################################

rm(list=ls())

library(tidyr) # for pivot_longer
library(dplyr) # for left_join
library(countrycode) # for countrycode
library(plotrix) # for std.error
library(graphics) # for boxplot
library(grDevices) # for pdf
library(stats) # for lm
library(ggplot2) # for various plotting commands
library(rnaturalearth) # for ne_countries
library(tibble) # for rownames_To_column

#################################################################################################################################################
## IMPORT DATA ##
#################################################################################################################################################

#read in BD and Invasive data
countryBD <- readRDS("../../Data/BiodiversityData/WrangledBiodiversityData.RDS")
countryInvasive <- readRDS("../../Data/InvasiveSpeciesData/WrangledInvasiveSpeciesData.RDS")

#################################################################################################################################################
## WRANGLE DATASETS  ##
#################################################################################################################################################

#match years of data
matchedyears <- c(intersect(colnames(countryBD), countryInvasive$FirstRecord))
countryInvasive <- subset(countryInvasive, FirstRecord %in% matchedyears)

# remove rows with NAs (might be pointless because i changed the way i match years in this script)
countryBD <- na.omit(countryBD)
countryInvasive <- na.omit(countryInvasive)

# make sure a country is only included in either table if it is present in both
matchingcountrys <- intersect(countryBD$Country, countryInvasive$Country)

countryBD <- countryBD[countryBD$Country %in% matchingcountrys, ]
countryInvasive <- subset(countryInvasive, Country %in% matchingcountrys) 

# check countrys matched and above method worked
levels(as.factor(countryInvasive$Country))==countryBD$Country

##################################
## PREPARE AND MERGE DATAFRAMES ##
##################################
#create results data frame
resultsDF <- data.frame(matchingcountrys)
colnames(resultsDF)[1] <- "Country"
resultsDF$corr <- NA
resultsDF$se <- NA

# pivot BD dataframe longer
countryBD <- pivot_longer(countryBD, -c(Country), values_to = "Biodiversity", names_to = "Year")
colnames(countryInvasive)[2] <- "Year"

# merge data frames into one
alldata <- merge(countryInvasive, countryBD, by=c("Country", "Year"))

###############################
## OBTAIN SENSITIVITY SCORES ##
###############################
# loop through countrys and find significant correlation coefficients
for (countryloop in seq_along(matchingcountrys)){ # this for loop is absolutely fucked and doesn't work
  
  # make subset of dataframe containing only entries from that country
  onecountry <- alldata %>% dplyr::filter(Country == matchingcountrys[countryloop])
  
  if (length(levels(as.factor(onecountry$TaxonCount)))>1) {
    # fit model
    model <- (lm(onecountry$Biodiversity~onecountry$TaxonCount))

    #add correlation result to results data frame
    resultsDF$corr[countryloop] <- as.numeric(model[[1]][2])
    resultsDF$se[countryloop] <- as.numeric(sqrt(diag(vcov(model)))[2])
    
    }
  }

#remove NAs 
resultsDF <- na.omit(resultsDF)

## remove countries with SE of 0
resultsDF <- subset(resultsDF, se != 0)

# get continents and region
resultsDF$continent <- countrycode(sourcevar = resultsDF$Country,
                                   origin = "country.name",
                                   destination = "continent")
resultsDF$region <- countrycode(sourcevar = resultsDF$Country,
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

# investigate surprising outliers
Europesubset <- subset(resultsDF, resultsDF$continent == "Europe")
Europeanoutlier <- as.character(Europesubset[which(Europesubset$corr == max(Europesubset$corr)), "Country"])
outlierdata <- alldata[c(which(alldata$Country == Europeanoutlier)), ]
bosniaplot <- plot(outlierdata$TaxonCount, outlierdata$Biodiversity) # looks normal
# standard error of Bosnia and Herzegovina is larges (mid-range)

# investigate surprising outliers
Africasubset <- subset(resultsDF, resultsDF$continent == "Africa")
Africanoutlier <- as.character(Africasubset[which(Africasubset$corr == max(Africasubset$corr)), "Country"])
outlierdata <- alldata[c(which(alldata$Country == Africanoutlier)), ]
malawiplot <- plot(outlierdata$TaxonCount, outlierdata$Biodiversity) # looks normal

##################################################
## DESCRIPTIVE STATISTICS OF SENSITIVITY SCORES ##
##################################################

mean(resultsDF$corr)
std.error(resultsDF$corr)
range(resultsDF$corr)
##################################
## VISUALISE SENSITIVITY SCORES ##
##################################
theme_set(theme_bw())

world <- ne_countries(scale = "medium", returnclass = "sf")

InvasiveSpeciesMapData <- map_data("world")
names(InvasiveSpeciesMapData)[names(InvasiveSpeciesMapData) == 'region'] <- 'Country' # change the name of the countries column to match the other DF

InvasiveSpeciesMapData <- left_join(InvasiveSpeciesMapData, resultsDF, by='Country') # join the data frames

pdf(file="../../Images/InvasiveSpeciesSensitivityMap.pdf")

InvasiveSpeciesMap<- ggplot(InvasiveSpeciesMapData, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill= corr), colour = "black")

InvasiveSpeciesMap<- InvasiveSpeciesMap+ scale_fill_gradient2(name="Sensitivity Score", midpoint = 0, mid = "white", high = "darkgoldenrod2", low = "blue4", limits = c(-0.02300199, 0.05477225), space="Lab") # maybe would be better to make all countries below zero on a different colour gradient

# Remove axis titles and details
InvasiveSpeciesMap<- InvasiveSpeciesMap+ theme(axis.text.x=element_blank(), 
                   axis.ticks.x=element_blank(),
                   axis.text.y=element_blank(),
                   axis.ticks.y=element_blank(),
                   axis.title.y = element_blank(),
                   axis.title.x = element_blank())
InvasiveSpeciesMap<- InvasiveSpeciesMap+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = c(0.1, 0.25))

InvasiveSpeciesMap

dev.off()


##################################
## COMPARING SENSITIVITY SCORES ##
##################################


ggplot(data = resultsDF, mapping = aes(y=corr, x=continent)) +
  geom_point() # plot sensitivity score against continent (Scatter)

pdf(file="../../Images/InvasiveSpeciesSensitivityBoxplot.pdf")
boxplot(corr ~ continent, data=resultsDF) # plot sensitivity score against continent (boxplot)
dev.off()



# make reference category the most numerous one
abundancetable <- table(resultsDF$continent)
resultsDF$continent <- relevel(factor(resultsDF$continent), ref = "Europe")


sensitivitymodel <- lm(resultsDF$corr ~ resultsDF$continent, weights = 1/(resultsDF$se))

summary(sensitivitymodel)











