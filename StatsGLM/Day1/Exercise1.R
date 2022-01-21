rm(list=ls()) # clear workspace
d <- read.table("SparrowSize.txt", header=TRUE) # read in sparrow data
str(d)
names(d)
head(d)

## Centrality and spread
hist(d$Tarsus, main="", xlab="Sparrow tarsus length (mm)", col="grey") # produce histogram of tarsus length
mean(d$Tarsus, na.rm = TRUE) # calculate mean of tarsus length, ignoring NA values
var(d$Tarsus, na.rm = TRUE) # calculate variance, ignoring NA values
sd(d$Tarsus, na.rm = TRUE) # calculate standard deviation of tarsus length, removing NA values

## Plotting densities (probability of the data coming up)
hist(d$Tarsus, main="", xlab="Sparrow tarsus length (mm)", col="grey", prob = TRUE) # this argument tells R to plot density instead of frequency, as seen on y axis
lines(density(d$Tarsus, na.rm=TRUE), lwd = 2) # probability density curve -lwd is line width
abline(v = mean(d$Tarsus, na.rm = TRUE), col="red", lwd  = 2) # plots vertical line of mean tarsus length
abline(v = mean(d$Tarsus, na.rm = TRUE)-sd(d$Tarsus, na.rm=TRUE), col="blue", lwd=2, lty=5) # lty stands for line types
abline(v = mean(d$Tarsus, na.rm = TRUE)+sd(d$Tarsus, na.rm=TRUE), col="blue", lwd=2, lty=5) # lty stands for line types

## Checking whether the two peaks are sexual dimorphism
t.test(d$Tarsus~d$Sex)

par(mfrow=c(2,1)) # creates multi-panelled plot
hist(d$Tarsus[d$Sex==1], main="", xlab="Male sparrow tarsus length (mm)", col = "grey", prob=TRUE)
lines(density(d$Tarsus[d$Sex==1], na.rm = TRUE), lwd = 2)
abline(v = mean(d$Tarsus[d$Sex==1], na.rm=TRUE), col="red", lwd = 2)
abline(v = mean(d$Tarsus[d$Sex==1], na.rm = TRUE)-sd(d$Tarsus[d$Sex==1], na.rm = TRUE), col="blue", lwd = 2, lty = 5)
abline(v = mean(d$Tarsus[d$Sex==1], na.rm = TRUE)+sd(d$Tarsus[d$Sex==1], na.rm = TRUE), col="blue", lwd = 2, lty = 5)

hist(d$Tarsus[d$Sex==0], main="", xlab="Female sparrow tarsus length (mm)", col = "grey", prob=TRUE)
lines(density(d$Tarsus[d$Sex==0], na.rm = TRUE), lwd = 2)
abline(v = mean(d$Tarsus[d$Sex==0], na.rm=TRUE), col="red", lwd = 2)
abline(v = mean(d$Tarsus[d$Sex==0], na.rm = TRUE)-sd(d$Tarsus[d$Sex==1], na.rm = TRUE), col="blue", lwd = 2, lty = 5)
abline(v = mean(d$Tarsus[d$Sex==0], na.rm = TRUE)+sd(d$Tarsus[d$Sex==1], na.rm = TRUE), col="blue", lwd = 2, lty = 5)

dev.off()

## Variance
var(d$Tarsus, na.rm=TRUE)
sd(d$Tarsus, na.rm=TRUE)
sd(d$Tarsus, na.rm=TRUE)^2 # variance is square of sd
sqrt(var(d$Tarsus, na.rm=TRUE)) # variance is square root of sd

## Checking to see if the data follows rule 1 of var(A+B)=var(A)+var(B)
d1 <- subset(d, d$Tarsus!="NA") # create subset without NAs so don't have to retype na.rm lines
d1 <- subset(d1, d1$Wing!="NA")
sumz <- var(d1$Tarsus)+var(d1$Wing)
test <- var(d1$Tarsus+d1$Wing)
sumz
test # it doesn't, because rule only works for independent variables

dev.off()
plot(jitter(d1$Wing), d1$Tarsus, pch=19, cex=0.4) 
# can see that they are not independent

## Checking other version of rule 1 of var(A+B)=var(A)+var(B)+2COV(A,B)
cov(d1$Tarsus, d1$Wing)
sumz <- var(d1$Tarsus)+var(d1$Wing)+2*cov(d1$Tarsus, d1$Wing)
test <- var(d1$Tarsus+d1$Wing)
sumz
test

## Checking whether data follows rule 2 
var(d1$Tarsus*10)
var(d1$Tarsus)*10^2

## Linear models
## testing hypothesis that heavier unicorns have larger horns
uni <- read.table("RUnicorns.txt", header=T)
str(uni)
head(uni)
mean(uni$Bodymass)
sd(uni$Bodymass)
var(uni$Bodymass)
hist(uni$Bodymass)

mean(uni$Hornlength)
sd(uni$Hornlength)
var(uni$Hornlength)
hist(uni$Hornlength)

plot(uni$Bodymass~uni$Hornlength, pch=19, xlab="Unicorn horn length", ylab="Unicorn body mass", col="blue")
mod <- lm(uni$Bodymass~uni$Hornlength)
abline(mod, col="red")
res <- signif(residuals(mod), 5)
pre <- predict(mod)
segments(uni$Hornlength, uni$Bodymass, uni$Hornlength, pre, col="black") # supports hypothesis

hist(uni$Bodymass)
hist(uni$Hornlength)
hist(uni$Height)
# Not so normal, but will do as we can check validation at the end. no zero inflation

