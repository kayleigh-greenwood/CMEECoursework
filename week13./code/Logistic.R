# Binary models

# worker bees data

require(ggplot2)
require(ggpubr)

worker <- read.csv("workerbees.csv", stringsAsFactors = T)
str(worker)
head(worker)

scatterplot <- ggplot(data=worker, mapping = aes(x=CellSize, y=Parasites))+ geom_point()+labs(x = "Cell Size (cm)", y="Probability of parasites")+theme_classic()
boxplot <- ggplot(data=worker, aes(x=factor(Parasites), y=CellSize))+geom_boxplot()+theme_classic()+labs(x = "Probability of parasites", y="Cell Size (cm)")+theme_classic()
ggarrange(scatterplot, boxplot, labels=c("A", "B"), ncol=1, nrow=2)

workerm1 <- glm(formula= Parasites~CellSize, data=worker, family="binomial")
summary(workerm1)
anova(workerm1, test="Chisq")
# Pseudo R^2 = 0.123. model explains 12.3% of variance
# logit(probability of parasites)= -11.25 + 22.18*CellSize

plogis(coef(workerm1))
# can interpret that for every cm increase in cell size, probability of being infected increases by a factor of 1 or 100%

# value of x where prob flips: b0/b1 = 11.25/22.18 = 0.51cm

#graph

range(worker$CellSize)

new_data <- data.frame(CellSize=seq(from=0.352, to= 0.664, length=100))
predictions <- predict(workerm1, newdata=new_data, type="link", se.fit=TRUE) # type=link predicts the fit and se on the log-linear scale
new_data$pred <- predictions$fit
new_data$se <- predictions$se.fit
new_data$upperCI <- new_data$pred+(new_data$se*1.96)
new_data$lowerCI <- new_data$pred-(new_data$se*1.96)



ggplot(new_data, aes(x=CellSize, y=plogis(pred)))+
  geom_line(col="black")+
  geom_ribbon(aes(ymin=plogis(lowerCI), ymax=plogis(upperCI), alpha=0.2), show.legend=FALSE, fill="grey")+
  geom_point(worker, mapping=aes(x=CellSize, y=Parasites), col="blue")+
  labs(x = "Cell Size (cm)", y="Probability of parasites")+
  theme_classic()

# chytrid data as binary

chytrid <- read.csv("chytrid.csv", stringsAsFactors = T)
str(chytrid)

scatterplot <- ggplot(data=chytrid, mapping = aes(x=Springavgtemp, y=InfectionStatus))+ geom_point()+labs(x = "Spring temperature", y="Probability of Infection")+theme_classic()
boxplot <- ggplot(data=chytrid, aes(x=factor(InfectionStatus), y=Springavgtemp))+geom_boxplot()+theme_classic()+labs(x = "Probability of Infection", y="Spring temperature")+theme_classic()
ggarrange(scatterplot, boxplot, labels=c("A", "B"), ncol=1, nrow=2)

#graphs imply no sig diff, but research shows increasing spring temp increases probaility of chytrid fungus infection in amphibians
# model with binary generalised model

chytridm1 <- glm(data = chytrid, formula = InfectionStatus~Springavgtemp, family="binomial")
summary(chytridm1)
anova(chytridm1, test="Chisq")

#Pseudo R^2 = 0.005, model explains 0.5% of data
# logit (probability of infection) = -0.06 + 0.05*Springavgtemp
plogis(coef(chytridm1))
# can interpret that for every degree increase in spring temp, probability of being infected increases by a factor of 0.51 or 51%

# calculate flipping point
# b0/b1 = 0.06/0.05 = 1.2 degrees
# can infer that amphibians experiencing temps above 1.2 are more likely to be infected

#graph

range(chytrid$Springavgtemp)

new_data <- data.frame(Springavgtemp=seq(from=0.997, to= 13.664, length=100))
predictions <- predict(chytridm1, newdata=new_data, type="link", se.fit=TRUE) # type=link predicts the fit and se on the log-linear scale
new_data$pred <- predictions$fit
new_data$se <- predictions$se.fit
new_data$upperCI <- new_data$pred+(new_data$se*1.96)
new_data$lowerCI <- new_data$pred-(new_data$se*1.96)



ggplot(new_data, aes(Springavgtemp, y=plogis(pred)))+
  geom_line(col="black")+
  geom_ribbon(aes(ymin=plogis(lowerCI), ymax=plogis(upperCI), alpha=0.2), show.legend=FALSE, fill="grey")+
  geom_point(chytrid, mapping=aes(x=Springavgtemp, y=InfectionStatus), col="blue")+
  labs(x = "Spring temp (degrees)", y="Probability of infection")+
  theme_classic()

# model chytrid data with binomial outcome

chytrid_binomial <- read.csv("chytrid_binomial.csv", stringsAsFactors = T)
str(chytrid_binomial)

# model with binomial model

chytridm2 <- glm(cbind(Positives, Total-Positives)~AverageSpringTemp, data = chytrid_binomial, family="binomial")
summary(chytridm2)
anova(chytridm2, test="Chisq")

