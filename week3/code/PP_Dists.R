# # writes  and saves three figures

# ### write scatter plot
# pdf("../results/name.pdf")
# plot(MyDF$x, MyDF$y)
# graphics.off()
# # OR if variables are log-normally distributed;
# pdf("../results/name.pdf")
# plot(log10(MyDF$x), log10(MyDF$y), xlab="log10(title of x axis(units))", ylab="log10(Title of y axis(units))", pch=20, main="figure title")
# graphics.off()
# # pch=20 specifies small black circle



# # write hist
# pdf("../results/name.pdf")
# hist(log10(MyDF$variable), xlab="log10(X axis name(units))", ylab="log10(y axis name(units))", col="colour of bars", border="colour of border around bars", main="figure title")
# graphics.off()

# # write sub-plot hist
# pdf("../results/name.pdf")
# par(mfcol=c(2,1)) #initialize multi-paneled plot
# par(mfg = c(1,1)) # specify which sub-plot to use first 
# hist(log10(MyDF$variable),
#     xlab = "log10(variable(unit))", ylab = "Count", col = "box colour", border = "box border colour", 
#     main = 'Image title') # Add title
# par(mfg = c(2,1)) # Second sub-plot
# hist(log10(MyDF$variable), xlab="log10(variable(units))",ylab="Count", col = "box colour", border = "box border colour", main = 'title')
# graphics.off()

# # write box
# # single boxplot
# pdf("../results/name.pdf")
# boxplot(log10(MyDF$variable), xlab= "log10(x axis label(units))", ylab="Y axis label", main="figure title")
# graphics.off()

# # boxplot split by a variable
# pdf("../results/name.pdf")
# boxplot(log10(MyDF$variable) ~ MyDF$factor, xlab= "x axis label(units))", ylab="log10(Y axis label(units))", main="figure title")
# graphics.off()


#### actual task ####

# TO DO NEXT TIME:
# work out why this isn't working (producing three figures)

# import data
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
MyDF$Size.ratio <- NA # creates new column


for (i in 1:nrow(MyDF)){
    SizeRatio=MyDF$Prey.mass[i]/MyDF$Predator.mass[i]
    MyDF$Size.ratio[i] <- SizeRatio
}

# boxplot split by a variable
pdf("../results/Predator_mass_by_feeding_interaction_type.pdf")
boxplot(log10(MyDF$Predator.mass) ~ MyDF$Type.of.feeding.interation, xlab= "Type of feeding interation)", ylab="log10(Predator mass(g))", main="Predator mass by feeding interaction type")
graphics.off()

# boxplot split by a variable
pdf("../results/Prey_mass_by_feeding_interation_type.pdf")
boxplot(log10(MyDF$Prey.mass) ~ MyDF$Type.of.feeding.interaction, xlab= "Type of feeding interation)", ylab="log10(Prey mass(g))", main="Prey mass by feeding interaction type")
graphics.off()

# boxplot split by a variable
pdf("../results/Size_ratio_of_prey_mass_over_predator_mass_by_feeding_interaction_type.pdf")
boxplot(log10(MyDF$Size.ratio) ~ MyDF$Type.of.feeding.interaction, xlab= "Type of feeding interation)", ylab="log10(Y axis label(units))", main="Size ratio of prey mass over predator mass by feeding interation type")
graphics.off()