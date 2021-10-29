################################################################
################## Wrangling the Pound Hill Dataset using tidyverse ############
################################################################
require(tidyverse)
############# Load the dataset ###############

# tidyverse version
MyData <- as.matrix(read_csv("../data/PoundHillData.csv", col_names = FALSE)) # guarantees data is imported as is. Otherwise, read.csv would convert first row to column headers

# tidyverse version
MyMetaData <- read_csv2("../data/PoundHillMetaData.csv", col_names = TRUE) # header is true because the file does contain headers

############# Inspect the dataset ###############
head(MyData) # Output can be seen in Text1 (in sandbox and notes)
dim(MyData) # dimensions
str(MyData) # compactly display the structure
fix(MyData) #you can also do this
fix(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
TempData <- t(MyData) #Swaps rows and columns around
head(TempData) # output can be seen in Text2 in sandbox
dim(TempData)

# method in progress with tidyverse
# TempData %>%
#    rownames_to_column() %>%  ## gave an error message about this line needing something in the brackets
#    pivot_longer(-rowname) %>% 
#    pivot_wider(names_from=rowname, values_from=value) 

############# Convert raw matrix to data frame ###############

### NEXT TIME, FIX THIS SECTION
TempData <- as.data.frame(TempData[-1,],stringsAsFactors = FALSE) 
# MyData[-1] means MyData without the first row (in this case, removes the headers)
#stringsAsFactors = F is important as it may restrict the things we can do to the strings otherwise
colnames(TempData) <- TempData[1,] # assign column names as actual column names from original data

# find tidyverse way of doing this

############# Convert from wide to long format  ###############
require(tidyverse)
MyWrangledData <- tidyr::pivot_longer(TempData, cols=2:5,names_to="Species",values_to="Count")

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0 # puts a zero in every empty box

# tidyverse version
replace_na(MyWrangledData, )

# this means we must specify which parts we do want as factors
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)


### tasks i need to find a tidyverse function for ###
# change datatype to a factor
# change datatype to integer
# change from wide to long format (currently using melt)
# convert raw matrix to data frame
# replace absences with zero
# transpose
# load data
# inspect data
# assign column names as actual column names from original data
# next time: carry on with this task



############# Exploring the data (extend the script below)  ###############


MyWrangledData <- tibble::as_tibble(MyWrangledData)
# a tibble in tidyverse is equivalent to R's traditional dataframe
# don't need to convert dataframe to tibble to use tidyverse, but its recommended
# tibbles are lazy data frames that do less
# tibbles dont change variable types or names
# tibbles complain more (eg when a variable doesnt exist)
# tibble displays data along with data type while displaying 
# whereas data frames do not
MyWrangledData

dplyr::glimpse(MyWrangledData) #like str(), but nicer!
# dbl means double precision floating point number

dplyr::filter(MyWrangledData, Count>100) #like subset(), but nicer!

dplyr::slice(MyWrangledData, 10:15) # Look at an arbitrary set of data rows