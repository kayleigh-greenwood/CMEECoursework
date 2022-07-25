# Comparing biodiversity trends with trends of land use change ( built up areas)

setwd("~/CMEECoursework/Project/code")
rm(list=ls())

#read in BD and climate data
countryBD <- readRDS("../data/RawDataFiles/NHMBiodiversityData/countryBD.RDS")
countryBuilt <- readRDS("../data/RawDataFiles/LandUseBuiltUp/countrybuilt.RDS")

#match years of data
countryBD <- countryBD[(c(intersect(colnames(countryBD), colnames(countryBuilt))))]
countryBuilt <- countryBuilt[(c(intersect(colnames(countryBD), colnames(countryBuilt))))]

# remove rows with NAs
countryBD <- na.omit(countryBD)
countryBuilt <- na.omit(countryBuilt)

# make sure a country is only included in either table if it is present in both
matchingcountrys <- intersect(row.names(countryBD),row.names(countryBuilt))

countryBD <- countryBD[rownames(countryBD) %in% matchingcountrys, ]
countryBuilt <- countryBuilt[rownames(countryBuilt) %in% matchingcountrys, ]

#leaves 175 countries

#create results data frame
resultsDF <- data.frame(matchingcountrys)

#make the countrys the row names
row.names(resultsDF) <- matchingcountrys
resultsDF <- resultsDF[-1]
resultsDF$corr <- NA

# loop through countrys and find significant correlation coefficients

for (country in seq_along(matchingcountrys)){
  
  BDvalues <- as.numeric(as.vector(countryBD[country,]))
  Builtvalues <- as.numeric(as.vector(countryBuilt[country,]))
  
  #myDF <- data.frame(colnames(countryBD), BD, Climate)
  
  # fit model
  model <- (lm(BDvalues~Builtvalues))
  
  #plot models
  #plot(x=Builtvalues, y=BDvalues)
  #abline(model)
  
  #check if p value is below 0.05 (make sure )
  if (as.numeric(summary(model)$coefficients[,4][2]) < 0.05){
    # REMEMBER TO ADD THIS P VALUE SIGNIFICANCE BACK IN
    #add correlation result to results data frame
    resultsDF$corr[country] <- as.numeric(model[[1]][2])
  }
  
}

########  I DON'T THINK IT WORKS BECAUSE THERE ARE ONLY THREE DATA POINTS FOR EACH COUNTRY AND THEREFORE NOT ENOUGH DEGREES OF FREEDOM

#remove unnecessary variables from loop
rm(list=c("BDvalues", "Builtvalues","model", "country"))

#remove NAs where p value wasn't significant
resultsDF <- na.omit(resultsDF)


#leaves us with 1 country



#visualize

resultsDF$ID <- 1:175
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

resultsDF$ID <- 1:175
plot(x=resultsDF$ID,y=resultsDF$corr, col=factor(resultsDF$continent))

require(ggplot2)
qplot(resultsDF$continent, resultsDF$corr)
qplot(resultsDF$continent, resultsDF$corr, 
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
