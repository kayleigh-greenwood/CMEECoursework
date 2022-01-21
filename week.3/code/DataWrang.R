################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE)) # guarantees data is imported as is. Otherwise, read.csv would convert first row to column headers

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";") # header is true because the file does contain headers

############# Inspect the dataset ###############
# head(MyData)
# dim(MyData) # dimensions
# str(MyData) # compactly display the structure
# fix(MyData) #you can also do this
# fix(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) #Swaps rows and columns around
# head(MyData) # output can be seen in Text2 in sandbox
# dim(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0 # puts a zero in every empty box

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = FALSE) 
# MyData[-1] means MyData without the first row (in this case, removes the headers)
#stringsAsFactors = F is important as it may restrict the things we can do to the strings otherwise
colnames(TempData) <- MyData[1,] # assign column names as actual column names from original data

############# Convert from wide to long format  ###############
require(reshape2) # load the reshape2 package

# ?melt #check out the melt function: convert an object into a molten data frame

MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")


## UNDERSTANDING MELT ##

# The melt() function is used to convert a data frame with several measurement columns 
# into a data frame which has one row for every value. 
# You need to tell melt() which of your variables are identifying variables (id.vars), 
# and which are measured variables (measure.vars). 
# If you only supply one of id.vars or measure.vars, 
# melt() will assume the remainder of the variables in the data set belong to the other
# By default, the name of the measurement variables will be put into a column called "variable", 
# and their associated values will be put into a column called "value", 
# but these can be changed by using the arguments 
# variable.name (or varnames for matrices) and value.name.

## CONTINUE

# this section is necessary because we set stringsAsFactors to false at the beginning to avoid it converting unwanted sections
# this means we must specify which parts we do want as factors
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

# str(MyWrangledData)
# head(MyWrangledData)
# dim(MyWrangledData)

############# Exploring the data (extend the script below)  ###############

MyWrangledData <- tibble::as_tibble(MyWrangledData)
# a tibble in tidyverse is equivalent to R's traditional dataframe
# don't need to convert dataframe to tibble to use tidyverse, but its recommended
# tibbles are lazy data frames that do less
# tibbles dont change variable types or names
# tibbles complain more (eg when a variable doesnt exist)
# tibble displays data along with data type while displaying 
# whereas data frames do not



# MyWrangledData

dplyr::glimpse(MyWrangledData) #like str(), but nicer!
# dbl means double precision floating point number

dplyr::filter(MyWrangledData, Count>100) #like subset(), but nicer!

dplyr::slice(MyWrangledData, 10:15) # Look at an arbitrary set of data rows