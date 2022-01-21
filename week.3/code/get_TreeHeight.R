#This function calculates heights of trees given distance of each tree
#from its base and angle to its top, using the trigonometric formula

#height = distance * tan(radians)

#ARGUMENTS
#degrees: The angle of elevation of tree
#distance: The distance from base of tree (e.g., meters)

#OUTPUT
#The heights of the tree, same units as "distance"

rm(list = ls())

args<-commandArgs(TRUE)

### Read the csv file ###
treeData<- read.csv(paste0("../data/",args, ".csv"), stringsAsFactors = F)

TreeHeight <- function(degrees, distance){
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  return (height)
}


Tree.Height.m <- c()

### Calculate the tree height ###
for (i in 1:nrow(treeData)){
  Tree.Height.m <- append(Tree.Height.m,TreeHeight(treeData$Angle.degrees[i],treeData$Distance.m[i]))
}

treeData$Tree.Height.m <- Tree.Height.m

### Output the result to the csv file ###
write.csv(treeData, paste("../results/",args,"_TreeHts_R.csv",sep = ""),row.names = F)

