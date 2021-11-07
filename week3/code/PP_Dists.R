###########################################
## Data exploration - creating sub-plots ##
###########################################

# writes  and saves three figures
require(ggplot2)

#### actual task ####

# import data
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
MyDF$Size.ratio <- NA # creates new column

# calculating size ratio
for (i in 1:nrow(MyDF)){
    SizeRatio=MyDF[i,13]/MyDF[i,9]
    MyDF[i,16] <- SizeRatio
}

# calculating body size stats by feeding type
# how to use subset, subset(data, data$x == "whatever")
MyDFinsectivorous <- subset(MyDF, MyDF$Type.of.feeding.interaction == "insectivorous")
MyDFpiscivorous <- subset(MyDF, MyDF$Type.of.feeding.interaction == "piscivorous")
MyDFplanktivorous <- subset(MyDF, MyDF$Type.of.feeding.interaction == "planktivorous")
MyDFpredacious <- subset(MyDF, MyDF$Type.of.feeding.interaction == "predacious")
MyDFpredaciouspiscivorous <- subset(MyDF, MyDF$Type.of.feeding.interaction == "predacious/piscivorous")

# creating predator mass histograms

pdf("../results/Pred_Subplots.pdf")

par(mfcol=c(5,1)) # initialise multi-paneled plot

par(mfg=c(1,1)) # first sub-plot
hist(log10(MyDFinsectivorous$Predator.mass), xlab="log10(Predator mass(g))", ylab="Count", main="Predator mass histogram - insectivorous")
par(mfg=c(2,1)) # second sub-plot
hist(log10(MyDFpiscivorous$Predator.mass), xlab="log10(Predator mass(g))", ylab="Count", main="Predator mass histogram - piscivorous")
par(mfg=c(3,1)) # second sub-plot
hist(log10(MyDFplanktivorous$Predator.mass), xlab="log10(Predator mass(g))", ylab="Count", main="Predator mass histogram - planktivorous")
par(mfg=c(4,1)) # second sub-plot
hist(log10(MyDFpredacious$Predator.mass), xlab="log10(Predator mass(g))", ylab="Count", main="Predator mass histogram - predacious")
par(mfg=c(5,1)) # second sub-plot
hist(log10(MyDFpredaciouspiscivorous$Predator.mass), xlab="log10(Predator mass(g))", ylab="Count", main="Predator mass histogram - predacious/piscivorous")

dev.off()

# creating prey mass histograms

pdf("../results/Prey_Subplots.pdf")

par(mfcol=c(5,1)) # initialise multi-paneled plot

par(mfg=c(1,1)) # first sub-plot
hist(log10(MyDFinsectivorous$Prey.mass), xlab="log10(Prey mass(g))", ylab="Count", main="Prey mass histogram - insectivorous")
par(mfg=c(2,1)) # second sub-plot
hist(log10(MyDFpiscivorous$Prey.mass), xlab="log10(Prey mass(g))", ylab="Count", main="Prey mass histogram - piscivorous")
par(mfg=c(3,1)) # second sub-plot
hist(log10(MyDFplanktivorous$Prey.mass), xlab="log10(Prey mass(g))", ylab="Count", main="Prey mass histogram - planktivorous")
par(mfg=c(4,1)) # second sub-plot
hist(log10(MyDFpredacious$Prey.mass), xlab="log10(Prey mass(g))", ylab="Count", main="Prey mass histogram - predacious")
par(mfg=c(5,1)) # second sub-plot
hist(log10(MyDFpredaciouspiscivorous$Prey.mass), xlab="log10(Prey mass(g))", ylab="Count", main="Prey mass histogram - predacious/piscivorous")

dev.off()

# creating size ratio histograms

pdf("../results/SizeRatio_Subplots.pdf")

par(mfcol=c(5,1)) # initialise multi-paneled plot

par(mfg=c(1,1)) # first sub-plot
hist(log10(MyDFinsectivorous$Size.ratio), xlab="log10(Size ratio)", ylab="Count", main="Size ratio histogram - insectivorous")
par(mfg=c(2,1)) # second sub-plot
hist(log10(MyDFpiscivorous$Size.ratio), xlab="log10(Size ratio)", ylab="Count", main="Size ratio histogram - piscivorous")
par(mfg=c(3,1)) # second sub-plot
hist(log10(MyDFplanktivorous$Size.ratio), xlab="log10(Size ratio)", ylab="Count", main="Size ratio histogram - planktivorous")
par(mfg=c(4,1)) # second sub-plot
hist(log10(MyDFpredacious$Size.ratio), xlab="log10(Size ratio)", ylab="Count", main="Size ratio histogram - predacious")
par(mfg=c(5,1)) # second sub-plot
hist(log10(MyDFpredaciouspiscivorous$Size.ratio), xlab="log10(Size ratio)", ylab="Count", main="Size ratio histogram - predacious/piscivorous")

dev.off()


