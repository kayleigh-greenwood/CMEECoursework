rm(list=ls())
library("rjson")
library("stringr")

# import JSON data
newDF <- fromJSON(file="~/CMEECoursework/Project/data/RawDataFiles/NHMBiodiversityData/area_code_hier.json")

# convert JSON to data frame
newDF <- data.frame(myData = unlist(newDF))

#convert from 1 column to 2
newDF <- as.data.frame(matrix(newDF$myData, ncol = 2, byrow = TRUE))

# re-format area codes
counter = 0
notcountrys = c()
for (x in newDF$V1){
  counter = counter + 1
  # replace full stops with dashes in area codes
  newDF[counter, 1] = str_replace_all(x, "\\.", "-")
  
  #remove any hierarchy above country
  areacode = x
  lastindex = substr(areacode, nchar(areacode), nchar(areacode))
  if (!is.na(as.numeric(lastindex))){
    #is not country, add to list of row numbers
    notcountrys = append(notcountrys, counter)
  }
}

print(notcountrys)
newDF = newDF[-c(notcountrys),]


#export to excel
#install.packages("writexl")
library("writexl")
write_xlsx(newDF,"area_codes.xlsx")

#export as rds
areacodes = newDF
saveRDS(newDF, file = "areacodes.RDS")

