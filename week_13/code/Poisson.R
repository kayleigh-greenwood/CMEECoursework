# FISH DATA

require(ggplot2)
require(MASS)
require(ggpubr)
fish <- read.csv("fisheries.csv", stringsAsFactors = T)
str(fish)

# investigate whether total abundance changes with mean depth of the water column
# scatterplot
ggplot(data=fish, mapping = aes(x=MeanDepth, y=TotAbund))+ geom_point()+labs(x = "Mean Depth (km)", y="Total Abundance")+theme_classic()

# fitting the model: total abundance as response and mean depth as explanatory
# model equation: ln(TotAbund) = B0 + B1*MeanDepth
model1 <- glm(formula = fish$TotAbund~fish$MeanDepth, family="poisson")
summary(model1)
# ln(TotAbund) = 6.64 - 0.63*MeanDepth
# Pseudo R^2 = 1 - (15770/27779) = 0.43

# model validation process
# step 1: examine diagnostic plots
par(mfrow=c(2,2))
plot(model1)
# Residuals vs fitted: DOESN't show starry night pattern. Shows heteroscedaticity. Spread is not constant.
# Normal QQ: suggests data is right skewed
# Scale-Location: No starry night so variance is not equal
# Residuals vs Leverage: LOTS of points lie outside of cook's distance. there are lots of influentoal observations. Implies model isnt good

# Check how many outliers there are outside of a cooks distance of 1
sum(cooks.distance(model1)>1)

# step 2: examine dispersion parameter
15770/144 = 109.51
# >1, so overdispersed

# explore adding period as a covariate
boxplot(fish$TotAbund~fish$Period)
scatterplot <- ggplot(data=fish, mapping = aes(x=MeanDepth, y=TotAbund, color=factor(Period)))+ geom_point()+labs(x = "Mean Depth", y="Total Abundance")+theme_classic()+scale_color_discrete(name="Period", labels=c("1979-1989", "1997-2002"))
boxplot <- ggplot(data=fish, aes(x=factor(Period, labels=c("1979-1989", "1997-2002")), y=TotAbund))+geom_boxplot()+theme_classic()+labs(x="Period", y="Total Abundance")
ggarrange(scatterplot, boxplot, labels=c("A", "B"), ncol=1, nrow=2)
# looks like period could be having an effect, lets include it

#adding period as a fixed factor and interact it with MeanDepth
model2 <- glm(TotAbund ~ MeanDepth*factor(Period), data=fish, family="poisson")
summary(model2)
# Pseudo R^2 = 0.485... model explains 48.5% of the variance
anova(model2, test="Chisq")
# Period 1: lm(TotAbund) =  6.83 -0.66*MeanDepth
# Period 2: lm(TotAbund) = 6.83 -0.67 -0.66*MeanDepth +0.12*MeanDepth = 6.16 -0.54*MeanDepth

# Dispersion parameter: 14293/142 = 100.65
# Has decreased since the Period factor has been added. so we have decreased dispersion but model is still overdispersed
# 2 solutions are: fir quasi-poisson model OR negative binomial model

# Fitting negative binomial model
model3 <- glm.nb(TotAbund ~ MeanDepth*factor(Period), data=fish)
summary(model3)
anova(model3, test="Chisq")
# shows there is no sif dig between slopes for each period but there is between the intercepts

# Run reduced model (without the interaction between meandepth and period) before model validation
model4 <- glm.nb(TotAbund ~ MeanDepth+factor(Period), data=fish)
summary(model4)
anova(model4, test="Chisq")

# examine model diagnostics
par(mfrow=c(2,2))
plot(model4)
# residuals vs fitted has improved
# normal QQ similar
#Scale-Location improved
# Residuals vs leverge improved, none even outside of cooks distance = 0.5

#examine dispersal parameter
158.23/143 # = 1.11, much better than previous models. not perfect but good enough given sample size of 146

# Model 4 equations
# Period 1: lm(TotAbund = 6.96 -0.73*MeanDepth)
# Period 2: lm(TotAbund = 6.57 -0.73*MeanDepth)

