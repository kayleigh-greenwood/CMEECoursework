####################
## Data Wrangling ##
####################

## imports ##

require(tidyverse)

## load dataset ##

MyData <- as.data.frame(read_csv("../data/LogisticGrowthData.csv"), na.strings=("NA"))
# import csv content as a dataframe

## alter dataset ##

MyData<-subset(MyData, Time>=0)
# removed all time points less than 0

MyData<-subset(MyData, PopBio>0)
# removed all populations/masses less than 0

MyData$ID <- paste(MyData$Species, MyData$Temp, MyData$Medium, MyData$Citation, sep=" ")
# create new ID column

MyData$ID <- as.factor(MyData$ID)
# turn ID column into factor

levels(MyData$ID) <- 1:285
# replace ID names with numbers

for (i in 1:nlevels(MyData$ID)){
  if ((length(which(MyData$ID == i))) < 5) {
    MyData <- MyData[!(MyData$ID==i),]
  }
}
# remove subsets with less than 5 entries

MyData <- droplevels(MyData)
# remove empty levels from data

levels(MyData$ID) <- 1:nlevels(MyData$ID)
# rename ID numbers

levelsummary <- (summary(MyData$ID)[])
# provides the frequencies of most common levels

## Saving data ##
write.csv(MyData, "../data/ModifiedData.csv")

###################
## methods to remember
# summary(x) gives means and other stats for each variable
# hist(data$column) gives histogram of a column
# plot(x ~ y, data=whatever) plots x as response and the different y values as explanatory
# subset using Subset(Data, Suborder=='x')