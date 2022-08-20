# Comparing Invasive species trends with Biodiversity trends

#################################################################################################################################################
## SET UP WORKSPACE ##
#################################################################################################################################################

setwd("~/CMEECoursework/Project/code")
rm(list=ls())

#################################################################################################################################################
## IMPORT DATA ##
#################################################################################################################################################

#read in BD and Invasive data
countryBD <- readRDS("../data/RawDataFiles/NHMBiodiversityData/countryBD.RDS")
countryInvasive <- readRDS("../data/RawDataFiles/invasivespecies/countryinvasive.RDS")

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
matchingcountrys <- intersect(row.names(countryBD), countryInvasive$country)

countryBD <- countryBD[rownames(countryBD) %in% matchingcountrys, ]
countryInvasive <- subset(countryInvasive, country %in% matchingcountrys) 

# check countrys matched and above method worked
levels(as.factor(countryInvasive$country))==row.names(countryBD)
nrow(countryBD)

#leaves 147 countries

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

# pivot BD dataframe longer
library(tidyr)
countryBD2 <- pivot_longer(countryBD2, -c(country), values_to = "Biodiversity", names_to = "Year")

# merge data frames into one
colnames(countryInvasive)[2] <- "Year"
alldata <- merge(countryInvasive, countryBD2, by=c("country", "Year"))

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
} # error message here i need to look at

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
plot(alldata$TaxonCount, alldata$Biodiversity, col=cols[alldata$Continent])

legend(50,0.6, sort(unique(alldata$Continent)),col=cols,pch=1)
# serious zero inflation to look at

##################
## CREATE MODEL ##
##################

model <- lm(Biodiversity~TaxonCount*Continent, data = alldata)

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

plotly_interaction(alldata, "TaxonCount", "Biodiversity", "Continent")



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

# make row names into a column
library(tibble)
countryBD2 <- tibble::rownames_to_column(countryBD, "country")

# pivot BD dataframe longer
library(tidyr)
countryBD2 <- pivot_longer(countryBD2, -c(country), values_to = "Biodiversity", names_to = "Year")
colnames(countryInvasive)[2] <- "Year"

# merge data frames into one
alldata <- merge(countryInvasive, countryBD2, by=c("country", "Year"))

###############################
## OBTAIN SENSITIVITY SCORES ##
###############################
library(dplyr)
# loop through countrys and find significant correlation coefficients
for (countryloop in seq_along(matchingcountrys)){ # this for loop is absolutely fucked and doesn't work
  
  print(matchingcountrys[countryloop])
  # make subset of dataframe containing only entries from that country
  onecountry <- alldata %>% dplyr::filter(country == matchingcountrys[countryloop])
  
  if (length(levels(as.factor(onecountry$TaxonCount)))>1) {
    print(onecountry)
    # fit model
    model <- (lm(onecountry$Biodiversity~onecountry$TaxonCount))
    # print(model)
    # plot(onecountry$TaxonCount, onecountry$Biodiversity)
    #abline(model)
    #add correlation result to results data frame
        resultsDF$corr[countryloop] <- as.numeric(model[[1]][2])
    }
  }
}


#remove unnecessary variables from loop
rm(list=c("BDvalues", "Invasivevalues","model", "country"))

#remove NAs 
resultsDF <- na.omit(resultsDF)
#leaves 88 countries from 158 (50%)

# get continents and region
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
# mapdata <- mapdata %>%  filter(!is.na(mapdata$corr))   # remove NAs

pdf(file="../images/invasivesensitivitymapgradient.pdf")

map <- ggplot(mapdata, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill= corr), colour = "black")

map <- map + scale_fill_gradient2(name="Sensitivity Score", midpoint = 0, mid = "white", high = "darkgoldenrod2", low = "blue4", limits = c(-0.02300198, 0.05477224), space="Lab") # maybe would be better to make all countries below zero on a different colour gradient

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

library(ggplot2)

ggplot(data = resultsDF, mapping = aes(y=corr, x=continent)) +
  geom_point() # plot sensitivity score against continent (Scatter)

boxplot(corr ~ continent, data=resultsDF) # plot sensitivity score against continent (boxplot)

sensitivitymodel <- lm(resultsDF$corr ~ resultsDF$continent)

TukeyHSD(x=aov(sensitivitymodel))












