## TO DO NEXT TIME: keep adjusting figure to get it as similar to the example as possible


# import predator-prey dataset

require(ggplot2)
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")


# iteration1 works
    # plot(MyDF$Prey.mass, MyDF$Predator.mass, xlab="Prey mass in grams", ylab="Predator mass in grams", pch=3, log="xy")

# iteration 2 trying to split into multiple graphs - works
    # p <- ggplot(MyDF, aes(x = Prey.mass, y = Predator.mass)) + geom_point(pch=3) + facet_wrap( Type.of.feeding.interaction ~ ., ncol=1 )
    # q <- p + scale_x_log10() + scale_y_log10()

# iteration 3 - colours - works

    # p <- ggplot(MyDF, aes(x = Prey.mass, y = Predator.mass, colour = Predator.lifestage)) + geom_point(pch=3) + facet_wrap( Type.of.feeding.interaction ~ ., ncol=1 )
    # q <- p + scale_x_log10() + scale_y_log10()
    # q <- q + theme(legend.position = "bottom")

# iteration 4 - lines - works

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