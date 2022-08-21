# Wrangling the greenhouse gas data

# set up environment
setwd("../../Data/PollutionData/")
rm(list=ls())

# load packages
library(readr) # for read_csv
library(tidyr) # for pivot_wider

#import data
countrygreenhouse <- read_csv("RawPollutionData.csv")

#extract greenhouse gas rows only
countrygreenhouse <- countrygreenhouse[countrygreenhouse$POL=="GHG",]

# extract correct variable
countrygreenhouse <- countrygreenhouse[countrygreenhouse$Variable=="Total  emissions excluding LULUCF",]

#remove irrelevant columns
countrygreenhouse <- countrygreenhouse[c("Country", "Year", "Value")]

#wrangle from long to wide
countrygreenhouse = pivot_wider(countrygreenhouse, names_from = Year, values_from = Value)

#turn tibble to DF
countrygreenhouse <- as.data.frame(countrygreenhouse)

#export as RDS
saveRDS(countrygreenhouse, file = "WrangledPollutionData.RDS")
