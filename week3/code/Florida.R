#####################################################################
## Calculates correlation coefficient between temperature and time ##
#####################################################################

# write an R script that will help answer the question: Is Florida getting warmer? 
# Calculate the correlation coefficients between temperature and time.
# However, you can’t use the standard p-value calculated for a correlation coefficient, because measurements of climatic variables in successive time-points in a time series (successive seconds, minutes, hours, months, years, etc.) are not independent.
# you will use a permutation analysis instead, by generating a distribution of random correlation coefficients and compare your observed coefficient with this random distribution

# Load and examine the annual temperature dataset from Key West in Florida, USA for the 20th century:

rm(list=ls())

load("../data/KeyWestAnnualMeanTemperature.RData")

ls()

require(knitr)

# Compute the appropriate correlation coefficient between years and Temperature and store it (look at the help file for cor()

corcoeff <- cor(ats$Year, ats$Temp, method = "kendall")

print("Correlation coefficient for Year and Temp is:")
print (corcoeff)

# Repeat this calculation a sufficient number of times, each time randomly reshuffling the temperatures (i.e., randomly re-assigning temperatures to years), and recalculating the correlation coefficient (and storing it)
# You can use the sample function that we learned about above to do the shuffling. Read the help file for this function and experiment with it.

allcoeffs = c()
# create an empty vector to hold the coefficients of sampled populations
for (i in 1:1000){ # shuffles and calculates 1000 times
    tempsample = sample(ats$Temp) # creates a shuffled sample of the temperatures
    newcoeff <- cor(ats$Year, tempsample, method = "kendall") # calculates correlation coefficient of years and shuffled temperatures
    allcoeffs = c(allcoeffs, newcoeff) # stores all coefficients in a vector
}

# Calculate what fraction of the random correlation coefficients were greater than the observed one (this is your approximate, asymptotic p-value).

above <- allcoeffs[allcoeffs>corcoeff]
print("Approximate, asymptomatic p-value")
print(above/allcoeffs)


# create figures
pdf("../results/atsplot.pdf")
plot(ats, main = "Temperature records by Year in Key West, Florida")
dev.off()

pdf("../results/allcoeffs.pdf")
plot(allcoeffs, main = "Year vs. Temperature in Key West, Florida", ylab = "Correlation coefficient")
dev.off()


pdf("../results/allcoeffshist.pdf")
hist(allcoeffs, main = "Permutation Analysis", xlab = "Correlation Coefficient")
dev.off()
# we take all values above 0.3.. and not below -0.3.. because the hypothesis is:
# is florida getting warmer? meaning we have specified we are interested in whether there is a positive correlation
# if hypothesis was is floridas temperature changing, we would be interested in numbers above 0.3 and below -0.3
# if hypothesis was is florida getting colder, we would be interested in which results were below our number

# Interpret and present the results: Present your results and their interpretation in a pdf document written in latex (include the the document’s source code in the submission) (Keep the writeup, including any figures, to one A4 page).

