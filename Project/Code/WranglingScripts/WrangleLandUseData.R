# wrangling the land use (built up areas) data

# set up workspace
rm(list=ls())
setwd("../../Data/LandUseData/")

# load packages
library(readr) # for read_csv
library(tidyr) # for pivot_wider

#import data
countrybuilt <- read_csv("RawLandUseData.csv")

#extract square kilometer values only
countrybuilt <- countrybuilt[countrybuilt$MEAS=="SQKM",]

#extract correct variable
countrybuilt <- countrybuilt[countrybuilt$VAR=="BUILT_UP_BEFORE",]

#extract relevant columns
countrybuilt <- countrybuilt[c("Country", "Year", "Value")]

#wrangle from long to wide
countrybuilt = pivot_wider(countrybuilt, names_from = Year, values_from = Value)

#turn tibble to DF
countrybuilt <- as.data.frame(countrybuilt)

#export as RDS
saveRDS(countrybuilt, file = "WrangledLandUseData.RDS")
