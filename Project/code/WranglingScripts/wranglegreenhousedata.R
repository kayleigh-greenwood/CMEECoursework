# Wrangling the greenhouse gas data

setwd("~/CMEECoursework/Project/data/RawDataFiles/greenhousegas/")
rm(list=ls())

#import data
countrygreenhouse <- read_csv("AIR_GHG_27062022101434000.csv")

#extract greenhouse gas rows only
countrygreenhouse <- countrygreenhouse[countrygreenhouse$POL=="GHG",]

# this line shows the available versions of the data
# levels(as.factor(countrygreenhouse$Variable))

# extract correct variable
countrygreenhouse <- countrygreenhouse[countrygreenhouse$Variable=="Total  emissions excluding LULUCF",]

#remove irrelevant columns
countrygreenhouse <- countrygreenhouse[c("Country", "Year", "Value")]

#wrangle from long to wide
library(tidyr)
library(dplyr)
countrygreenhouse = pivot_wider(countrygreenhouse, names_from = Year, values_from = Value)

#turn tibble to DF
countrygreenhouse <- as.data.frame(countrygreenhouse)

#make country the row name
names <- countrygreenhouse$Country
row.names(countrygreenhouse) <- names
countrygreenhouse = countrygreenhouse[-c(1)]


#export as RDS
saveRDS(countrygreenhouse, file = "countrygreenhouse.RDS")
