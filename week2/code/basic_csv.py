import csv

# Read a file containing:
# 'Species','Infraorder','Family','Distribution','Body mass male (Kg)'
with open('../data/testcsv.csv','r') as f:

    csvread = csv.reader(f) # creates a csvread variable and reads the test.csv file
    temp = [] # creates a list named temp
    for row in csvread: #creates a loop to iterate through the rows in test.csv
        temp.append(tuple(row)) # converts each row into a tuple, and adds this tuple to the temp list. 
        print(row) # prints each row to the terminal
        print("The species is", row[0]) #prints to the terminal the species name of each row


# write a file containing only species name and Body mass
with open('../data/testcsv.csv','r') as f:
    with open('../data/bodymass.csv','w') as g:

        csvread = csv.reader(f) # opens the test.csv to read it
        csvwrite = csv.writer(g) # opens bodymass.csv to write it
        for row in csvread: #creates a for loop to iterate through the rows
            print(row) #prints the row to this terminal
            csvwrite.writerow([row[0], row[4]]) #writes the first and fifth row into the bodymass.csv file
