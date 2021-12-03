####################
# Plot and Analyse #
####################

## imports ##
library(ggplot2)

## import data ##

AnalysisDF <- read.csv("../results/Analysis.csv")


## metaanalysis ##
SampleSize <- dim(AnalysisDF)[1]

## AIC analysis ##
CubicAICBest=sum(AnalysisDF['LowerAIC']=='Cubic' & AnalysisDF['SignifAIC']==TRUE)
LogisticAICBest=sum(AnalysisDF['LowerAIC']=='Logistic' & AnalysisDF['SignifAIC']==TRUE)
NoAICBest=sum(AnalysisDF['SignifAIC']==FALSE)
AIC <- c(CubicAICBest, LogisticAICBest, NoAICBest)

## Data ##
AICHeadings <-c("Cubic", "Logistic", "No Significant Difference")
AICAnalysis <- data.frame(AICHeadings, AIC)

## Chart ##
pdf("../results/AIC.pdf")
ggplot(AICAnalysis, aes(x=AICHeadings, y=AIC)) +
  ggtitle("Comparison of Significant AIC Value Between Models") +
  geom_bar(stat="Identity") +
  xlab("Lowest Significant AIC Value") +
  ylab("Number of subsets")
dev.off()



## RSS analysis ##
CubicRSSBest=sum(AnalysisDF['LowerRSS']=='Cubic')
LogisticRSSBest=sum(AnalysisDF['LowerRSS']=='Logistic')
RSS <- c(CubicRSSBest, LogisticRSSBest)

## Data ##
RSSHeadings<- c("Cubic", "Logistic")
RSSAnalysis <- data.frame(RSSHeadings, RSS)

## Chart ##
pdf("../results/RSS.pdf")
ggplot(RSSAnalysis, aes(x=RSSHeadings, y=RSS)) +
  ggtitle("Comparison of Lowest RSS Value Between Models") +
  geom_bar(stat="Identity") +
  xlab("Lowest RSS Value") +
  ylab("Number of subsets")
dev.off()









# perform any analyses of the results of the Model fitting, for example to summarize which model fits best, and address any biological questions involving covariates