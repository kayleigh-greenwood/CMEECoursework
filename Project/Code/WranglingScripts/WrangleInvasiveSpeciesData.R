# wrangling the invasive species data

# set up workspace
rm(list=ls())
setwd("../../Data/InvasiveSpeciesData/")

# load packages
library(readxl) # for read_excel
library(dplyr) # for group_by, n() and summarise

# import data
countryinvasive <- read_excel("RawInvasiveSpeciesData.xlsx", sheet=2)

# exclude irrelevant columns
countryinvasive <- countryinvasive[c("TaxonName", "Region", "FirstRecord")]

# change region to country
colnames(countryinvasive)[2] <- "Country"

# turn taxon column into a count
countryinvasive <- countryinvasive %>% group_by(Country, FirstRecord) %>% summarise(TaxonCount = n())

# export data
saveRDS(countryinvasive, file = "WrangledInvasiveSpeciesData.RDS")

