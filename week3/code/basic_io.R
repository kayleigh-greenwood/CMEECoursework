# A simple script to illustrate R input output.
# Run line by line and check inputs outputs to understand what is happening

MyData <- read.csv("../data/trees.csv", header = TRUE) 
# import file inro variable, with headers

write.csv(MyData, "../results/MyData.csv") 
# write contents of MyData into MyData.csv file in results

write.table(MyData[1,], file = "../results/MyData.csv", append=TRUE) 
# append=TRUE means append to the previously created .csv file
# appends a table of MyData's headings and the first row

write.csv(MyData, "../results/MyData.csv", row.names=TRUE) 
# write contents of MyData into MyData.csv file in results
# write row names in the first column

write.table(MyData, "../results/MyData.csv", col.names=FALSE) 
# write contents of MyData into MyData.csv file in results
# ignore column names, don't write them into csv

print("Script complete")
