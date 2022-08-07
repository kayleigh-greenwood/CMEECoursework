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

