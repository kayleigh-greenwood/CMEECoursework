rm(list=ls())
setwd("~/CMEECoursework/Project/data/RawDataFiles/NHMBiodiversityData")
#import data
countryBDdetail <- readRDS("detailedBDdata.rds")
countrycodes <- readRDS("areacodes.RDS")

# extract BII (biodiversity) values only
countryBDdetail <- countryBDdetail[countryBDdetail$variable=="bii",]

# extract historical values only, removing predictions
countryBDdetail <- countryBDdetail[countryBDdetail$scenario=="historical",]

# determine which columns are countrys
counter = 0
notcountrys = c()
for (code in countryBDdetail$area_code){
  counter = counter + 1
  
  #search for code in code list and replace
  if (code %in% countrycodes$V1){
    newname = which(countrycodes$V1 == code)
    countryBDdetail[counter, 1] = countrycodes[newname, 2]
  } else {
    notcountrys = append(notcountrys, counter)
  }
}


#remove entries for any hierarchy above country
countryBD = countryBDdetail[-c(notcountrys),]

#remove irrelevant columns
countryBD = subset(countryBD, select= -c(scenario, variable, lower_uncertainty, upper_uncertainty))

#re-format to get table of country by year
#install.packages("devtools")
#install.packages("tidyr")
library(tidyr)
library(dplyr)
countryBDwide = pivot_wider(countryBD, names_from = year, values_from = value)

#convert tibble to data frame
countryBDwide <- as.data.frame(countryBDwide)

#sort by alphabetical
countryBDwide <- countryBDwide[ order(countryBDwide$area_code) , ]

#make country the row name
names <- countryBDwide$area_code
row.names(countryBDwide) <- names

countryBDwide = countryBDwide[-c(1)]


#export as RDS
saveRDS(countryBDwide, file = "countryBD.RDS")

