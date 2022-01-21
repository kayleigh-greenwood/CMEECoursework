rm(list=ls())

load("../data/KeyWestAnnualMeanTemperature.RData")

# head(ats)

# plot(ats)

#reassign Year as a character 
as.character(ats$Year)

# Make a new column and fill with NA values
ats$s_temp <- NA

# Fill s_temp column with the temperature value of the successive year 
for (i in 1:nrow(ats)){
  ats$s_temp[i] <- ats$Temp[i+1]
}
# remove last row to remove the NA value (as last year of data set does not have a value for the successive year)
ats <- ats[-100,]

# Calculate the Pearson's coefficient
coeff <- cor(x= ats$Temp, y=ats$s_temp, method = "pearson")

#set seed for reproducible results
set.seed(2349)

# no. of observations in ats dataset 
n <- length(ats$Temp)

# No. of permutation samples 
P <- 1000

# Initialise an empty matrix to store permutation data
PermSamp <- matrix(0, nrow=n, ncol=P)

# Make permutation samples using  loop
# Makes 1000 (1:P) permutations of the data and store each one 
# replace= FALSE: sampling without replacement allows for a reordering (permutation) of the data

for (i in 1:P){ # Each loop is a permutation 
  PermSamp[,i] <- sample(ats$s_temp, size=n, replace=FALSE) # for each column [,i], resample (reorders) the s_temp values. The number of rows is equal to n (the number of variables in the original dataset)
  
}

# make an empty vector  to store coefficients
Perm.test.stat <-  rep(0, P)

# Loop through and calculate the test statistics 
# calculates correlation between permutated temp values and s_temp..
for (i in 1:P){
  Perm.test.stat[i]<-cor(x= ats$Temp, y= PermSamp[,i], method= "pearson") #for each column, 
}
# x = ats$Temp: this calculates the coefficient between Temp (in its original order in ats dataset) with each permutation (i.e. each randomly shuffled column of s_temp values)
# each coeff calculated from the step above is populated into an empty matrix 

# calculate fraction of permuted coefficients were greater than the observed coefficicent (coeff)
# sum function will count the number of "TRUE" values (where the coeff calculated for permutation test is greater than coeff (observed correlation coefficient)
perm_coeff <- sum(Perm.test.stat > coeff)

# Calculate what fraction of the random correlation coefficients were greater than the observed one (i.e. p-value)
pvalue <- perm_coeff/P

# Graph distribution of permutated coefficients 
hist(Perm.test.stat, 
     breaks = 50,
     main= "Distribution of permuted coefficients", 
     xlab = "Correlation coefficient", #between temp and years
     ylab="frequency",
     xlim = c(-0.4,0.4),
     ylim = c(0, 50),
     col="pink2")
abline(v=0.3262, col="blue", lwd=2)
text(0.35,40,"Observed correlation", col = "black", cex=1.5, srt = 90)

#Interpret and present the results: Present your results and their interpretation in a pdf document written in latex (include the the document’s source code in the submission) (Keep the writeup, including any figures, to one A4 page).



# reference video (good explanation of permutation tests in R)
# https://youtu.be/xRzEWLfEEIA