cor.test(uni$Hornlength, uni$Height)
# Not much collinearity, they seem to be independent

boxplot(uni$Bodymass~uni$Gender)
# Females are heavier, with a larger variance, could this be due to pregnancy?

par(mfrow=c(2,1))
boxplot(uni$Bodymass~uni$Pregnant)

plot(uni$Hornlength[uni$Pregnant==0], uni$Bodymass[uni$Pregnant==0], pch=19, xlab="Horn length", ylab="Body mass", xlim=c(2,10), ylim=c(6,19))
points(uni$Hornlength[uni$Pregnant==1], uni$Bodymass[uni$Pregnant==1], pch=19, col="red")

dev.off()

boxplot(uni$Bodymass~uni$Pregnant)
plot(uni$Hornlength[uni$Gender=="Female"], uni$Bodymass[uni$Gender=="Female"],pch=19,xlab="Horn length",ylab="Body Mass",xlim=c(2,10),ylim=c(6,19))
points(uni$Hornlength[uni$Gender=="Male"],uni$Bodymass[uni$Gender=="Male"],pch=19,col="red")
points(uni$Hornlength[uni$Gender=="Undecided"],uni$Bodymass[uni$Gender=="Undecided"],pch=19,col="green")
# looks like there is a sex effect in body mass and horn length

boxplot(uni$Bodymass~uni$Glizz)
plot(uni$Hornlength[uni$Glizz==0],uni$Bodymass[uni$Glizz==0],pch=19,xlab="Horn length", ylab="Body mass", xlim=c(2,10), ylim=c(6,19))
points(uni$Hornlength[uni$Glizz==1],uni$Bodymass[uni$Glizz==1],pch=19,col="red")
# unicorns with glizz are heavier and have longer horns

#include all above realized affecting factors in model (gender, pregnancy, glizz)
FullModel <- lm(uni$Bodymass~uni$Hornlength+uni$Gender+uni$Pregnant+uni$Glizz)
summary(FullModel)
# pregnancy and glizz shown to be significant but not horn length or gender

#Try excluding pregnant unicorns
u1 <- subset(uni, uni$Pregnant==0)
FullModel <- lm(u1$Bodymass~u1$Hornlength+u1$Gender+u1$Glizz)
summary(FullModel)

ReducedModel <- lm(u1$Bodymass~u1$Hornlength+u1$Glizz)
summary(ReducedModel)

plot(u1$Hornlength[u1$Glizz==0], u1$Bodymass[u1$Glizz==0], pch=19, xlab="Horn length", ylab="Body mass", xlim=c(2,10), ylim=c(6,19))
points(u1$Hornlength[u1$Glizz==1], u1$Bodymass[u1$Glizz==1], pch=19, col="red")
abline(ReducedModel)
# Get warning message that only first two coefficients in model have been used. This is because abline plots a 2D line

# Maybe it would be better if plot without glizz
ModForPlot <- lm(u1$Bodymass~u1$Hornlength)
summary(ModForPlot)
plot(u1$Hornlength[u1$Glizz==0], u1$Bodymass[u1$Glizz==0], pch=19, xlab="Horn length", ylab="Body mass", xlim=c(2,10), ylim=c(6,19))
points(u1$Hornlength[u1$Glizz==1], u1$Bodymass[u1$Glizz==1], pch=19, col="red")
abline(ModForPlot)

# Checking additive rule for variances
boxplot(u1$Hornlength~u1$Glizz)
t.test(u1$Hornlength~u1$Glizz)
# statistically significant difference between horn lenghts of glizz wearers and horn lengths of non glizz wearers
# the two variables are not completely independent so cant assume the difference in R squares is also the difference in variance explained by each variable

# Check model for violations of assumptions
# we already know of one: that horn length and glizz are independent
plot(ReducedModel)
View(u1)
plot(u1$Hornlength[u1$Glizz==0],u1$Bodymass[u1$Glizz==0], pch=19, xlab="Horn length", ylab="Body Mass", xlim=c(3,8), ylim=c(6,15))
points(u1$Hornlength[u1$Glizz==1], u1$Bodymass[u1$Glizz==1], pch=19, col="red")
abline(ReducedModel)


# Linear models - interpretation of interactions - two-level fixed factor and continuoua variable
# yet to receive relevant dataset

# Linear models - interpretation of interactions - three-level fixed factor and continuous variable
rm(list=ls())
d<- read.table("Three-way-Unicorn.txt", header=TRUE)
str(d)
names(d)
head(d)
mean(d$Bodymass)
sd(d$Bodymass)
var(d$Bodymass)

par(mfrow=c(2,1))
hist(d$Bodymass, main="")

mean(d$HornLength)
sd(d$HornLength)
var(d$HornLength)
hist(d$HornLength,  main="")

plot(d$Bodymass~d$HornLength)


plot(d$HornLength[d$Gender=="male"]~d$Bodymass[d$Gender=="male"],pch=19, col="black",xlim=c(70,100), ylim=c(0,18), xlab="Bodymass(kg)", ylab="Hornlength(cm)")
points(d$Bodymass[d$Gender=="female"],d$HornLength[d$Gender=="female"],pch=19, col="red")
points(d$Bodymass[d$Gender=="not_sure"],d$HornLength[d$Gender=="not_sure"],pch=19, col="green")
# there looks to be different means

mod <- lm(formula=HornLength ~ Bodymass * Gender, data=d)
summary(mod)


horn length of females: -0.42 +0.63*bodymass