#Pseudo R^2 = 0.05, model explains 5% of data
# Dispersion parameter: 4795.7/173 = 27.72, overdispersed
# logit (probability of infection) = -0.4 + 0.08*Springavgtemp
par(mfrow=c(2,2))
plot(chytridm2)
#Residuals vs levergae suggests a number of outliers that are causing overdispersion
sum(cooks.distance(chytridm2)> 1)
# 2 outliers
# in response we will fit quasi-binomial model

# model with quasi-binomial model

chytridm3 <- glm(cbind(Positives, Total-Positives)~AverageSpringTemp, data = chytrid_binomial, family="quasibinomial")
summary(chytridm3)
anova(chytridm3, test="Chisq")

## below values have not changed between binomial and quasi binomial, but standard errors have inflated
#Pseudo R^2 = 0.052, model explains 5% of data
# Dispersion parameter: 4795.7/173 = 27.72, overdispersed
# logit (probability of infection) = -0.4 + 0.08*Springavgtemp

par(mfrow=c(2,2))
plot(chytridm3)
#Residuals vs leverage has changed so that cooks distance isnt even on graph
sum(cooks.distance(chytridm3)> 1)
# 0 outliers

# plotting chytrid binomial data

range(chytrid_binomial$AverageSpringTemp)

new_data <- data.frame(AverageSpringTemp=seq(from=0.997, to= 13.664, length=100))
predictions <- predict(chytridm3, newdata=new_data, type="link", se.fit=TRUE) # type=link predicts the fit and se on the log-linear scale
new_data$pred <- predictions$fit
new_data$se <- predictions$se.fit
new_data$upperCI <- new_data$pred+(new_data$se*1.96)
new_data$lowerCI <- new_data$pred-(new_data$se*1.96)



ggplot(new_data, aes(AverageSpringTemp, y=plogis(pred)))+
  geom_line(col="black")+
  geom_ribbon(aes(ymin=plogis(lowerCI), ymax=plogis(upperCI), alpha=0.2), show.legend=FALSE, fill="grey")+
  geom_point(chytrid_binomial, mapping=aes(x=AverageSpringTemp, y=(Positives/Total)), col="blue")+
  labs(x = "Spring temp (degrees)", y="Probability of infection")+
  theme_classic()

# Bee mites data
mites <- read.csv("bee_mites.csv", stringsAsFactors = T)
str(mites)
head(mites)

ggplot(data=mites, mapping = aes(x=Concentration, y=Dead_mites))+ geom_point()+labs(x = "Concentration", y="Dead mites")+theme_classic()
mitemodel2 <- glm(cbind(Dead_mites, Total-Dead_mites)~Concentration, data=mites, family="binomial")
summary(mitemodel2)
anova(mitemodel2, test="Chisq")
# 
# logit(proportion of Dead mites) = -0.87 + 2.97 * Concentration
#Pseudo R^2 = 0.44. 44% of variance is explained by this model

# model validation
# dispersion parameter: 1.72, slightly overdispersed 

# plots
par(mfrow=c(2,2))
plot(mitemodel2)

# Residuals vs fitted: red line is straighter than model 1
# scale-location: red line is straighter than model 1

# changing model family has corrected for unequal variance in previous model

# still no points outside of cooks distance
sum(cooks.distance(mitemodel2)> 1)

# could fit quasi binomial model to account for overdispersion

mitemodel3 <- glm(cbind(Dead_mites, Total-Dead_mites)~Concentration, data=mites, family="quasibinomial")
summary(mitemodel3)
anova(mitemodel3, test="Chisq")

# logit(proportion of Dead mites) = -0.87 + 2.97 * Concentration
#Pseudo R^2 = 0.44. 44% of variance is explained by this model

# model validation
# dispersion parameter: 1.72, slightly overdispersed 

# plots
par(mfrow=c(2,2))
plot(mitemodel3)

# all plots same apart form residuals vs leverage where cooks distance got further away

range(mites$Concentration)

new_data <- data.frame(Concentration=seq(from=0, to=2.16, length=100))
predictions <- predict(mitemodel3, newdata=new_data, type="link", se.fit=TRUE) # type=link predicts the fit and se on the log-linear scale
new_data$pred <- predictions$fit
new_data$se <- predictions$se.fit
new_data$upperCI <- new_data$pred+(new_data$se*1.96)
new_data$lowerCI <- new_data$pred-(new_data$se*1.96)



ggplot(new_data, aes(x=Concentration, y=plogis(pred)))+
  geom_line(col="black")+
  geom_ribbon(aes(ymin=plogis(lowerCI), ymax=plogis(upperCI), alpha=0.1), show.legend=FALSE, fill="grey")+
  geom_point(mites, mapping=aes(x=Concentration, y=Dead_mites/Total), col="blue")+
  labs(y="Number of Dead Mites", x="Concentration (g/l)")+
  theme_classic()

