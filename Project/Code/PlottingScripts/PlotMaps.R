# make multi panelled plot of 4 maps

#################################################################################################################################################
## SET UP WORKSPACE ##
#################################################################################################################################################
rm(list=ls())

#################################################################################################################################################
## IMPORT DATA ##
#################################################################################################################################################

# create function that reads files but skips first few lines (because they contain rm(list=ls()))
source2 <- function(file, start, end, ...) {
  file.lines <- scan(file, what=character(), skip=start-1, nlines=end-start+1, sep='\n')
  file.lines.collapsed <- paste(file.lines, collapse='\n')
  source(textConnection(file.lines.collapsed), ...)
}

# I manually included which lines to start and stop at so may have to alter as i go along
source2('ClimateModel.R', 7, 163)
source2('PollutionModel.R', 8, 174)
source2('InvasiveSpeciesModel.R', 8, 166)
source2('LandUseModel.R', 8, 179)


######################
# CLIMATE MAP
######################

ClimateMap <- ggplot(ClimateMapData, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill= corr), colour = "black") 

# add colours
ClimateMap <- ClimateMap + scale_fill_gradient2(name="Sensitivity Score", midpoint = 0, mid = "white", high = "darkgoldenrod2", low = "blue4", limits = c(-0.2400587, 0.0775445), space="Lab") # maybe would be better to make all countries below zero on a different colour gradient

# Remove axis titles and details
ClimateMap <- ClimateMap + theme(axis.text.x=element_blank(), 
                                 axis.ticks.x=element_blank(),
                                 axis.text.y=element_blank(),
                                 axis.ticks.y=element_blank(),
                                 axis.title.y = element_blank(),
                                 axis.title.x = element_blank())
ClimateMap <- ClimateMap + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = c(0.1, 0.25))




####################
##  POLLUTION MAP
#####################

PollutionMap<- ggplot(PollutionMapData, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill= corr), colour = "black") 

# add colours
PollutionMap<- PollutionMap+ scale_fill_gradient2(name="Sensitivity Score", midpoint = 0, mid = "white", high = "darkgoldenrod2", low = "blue4", limits = c(-0.000006073096, 0.000013764), space="Lab") # maybe would be better to make all countries below zero on a different colour gradient

# Remove axis titles and details
PollutionMap<- PollutionMap+ theme(axis.text.x=element_blank(), 
                                   axis.ticks.x=element_blank(),
                                   axis.text.y=element_blank(),
                                   axis.ticks.y=element_blank(),
                                   axis.title.y = element_blank(),
                                   axis.title.x = element_blank())
PollutionMap<- PollutionMap+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = c(0.1, 0.25))



#####################
## INVASIVE SPECIES MAP ##
#########################
InvasiveSpeciesMap<- ggplot(InvasiveSpeciesMapData, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill= corr), colour = "black")

InvasiveSpeciesMap<- InvasiveSpeciesMap+ scale_fill_gradient2(name="Sensitivity Score", midpoint = 0, mid = "white", high = "darkgoldenrod2", low = "blue4", limits = c(-0.02300199, 0.05477225), space="Lab") # maybe would be better to make all countries below zero on a different colour gradient

# Remove axis titles and details
InvasiveSpeciesMap<- InvasiveSpeciesMap+ theme(axis.text.x=element_blank(), 
                                               axis.ticks.x=element_blank(),
                                               axis.text.y=element_blank(),
                                               axis.ticks.y=element_blank(),
                                               axis.title.y = element_blank(),
                                               axis.title.x = element_blank())
InvasiveSpeciesMap<- InvasiveSpeciesMap+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = c(0.1, 0.25))



########################
## LAND USE MODEL ##
##################

LandUseMap<- ggplot(LandUseMapData, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill= corr), colour = "black") 

# add colours
LandUseMap<- LandUseMap+ scale_fill_gradient2(name="Sensitivity Score", midpoint = 0, mid = "white", high = "darkgoldenrod2", low = "blue4", limits = c(-0.121097, 0.07003952), space="Lab") # maybe would be better to make all countries below zero on a different colour gradient

# Remove axis titles and details
LandUseMap<- LandUseMap+ theme(axis.text.x=element_blank(), 
                               axis.ticks.x=element_blank(),
                               axis.text.y=element_blank(),
                               axis.ticks.y=element_blank(),
                               axis.title.y = element_blank(),
                               axis.title.x = element_blank())
LandUseMap<- LandUseMap+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = c(0.1, 0.25))

######################
## MULTI PANELLLED PLOT
#####################

#layout(matrix(1:4, ncol=2))
par(mfrow=c(2,2))
par(oma=c(4, 4, 4, 4), mar=c(4, 4, 4, 4))
ClimateMap
PollutionMap
LandUseMap
InvasiveSpeciesMap