#Pseudo R^2 for model 4 = 1-(158.23/334.13) = 0.53

# Plotting model
range(fish$MeanDepth)
period1 <- data.frame(MeanDepth=seq(from=0.804, to=4.865, length=100), Period="1")
period2 <- data.frame(MeanDepth=seq(from=0.804, to=4.865, length=100), Period="2")
period1_predictions <- predict(model4, newdata=period1, type="link", se.fit=TRUE) # type=link predicts the fit and se on the log-linear scale
period2_predictions <- predict(model4, newdata=period2, type="link", se.fit=TRUE)

period1$pred <- period1_predictions$fit
period1$se <- period1_predictions$se.fit
period1$upperCI <- period1$pred+(period1$se*1.96)
period1$lowerCI <- period1$pred-(period1$se*1.96)

period2$pred <- period2_predictions$fit
period2$se <- period2_predictions$se.fit
period2$upperCI <- period2$pred+(period2$se*1.96)
period2$lowerCI <- period2$pred-(period2$se*1.96)

complete <- rbind(period1, period2)

#making the plot
ggplot(complete, aes(x=MeanDepth, y=exp(pred)))+
  geom_line(aes(color=factor(Period)))+
  geom_ribbon(aes(ymin=exp(lowerCI), ymax=exp(upperCI), fill=factor(Period), alpha=0.3), show.legend=FALSE)+
  geom_point(fish, mapping=aes(x=MeanDepth, y=TotAbund, color=factor(Period)))+
  labs(y="Total Abundance", x="Mean Depth (km)")+
  theme_classic()+
  scale_color_discrete(name="Period", labels=c("1979-1989", "1997-2002"))

# Alternative plotting method
require(interactions)
interact_plot(model4, pred=MeanDepth, modx= Period, plot.points = T, data = fish)


# BEE MITES DATA
mites <- read.csv("bee_mites.csv", stringsAsFactors = T)
str(mites)
head(mites)

# investigate whether number of dead mites changes with concentration
ggplot(data=mites, mapping = aes(x=Concentration, y=Dead_mites))+ geom_point()+labs(x = "Concentration", y="Dead mites")+theme_classic()

mitemodel1 <- glm(Dead_mites~Concentration, data=mites, family="poisson")
summary(mitemodel1)
# ln(Dead_mites) = 0.53 + 0.57 * Concentration
# Pseudo R^2 = 0.295 = model explains 29.5% of data
anova(mitemodel1, test="Chisq")




# model validation
#Step 1: # Dispersion parameter:
# 109.25/113 = 0.9668142. close to 1, so okay.

#step 2: model diagnostic plots
par(mfrow=c(2,2))
plot(mitemodel1)

# Residuals vs Fitted: heteroscedaticity / non-linear
# Normal QQ:  light tailed
# Scale-Location: bend in red line.
sum(cooks.distance(mitemodel1)>1)
# Residuals vs leverage: none outside cook's distance

#examine dispersal parameter
109.25/113 # = 0.97  < 1 so underdispersed

# plot the model

range(mites$Concentration)

new_data <- data.frame(Concentration=seq(from=0, to=2.16, length=115))
predictions <- predict(mitemodel1, newdata=new_data, type="link", se.fit=TRUE) # type=link predicts the fit and se on the log-linear scale
new_data$pred <- predictions$fit
new_data$se <- predictions$se.fit
new_data$upperCI <- new_data$pred+(new_data$se*1.96)
new_data$lowerCI <- new_data$pred-(new_data$se*1.96)



ggplot(new_data, aes(x=Concentration, y=exp(pred)))+
  geom_line(col="black")+
  geom_ribbon(aes(ymin=exp(lowerCI), ymax=exp(upperCI), alpha=0.1), show.legend=FALSE, fill="grey")+
  geom_point(mites, mapping=aes(x=Concentration, y=Dead_mites), col="blue")+
  labs(y="Number of Dead Mites", x="Concentration (g/l)")+
  theme_classic()





