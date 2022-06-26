setwd("~/CMEECoursework/Project/data/latitudeData")
rm(list=ls())

#import data
countrylatitude <- read_csv("world_country_and_usa_states_latitude_and_longitude_values.csv")

#remove irrelevant columns
countrylatitude <- countrylatitude[c("country", "latitude")]

#sort alphabetically
countrylatitude <- countrylatitude[ order(countrylatitude$country) , ]

#export as RDS
saveRDS(countrylatitude, file = "countrylatitude.RDS")
