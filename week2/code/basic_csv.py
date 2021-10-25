#!/usr/bin/env python3

"""Example of using the CSV package"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

# IMPORTS

import csv

# SCRIPT

print("Task 1")
# Read a file containing:'Species','Infraorder','Family','Distribution','Body mass male (Kg)'
with open('../data/testcsv.csv','r') as f: # opens the file as read
    csvread = csv.reader(f) # creates a csvread variable and stores the test.csv file
    temp = [] # creates a list named temp
    for row in csvread: #creates a loop to iterate through the rows in the csvread variable, which contains a copy of test.csv
        if row[0] == 'Species':
            continue
        temp.append(tuple(row)) # converts each row into a tuple, and adds this tuple to the temp list. 
        print(row) # prints each row to the terminal
        print("The species is", row[0], "\n") #prints to the terminal the species name of each row


print("Task 2")
# write a file containing only species name and Body mass
with open('../data/testcsv.csv','r') as f: # opens testcsv.csv to read
    with open('../data/bodymass.csv','w') as g: # opens a file to write the new information in
        csvread = csv.reader(f) # opens the test.csv to read it
        csvwrite = csv.writer(g) # opens bodymass.csv to write it
        for row in csvread: #creates a for loop to iterate through the rows
            if row[0] == 'Species':
                continue
            print(row) #prints the row to this terminal
            csvwrite.writerow([row[0], row[4]]) #writes the first and fifth row into the bodymass.csv file
