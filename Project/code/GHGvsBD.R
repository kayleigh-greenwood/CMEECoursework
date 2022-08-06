# comparing biodiversity trends with greenhosue gas trends

#################################################################################################################################################
## SET UP WORKSPACE ##
#################################################################################################################################################

setwd("~/CMEECoursework/Project/code")
rm(list=ls())

#################################################################################################################################################
## IMPORT DATA ##
#################################################################################################################################################

#read in BD and GHG data
countryBD <- readRDS("../data/RawDataFiles/NHMBiodiversityData/countryBD.RDS")
countryGHG <- readRDS("../data/RawDataFiles/greenhousegas/countrygreenhouse.RDS")

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
matchingcountrys <- intersect(row.names(countryBD),row.names(countryGHG))

countryBD <- countryBD[rownames(countryBD) %in% matchingcountrys, ]
countryGHG <- countryGHG[rownames(countryGHG) %in% matchingcountrys, ]

#leaves 43 countries

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
countryGHG2 <- tibble::rownames_to_column(countryGHG, "country")

# pivot both dataframes longer
library(tidyr)
countryGHG2 <- pivot_longer(countryGHG2, -c(country), values_to = "GHG", names_to = "Year")
countryBD2 <- pivot_longer(countryBD2, -c(country), values_to = "Biodiversity", names_to = "Year")

# merge data frames into one
alldata <- merge(countryGHG2, countryBD2, by=c("country", "Year"))

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
plot(alldata$GHG, alldata$Biodiversity, col=cols[alldata$Continent])

legend(1200000,0.6, sort(unique(alldata$Continent)),col=cols,pch=1)


##################
## CREATE MODEL ##
##################

model <- lm(Biodiversity~GHG*Continent, data = alldata)

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

plotly_interaction(alldata, "GHG", "Biodiversity", "Continent")


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
  GHGvalues <- as.numeric(as.vector(countryGHG[country,]))
  
  #myDF <- data.frame(colnames(countryBD), BD, GHG)
  
  # fit model
  model <- (lm(BDvalues~GHGvalues))
  
  #plot models
  #plot(x=GHGvalues, y=BDvalues)
  #abline(model)
  
  #check if p value is below 0.05 (make sure )
  if (as.numeric(summary(model)$coefficients[,4][2]) < 0.05){
    # REMEMBER TO ADD THIS P VALUE SIGNIFICANCE BACK IN
    #add correlation result to results data frame
    resultsDF$corr[country] <- as.numeric(model[[1]][2])
  }
  
}

#remove unnecessary variables from loop
rm(list=c("BDvalues", "GHGvalues","model", "country"))

#remove NAs where p value wasn't significant
resultsDF <- na.omit(resultsDF)

#visualize

resultsDF$ID <- 1:7
plot(x=resultsDF$ID,y=resultsDF$corr)


#add in continents and regions
library(countrycode)
resultsDF$continent <- countrycode(sourcevar = row.names(resultsDF),
                                   origin = "country.name",
                                   destination = "continent")
resultsDF$region <- countrycode(sourcevar = row.names(resultsDF),
                                origin = "country.name",
                                destination = "region")

####### try clustering by continent

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

resultsDF$ID <- 1:7
plot(x=resultsDF$ID,y=resultsDF$corr, col=factor(resultsDF$continent))

require(ggplot2)
qplot(resultsDF$continent, resultsDF$corr)
qplot(resultsDF$continent, resultsDF$corr, 
      geom=c("boxplot"))


