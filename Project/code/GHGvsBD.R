# comparing biodiversity trends with greenhosue gas trends

setwd("~/CMEECoursework/Project/code")
rm(list=ls())

#read in BD and climate data
countryBD <- readRDS("../data/RawDataFiles/NHMBiodiversityData/countryBD.RDS")
countryGHG <- readRDS("../data/RawDataFiles/greenhousegas/countrygreenhouse.RDS")

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
  
  #myDF <- data.frame(colnames(countryBD), BD, Climate)
  
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


