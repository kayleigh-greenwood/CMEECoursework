################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# Load the dataset ###############
rm(list=ls())

require(tidyverse)

MyData <- as.matrix(read_csv("../data/PoundHillData.csv", col_names = FALSE)) 
# col_names = FALSE guarantees data is imported as is. Otherwise, read.csv would convert first row to column headers

MyMetaData <- read_csv2("../data/PoundHillMetaData.csv", col_names = TRUE) 
# header is true because the file does contain headers

############# Inspect the dataset ###############

as_tibble(MyData) 
# tidyverse equivalent to head(MyData) as it displays the first 10 lines, but head is better
dim_desc(MyData) 
# dimensions, equivalent to dim()
dplyr::glimpse(MyData) 
# compactly display the structure
# like str(), but nicer!
# dbl means double precision floating point number
utils::View(MyData) 
# you can also do this
# equivalent to fix()
utils::View(MyMetaData)

############# Transpose ###############
# To get the species into columns and treatments into rows 
MyData <- t(MyData) #Swaps rows and columns around
# no viable way to do it in tidyverse

############# Replace species absences with zeros ###############
MyData <- replace_na(MyData, 0)

############# Convert raw matrix to data frame ###############

TempData <- tibble::as_tibble(MyData[-1,],stringsAsFactors = FALSE) 
 
colnames(TempData) <- MyData[1,] # assign column names as actual column names from original data
# there is a way to do this in tidyverse with rename but this method is better

############# Convert from wide to long format ###############
MyWrangledData <- tidyr::pivot_longer(TempData, cols=5:45,names_to="Species",values_to="Count")

############ Coerce column types ####################

# this section is necessary because we set stringsAsFactors to false at the beginning to avoid it converting unwanted sections
# this means we must specify which parts we do want as factors

MyWrangledData <- MyWrangledData %>%
    mutate(across(c(Cultivation, Block, Plot, Quadrat, Species), as.factor))
    # uses across to apply the same function (as.factor) to mutate multiple columns

MyWrangledData <- MyWrangledData %>%
    mutate(across(c(Count), as.integer))


############# Exploring the data  ###############

MyWrangledData <- tibble::as_tibble(MyWrangledData)
# a tibble in tidyverse is equivalent to R's traditional dataframe
# don't need to convert dataframe to tibble to use tidyverse, but its recommended
# tibbles are lazy data frames that do less
# tibbles dont change variable types or names
# tibbles complain more (eg when a variable doesnt exist)
# tibble displays data along with data type while displaying 
# whereas data frames do not

MyWrangledData

dplyr::glimpse(MyWrangledData) 

dplyr::filter(MyWrangledData, Count>100) #like subset(), but nicer!

dplyr::slice(MyWrangledData, 10:15) # Look at an arbitrary set of data rows