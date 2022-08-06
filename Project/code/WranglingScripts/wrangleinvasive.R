# wrangling the invasive species data

#################################
## SET-UP WORKSPACE AND IMPORT ##
#################################

library(readr)
setwd("~/CMEECoursework/Project/data/RawDataFiles/invasivespecies/")
rm(list=ls())

library(readxl)
countryinvasive <- read_excel("GlobalAlienSpeciesFirstRecordDatabase_v2(1).xlsx", sheet=2)

##################
## WRANGLE DATA ##
##################

# exclude irrelevant columns
countryinvasive <- countryinvasive[c("TaxonName", "Region", "FirstRecord")]

# turn taxon column into a count
library(dplyr)
countryinvasive <- countryinvasive %>% group_by(Region, FirstRecord) %>% summarise(TaxonCount = n())

#make country the row name
names <- countryinvasive$Country
row.names(countryinvasive) <- names
countryinvasive = countryinvasive[-c(1)]

#################
## EXPORT DATA ##
#################

saveRDS(countryinvasive, file = "countryinvasive.RDS")
