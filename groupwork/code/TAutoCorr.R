# Question: Are temperatures of one year significantly correlated with the next year (successive years), across years in a given location?
# Method: calculate the correlation between (n-1) pairs of years, where n is the total number of years. 
# Tips: you can’t use the standard p-value calculated for a correlation coefficient, because measurements of climatic variables in successive time-points in a time series (successive seconds, minutes, hours, months, years, etc.) are not independent.

# Step 0: Load and examine the annual temperature dataset from Key West in Florida, USA for the 20th century:
rm(list=ls())

load("../data/KeyWestAnnualMeanTemperature.RData")

ls()

# Step 0.5: create new column of temp year after
ats$NextTemp = c(tail(ats$Temp, -1), NA)

# Step 1: Compute the appropriate correlation coefficient between successive years and store it (look at the help file for cor()
corcoeff <- cor(ats$Temp[1:99], ats$NextTemp[1:99], method = "kendall")
print("Correlation coefficient between Temperature and Temperature the following year is:")
print(corcoeff)

# Step 2: Repeat this calculation a sufficient number of times by – randomly permuting the time series, and then recalculating the correlation coefficient for each randomly permuted sequence of annual temperatures and storing it

allcoeffs = c()
for (i in 1:1000){ # shuffles and calculates 1000 times
    newcoeff <- cor(ats$Temp[1:99], sample(ats$NextTemp[1:99]), method = "kendall") # calculates correlation coefficient of years and shuffled temperatures
    allcoeffs = c(allcoeffs, newcoeff) # stores all coefficients in a vector
}
# Step 3: Then calculate what fraction of the correlation coefficients from the previous step were greater than that from step 1 (this is your approximate p-value).

above <- allcoeffs[allcoeffs>corcoeff]
pval <- above/allcoeffs
print("P value:")
print(pval)
# Step 4: Interpret and present the results Present your results and their interpretation in a pdf document written in latex (submit the the document’s source code as well).

pdf("../results/TAutoCorrhist.pdf")
hist(allcoeffs, main = "Permutation Analysis", xlab = "Correlation Coefficient")
dev.off()