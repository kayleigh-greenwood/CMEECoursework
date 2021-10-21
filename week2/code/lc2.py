#!/usr/bin/env python3
"""Use list comprehensions and loops to make lists from rainfall data"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

 
#############################################
print("USING LIST COMPREHENSIONS:", "\n")
#############################################

### LIST COMPREHENSION FOR RAIN OVER 100mm ###
print("Months where the amount of rain was greater than 100mm:")
over_100 = [month for month in rainfall if ((month[1]>100))] # creates a new list, appends tuples of months where rainfall is above 100mm
print(over_100, "\n")

### LIST COMPREHENSION FOR RAIN UNDER 50mm ###

print("Months where the amount of rain was less than 50mm:")
under_50 = [month[0] for month in rainfall if ((month[1]<50))] # creates a new list, appends names of months where rainfall is below 50mm
print(under_50, "\n") 

#############################################
print("USING CONVENTIONAL LOOPS:", "\n")
#############################################

### CONVENTIONAL LOOP FOR RAIN OVER 100mm ###

print("Months where the amount of rain was greater than 100mm:")

over_100 = [] # creates a new list 
for month in rainfall: # loops through tuples in rainfall
    if ((month[1]>100)): # for months where rainfall is above 100mm...
        over_100.append(month) # appends tuples of months to the new list
print(over_100, "\n")

### CONVENTIONAL LOOP FOR RAIN UNDER 50mm ###

print("Months where the amount of rain was less than 50mm:")

under_50 = [] # creates a new list
for month in rainfall:
    if ((month[1]<50)): # loops through tuples in rainfall
        under_50.append(month[0]) # for months where rainfall is below 50mm...
print(under_50, "\n") # append the month name only to the new list
# creates a new list, appends names of months where rainfall is below 50mm and prints