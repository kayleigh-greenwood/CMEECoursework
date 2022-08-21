# set up environment
rm(list=ls())
setwd("../../Data/BiodiversityData")

# set up libraries
library(rjson) # for fromJSON() 
library(stringr) # for str_replace_all()
library(tidyr) # for pivot_wider()

# import JSON data
AreaCodes <- fromJSON(file="RawAreaCodes.json")

# convert JSON to data frame
AreaCodes <- data.frame(myData = unlist(AreaCodes))

#convert from 1 column to 2
AreaCodes <- as.data.frame(matrix(AreaCodes$myData, ncol = 2, byrow = TRUE))

# convert first column to character
AreaCodes$V1 <- as.character(AreaCodes$V1)

# create variables for loop
counter = 0
notcountrys = c()

# create vector of which rows aren't countries
for (codestring in AreaCodes$V1){
  counter = counter + 1
  
  # replace full stops with dashes in area codes
  AreaCodes[counter, 1] = str_replace_all(codestring, "\\.", "-")
  
  # identify last character in string
  lastindex = substr(codestring, nchar(codestring), nchar(codestring))
  
  # if not a country (if last character isn't a letter)
  if (!is.na(as.numeric(lastindex))){
    
    # add to list of row numbers
    notcountrys = append(notcountrys, counter)
  }
} # ignore warnings, they are warnings of NAs

# remove rows that aren't countries
AreaCodes = AreaCodes[-c(notcountrys),]

#import biodiversity data
countryBD <- readRDS("RawBiodiversityData.RDS")

# extract BII (biodiversity) values only
countryBD <- countryBD[countryBD$variable=="bii",]

# extract historical values only, removing predictions
countryBD <- countryBD[countryBD$scenario=="historical",]

#remove irrelevant columns
countryBD = subset(countryBD, select= -c(scenario, variable, lower_uncertainty, upper_uncertainty))

# determine which columns are countrys
counter = 0
notcountrysBD = c()
for (code in countryBD$area_code){
  counter = counter + 1
  
  #search for code in code list and replace
  if (code %in% AreaCodes$V1){
    areacoderow <- which(AreaCodes$V1 == code)
    countryBD[counter, 1] <- as.character(AreaCodes[areacoderow, 2])
  } else {
    notcountrysBD = append(notcountrysBD, counter)
  }
}

#remove entries for any hierarchy above country
countryBD = countryBD[-c(notcountrysBD),]

#re-format to get table of country by year
countryBD = pivot_wider(countryBD, names_from = year, values_from = value)

#convert tibble to data frame
countryBD <- as.data.frame(countryBD)

#sort by alphabetical
countryBD <- countryBD[ order(countryBD$area_code) , ]

# remove rows with NAs
countryBD <- na.omit(countryBD)

# change column names
names(countryBD)[1] <- "Country"

# sort out row numbers
row.names(countryBD) <- 1:nrow(countryBD)

#export as RDS
saveRDS(countryBD, file = "WrangledBiodiversityData.RDS")

