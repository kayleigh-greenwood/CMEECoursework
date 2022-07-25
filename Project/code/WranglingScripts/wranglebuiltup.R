# wrangling the land uswe (built up areas) data
library(readr)
setwd("~/CMEECoursework/Project/data/RawDataFiles/LandUseBuiltUp/")
rm(list=ls())

#import data
countrybuilt <- read_csv("BUILT_UP_27062022141923706.csv")

#extract square kilometer values only
countrybuilt <- countrybuilt[countrybuilt$MEAS=="SQKM",]

#extract correct variable
countrybuilt <- countrybuilt[countrybuilt$VAR=="BUILT_UP_BEFORE",]

#extract relevant columns
countrybuilt <- countrybuilt[c("Country", "Year", "Value")]

#wrangle from long to wide
library(tidyr)
library(dplyr)
countrybuilt = pivot_wider(countrybuilt, names_from = Year, values_from = Value)

#turn tibble to DF
countrybuilt <- as.data.frame(countrybuilt)

#make country the row name
names <- countrybuilt$Country
row.names(countrybuilt) <- names
countrybuilt = countrybuilt[-c(1)]


#export as RDS
saveRDS(countrybuilt, file = "countrybuilt.RDS")

