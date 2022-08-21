# wrangling climate change data

# set up workspace
rm(list=ls())
setwd("../../Data/ClimateData/RawClimateData/")

# create list of file names
files = c()
files <- list.files(pattern="*.csv", full.names=FALSE, recursive=FALSE)

#create list of the data frames
my_data <- lapply(files, data.table::fread)

#name the list elements correctly
names(my_data) <- gsub("\\.csv$", "", files)

#create empty df
finaldf <- data.frame()[1:120, ]

#create vector of row names
rownameslist <- seq(1901, 2020)

#make these the row names of the data frame
rownames(finaldf) <- rownameslist 

# make list of column names I would like to extract
columnnames <- c()
counter = 0

for (country in my_data){
  counter = counter + 1
  
  #create list of column names
  columnnames <- append(columnnames, colnames(country)[2])
  
  #select the data for this country
  finaldf <- cbind(finaldf, country[[2]])
}

#add column names
names(finaldf) <- columnnames

#sort column names alphabetically
finaldf <- finaldf[ , order(names(finaldf))]

#pivot long
finaldf <- t(finaldf)

# convert to data frame
climatecountry <- as.data.frame(finaldf)

# convert rownames to column
climatecountry <- tibble::rownames_to_column(climatecountry, "Country")

#export as RDS
saveRDS(climatecountry, file = "../WrangledClimateData.RDS")
