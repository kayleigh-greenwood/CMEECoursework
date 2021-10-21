# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

TreeHeight <- function(degrees, distance){ # stores function inside variable TreeHeight
    radians <- degrees * pi / 180 # converts degrees to radians
    height <- distance * tan(radians) # uses trig to calculated height
    print(paste("Tree height is:", height)) 
  
    return (height) # returns the value of height, making it available outside of the function
}

TreeHeight(37, 40)