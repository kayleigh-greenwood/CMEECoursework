# load maps package
require(maps)
require(ggplot2)
require(mapdata)
# load GPDD data
load("../data/GPDDFiltered.RData")

# create a world map (using the map function, read its help page, also google example using maps)
# superimpose on the map all the locations from which we have data in the GPDD Dataframe

mymap<- map() + points(gpdd$long, gpdd$lat, col="red", cex= 1.5, pch=20)

pdf("../results/worldmap.pdf")
print(mymap)
dev.off()


# Question: looking at the map, what biases might you expect in any analysis based on the data represented?
# Answer: 
    # cannot interpret density of data points in areas where they are grouped.
    # static data is biased to the moment in which it was collected.
    # this may not be a truly representative dataset.