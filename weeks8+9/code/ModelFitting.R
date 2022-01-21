###################
## Model Fitting ##
###################

#### import packages ####
require(minpack.lm)
require(tidyverse)

#### import data ####
MyData <- as.data.frame(read_csv("../data/ModifiedData.csv"))
MyData$ID <- as.factor(MyData$ID)

#### for loop version of subset, model and plot sections ####

## preallocation
ID <- rep(NA, nlevels(MyData$ID))
AICDiff <- rep(NA, nlevels(MyData$ID))
LowerAIC <- rep(NA, nlevels(MyData$ID))
SignifAIC <- rep(NA, nlevels(MyData$ID))
RSS_Cubic <- rep(NA, nlevels(MyData$ID))
RSS_Logistic <- rep(NA, nlevels(MyData$ID))
LowerRSS <- rep(NA, nlevels(MyData$ID))


for (i in 1:nlevels(MyData$ID)){
  ## subset
  subset1 <- subset(MyData,ID== i)
  subset1 <- subset1[order(subset1$Time),]
  # sort time column as ascending to fix plots
  
  
  ## models
  tryCatch(
    expr = {
      ########## CREATE MODELS ############
      # create cubic model
      cubicmodel <- lm(log(subset1$PopBio) ~ subset1$Time + I(subset1$Time^2) +I(subset1$Time^3))
      
      # create logistic model
      logistic1 <- function(t, r, K, N0){
        N0 * K * exp(r * t)/(K+N0 * (exp(r * t)-1))
      }

      logisticmodel <- nlsLM(log(subset1$PopBio)~logistic1(subset1$Time, r, K, N0), start=list(K=1, r=0.1, N0=0.1), data=subset1)
      

      ######### FIT MODELS ###########

      # open pdf
      pdf(paste("../plots/PlotID", i, ".pdf", sep=""))

      # plot data points
      # par(fig=c(0,1,0.1,1))
      plot(log(subset1$PopBio) ~ subset1$Time, main=paste("Microbial growth over time in Subset:", i), xlab = "Time (Hours)", ylab = "log(Abundance)")
      
      ########## CUBIC MODEL ############
      # CUBIC MODEL: get predicted values for model and input them into variable
      PredictedCubic <- predict(cubicmodel, data.frame(x=subset1$Time), interval='confidence', level=0.99)
      
      # CUBIC MODEL: use the first column of the variable to plot the model
      lines(subset1$Time, PredictedCubic[,1], col=2, lwd=2)
      

      
      ########## LOGISTIC MODEL ##########
      # LOGISTIC MODEL: get predicted values for model and input them into variable
      PredictedLogistic <- predict(logisticmodel, data.frame(x=subset1$Time))
      
      # # LOGISTIC MODEL: use the first column of the variable to plot the model
      lines(subset1$Time, PredictedLogistic, col=3, lwd=2)
      
      legend("bottomright", legend = c("Cubic Polynomial", "Logistic"), lwd=2, lty=1, col=2:3)
      
      # close pdf
      dev.off()
      message("Successfully executed the model for subset:", i)

      ID[i] <- i
      # save ID to ID variable
      
      #### statistical measures of model fit ####
      
      RSS_Cubic[i] <- sum(residuals(cubicmodel)^2)
        
      RSS_Logistic[i] <- sum(residuals(logisticmodel)^2)
      
      RSSResults <- c(RSS_Cubic[i], RSS_Logistic[i])
      
      if (which.min(RSSResults)==1){
        LowerRSS[i] <- "Cubic"
      }
      if (which.min(RSSResults)==2){
        LowerRSS[i] <- "Logistic"
      }
      
      
      AICResults <- c(AIC(cubicmodel), AIC(logisticmodel))
      
      AICDiff[i] <- abs(diff(AICResults))
      
      if (AICDiff[i]>=2){
        SignifAIC[i] <- TRUE
      } else {
        SignifAIC[i] <- FALSE
      }
      

      if (which.min(AICResults)==1){
        LowerAIC[i] <- "Cubic"
      }
      if (which.min(AICResults)==2){
        LowerAIC[i] <- "Logistic"
      }
      
      
    },
    error = function(e){
      message("Caught an error for subset:", i)
      print(e)
    },
    warning = function(w){
      message("Caught a warning for subset:", i)
      print(w)
    },
    finally = {
      # graphics.off()
      message('All done, quitting.')
    }
  )
}

### make analysis data frame

AnalysisDF <- data.frame(ID, LowerAIC, AICDiff, SignifAIC, RSS_Cubic, RSS_Logistic, LowerRSS)
AnalysisDF <- na.omit(AnalysisDF)

#### export results ####

write.csv(AnalysisDF, "../results/Analysis.csv", row.names = FALSE)

# export results for final plotting script