# Modelling all pressures together (one model per country)

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
# countryGHG <- readRDS("../data/RawDataFiles/greenhousegas/countrygreenhouse.RDS") # excluding for now as this dataset only contains 63 countries
countryInvasive <- readRDS("../data/RawDataFiles/invasivespecies/countryinvasive.RDS")
countryClimate<- readRDS("../data/RawDataFiles/WorldBankClimateData/countryclimate.RDS")
# countryBuilt <- readRDS("../data/RawDataFiles/LandUseBuiltUp/countrybuilt.RDS") # excluding for now as this dataset only contains 4 years of data

#################################################################################################################################################
## WRANGLE DATASETS  ##
#################################################################################################################################################

# remove complete rows of NAs
countryBD <- na.omit(countryBD)


# reshape invasive species and make country into row name
library(reshape2)
countryInvasive <- dcast(countryInvasive, country ~ FirstRecord)
row.names(countryInvasive) <- countryInvasive$country
countryInvasive <- countryInvasive[-c(1)]

# find out which years match
matchingyears <- intersect(intersect(colnames(countryBD), colnames(countryInvasive)), colnames(countryClimate))

# find out which countries match
matchingcountrys <- intersect(intersect(rownames(countryBD), rownames(countryInvasive)), rownames(countryClimate))

# filter datasets for correct years
countryBD <- countryBD[c(matchingyears)]
countryClimate <- countryClimate[c(matchingyears)]
countryInvasive <- countryInvasive[c(matchingyears)]

# remove country as row name
library(tibble)
countryBD <- tibble::rownames_to_column(countryBD, "country")
countryClimate <- tibble::rownames_to_column(countryClimate, "country")
countryInvasive <- tibble::rownames_to_column(countryInvasive, "country")

# filter datasets for correct countries

countryBD <- countryBD[countryBD$country %in% matchingcountrys,]
countryClimate <- countryClimate[countryClimate$country %in% matchingcountrys,]
countryInvasive <- countryInvasive[countryInvasive$country %in% matchingcountrys,]

# change all NAs in invasive species to 0s. Is this problematic? it will give zero inflation. does first record actually mean anything also, wouldnt total number be better? the invasive species are unlikely to have an effect that year