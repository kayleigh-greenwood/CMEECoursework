### NOT CURRENTLY WORKING AS OF 26/06

rm(list=ls())
setwd("~/CMEECoursework/Project/code/WranglingScripts")

#import data
countryBD <- readRDS("~/CMEECoursework/Project/data/RawDataFiles/NHMBiodiversityData/countryBD.RDS")

#create time variable
years = c(1970, 1980, 1990)
years = c(years, seq(2000, 2014))

#create function that plots country's BII

plotcountry <- function(countryname) {
  rownum = which(countryBD$area_code==countryname)
  plot(x = years, y = countryBD[rownum, 1:18])
}

#use function to plot country's biodiversity
plotcountry("France")
