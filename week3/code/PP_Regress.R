
# import predator-prey dataset
require(ggplot2)
require(plyr)
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")

# creates figure
p <- ggplot(MyDF, aes(x = Prey.mass, y = Predator.mass, colour = Predator.lifestage), geom=c("point", "smooth")) + geom_point(pch=3) + geom_smooth(method = "lm", fullrange=TRUE) + (facet_wrap( Type.of.feeding.interaction ~ ., ncol=1 ))
q <- p + scale_x_log10() + scale_y_log10()
q <- q + theme(legend.position = "bottom")


# instructions
# calculate regression results corresponding to the lines fitted in the figure
    # initialise a new dataframe and store results in there
    # results of analysis of linear regression on subsets of the data corresponding to available feeding type x predator life stage combination
    # NOT  multivariate linear model with these two as separate covariates
    # results should include the following(with appropriate headers):
        # regression slope
        # regression intercept
        # r squared
        # F-statistic value
        # p-value of the overall regression(review the stats week for this)
    # use dplyr (no for loops)
    # use ggplot (no qplot)

# save regression results to csv delimited table

# write.csv(dataframe, "../results/PP_Regress_Results.csv")

# results of analysis of linear regression on subsets of the data corresponding to available feeding type x predator life stage combination
# NOT  multivariate linear model with these two as separate covariates


# saves pdf file to results directory
pdf("../results/PP_Regress.pdf")
print(q)
dev.off()


### generate the statistics of linear models

make_model <- function(df){
    summary(lm(df$Predator.mass ~ df$Prey.mass))
}

ModelAnswers <- dlply(.data = MyDF, .variables = as.quoted(.(Type.of.feeding.interaction, Predator.lifestage)), .fun = make_model)
# dlply applies a function to specific subsets of a dataframe


# data.frame(Intercept, Slope, RSquared, PValue)
### pick out the stats i want and put them in a dataframe

StatSummary1 <- ldply(ModelAnswers, function(x){
    Intercept <- x$coefficients[1]
    Slope <- x$coefficients[2]
    RSquared <- x$r.squared
    PValue <- x$coefficients[8]
    data.frame(Intercept, Slope, RSquared, PValue)
})


StatSummary2 <- ldply(ModelAnswers, function(x){
    FStat <- x$fstatistic[1]
    data.frame(FStat)
})
# ldply: for each element of a list, apply a function and combine results into a data frame


# merge data frames

FinalDataFrame <- merge(StatSummary1, StatSummary2, by=c("Type.of.feeding.interaction", "Predator.lifestage"), all=T)
# by specifies which columns to merge

write.csv(FinalDataFrame, "../results/PP_Regress_Results.csv")

