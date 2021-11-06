## INTRO ##
# This function calculates heights of trees given distance of farthest treetop 
# from its base and angle to its top, using  the trigonometric formula 
# height = distance * tan(radians)
# requires tidyverse to be imported

## ARGUMENTS ##
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)

## OUTPUT ##
# The heights of the tree, same units as "distance"

## FUNCTION ##

# Define function
TreeHeight<- function(degrees, distance){ 
    # stores function inside variable TreeHeight
    radians <- degrees * pi / 180 
    # converts degrees to radians
    height <- distance * tan(radians) 
    # uses trig to calculate height
  
    return (height) 
    # returns the value of height, making it available outside of the function
}

## CODE ##
TreeData <- read.csv("../data/trees.csv") 
# imports data frame to read and puts it into TreeData variable

TreeData$Tree.Height.m <- NA 
# creates a new column for data frame in TreeData named Tree.Height.m

# for loop that calculates tree height for each data entry and adds it to Tree.Height.m column
for(i in 1:nrow(TreeData)) { 
    # for each row(and therefore data point) in treedata
    TreeHeightValue=TreeHeight(TreeData[i,3], TreeData[i,2]) 
    # create a new variable and store the output of the tree height function into it
    # use indexing to calculate Tree Height for that row

    TreeData[i,4] <- TreeHeightValue 
    # store result in the Tree.height.m column of each row
} 

write.csv(TreeData, "../results/TreeHts.csv", row.names=FALSE)  
# writes the contents of TreeData into a file in results, without the rows being numbered.

print("Results saved to ../results/TreeHts.csv")
# end
 