# initialise new dataframe/matrix (Called DataFrame) to store the calculations with appropriate headers
    # calculate log mean predator mass by feeding type

    # calculate log median predator mass by feeding type

    # calculate log mean prey mass by feeding type

    # calculate log median prey mass by feeding type

    # calculate log mean size ratio by feeding type

    # calculate log median size ratio by feeding type

# initialise new dataframe/matrix (Called DataFrame) to store the calculations with appropriate headers

FeedingType <- c("insectivorous", "piscivorous", "planktivorous", "predacious", "predacious/piscivorous")
# create means of predator masses
MeanLogPredMass <- c()
MeanLogPredMass<- c(MeanLogPredMass, mean(log(MyDFinsectivorous$Predator.mass)))
MeanLogPredMass<- c(MeanLogPredMass, mean(log(MyDFpiscivorous$Predator.mass)))
MeanLogPredMass<- c(MeanLogPredMass, mean(log(MyDFplanktivorous$Predator.mass)))
MeanLogPredMass<- c(MeanLogPredMass, mean(log(MyDFpredacious$Predator.mass)))
MeanLogPredMass<- c(MeanLogPredMass, mean(log(MyDFpredaciouspiscivorous$Predator.mass)))

# create medians of predator mass
MedianLogPredMass <- c()
MedianLogPredMass<- c(MedianLogPredMass, median(log(MyDFinsectivorous$Predator.mass)))
MedianLogPredMass<- c(MedianLogPredMass, median(log(MyDFpiscivorous$Predator.mass)))
MedianLogPredMass<- c(MedianLogPredMass, median(log(MyDFplanktivorous$Predator.mass)))
MedianLogPredMass<- c(MedianLogPredMass, median(log(MyDFpredacious$Predator.mass)))
MedianLogPredMass<- c(MedianLogPredMass, median(log(MyDFpredaciouspiscivorous$Predator.mass)))

# create means of prey masses
MeanLogPreyMass <- c()
MeanLogPreyMass<- c(MeanLogPreyMass, mean(log(MyDFinsectivorous$Prey.mass)))
MeanLogPreyMass<- c(MeanLogPreyMass, mean(log(MyDFpiscivorous$Prey.mass)))
MeanLogPreyMass<- c(MeanLogPreyMass, mean(log(MyDFplanktivorous$Prey.mass)))
MeanLogPreyMass<- c(MeanLogPreyMass, mean(log(MyDFpredacious$Prey.mass)))
MeanLogPreyMass<- c(MeanLogPreyMass, mean(log(MyDFpredaciouspiscivorous$Prey.mass)))

# create medians of prey mass
MedianLogPreyMass <- c()
MedianLogPreyMass<- c(MedianLogPreyMass, median(log(MyDFinsectivorous$Prey.mass)))
MedianLogPreyMass<- c(MedianLogPreyMass, median(log(MyDFpiscivorous$Prey.mass)))
MedianLogPreyMass<- c(MedianLogPreyMass, median(log(MyDFplanktivorous$Prey.mass)))
MedianLogPreyMass<- c(MedianLogPreyMass, median(log(MyDFpredacious$Prey.mass)))
MedianLogPreyMass<- c(MedianLogPreyMass, median(log(MyDFpredaciouspiscivorous$Prey.mass)))

# create means of size ratio
MeanLogSizeRatio <- c()
MeanLogSizeRatio <- c(MeanLogSizeRatio, mean(log(MyDFinsectivorous$Size.ratio)))
MeanLogSizeRatio <- c(MeanLogSizeRatio, mean(log(MyDFpiscivorous$Size.ratio)))
MeanLogSizeRatio <- c(MeanLogSizeRatio, mean(log(MyDFplanktivorous$Size.ratio)))
MeanLogSizeRatio <- c(MeanLogSizeRatio, mean(log(MyDFpredacious$Size.ratio)))
MeanLogSizeRatio <- c(MeanLogSizeRatio, mean(log(MyDFpredaciouspiscivorous$Size.ratio)))


# create medians of size ratio
MedianLogSizeRatio <- c()
MedianLogSizeRatio <- c(MedianLogSizeRatio, median(log(MyDFinsectivorous$Size.ratio)))
MedianLogSizeRatio <- c(MedianLogSizeRatio, median(log(MyDFpiscivorous$Size.ratio)))
MedianLogSizeRatio <- c(MedianLogSizeRatio, median(log(MyDFplanktivorous$Size.ratio)))
MedianLogSizeRatio <- c(MedianLogSizeRatio, median(log(MyDFpredacious$Size.ratio)))
MedianLogSizeRatio <- c(MedianLogSizeRatio, median(log(MyDFpredaciouspiscivorous$Size.ratio)))

AveragesDataFrame <- data.frame(FeedingType, MeanLogPredMass, MedianLogPredMass, MeanLogPreyMass, MedianLogPreyMass, MeanLogSizeRatio, MedianLogSizeRatio)

write.csv(AveragesDataFrame, "../results/PP_Results.csv")
